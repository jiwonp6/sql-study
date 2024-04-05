# ◎ SQL (Structured Query Language)
 : 관계형 데이터베이스(RDBMS)에서 데이터를 관리하기 위해 사용하는 표준화된 언어

 - 데이터 정의 언어 (Data Definition Language) : **DDL**
 - 데이터 조작 언어 (Data Manipulation Language) : **DML**
     -> INSERT, UPDATE, DELETE
 - 데이터 질의 언어 (Data Query Language) : **DQL**
 - 데이터 제어 언어 (Data Control Language) : **DCL**
 - 트랜잭션 제어 언어 (Transaction Control Language) : **TCL**

## * **DML** (데이터 조작어)
### (1) INSERT (데이터 삽입)
 - DB의 테이블에 새로운 데이터 행을 추가하는데 사용하는 SQL
```sql
-- 컬럼을 지정하는 방식
-- INSERT문에 명시된 열의 순서대로 값을 입력
INSERT INTO 테이블명 (컬럼명1, 컬럼명2, ...)
  VALUES (값1, 값2, ...)

-- 컬럼을 지정하지 않는 방식
-- 테이블 정의(DDL)에 명시된 열의 순서대로 값을 입력해야 됨
INSERT INTO 테이블명
  VALUES (값1, 값2, ...)

-- 여러 행을 동시에 삽입하기
INSERT INTO 테이블명 (컬럼명1, 컬럼명2, ...)
  VALUES (값1, 값2, ...)
```
 - ※ 주의사항
   - 해당 열의 데이터 타입 또는 제약조건을 준수하지 않으면 삽입할 수 없음
   - NOT NULL : 반드시 값을 입력해야 함
   - UNIQUE : 중복값을 넣을 수 없음
   - AUTO_INCREMENT : 값을 명시하지 않아도 자동 값 할당
   - 데이터 무결성을 유지

 - 대량의 샘플 데이터 삽입
   - SELECT문으로 조회한 다른 테이블의 데이터를 대량으로 입력
   - 테이블의 컬럼과 SELECT문으로 조회한 컬럼의 데이터타입이 일치해야 함
```sql
INSERT INTO 테이블명 (컬럼명1, 컬럼명2, ...)
  SELECT문;
```

### (2) UPDATE (데이터 수정)
   - 테이블의 기존 행(튜플)에서, 하나 이상의 열(속성) 데이터를 수정할 때 사용
   ```SQL
   UPDATE 테이블명
    SET 컬럼명1=값1, 컬럼명2=값2, ....
    WHERE 조건문;
   ```
   - SET : 하나 이상의 열(속성) 데이터를 수정, 콤마로 구분
   - WHERE절 : 어떤 행을 수정할지 결정
   - WHERE절을 생략하면 테이블의 모든 행이 수정됨 (주의)
   - 데이터 수정 작업을 진행할 때에도, 데이터 타입과, 제약 조건들을 준수하여 무결성 위반되지 않게 해야 함

#### - WHERE 절
   - SQL 쿼리에서 데이터를 필터링하기 위해 사용되는 조건절
   - condition (조건문) 및 논리, 비교 연산자를 사용해서 특정 기준 만족하는 데이터만 선택

   1. 비교 연산자
      - '=' : 같다
      - '!=' 또는 '<>' : 같지 않다.
      - '>', '>=' : 크다, 크거나 같다.
      - '<', '<=' : 작다, 작거나 같다.
   2. 논리 연산자
      - AND : 모든 조건 참이면 참     (조건1 AND 조건2)
      - OR : 조건 하나라도 참이면 참   (조건1 OR 조건2)
      - NOT : 조건 결과 반전          (NOT 조건1)

### (3) DELETE (삭제)
   - 테이블에서 특정 조건을 만족하는 행을 삭제
   ```SQL
   DELETE FROM 테이블명
    WHERE 조건문;
   ```
   - WHERE절을 생략하면 테이블의 모든 행이 삭제됨 (주의)
   - 정확한 조건을 지정하지 않으면 의도하지 않은 데이터가 삭제
   - 한 번 삭제된 데이터는 복구되지 않으므로 데이터 백업에 주의
   - 참조 무결성 제약조건을 위배할 경우 데이터 삭제에 실패하거나 연쇄적(CASCADE 레퍼런스 옵션)으로 삭제될 수 있음
   