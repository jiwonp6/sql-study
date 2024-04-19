# ◎ 데이터베이스 설계

## * 스토어드 프로그램
- MySQL 안에서 프로그래밍 언어와 같은 기능을 제공하는 것
- 일반 쿼리를 묶어주거나 프로그래밍 기능을 제공

### 스토어드 프로시저(Stored Procedure)
- SQL 명령어들을 미리 모아서 저장해두고 필요할 떄 호출해서 사용할 수 있는 코드 블록

- 기본 구조
   - 프로시저 이름 : 식별자
   - 매개변수
      - IN : 입력매개변수
      - OUT : 출력 매개변수 (호출 결과 전달)
      - INOUT : 입력된 값을 변경하여 호출 결과로 반환
   - SQL문
   - 조건문, 반복문, 예외처리 등이 사용 가능
   - 프로시저 시작과 종료
   - 구분자 변경
   - 프로시저 삭제
```sql
DELIMITER $$                    -- 프로시저 내의 구분자(;)를 변경

CREATE PROCEDURE 프로시저이름 (
   [IN/OUT] 매개변수1 타입,      -- 입력 또는 출력 매개변수
   [IN/OUT] 매개변수2 타입 ...
);
BEGIN                           -- 프로시저 시작
   -- SQL 본문... (;)
   -- SQL 본문... 또는 제어문
END                             -- 프로시저 종료

DELIMITER ;                     -- 구분자를 원래대로 복원

DROP PROCEDURE 프로시저명        -- 프로시저 삭제하기
```

### 동적 SQL
- 실행 시점의 SQL문을 미리 생성하고 실행하는 기술
- 사용자의 입력에 따라 SQL문이 변경되어야 할 때 유용하게 사용

- 구문
   - PREPARE : 문자열로 생성된 쿼리를 실행 준비 상태로 만듦
   - EXECUTE : 준비된 쿼리를 실행
   - DEALLOCATE PREPARE : 준비된 쿼리를 메모리에서 해제

## * 스토어드 함수
- MySQL에서 사용하는 내장 함수처럼 사용자가 직접 함수를 만들어 사용할 수 있음
```SQL
DELIMITER $$
CREATE FUNCTION 함수명 (매개변수명1 타입, 매개변수명2 타입...)
   RETURNS 리턴함수
BEGIN
   -- 함수 본문...
   RETURN 반환값;
END$$
DELIMITER ;
```

### 커서
- 데이터베이서의 쿼리 결과를 순회하고 조작하기 위한 개체
- 커서 사용 방법
   1. 커서 선언 : DECLARE CURSOR
   2. 반복 조건 선언 : DECLARE CONTINUE HANDLER
   3. 커서 열기 : OPEN
      - LOOP 반복 구간 지정
   4. 커서에서 데이터 가져오기 : FETCH
   5. 데이터 처리 : 가져온 데이터로 원하는 작업 수행
      - END LOOP 반복 종료
   6. 커서 닫기 : CLOSE

### 트리거
- 테이블과 관련하여 DML의 이벤트가 발생될 때 작동하는 DB 개체
   ```sql
   CREATE TRIGGER 트리거이름
      BEFORE|AFTER INSERT|UPDATE|DELETE  -- 시점과 이벤트
      ON 테이블명    -- 이벤트가 발생할 테이블
      FOR EACH ROW
   BEGIN
      트리거 본문
   END
   ```
- 트리거의 종류
   - AFTER 트리거
      - DML(INSERT, UPDATE, DELETE) 작업이 작동했을 때 작동하는 트리거
   - BEFORE 트리거
      - DML 이벤트가 발생하기 전에 작동하는 트리거
- 주의점
   - 무한 루프를 방지해야 함(트리거가 테이블A에 작동하고 작동한 트리거에서 테이블A를 조작할 경우 등)
   - 트리거는 너무 복잡하게 작성하면 안됨
   - 다른 작업 티어에서 트리거 인지하기 어려울 수 있음