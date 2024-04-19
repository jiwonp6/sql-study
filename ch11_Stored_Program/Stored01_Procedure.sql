CREATE SCHEMA store;
USE store;

/* 스토어드 프로시저의 작성 */
-- 프로시저 내의 구분자(;)를 변경
DELIMITER $$	
CREATE PROCEDURE userProc ()
BEGIN
	SELECT * FROM usertbl;
END$$
-- 구분자를 원래대로 복원
DELIMITER ;

/* 스토어드 프로시저의 호출 */
CALL userProc();

/* 1. 매개변수 사용하기 */
DELIMITER $$
CREATE PROCEDURE userProc1 (IN userName VARCHAR (10))
BEGIN
	SELECT * FROM usertbl WHERE name = userName;
END$$
DELIMITER ;

CALL userProc1('김범수');
CALL userProc1('바비킴');

/* 2. 매개변수 여러 개 사용하기 */
DELIMITER $$
CREATE PROCEDURE userProc2 (IN userBirth INT, IN userHeight INT)
BEGIN
	SELECT * FROM usertbl WHERE birthYear > userBirth AND height > userHeight;
END$$
DELIMITER ;

CALL userProc2(1980, 170);

/* 3. 출력 매개변수 사용하기 */
DELIMITER $$
CREATE PROCEDURE userProc3 (IN textValue CHAR(10), OUT outValue INT)
BEGIN
	INSERT INTO testtbl VALUES (null, textValue);
    SELECT max(id) INTO outValue FROM testtbl;
END$$
DELIMITER ;
-- 프로시저 작성 시점에는 테이블 없어도 작성 O -> but, 호출 시점에는 존재해야 한다.

CREATE TABLE testtbl (
	id INT PRIMARY KEY AUTO_INCREMENT,
    text char(255)
);

-- 첫 번째 매개변수(IN)는 저장 프로시저의 INSERT 문에 사용되고
-- 두 번째 매개변수(OUT)는 해당 변수 (@val)에 SELECT문의 결과가 저장된다
CALL userProc3('테스트', @val);
SELECT * FROM testtbl;
SELECT @val;

/* 4. INOUT : 입력된 값을 변경하여 호출 결과로 반환 */
DELIMITER $$
CREATE PROCEDURE swap (INOUT a INT, INOUT b INT)
BEGIN
	SET @temp = a;
	SET a = b;
	SET b = @temp;
END$$
DELIMITER ;

SET @a = 7, @b = 5;
CALL swap (@a, @b);

SELECT @a, @b;

/* 5. 조건문 */
DELIMITER $$
CREATE PROCEDURE ifelseProc (IN userName VARCHAR(10))
BEGIN
	DECLARE bYear INT;	-- 변수 선언 (저장 프로시저 내부에서 선언 및 사용)
    SELECT birthYear INTO bYear FROM usertbl WHERE name = userName;
    
    IF (bYear >= 1980) THEN 
		SELECT '젊습니다.';
    ELSE 
		SELECT '중년입니다.';
	END IF;
END$$
DELIMITER ;

CALL ifelseProc ('이승기');

/* 6. CASE문 */
DELIMITER $$
CREATE PROCEDURE caseProc (IN userName VARCHAR(10))
BEGIN
	DECLARE bYear INT;		-- 생년
	DECLARE tti CHAR(3);	-- 띠
    SELECT birthYear INTO bYear FROM usertbl WHERE name = userName;
    
    CASE 
		WHEN (bYear % 12 = 0) THEN SET tti = '원숭이';
		WHEN (bYear % 12 = 1) THEN SET tti = '닭';
		WHEN (bYear % 12 = 2) THEN SET tti = '개';
		WHEN (bYear % 12 = 3) THEN SET tti = '돼지';
		WHEN (bYear % 12 = 4) THEN SET tti = '쥐';
		WHEN (bYear % 12 = 5) THEN SET tti = '소';
		WHEN (bYear % 12 = 6) THEN SET tti = '호랑이';
		WHEN (bYear % 12 = 7) THEN SET tti = '토끼';
		WHEN (bYear % 12 = 8) THEN SET tti = '용';
		WHEN (bYear % 12 = 9) THEN SET tti = '뱀';
		WHEN (bYear % 12 = 10) THEN SET tti = '말';
		WHEN (bYear % 12 = 11) THEN SET tti = '양';
    END CASE;
    SELECT tti;
END$$
DELIMITER ;

CALL caseProc('이승기');

/* 7. WHILE문 */
DELIMITER $$
CREATE PROCEDURE printNum ()
BEGIN
	DECLARE counter INT DEFAULT 1;
    WHILE counter <= 5 DO 
		SELECT counter;				-- 숫자 표시
		SET counter = counter + 1;	-- 1씩 증가
	END WHILE;
END$$
DELIMITER ;

CALL printNum();

/* 8. 예외처리 */
-- DECLARE 액션[CONTINUE|EXIT] HANDLER FOR 오류조건 처리할 문장
-- 존재하지 않는 테이블 조회 시 에러코드 1146

DELIMITER $$
CREATE PROCEDURE errorProc ()
BEGIN
	DECLARE CONTINUE HANDLER FOR 1146 SELECT '존재하지 않는 테이블' AS 'error message';
    SELECT * FROM notable;
END$$
DELIMITER ;

CALL errorProc();

/* 그 외 문법*/
-- 프로시저 목록 표시
SHOW PROCEDURE STATUS;
SHOW PROCEDURE STATUS WHERE DB LIKE 'store';

-- 프로시저 정의 확인
SHOW CREATE PROCEDURE userProc;
