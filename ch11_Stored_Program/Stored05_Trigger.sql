-- 트리거
USE store;

-- usertbl 테이블의 데이터에 변경이 일어나면 backup 테이블에 자동으로 작동하는 트리거 생성
SELECT * FROM usertbl;

/* UPDATE */
DROP TABLE backup_usertbl;
CREATE TABLE backup_usertbl (
  backupId INT PRIMARY KEY AUTO_INCREMENT,
  userID char(8) NOT NULL,
  name varchar(10) NOT NULL,
  birthYear int NOT NULL,
  addr char(2) NOT NULL,
  mobile1 char(3) DEFAULT NULL,
  mobile2 char(8) DEFAULT NULL,
  height smallint DEFAULT NULL,
  mDate date DEFAULT NULL,
  modtype CHAR(10), 	-- 데이터 변경 타입
  modDate DATE,			-- 데이터 변경 날짜
  modUser VARCHAR(255)	-- 데이터 변경 사용자
);

drop trigger updateTrg;
DELIMITER $$
CREATE TRIGGER updateTrg
	AFTER UPDATE		-- 업데이트 작업이 일어난 이후
    ON usertbl			-- 해당 테이블에서 데이터가 변경되면
    FOR EACH ROW		-- 각 행마다 적용
BEGIN
	-- 백업 테이블에 수정 이전 정보 추가
	INSERT INTO backup_usertbl 
		VALUES (null, OLD.userID, OLD.name, OLD.birthYear, OLD.addr, OLD.mobile1, OLD.mobile2, OLD.height, OLD.mDate, 'modify', curdate(), current_user());
END$$
DELIMITER ;

-- UPDATE문이 수행된 후 트리거 작동
UPDATE usertbl SET addr = '제주' WHERE userId = 'EJW';

SELECT * FROM usertbl;
SELECT * FROM backup_usertbl;

/* DELETE */
drop trigger deleteTrg;
DELIMITER $$
CREATE TRIGGER deleteTrg
	AFTER DELETE		-- 삭제 작업이 일어난 이후
    ON usertbl			-- 해당 테이블에서 데이터가 변경되면
    FOR EACH ROW		-- 각 행마다 적용
BEGIN
	-- 백업 테이블에 수정 이전 정보 추가
	INSERT INTO backup_usertbl 
		VALUES (null, OLD.userID, OLD.name, OLD.birthYear, OLD.addr, OLD.mobile1, OLD.mobile2, OLD.height, OLD.mDate, 'delete', curdate(), current_user());
END$$
DELIMITER ;

DROP TABLE buytbl;		-- userid의 참조무결성 제거를 위해 삭제
DELETE FROM usertbl WHERE height > 175;

SELECT * FROM usertbl;
SELECT * FROM backup_usertbl;

-- 트리거 목록 확인하기
SHOW TRIGGERS FROM store;
