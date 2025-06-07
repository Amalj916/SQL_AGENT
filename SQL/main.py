from fastapi import FastAPI, HTTPException
from contextlib import contextmanager
import mysql.connector
from mysql.connector.pooling import MySQLConnectionPool
import requests
import os
import json
from dotenv import load_dotenv
from typing import Dict, Any

load_dotenv()
app = FastAPI()

# Database configuration with connection pooling
DB_CONFIG = {
    "host": os.getenv("DB_HOST"),
    "user": os.getenv("DB_USER"),
    "password": os.getenv("DB_PASSWORD"),
    "database": os.getenv("DB_NAME"),
    "pool_name": "mypool",
    "pool_size": 5,
}

# Initialize MySQL connection pool
try:
    connection_pool = MySQLConnectionPool(**DB_CONFIG)
except mysql.connector.Error as e:
    print(f"Error creating connection pool: {e}")
    raise

NLP_SERVICE_URL = "http://localhost:5002"


@contextmanager
def get_db_connection():
    """Context manager for database connections."""
    conn = None
    try:
        conn = connection_pool.get_connection()
        yield conn
    except mysql.connector.Error as e:
        raise HTTPException(
            status_code=500, detail=f"Database connection error: {str(e)}"
        )
    finally:
        if conn:
            conn.close()


@app.post("/process_query")
async def process_query(data: Dict[str, Any]):
    """
    Main endpoint that processes natural language queries
    """
    prompt = data.get("prompt")
    if not prompt:
        raise HTTPException(status_code=400, detail="Prompt is required")

    try:
        # Step 1: Get SQL query from NLP service
        nlp_response = requests.post(
            f"{NLP_SERVICE_URL}/generate_sql", json={"prompt": prompt}, timeout=10
        )
        nlp_response.raise_for_status()
        sql_query = nlp_response.json().get("sqlQuery")

        if not sql_query:
            raise HTTPException(status_code=500, detail="Failed to generate SQL query")

        # Step 2: Execute the SQL query
        with get_db_connection() as conn:
            cursor = conn.cursor(dictionary=True)
            try:
                cursor.execute(sql_query)
                results = cursor.fetchall()
                return {
                    "sql_query": sql_query,
                    "results": results,
                    "row_count": len(results),
                }
            finally:
                cursor.close()

    except requests.exceptions.RequestException as e:
        raise HTTPException(status_code=503, detail=f"NLP service error: {str(e)}")
    except mysql.connector.Error as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.get("/health")
async def health_check():
    """Health check endpoint"""
    try:
        with get_db_connection() as conn:
            cursor = conn.cursor()
            cursor.execute("SELECT 1")
            cursor.fetchone()
            return {"status": "healthy", "database": "connected"}
    except Exception as e:
        raise HTTPException(status_code=503, detail=f"Service unhealthy: {str(e)}")
