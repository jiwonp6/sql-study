USE store;

-- 스토어드 함수 생성 반환 허용
SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER $$
CREATE FUNCTION userFunc (value1 INT, value2 INT)
	RETURNS INT
BEGIN
	RETURN value1 + value2;
END$$
DELIMITER ;

-- 저장 함수 사용
SELECT userFunc(10, 20);

/* 출생년도를 입력하고 나이가 출력되는 함수 */
DELIMITER $$
CREATE FUNCTION getAgeFunc (bYear INT)
	RETURNS INT
BEGIN
	DECLARE age INT;
    SET age = year(curdate()) - bYear + 1;
	RETURN age;
END$$
DELIMITER ;

SELECT getAgeFunc(1980);

-- 내장함수처럼 sql문과 연결하여 사용 가능
SELECT name, getAgeFunc(birthYear) FROM usertbl;

-- 저장함수 확인
SHOW CREATE FUNCTION getAgeFunc;

-- 함수 삭제
DROP FUNCTION getAgeFunc;
