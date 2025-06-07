CREATE TABLE fee_structure (
    fee_id SERIAL PRIMARY KEY,
    student_id INT,
    course_id INT,
    semester VARCHAR(20),
    tuition_fee DECIMAL(10, 2),
    lab_fee DECIMAL(10, 2),
    library_fee DECIMAL(10, 2),
    sports_fee DECIMAL(10, 2),
    total_fee DECIMAL(10, 2) GENERATED ALWAYS AS (tuition_fee + lab_fee + library_fee + sports_fee) STORED,
    due_date DATE,
    payment_status VARCHAR(20) DEFAULT 'Pending'
);

-- Insert sample data into fee_structure table
INSERT INTO fee_structure (student_id, course_id, semester, tuition_fee, lab_fee, library_fee, sports_fee, due_date)
VALUES
(1, 101, 'Fall 2024', 50000, 20000, 15000, 5000, '2024-12-01'),
(2, 102, 'Fall 2024', 48000, 18000, 14000, 4500, '2024-12-01'),
(3, 103, 'Fall 2024', 47000, 17000, 13000, 4000, '2024-12-01'),
(4, 104, 'Spring 2025', 46000, 16000, 12000, 4000, '2025-05-01'),
(5, 105, 'Spring 2025', 70000, 25000, 12000, 8000, '2025-05-01'),
(6, 106, 'Spring 2025', 35000, 10000, 8000, 3000, '2025-05-01');

-- To check the data inserted
SELECT * FROM fee_structure;
