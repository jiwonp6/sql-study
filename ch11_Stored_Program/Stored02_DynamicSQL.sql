-- 동적 SQL
USE store;

-- 준비된 문장에서 ? 로 향후 입력될 값을 비워놓고 USING 키워드를 이용하여 값을 전달

-- 1. sql문 준비
PREPARE myQuery FROM 'SELECT * FROM usertbl WHERE userId = ?';
-- 2. sql문 실행
SET @userId = 'BBK';
EXECUTE myQuery USING @userId;
-- 3. 준비된 문장 메모리 해제
DEALLOCATE PREPARE myQuery;

/* 변수 2개 이상 */
SET @userId = 'BBK';
SET @userName = '바비킴';
SET @sql = 'SELECT * FROM usertbl WHERE userId = ? AND name = ?';

PREPARE statement FROM @sql;
EXECUTE statement USING @userId, @userName;	-- 2개 이상의 변수 -> 순서대로 대입
DEALLOCATE PREPARE statement;

-- -- -- --

SET @tableName = 'buytbl';
SET @columnName = 'price';
SET @limitPrice = 100;
SET @query = concat('SELECT * FROM ', @tableName, ' WHERE ', @columnName, '> ?');

PREPARE stmt FROM @query;
EXECUTE stmt USING @limitPrice;
DEALLOCATE PREPARE stmt;