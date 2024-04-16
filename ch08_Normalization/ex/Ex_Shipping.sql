CREATE SCHEMA nomarlization;
USE nomarlization;

-- 선박 정보를 저장하는 테이블
-- 함수 종속관계 : shipname -> shiptype
CREATE TABLE ship(
	shipname VARCHAR(255) PRIMARY KEY,
    shiptype VARCHAR(255)
);

-- 항해정보를 저장하는 테이블
-- 함수 종속관계 : voyageID -> shipname, cargo
CREATE TABLE voyage(
	voyageID INT PRIMARY KEY,
    shipname VARCHAR(255),
    cargo VARCHAR(255),
    FOREIGN KEY (shipname) REFERENCES ship(shipname)	-- 공유 컬럼을 외래키로
);

-- 항해 날짜와 항국 정보를 저장하는 테이블
-- 함수 종속성 : voyageID, date -> port
CREATE TABLE voyageDetail(
	voyageID INT,
	date DATE,
	port VARCHAR(255),
    PRIMARY KEY (voyageID, date),
    FOREIGN KEY (voyageID) REFERENCES voyage(voyageID)
);

DESC ship;
DESC voyage;
DESC voyageDetail;

INSERT INTO ship 
	VALUES ('한라호', '화물선'), ('백두호', '여객선');
SELECT * FROM ship;

INSERT INTO voyage 
	VALUES (101, '한라호', '화물컨테이너'), (102, '백두호', '고객화물');
SELECT * FROM voyage;    

INSERT INTO voyageDetail 
	VALUES (101, '2024-04-15', '부산'), (102, '2024-04-16', '인천');
SELECT * FROM voyageDetail;

-- 테이블 조인해서 보기
SELECT * 
	FROM voyage v 
	JOIN voyageDetail vd USING(voyageID)
	JOIN ship s USING(shipname);