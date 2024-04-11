-- 뷰 실습
USE sqldb;
SELECT * FROM usertbl;
SELECT * FROM buytbl;

-- 1. 뷰 생성 시 열의 정보를 내장함수로 조작 가능, 컬럼명도 별칭으로 변경 가능
DROP VIEW view_userbuytbl;
CREATE VIEW view_userbuytbl AS
	SELECT u.userid `User ID`, 
		   u.name `User name`, 
           b.prodName `Product Name`, 
           u.addr `User Address`, 
           concat(u.mobile1, u.mobile2) `Mobile Phone` 
		FROM usertbl u INNER JOIN buytbl b 
        WHERE u.userid = b.userid;
SELECT `User ID`, `User name` FROM view_userbuytbl;

-- 2. 기존 동일 이름의 뷰가 있으면 오류 발생 X 하고, 덮어쓰기
CREATE OR REPLACE VIEW view_usertbl AS
	SELECT userid, name, addr FROM usertbl;
    
SELECT * FROM view_usertbl;
DESC usertbl;		
DESC view_usertbl;	-- 데이터 타입은 동일, 기본키 등의 정보는 확인 X

-- 3. 뷰의 생성문(소스코드)을 확인하기
SHOW CREATE VIEW view_usertbl;

-- 4. 뷰를 통해서 데이터를 수정하기 -> 가능
UPDATE view_usertbl
	SET addr = '부산'
	WHERE userid = 'JKW';
    
-- 5. 뷰를 통해서 데이터를 입력하기 -> 불가능(원본 테이블의 제약조건에 따라 다름)
INSERT INTO view_usertbl(userid, name, addr)
	VALUES ('HKD', '홍길동', '제주');
    
-- 6. 그룹 함수를 포함하는 뷰 생성 -> 그룹 함수를 사용한 집계함수 컬럼 수정 X
-- 집계함수, JOIN, UNION ALL(합집합), DISTINCT, GROUP BY 사용하는 경우 -> 수정, 삭제 X
CREATE VIEW view_sum AS
	SELECT userid, sum(price * amount) 'total'
		FROM buytbl
		GROUP BY userid;
SELECT * FROM view_sum;

-- 7. 시스템에 저장된 뷰 정보 확인하기
SELECT * 
	FROM information_schema.views
	WHERE table_schema = 'sqldb';
    
-- 8. 뷰의 SELECT 문 조건에 만족 X -> view 테이블이 아니라 원본 테이블에 삽입됨 -> view 테이블로는 조회/수정/삭제 불가
CREATE VIEW view_height_uppder177 AS
	SELECT * FROM usertbl WHERE height >= 177;
    
INSERT INTO view_height_uppder177
	VALUES('SDR', '숏다리', 1990, '부산', '010', '11111111', 150, '2024-01-01');
    
-- 9. 뷰 수정
-- WITH CHECK OPTION : 뷰에서 키가 177 미만인 데이터가 입력되지 않도록 설정 => 무결성
ALTER VIEW view_height_uppder177 AS
	SELECT * FROM usertbl WHERE height >= 177
    WITH CHECK OPTION;

-- 10. 조인을 한 뷰는 데이터 삽입 불가
-- 도메인 제약조건에 맞게 삽입하여도 조인한 뷰에서는 삽입이 불가
SHOW CREATE VIEW view_userbuytbl;

SELECT * FROM view_userbuytbl;
INSERT INTO view_userbuytbl
	VALUES ('ABC', '가나다', '모니터', '서울', '01012345678');

-- 11. 원본 테이블이 삭제되는 경우, 뷰 조회 불가능 (참조 불가능)
DROP TABLE IF EXISTS buytbl, usertbl;

SELECT * FROM view_usertbl;
SELECT * FROM view_userbuytbl;

CHECK TABLE view_usertbl;		-- 뷰의 상태 체크 결과 : Error

DROP VIEW view_sum, view_usertbl, view_userbuytbl, view_height_uppder177;
