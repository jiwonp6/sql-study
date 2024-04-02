-- 데이터 선택하여 활용 
SELECT * FROM PRODUCTTBL;
SELECT * FROM MEMBERTBL;
SELECT MEMBERNAME FROM MEMBERTBL;
SELECT MEMBERNAME, MEMBERADDRESS FROM MEMBERTBL;
SELECT * FROM MEMBERTBL WHERE MEMBERNAME = '홍길동';

-- 테이블의 생성과 삭제
CREATE TABLE `my test_tbl` (id INT);
DROP TABLE `my test_tbl`;

CREATE TABLE INDEX_TBL ( 
	first_name VARCHAR(14),
    last_name VARCHAR(16),
    hire_date DATE
);

-- 데이터 삽입
INSERT INTO INDEX_TBL
	SELECT first_name, last_name, hire_date
    FROM employees.employees
    LIMIT 500;

-- 선택 조건으로 데이터 선택
SELECT * 
	FROM INDEX_TBL 
	WHERE first_name = 'MARY';   
    
-- 인덱스 생성
CREATE INDEX IDX_INDEX_TBL_FIRSTNAME
	ON INDEX_TBL(FIRST_NAME);

-- 사용자 뷰 만들기
CREATE VIEW uv_member_tbl 
	AS 
    SELECT memberName, memberAddress 
    FROM membertbl;
SELECT * FROM uv_member_tbl;

-- 테이블 데이터 삭제 및 복구
DELETE FROM producttbl;
SELECT * FROM producttbl;


