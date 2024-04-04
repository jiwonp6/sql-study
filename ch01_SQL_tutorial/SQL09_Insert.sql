CREATE SCHEMA ex_insert;
USE ex_insert;

CREATE TABLE employees LIKE employees.employees;

DESC employees;
SELECT * FROM employees;

-- 데이터 삽입
INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
	VALUES (101, '2000-01-01', '길동', '홍', 'M', current_date());
INSERT INTO employees
	VALUES (102, '1990-01-01', '길동', '김', 'M', '2002-01-01');
INSERT INTO employees (first_name, last_name, gender)
	VALUES ('길동', '이', 'F');

-- 여러 줄 삽입
INSERT INTO employees (first_name, last_name, gender)
	VALUES ('길동', '박', 'F'),
			('우치', '전', 'M'),
			('몽룡', '이', 'M');
            
-- 대량의 데이터 삽입
INSERT INTO employees
	SELECT * FROM employees.employees;
