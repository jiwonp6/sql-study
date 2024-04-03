/* 제약조건 추가하기 */
USE alter_test;
-- 1. UNIQUE 제약조건 추가
ALTER TABLE employees
	ADD COLUMN email VARCHAR(255);
ALTER TABLE employees
	ADD UNIQUE (email);

-- 2. FOREIGN KEY 제약조건 추가
CREATE TABLE departments (
	department_id INT PRIMARY KEY,
    departmenet_name VARCHAR(100)
);
ALTER TABLE employees
	ADD COLUMN department_id INT;
ALTER TABLE employees
	ADD CONSTRAINT fk_department_id	-- CONSTRAINT 제약조건 이름
    FOREIGN KEY(department_id) REFERENCES departments(department_id);

-- 3. CHECK 제약조건 추가
ALTER TABLE employees
	ADD COLUMN age INT;
ALTER TABLE employees
	ADD CONSTRAINT chk_age
    CHECK (age > 19);

-- 4. 열에 대한 설명 추가
ALTER TABLE employees
	ADD COLUMN salary INT COMMENT '직원의 급여와 관련된 속성';
    
/* 제약조건 삭제하기 */
-- 1. FOREIGN KEY 삭제하기
ALTER TABLE employees 
	DROP FOREIGN KEY fk_department_id;
    
-- 2. CHECK 삭제하기
ALTER TABLE employees 
	DROP CONSTRAINT chk_age;

/* ALTER COLUMN 으로 열 속성 변경하기 */
-- 1. 기본 값 추가
ALTER TABLE employees 
	ALTER COLUMN age SET DEFAULT 20;
    
-- 2. 기본 값 삭제
ALTER TABLE employees 
	ALTER COLUMN age DROP DEFAULT;
