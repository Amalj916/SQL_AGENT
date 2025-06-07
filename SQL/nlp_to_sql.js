require("dotenv").config();
const express = require("express");
const axios = require("axios");
const fs = require("fs");

const app = express();
app.use(express.json());

const OPENAI_API_KEY = process.env.OPENAI_API_KEY;

// Load metadata from JSON file
const METADATA_FILE = "college_db.json";
let metadata;
try {
    metadata = JSON.parse(fs.readFileSync(METADATA_FILE, "utf-8"));
} catch (error) {
    console.error(`Error loading metadata file ${METADATA_FILE}:`, error.message);
    process.exit(1);
}

async function generateSQLQuery(prompt) {
    try {
        if (!OPENAI_API_KEY) {
            throw new Error("OPENAI_API_KEY is not configured");
        }

        const response = await axios.post("https://api.openai.com/v1/chat/completions", {
            model: "gpt-4", // Use the latest OpenAI model
            messages: [
                {
                    role: "system",
                    
                    content: `"You are an advanced AI that converts natural language prompts into precise and optimized SQL queries. Generate only the raw SQL query without explanations, ensuring correctness, efficiency, and security based on the provided database schema. Use best practices for indexing, joins, filtering, and query optimization while handling various SQL operations, including SELECT, INSERT, UPDATE, DELETE, aggregations, joins, and subqueries.". The query should work with this database schema: ${JSON.stringify(metadata)}`
                },
                {
                    role: "user",
                    content: prompt
                }
            ],
            max_tokens: 150
        }, {
            headers: {
                "Content-Type": "application/json",
                "Authorization": `Bearer ${OPENAI_API_KEY}`
            },
            timeout: 10000
        });

        let sqlQuery = response.data.choices?.[0]?.message?.content;
        if (!sqlQuery) throw new Error("Invalid SQL response from OpenAI API");

        // Clean up the SQL query by removing markdown formatting
        sqlQuery = sqlQuery
            .replace(/```sql/gi, '')
            .replace(/```/g, '')
            .trim();

        // Verify the query starts with SELECT, INSERT, UPDATE, or DELETE
        if (!/^(SELECT|INSERT|UPDATE|DELETE)/i.test(sqlQuery)) {
            throw new Error("Invalid SQL query generated");
        }

        return sqlQuery;
    } catch (error) {
        console.error("Error generating SQL:", error.message);
        throw new Error("Failed to generate SQL query");
    }
}

app.post("/generate_sql", async (req, res) => {
    try {
        const { prompt } = req.body;
        if (!prompt || typeof prompt !== 'string' || prompt.trim().length === 0) {
            return res.status(400).json({ error: "Valid prompt is required" });
        }

        const sqlQuery = await generateSQLQuery(prompt.trim());
        res.json({ sqlQuery });
    } catch (error) {
        console.error("❌ ERROR:", error);
        res.status(500).json({ 
            error: error.message || "Unknown error occurred",
            timestamp: new Date().toISOString()
        });
    }
});

const server = app.listen(5002, () => 
    console.log(`NLP-to-SQL Service running on port 5002`));

process.on('SIGTERM', () => {
    console.log('Received SIGTERM. Performing graceful shutdown...');
    server.close(() => {
        console.log('Server closed');
        process.exit(0);
    });
});
