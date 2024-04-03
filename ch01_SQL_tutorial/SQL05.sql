USE test_db;
DROP TABLE employees;

-- 외래키 (참조 무결성 제약조건)
	-- 한 테이블의 컬럼이 다른 테이블의 키(기본키)를 참조
CREATE TABLE departments (	-- 부서 테이블
	department_id INT PRIMARY KEY,
    department_name VARCHAR(250) NOT NULL
);
SELECT * FROM departments;

CREATE TABLE employees (	-- 직원 테이블 생성
	employee_id INT PRIMARY KEY,
	employee_name VARCHAR(250) NOT NULL,
    department_id INT,
    -- 직원 테이블의 부서 ID는 부서 테이블의 부서 ID를 참조 (외래키 설정)
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
DESC employees;
SELECT * FROM employees;

-- 외래 키 레퍼런스 옵션
-- 1. CASCADE
DROP TABLE employees;
DROP TABLE departments;

CREATE TABLE departments (	-- 부서 테이블
	department_id INT PRIMARY KEY,
    department_name VARCHAR(250) NOT NULL
);
SELECT * FROM departments;

CREATE TABLE employees (	-- 직원 테이블 생성
	employee_id INT PRIMARY KEY,
	employee_name VARCHAR(250) NOT NULL,
    department_id INT,
    -- 직원 테이블의 부서 ID는 부서 테이블의 부서 ID를 참조 (외래키 설정)
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
    -- 특정 부서가 삭제될 때 해당 부서직원 정보도 모두 삭제
    ON DELETE CASCADE
);
DESC employees;
SELECT * FROM employees;

-- 2. SET NULL
DROP TABLE employees;
DROP TABLE departments;

CREATE TABLE departments (	-- 부서 테이블
	department_id INT PRIMARY KEY,
    department_name VARCHAR(250) not null
);
SELECT * FROM departments;

CREATE TABLE employees (	-- 직원 테이블 생성
	employee_id INT PRIMARY KEY,
	employee_name VARCHAR(250) NOT NULL,
    department_id INT,
    -- 직원 테이블의 부서 ID는 부서 테이블의 부서 ID를 참조 (외래키 설정)
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
    -- 특정 부서가 삭제될 때 해당 부서 ID가 NULL로 설정됨.
    ON DELETE SET NULL
);
DESC employees;
SELECT * FROM employees;

-- 3. NO ACTION
CREATE TABLE customers (	-- 고객 테이블 생성
	customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(250) NOT NULL
);
CREATE TABLE orders (	-- 고객 테이블을 참조하는 주문 테이블 생성
	order_num INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    -- 특정 고객 정보 삭제하거나 고객 ID 변경 시 작업 거부
    ON DELETE NO ACTION
    -- 
    ON UPDATE NO ACTION
);