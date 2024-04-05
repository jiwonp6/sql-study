# ◎ SQL (Structured Query Language)
 : 관계형 데이터베이스(RDBMS)에서 데이터를 관리하기 위해 사용하는 표준화된 언어

 - 데이터 정의 언어 (Data Definition Language) : **DDL**
     -> CREATE, ALTER, DROP, TRUNCATE, RENAME
 - 데이터 조작 언어 (Data Manipulation Language) : **DML**
 - 데이터 질의 언어 (Data Query Language) : **DQL**
 - 데이터 제어 언어 (Data Control Language) : **DCL**
 - 트랜잭션 제어 언어 (Transaction Control Language) : **TCL**

## * **DDL** (Data Definition Language)
 : 데이터의 접근 권한을 제어하고 관리하는 명령어들의 집합

#### - 키 (Key)
 : 데이터의 무결성을 유지하기 위해 사용되는 특별한 속성
   - *기본 키 (Primary Key)* => PK
     - 테이블의 행을 고유하게 식별하는 키 
     - 하나 이상의 컬럼의 조합
     - NULL 불가, UNIQUE
     - 테이블 내의 각 레코드(행)을 유일하게 식별할 수 있어야 함.
   - *외래 키 (Foreign Key)* => FK
     - 다른 테이블의 행(기본 키)을 참조하는 키 
     - 두 테이블 간의 관계 정의시 사용
     - 참조 무결성 유지하는데 사용 
   - 후보 키 : 데이터베이스에 모든 행을 유일하게 식별할 수 있는 속성들의 집합
     - 후보키에서 기본키가 선택
   - 대체 키 : 후보 키 중 기본 키로 선택되지 않은 키
   - 복합 키 : 두 개 이상의 속성을 조합하여 만든 키
   - 고유 키 : 모든 행에 대해서 고유한 값을 가져야 하는 속성 (NULL 허용)

#### - 제약조건 (Constraint)
- 무결성(Integrity) : DB에서 저장된 데이터의 일관성과 정확성을 지키는 것.
 1. NOT NULL
     - 해당 컬럼(속성)에는 NULL 값이 허용되지 않음.
     - 반드시 유효한 값이 있어야 함.
 2. UNIQUE
     - 해당 컬럼의 각 행은 서로 다른 값을 가져야 함.
     - 중복된 값 불가
     - NULL 가능
 3. PRIMARY KEY
     - 각 행을 유일하게 식별할 수 있는 열(또는 열의 조합)
     - NOT NULL, UNIQUE
 4. FOREIGN KEY
     - 한 테이블의 열이 다른 테이블의 PK를 참조
     - 참조 무결성 유지
     - 테이블의 관계를 정의
 5. CHECK
     - 해당 속성(컬럼, 열)에서 입력될 수 있는 데이터의 범위를 제한
     - 조건을 만족하는 데이터만 입력 가능
     - 예시 : 0 < 나이 < 200 : 특정 범위
 6. DEFAULT
     - 해당 속성에 대한 기본 값을 설정
     - 값이 명시 되지 않으면 지정된 기본 값이 자동으로 입력
 7. AUTO_INCREMENT
     - MySQL에서 사용하는 특수 제약조건
     - 기본 키에 주로 사용되고, 새로운 행(row, 레코드)가 추가 될 때마다 자동으로 숫자 증가
 8. BINARY (B)
     - 해당 컬럼이 이진데이터
 9. UNSIGNED
     - 부호가 존재하지 않음. 음수값을 허용하지 않음 => 양수
 10. ZEROFILL
     - 해당 숫자의 열이 특정 길이로 고정되어야 하는 경우
     - 해당길이보다 부족하면 왼쪽에 0이 채워짐
     - 예시. 007
 11. GENERATED
     - 해당 열의 값이 자동으로 생성.

#### - 속성 데이터 타입
 1. 숫자형 데이터 타입
   - INT : 정수 4byte
   - DECIMAL(M, N) : 고정 소수점 숫자, 정확한 소수 계산에 필요 M 총 자릿수, N 소수점 이하 자릿수
   - FOLAT, DOUBLE : 부동 소수점 소수 4byte, 8byte

 2. 문자열 데이터 타입
   - CHAR(N) : 고정 길이 문자열, N은 문자열의 길이, 문자열이 N보다 짧으면 공백으로 채워짐.
   - VARCHAR(N) : 가변 길이 문자열, N은 문자열의 최대 길이, 실제 사용된 길이만큼만 저장공간 차지. 
                  => 기본값 255 바이트, MYSQL 버전에 따라 최대 바이트가 다름
   - TEXT : 긴 텍스트를 저장 최대 65,535 바이트
   - MEDIUMTEXT : 최대 16MB까지 저장
   - LONGTEXT : 최대 4GB까지 저장

 3. 날짜 시간 데이터타입
   - DATE : 'YYYY-MM-DD'
   - TIME : 'HH:MM:SS'
   - DATETIME : 'YYYY-MM-DD HH:MM:SS'
   - TIMESTAMP : 유닉스 타임스탬프 기반 날짜 시간정보 저장 (1970-01-01 -> 32비트 정수)
   
 4. 이진 데이터 타입
   - BINARY(N) : 고정길이 이진데이터 (이미지, 파일 등 저장에 사용)
   - VARBINARY(N) : 가변길이
   - BLOB : 이진 대용량 객체 저장에 사용 Binary Large OBject, 4GB 저장

 5. 논리 데이터 타입
   - BOOLEAN : TRUE, FALSE 값 저장, 내부적으로 TINYINT(1)로 처리 => 0 또는 1
   
 6. 열거형
   - ENUM : 미리 정의된 값 중 하나를 저장 ENUM('mon', 'tue', 'wed' ...)

#### - 도메인 무결성 제약조건
   - 릴레이션 내 튜플들이 각 속성의 도메인에 지정된 값만 가져야 하는 조건
   - 데이터 타입, null 허용 또는 not null, default, check 제약 조건 등으로 제약조건을 가짐

### (1) CREATE : 테이블 생성
   - CREATE : DDL (데이터 정의어)
   - 데이터베이스 생성
```SQL
CREATE DATABASE 데이터베이스명;
CREATE DATABASE IF NOT EXISTS 데이터베이스명;  -- 데이터베이스 존재 확인하고 만듦
USE 데이터베이스명;  -- 특정 데이터베이스 사용
```
   - 테이블 생성
```SQL
CREATE TABLE 테이블명 (
   컬럼명1 데이터타입 제약조건,
   컬럼명2 데이터타입 제약조건,
   ...
   ...
   PRIMARY KEY (하나 또는 그 이상의 컬럼)
);
```
#### - 외래 키 참조
 - 참조 무결성 제약조건
 - 한 테이블의 컬럼이 다른 테이블의 키(기본 키)를 참조
 - 외래키 컬럼에 참조 위치에 존재하지 않는 값을 넣을 경우
 - 참조 무결성을 위반하게 되어 실행되지 않는다. (참조 무결성 제약조건)
 - 데이터 관계의 일관성을 보장

 ```sql
 FOREIGN KEY (컬럼명) REFERENCES 참조할테이블명(참조할컬럼(기본키)명)
 ON DELETE [CASECADE/SET NULL/NO ACTION/SET DEFAULT]          -- 삭제할 때 옵션
 ON UPDATE [CASECADE/SET NULL/NO ACTION/SET DEFAULT]          -- 수정할 때 옵션
 ```

#### - 레퍼런스 옵션
   1. CASECADE
     - 부모 테이블(참조하는 테이블)에서 삭제되거나 키 값이 변경되면
     - 자식 테이블에서도 동일하게 삭제되거나 변경 됨
     - 일관성을 유지하는데 도움이 되는 옵션
   2. SET NULL
     - 부모 테이블(참조하는 테이블)에서 삭제되거나 키 값이 변경되면
     - 자식 테이블(외래 키를 가진 테이블)의 행의 열이 NULL로 변경됨
     - 관련 데이터를 삭제하지 않고 유지
   3. NO ACTION
     - 참조된 행의 변경 또는 삭제 자체를 하지 않음
   4. SET DEFAULT
     - 삭제나 수정될 때 사전에 정의된 기본 값으로 설정

### (2) ALTER
 - DDL (데이터 정의어), 데이터베이스 및 객체의 구조를 수정하는데 사용
 - ALTER TABLE
   - 테이블의 열을 추가, 삭제, 타입 변경 등의 수정 작업을 할 수 있음.
   1. ADD : 추가
      ```SQL
      ALTER TABLE 테이블명
      ADD 컬럼명 데이터 타입
      ```
   2. DROP : 삭제
      ```SQL
      ALTER TABLE 테이블명
      DROP COLUMN 컬럼명
      ```
   3. MODIFY : 데이터 타입 수정
      ```SQL
      ALTER TABLE 테이블명
      MODIFY COLUMN 컬럼명 새로운 데이터 타입
      ```
   4. CHANGE : 열이름 변경 (MySQL의 경우)
      ```SQL
      ALTER TABLE 테이블명
      CHANGE COLUMN 컬럼명 새로운컬럼명 새로운데이터타입;
      ```
   5. RENAME : 테이블 이름 변경
      ```SQL
      ALTER TABLE 테이블명
      RENAME TO 새로운테이블명;
      ```

#### - CONSTRAINT 제약조건명 (제약조건 이름 명시하기)
 - 제약조건은 생성 시 이름을 생략하고 만들 수 있음
 - 생략하고 만들 경우 자동으로 제약조건의 이름이 부여됨
 - 생성 시 `CONSTRAINT 제약조건명` 이 부여되면, 제약조건 이름을 명시할 수 있음
 - 제약조건의 이름을 확인하기 위해서는 DB객체나 DDL을 확인하면 됨
```sql
-- 1. information_schema 오브젝트를 통해 확인
   -- CONTRAINT_NAME 필드 : 제약조건의 이름
   SELECT * FROM information_schema.table_constraints
   WHERE table_name = '테이블명';  -- 테이블명

-- 2. DDL을 통해 확인
   SHOW CREATE TABLE 스키마명.테이블명;
-- 워크벤치의 경우 open value in viewer
   SHOW CREATE TABLE 테이블명;
```