-- Create College Database
CREATE DATABASE IF NOT EXISTS college_db;
USE college_db;

-- Students Table
CREATE TABLE IF NOT EXISTS students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    age INT CHECK (age BETWEEN 18 AND 30),
    gender ENUM('Male', 'Female', 'Other'),
    department_id INT,
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE SET NULL
);

-- Teachers Table
CREATE TABLE IF NOT EXISTS teachers (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department_id INT,
    salary DECIMAL(10,2),
    hire_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE SET NULL
);

-- Non-Teaching Staff Table
CREATE TABLE IF NOT EXISTS non_teaching_staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE DEFAULT (CURRENT_DATE)
);

-- Departments Table
CREATE TABLE IF NOT EXISTS departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) UNIQUE NOT NULL
);

-- Courses Table
CREATE TABLE IF NOT EXISTS courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    teacher_id INT,
    credits INT CHECK (credits BETWEEN 1 AND 6),
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id) ON DELETE SET NULL
);

-- Enrollments Table
CREATE TABLE IF NOT EXISTS enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
);

-- Office Staff Table
CREATE TABLE IF NOT EXISTS office_staff (
    office_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2),
    hire_date DATE DEFAULT (CURRENT_DATE)
);

-- Payments Table
CREATE TABLE IF NOT EXISTS payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
);

INSERT INTO departments (department_name) VALUES
('Computer Engineering'), ('Mechanical Engineering'), ('Electrical Engineering'), ('Civil Engineering'), ('Chemical Engineering'), ('Aerospace Engineering'), ('Biomedical Engineering'), ('Industrial Engineering');

INSERT INTO students (name, email, age, gender, department_id) VALUES
('Alice Johnson', 'alice.johnson1@example.com', 19, 'Female', 1),
('Bob Smith', 'bob.smith2@example.com', 20, 'Male', 2),
('Charlie Davis', 'charlie.davis3@example.com', 21, 'Male', 3),
('Diana Miller', 'diana.miller4@example.com', 22, 'Female', 4),
('Ethan Wilson', 'ethan.wilson5@example.com', 23, 'Male', 5),
('Fiona Brown', 'fiona.brown6@example.com', 18, 'Female', 6),
('George Clark', 'george.clark7@example.com', 24, 'Male', 7),
('Hannah Lewis', 'hannah.lewis8@example.com', 25, 'Female', 8),
('Ian Walker', 'ian.walker9@example.com', 20, 'Male', 1),
('Jenna Scott', 'jenna.scott10@example.com', 22, 'Female', 2),
('Kevin Young', 'kevin.young11@example.com', 21, 'Male', 3),
('Laura Adams', 'laura.adams12@example.com', 19, 'Female', 4),
('Michael Carter', 'michael.carter13@example.com', 23, 'Male', 5),
('Nancy Evans', 'nancy.evans14@example.com', 24, 'Female', 6),
('Oscar Hall', 'oscar.hall15@example.com', 20, 'Male', 7),
('Paula Baker', 'paula.baker16@example.com', 21, 'Female', 8),
('Quentin Allen', 'quentin.allen17@example.com', 22, 'Male', 1),
('Rachel Thomas', 'rachel.thomas18@example.com', 23, 'Female', 2),
('Samuel White', 'samuel.white19@example.com', 19, 'Male', 3),
('Tina Harris', 'tina.harris20@example.com', 24, 'Female', 4),
('Umar King', 'umar.king21@example.com', 25, 'Male', 5),
('Vera Nelson', 'vera.nelson22@example.com', 20, 'Female', 6),
('William Reed', 'william.reed23@example.com', 21, 'Male', 7),
('Xena Wright', 'xena.wright24@example.com', 22, 'Female', 8),
('Yusuf Green', 'yusuf.green25@example.com', 23, 'Male', 1),
('Zara Murphy', 'zara.murphy26@example.com', 24, 'Female', 2),
('Adam Foster', 'adam.foster27@example.com', 19, 'Male', 3),
('Bella Rogers', 'bella.rogers28@example.com', 20, 'Female', 4),
('Chris Simmons', 'chris.simmons29@example.com', 21, 'Male', 5),
('Daisy Powell', 'daisy.powell30@example.com', 22, 'Female', 6),
('Edward Ross', 'edward.ross31@example.com', 23, 'Male', 7),
('Felicity Perry', 'felicity.perry32@example.com', 24, 'Female', 8);

SELECT * FROM students where student_id= 20;

INSERT INTO teachers (name, email, department_id, salary) VALUES
('John Anderson', 'john.anderson@example.com', 1, 65000.00),
('Emma Watson', 'emma.watson@example.com', 2, 62000.00),
('Michael Brown', 'michael.brown@example.com', 3, 70000.00),
('Sarah Johnson', 'sarah.johnson@example.com', 4, 68000.00),
('David Smith', 'david.smith@example.com', 5, 64000.00),
('Emily Davis', 'emily.davis@example.com', 6, 71000.00),
('Daniel White', 'daniel.white@example.com', 7, 69000.00),
('Sophia Martin', 'sophia.martin@example.com', 8, 72000.00),
('Matthew Lee', 'matthew.lee@example.com', 1, 66000.00),
('Olivia Harris', 'olivia.harris@example.com', 2, 63000.00);

INSERT INTO courses (course_name, teacher_id, credits) VALUES
('Data Structures', 1, 3),
('Thermodynamics', 2, 4),
('Circuit Analysis', 3, 3),
('Structural Engineering', 4, 4),
('Chemical Reactions', 5, 3),
('Aerodynamics', 6, 4),
('Biomedical Imaging', 7, 3),
('Supply Chain Management', 8, 4),
('Software Engineering', 1, 3),
('Robotics', 2, 4);

INSERT INTO enrollments (student_id, course_id) VALUES
(1, 1),
(1, 9),
(9, 1),
(9, 9),
(17, 1),
(2, 2),
(2, 10),
(10, 2),
(18, 2),
(3, 3),
(11, 3),
(19, 3),
(4, 4),
(12, 4),
(20, 4),
(5, 5),
(13, 5),
(21, 5),
(6, 6),
(14, 6),
(22, 6),
(7, 7),
(15, 7),
(23, 7),
(8, 8),
(16, 8),
(24, 8);


INSERT INTO non_teaching_staff (name, role, salary, hire_date) VALUES
('James Wilson', 'Librarian', 45000.00, '2020-03-15'),
('Maria Garcia', 'Lab Technician', 42000.00, '2019-08-22'),
('Robert Chen', 'IT Support', 48000.00, '2021-01-10'),
('Patricia Lee', 'Administrative Assistant', 38000.00, '2018-11-30'),
('Thomas Brown', 'Security Guard', 35000.00, '2019-06-14'),
('Linda Martinez', 'Cafeteria Manager', 41000.00, '2020-07-25'),
('Richard Taylor', 'Maintenance Supervisor', 46000.00, '2017-09-18'),
('Sandra Rodriguez', 'Library Assistant', 36000.00, '2021-04-05'),
('Joseph Anderson', 'IT Network Specialist', 52000.00, '2019-12-03'),
('Margaret White', 'Administrative Secretary', 39000.00, '2020-02-28'),
('Christopher King', 'Security Supervisor', 42000.00, '2018-05-17'),
('Elizabeth Turner', 'Lab Coordinator', 44000.00, '2021-03-12'),
('Daniel Moore', 'Facilities Manager', 49000.00, '2019-01-20'),
('Jennifer Adams', 'Student Services Coordinator', 43000.00, '2020-08-15'),
('Kevin Wright', 'Maintenance Technician', 37000.00, '2021-02-08'),
('Michelle Scott', 'Records Clerk', 36500.00, '2019-07-30'),
('Steven Baker', 'IT Help Desk', 41000.00, '2020-05-22'),
('Laura Phillips', 'Financial Aid Assistant', 38500.00, '2018-10-11'),
('Charles Nelson', 'Building Services', 34000.00, '2021-01-15'),
('Rebecca Cooper', 'Library Technician', 37500.00, '2019-09-28'),
('Andrew Rivera', 'Security Officer', 36000.00, '2020-04-17'),
('Susan Morgan', 'Administrative Coordinator', 42500.00, '2018-12-05'),
('David Peterson', 'Lab Assistant', 38000.00, '2021-03-20'),
('Karen Butler', 'Cafeteria Staff', 33000.00, '2019-11-14'),
('Michael Hayes', 'Maintenance Staff', 35500.00, '2020-06-30'),
('Lisa Washington', 'Student Affairs Assistant', 39500.00, '2018-08-22'),
('George Sanders', 'IT Support Specialist', 45500.00, '2021-02-15'),
('Nancy Rogers', 'Records Manager', 43500.00, '2019-05-08'),
('Paul Henderson', 'Security Personnel', 36500.00, '2020-09-10'),
('Carol Patterson', 'Office Assistant', 37000.00, '2018-07-19');


INSERT INTO office_staff (name, role, salary, hire_date) VALUES
('Sarah Thompson', 'Administrative Director', 52000.00, '2019-06-15'),
('Mark Johnson', 'Office Manager', 48000.00, '2020-03-22'),
('Emily Rodriguez', 'Admissions Coordinator', 45000.00, '2021-01-10'),
('William Chen', 'Financial Coordinator', 47000.00, '2019-11-30'),
('Jessica Martinez', 'Student Records Officer', 42000.00, '2020-08-14'),
('Daniel Kim', 'Registration Specialist', 41000.00, '2019-07-25'),
('Rachel Foster', 'Academic Advisor', 46000.00, '2020-09-18'),
('Anthony Parker', 'Enrollment Specialist', 43000.00, '2021-02-05'),
('Lauren Wilson', 'Administrative Assistant', 38000.00, '2019-12-03'),
('Brian Taylor', 'Front Desk Supervisor', 40000.00, '2020-04-28'),
('Amanda Lewis', 'Student Services Officer', 44000.00, '2019-05-17'),
('Christopher Lee', 'Office Coordinator', 43500.00, '2021-03-12'),
('Nicole White', 'Scheduling Coordinator', 41500.00, '2020-01-20'),
('Ryan Garcia', 'Administrative Secretary', 39000.00, '2019-08-15'),
('Katherine Brown', 'Documentation Specialist', 42500.00, '2020-02-08'),
('Peter Anderson', 'Student Affairs Officer', 45500.00, '2019-07-30'),
('Michelle Davis', 'Office Administrator', 44500.00, '2020-05-22'),
('James Wilson', 'Records Administrator', 43000.00, '2019-10-11'),
('Victoria Moore', 'Admissions Officer', 46500.00, '2020-12-15'),
('Robert Turner', 'Administrative Supervisor', 49000.00, '2019-09-28');

INSERT INTO payments (student_id, amount, payment_date) VALUES
(1, 5500.00, '2023-01-15'),
(2, 4800.00, '2023-01-16'),
(3, 5200.00, '2023-01-17'),
(4, 4900.00, '2023-01-18'),
(5, 5100.00, '2023-01-20'),
(6, 5300.00, '2023-01-22'),
(7, 4700.00, '2023-01-25'),
(8, 5400.00, '2023-01-28'),
(9, 5000.00, '2023-02-01'),
(10, 4850.00, '2023-02-03'),
(1, 250.00, '2023-02-05'),
(2, 300.00, '2023-02-06'),
(11, 5250.00, '2023-02-08'),
(12, 4950.00, '2023-02-10'),
(13, 5150.00, '2023-02-12'),
(14, 4800.00, '2023-02-15'),
(15, 5350.00, '2023-02-18'),
(3, 180.00, '2023-02-20'),
(16, 4750.00, '2023-02-22'),
(17, 5200.00, '2023-02-25'),
(4, 220.00, '2023-03-01'),
(18, 4900.00, '2023-03-03'),
(19, 5100.00, '2023-03-05'),
(20, 5300.00, '2023-03-08'),
(5, 150.00, '2023-03-10'),
(21, 4850.00, '2023-03-12'),
(22, 5250.00, '2023-03-15'),
(6, 280.00, '2023-03-18'),
(23, 4950.00, '2023-03-20'),
(24, 5150.00, '2023-03-22'),
(7, 200.00, '2023-03-25'),
(1, 5600.00, '2023-04-01'),
(2, 4900.00, '2023-04-03'),
(3, 5300.00, '2023-04-05'),
(4, 5000.00, '2023-04-08'),
(5, 5200.00, '2023-04-10'),
(8, 175.00, '2023-04-12'),
(6, 5400.00, '2023-04-15'),
(7, 4800.00, '2023-04-18'),
(8, 5500.00, '2023-04-20'),
(9, 5100.00, '2023-04-22'),
(9, 230.00, '2023-04-25'),
(10, 4950.00, '2023-04-28'),
(11, 5350.00, '2023-05-01'),
(12, 5050.00, '2023-05-03'),
(10, 190.00, '2023-05-05'),
(13, 5250.00, '2023-05-08'),
(14, 4900.00, '2023-05-10'),
(15, 5450.00, '2023-05-12'),
(11, 260.00, '2023-05-15'),
(16, 4850.00, '2023-05-18'),
(17, 5300.00, '2023-05-20'),
(12, 170.00, '2023-05-22'),
(18, 5000.00, '2023-05-25'),
(19, 5200.00, '2023-05-28'),
(20, 5400.00, '2023-06-01'),
(13, 240.00, '2023-06-03'),
(21, 4950.00, '2023-06-05'),
(22, 5350.00, '2023-06-08'),
(14, 210.00, '2023-06-10'),
(23, 5050.00, '2023-06-12'),
(24, 5250.00, '2023-06-15'),
(15, 195.00, '2023-06-18'),
(1, 290.00, '2023-06-20'),
(2, 5000.00, '2023-06-22'),
(3, 5400.00, '2023-06-25'),
(16, 225.00, '2023-06-28'),
(4, 5200.00, '2023-07-01'),
(5, 4900.00, '2023-07-03'),
(17, 185.00, '2023-07-05'),
(6, 5300.00, '2023-07-08'),
(7, 4950.00, '2023-07-10'),
(18, 270.00, '2023-07-12'),
(8, 5150.00, '2023-07-15'),
(9, 5350.00, '2023-07-18'),
(19, 165.00, '2023-07-20'),
(10, 4800.00, '2023-07-22'),
(11, 5400.00, '2023-07-25'),
(20, 245.00, '2023-07-28'),
(12, 5100.00, '2023-08-01'),
(13, 4950.00, '2023-08-03'),
(21, 205.00, '2023-08-05'),
(14, 5250.00, '2023-08-08'),
(15, 5000.00, '2023-08-10'),
(22, 235.00, '2023-08-12'),
(16, 5350.00, '2023-08-15'),
(17, 4900.00, '2023-08-18'),
(23, 255.00, '2023-08-20'),
(18, 5150.00, '2023-08-22'),
(19, 5300.00, '2023-08-25'),
(24, 215.00, '2023-08-28'),
(20, 4850.00, '2023-08-30'),
(21, 5400.00, '2023-09-01'),
(22, 5100.00, '2023-09-03'),
(23, 4950.00, '2023-09-05'),
(24, 5250.00, '2023-09-08'),
(1, 5150.00, '2023-09-10'),
(2, 5300.00, '2023-09-12'),
(3, 4900.00, '2023-09-15'),
(4, 5200.00, '2023-09-18');

