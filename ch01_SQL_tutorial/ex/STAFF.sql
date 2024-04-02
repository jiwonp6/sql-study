-- * 직원 : 스키마별로 권한 부여
-- 데이터베이스 생성은 불가능
CREATE DATABASE test_db;	

-- employees : 데이터 삽입, 수정, 삭제 불가
USE employees;
SELECT * FROM employees;

-- shopdb : 권한이 있는 스키마에 대해서는 명령 적용 가능
USE shopdb;
SELECT * FROM memberTBL;
DELETE FROM memberTBL WHERE memberID = 'ABC';


