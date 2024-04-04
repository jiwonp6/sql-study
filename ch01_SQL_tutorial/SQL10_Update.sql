-- 스키마 생성 및 사용
CREATE SCHEMA IF NOT EXISTS ex_insert;
USE ex_insert;

-- 테이블 초기화
DROP TABLE IF EXISTS employees;
CREATE TABLE employees LIKE employees.employees;

DESC employees;
SELECT * FROM employees;

-- 샘플 데이터 대량 삽입
INSERT INTO employees
	SELECT * FROM employees.employees;
    
-- 데이터 수정 
-- 이름 Georgi인 사람의 생일 수정 -> 해당 조건 매치 :253행 모두 수정
UPDATE employees
	SET birth_date = '1970-09-02'
    WHERE first_name = 'Georgi';

-- 사원번호가 10001인 사람의 생일 수정 -> 해당 조건 매치 : 1행 수정 
	-- 속성이 고유한 키 사용하여 수정 -> 해당 조건에 매치되는 한 행만 수정 가능
UPDATE employees
	SET birth_date = '1953-09-02'
    WHERE emp_no = '10001';

-- WHERE 절 생략 -> 모든 행 수정 
UPDATE employees
	SET last_name = '';

-- 비교 연산자 사용
UPDATE employees
	SET first_name = '', last_name = ''
    WHERE hire_date > '1990-01-01';

-- 복합 연산자 사용
UPDATE employees
	SET first_name = '타이쇼', last_name = '이와사키'
    WHERE gender <> 'F' AND hire_date <= '1990-01-01';
    
select * from employees;
        