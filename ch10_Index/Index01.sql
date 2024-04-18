CREATE SCHEMA db_index;
USE db_index;

/* 인덱스 1개 */
-- 테이블 생성
CREATE TABLE table1 (
	pk INT PRIMARY KEY,
	col_a INT,
	col_b INT
);

-- 인덱스 확인하기
SHOW INDEX FROM table1;

-- Key_name : 인덱스 이름 (PRIMARY는 기본키 클러스터형 인덱스)
-- column_name : 인덱스에 포함된 컬럼의 이름

/* 인덱스 3개 */
-- 테이블 생성
CREATE TABLE table2 (
	pk INT PRIMARY KEY, 	-- 클러스터형 인덱스 (자동생성)
	col_a INT UNIQUE,  		-- 유니크 인덱스 (자동생성, 보조인덱스)	-> 보조인덱스는 여러 개 가능
	col_b INT UNIQUE,  		-- 유니크 인덱스 (자동생성, 보조인덱스)
	col_c INT				-- 제약 조건 X -> 자동생성 X
);

-- 인덱스 확인하기
SHOW INDEX FROM table2;

/* PRIMARY KEY 없는 경우 */
-- 테이블 생성
CREATE TABLE table3 (
	col_Z INT UNIQUE,
	col_a INT UNIQUE,
	col_b INT UNIQUE,
	col_c INT
);

-- 인덱스 확인하기
SHOW INDEX FROM table3;

/* PRIMARY KEY -> UNIQUE + NOT NULL로 생성 */
-- 테이블 생성
CREATE TABLE table4 (
	col_Z INT UNIQUE NOT NULL, -- 클러스터형 인덱스 (자동생성)	
	col_a INT UNIQUE,
	col_b INT UNIQUE,
	col_c INT
);

-- 인덱스 확인하기
SHOW INDEX FROM table4;

/* PRIMARY KEY, UNIQUE + NOT NULL 동시 존재 */
-- 테이블 생성
CREATE TABLE table5 (
	pk INT PRIMARY KEY,  		-- 클러스터형 인덱스 (자동생성)	
	col_Z INT UNIQUE NOT NULL, 	-- 유니크 인덱스 (자동생성, 보조인덱스)
	col_a INT UNIQUE,
	col_b INT UNIQUE
);

-- 인덱스 확인하기
SHOW INDEX FROM table5;

/* FOREIGN KEY */
-- 테이블 생성
CREATE TABLE table6 (
	pk INT PRIMARY KEY,
	col_a INT UNIQUE,
	col_b INT,
	col_c INT,
    FOREIGN KEY (col_c) REFERENCES table5 (pk) -- 외래키 인덱스 (자동생성)
);

-- 인덱스 확인하기
SHOW INDEX FROM table6;