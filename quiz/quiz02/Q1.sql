DROP SCHEMA IF EXISTS quiz;
CREATE SCHEMA quiz;
USE quiz;

CREATE TABLE employees LIKE employees.employees;
CREATE TABLE salaries LIKE employees.salaries;
INSERT INTO employees SELECT * FROM employees.employees;
INSERT INTO salaries SELECT * FROM employees.salaries;

-- 1. 인덱스 생성 전 `employees` 테이블에  `last_name` 컬럼을 조건으로 하는 쿼리문 실행
SELECT * FROM employees WHERE last_name = 'Facello';

-- 2. `EXPLAIN`과 Execution Plan을 사용하여 `last_name`을 조건으로 하는 SELECT 쿼리의 실행 계획 확인
EXPLAIN SELECT * FROM employees WHERE last_name = 'Facello';

-- 3. 인덱스 생성
CREATE INDEX idx_lastName
	ON employees (last_name);

-- 4. 인덱스 생성 전후의 쿼리문의 실행 시간을 비교
SELECT * FROM employees WHERE last_name = 'Facello';

-- 5. `employees` 테이블의 모든 인덱스 정보 조회
SHOW INDEX FROM employees;
