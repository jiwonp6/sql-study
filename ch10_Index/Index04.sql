-- 인덱스 사용 실습
use db_index;

-- 샘플 테이블 생성(usertbl, buytbl), sample_data.sql 실행
SELECT * FROM usertbl;

-- 인덱스 확인
SHOW INDEX FROM usertbl;

-- 인덱스 크기 확인
-- => 테이블의 크기 16384, 16KB / (페이지 1개 크기 = 16KB) : 페이지 수 1개
SHOW TABLE STATUS LIKE 'usertbl';

-- 1. 인덱스 생성 : 단순한 보조 인덱스 (주소 컬럼 기준)
CREATE INDEX idx_usertbl_addr ON usertbl (addr);

SHOW INDEX FROM usertbl;			-- 인덱스 생성 확인
SHOW TABLE STATUS LIKE 'usertbl'; 	-- 테이블 상태 확인, index_length = 0

-- 생성한 인덱스를 실제 적용하려면 ANALYZE로 분석 필요
ANALYZE TABLE usertbl;
SHOW TABLE STATUS LIKE 'usertbl'; 	-- 테이블 상태 확인, index_length = 16384 (16KB)

-- 2. 고유 인덱스 만들기 -> 생성 불가 (고유 인덱스 만들기 위해서는 컬럼의 값이 고유해아 함)
-- CREATE INDEX idx_usertbl_birthYear ON usertbl (birthYear);
CREATE INDEX idx_usertbl_name ON usertbl (name);

SHOW INDEX FROM usertbl;			-- 인덱스 생성 확인

-- 3. 복합 인덱스 만들기
CREATE INDEX idx_usertbl_name_birthYear
	ON usertbl (name, birthYear);	-- 기준 컬럼 2개 이상
    
SHOW INDEX FROM usertbl;			-- 인덱스 생성 확인

-- 복합 인덱스의 컬럼들을 사용해서 쿼리할 경우 인덱스를 통한 성능 향상
SELECT * 
	FROM usertbl 
	WHERE name = '윤종신' AND birthYear = '1969';

-- 4. 쿼리 실행계획 확인
-- 인덱스가 있는 경우 가능한 인덱스와 key가 도출되고, 검색한 행의 갯수가 효율적으로 찾아짐
EXPLAIN 
	SELECT * 
		FROM usertbl
		WHERE name = '윤종신' AND birthYear = '1969';
-- WHERE 컬럼에 인덱스가 없는 경우 -> Full Table Scan
-- 모든 데이블의 행을 다 찾아보고 결과 반환
-- 가능한 인덱스도 없음
EXPLAIN 
	SELECT * 
		FROM usertbl 
		WHERE height > 170;

SELECT * FROM usertbl;

-- 인덱스로 사용하는 컬럼은 고유값의 개수가 적은 경우 성능에 도움이 되지 않음

-- 5. 인덱스 삭제
DROP INDEX idx_usertbl_name_birthYear ON usertbl;
ALTER TABLE usertbl DROP INDEX idx_usertbl_name;
-- 기본키(클러스터형 인덱스)는 ALTER문으로만 제거 가능
-- 참조하고 있는 외래키가 있을 경우 참조 무결성에 의해 제거 X
-- => 참조 되어있는 경우 참조 무결성을 제거하고 삭제 가능
ALTER TABLE buytbl DROP FOREIGN KEY buytbl_ibfk_1;
ALTER TABLE usertbl DROP PRIMARY KEY;
