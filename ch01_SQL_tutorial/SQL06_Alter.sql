-- 테이블 구조 변경
-- ALTER 문
CREATE SCHEMA alter_test;
USE alter_test;

-- 샘플 데이터베이스에서 테이블 구조 복사
CREATE TABLE employees
	LIKE employees.employees;

-- 복사한 구조 확인
DESC employees;
SELECT * FROM employees;

-- 새로운 열을 추가
ALTER TABLE employees 
	ADD COLUMN phone_number VARCHAR(255);
    
-- 컬럼을 삭제
ALTER TABLE employees 
	DROP COLUMN phone_number;    

-- 컬럼명 변경하기
ALTER TABLE employees 
	CHANGE COLUMN first_name FirstName VARCHAR(14);
    
-- 데이터 타입 변경하기
ALTER TABLE employees
	MODIFY COLUMN hire_date DATETIME;
    
-- 테이블 이름 변경하기
ALTER TABLE employees
	RENAME TO employees_backup;
ALTER TABLE employees_backup
	RENAME TO employees;
    