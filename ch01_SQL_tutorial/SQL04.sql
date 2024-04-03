-- 데이터베이스(스키마 생성)
CREATE DATABASE test_db;
-- 데이터베이스 사용
USE test_db;
-- 테이블 생성 & 제약조건 설정
CREATE TABLE employees(
	employee_id INT NOT NULL,	-- 컬럼에서 제약조건
    first_name VARCHAR(50),		-- 제약조건X -> 기본 NULL 허용
    last_name VARCHAR(50),
    PRIMARY KEY (employee_id)	-- 해당 컬럼을 기본키로 설정
);
-- 테이블의 정보 확인
DESCRIBE employees;

-- 복합 기본 키 설정
CREATE TABLE player(
	team_id INT NOT NULL,
    back_number VARCHAR(100) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    PRIMARY KEY (team_id, back_number)	-- team_id, back_number 조합해서 기본 키로 생성
										-- 각 컬럼은 중복 가능 but, 두 컬럼의 조합으로는 고유한 기본키 생성
);
-- 테이블의 정보 확인
DESC player;

-- 테이블 생성 시 컬럼에서 제약조건 지정
CREATE TABLE member (
	member_id INT PRIMARY KEY	-- 복합키 속성이 하나일 경우 컬럼에서 제약조건 지정도 가능
);
DESC member;

-- UNIQUE 제약 조건
	-- 동일한 값 두 번 이상 X
CREATE TABLE users (
	user_id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE 	-- email 열의 고유 보장, null 허용
);
DESC users;
SELECT * FROM users;

-- 체크 제약조건
CREATE TABLE adults(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    CHECK (age >= 19)	-- age 필드에 값이 들어올 때 19세 이상인지 체크  
);
DESC adults;

SELECT * FROM adults;

-- DEFAULT 제약조건 (각 컬럼에 대한 기본 값 지정)
CREATE TABLE persons (
	id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    status VARCHAR(50) DEFAULT '활동중',				-- 상태 열 기본값 : '활동줄'
    join_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP	-- 가입일 기본값 : 현재 날짜와 시간
);
DESC persons;
SELECT * FROM persons;
DROP TABLE persons;

-- AUTO_INCREMENT : 데이터베이스에서 자동으로 값이 증가하는 열 설정
	-- 일반적으로 기본키 컬럼에 사용됨.
CREATE TABLE products (
	product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(250) NOT NULL
);
DESC products;
SELECT * FROM products;
