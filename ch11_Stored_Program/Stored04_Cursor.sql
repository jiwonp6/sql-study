-- 커서
USE store;

DROP PROCEDURE cursorProc;

/* 테이블의 키 속성을 가져와 평균 키 구하는 프로시저(커서 활용) */
DELIMITER $$
CREATE PROCEDURE cursorProc ()
BEGIN
	DECLARE userHeight INT;					-- 키 변수 선언
	DECLARE cnt INT DEFAULT 0;				-- 고객 수(= 읽은 챙의 수)
    DECLARE totalHeight INT DEFAULT 0;		-- 키 합계
    DECLARE endOfRow BOOLEAN DEFAULT FALSE;	-- 행이 끝났는지 여부
    
    -- 1. 커서 선언
    DECLARE userCursor CURSOR FOR
		SELECT height FROM usertbl;
	-- 2. 반복 조건 선언
    DECLARE CONTINUE HANDLER FOR
		NOT FOUND SET endOfRow = TRUE;
	
    -- 3. 커서 열기
    OPEN userCursor;
	
    cursorLOOP : LOOP	-- 반복 구간
		-- 4. 커서에서 데이터 가져오기
        -- 커서에 있는 데이터를 userHeight 변수에 대입
		FETCH userCursor INTO userHeight;
        
		-- 끝 행(TRUE)이면 루프 종료
        IF endOfRow THEN	
			LEAVE cursorLoop; 
		END IF;
        
        -- 5. 데이터 처리
        -- 읽을 행의 수를 증가시키고 읽은 값을 합계에 더함
        SET cnt = cnt + 1;							
        SET totalHeight = totalHeight + userHeight;
    END LOOP cursorLoop;
    
    -- 6. 커서 닫기
    CLOSE userCursor;
    
    SELECT totalHeight / cnt;
END$$
DELIMITER ;

-- 프로시저 실행
CALL cursorProc();