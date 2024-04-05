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
    
SELECT * FROM employees;

-- 데이터 삭제하기 
-- WHERE 조건에 만족하는 모든 행을 삭제
DELETE FROM employees
	WHERE first_name = 'Georgi';
    
-- 테이블 삭제 시 상위 N 건만 지우고 싶은 경우 LIMIT 구문과 함께 사용
DELETE FROM employees
	WHERE first_name = 'Bezalel' LIMIT 100;

-- 조건 연산자 사용
DELETE FROM employees
	WHERE birth_date >= '1965-01-01';
    
-- 복합 조건 삭제
DELETE FROM employees
	WHERE first_name = 'Parto' AND last_name = 'Bamford';
 
-- WHERE 조건문을 생략하고 삭제할 경우 -> 모든 행 삭제
DELETE FROM employees;

-- 테이블의 구조는 남기고 모든 데이터를 삭제
-- DDL : DML의 트랜잭션 로그 기록 없음
TRUNCATE TABLE employees;

-- 테이블 자체를 지우고 싶을 때 (데이터 및 구조 모두 삭제), DDL
DROP TABLE employees;
