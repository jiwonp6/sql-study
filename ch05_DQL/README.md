# ◎ SQL (Structured Query Language)
 : 관계형 데이터베이스(RDBMS)에서 데이터를 관리하기 위해 사용하는 표준화된 언어

 - 데이터 정의 언어 (Data Definition Language) : **DDL**
 - 데이터 조작 언어 (Data Manipulation Language) : **DML**
 - 데이터 질의 언어 (Data Query Language) : **DQL**
     -> SELECT, GROUPING, JOIN, SUBQUERY, BUILTINFUNCTION
     (WHERE - NOT, BETWEEN ~ AND, IN(), LIKE, ORDER BY, LIMIT, OFFSET, DISTINCT)
 - 데이터 제어 언어 (Data Control Language) : **DCL**
 - 트랜잭션 제어 언어 (Transaction Control Language) : **TCL**

## * **DQL** (데이터 질의어)
 - DB에서 데이터를 조회하는 데 사용
 - 데이터를 조작하거나 수정하지는 않음.
 - DB 서버에 Data를 요청하는 것
### (1) SELECT
 - 기본 구조
```sql
-- 특정 열 선택 : Projection (π) Attribute
SELECT 컬럼명1, 컬럼명2, ...
  FROM 테이블명;

-- 테이블의 모든 데이터 조회
SELECT *
  FROM 테이블명;

-- 특정 조건 선택 : Selection (σ) Condtion 
SELECT 컬럼명1, 컬럼명2, ...
  FROM 테이블명
  WHERE 조건식;

```
 - * (asterisk) : 테이블의 모든 열 선택
 - 셀렉션 (+ 컨디션)
   - σ 가격 > 8000 (상품) : 가격이 8000원 이상인 행들만 선택
      `SELECT * FROM 상품 WHERE 가격 > 8000;`
 - 프로젝션 (+ 애트리뷰트)
   - π 이름, 주소 (고객) : 고객 테이블에서 이름 주소 속성만 선택
      `SELECT 이름, 주소 FROM 고객`

- 별칭 (AS) 사용하기
   `SELECT 컬럼명 AS 별칭 FROM 테이블명 AS 별칭`
   1. 컬럼명에 별칭을 지정하면 쿼리 결과의 헤더로 사용
   2. 테이블명에 별칭을 사용하면 쿼리문의 테이블을 간결하게 사용할 수 있음 -> 조인문에 사용
   3. AS 생략 가능

#### * 메소드 
- BETWEEN ... AND
   - 특정 범위 내 값을 찾기
   ```SQL
   SELECT 컬럼명, ...
    FROM 테이블명
    WHERE 컬럼명 BETWEEN 범위1 AND 범위2;
   ```
   - 특정 컬럼의 범위를 조회하고 범위1, 범위2값 모두 포함
   - 날짜, 숫자, 문자열 등 사용가능

- IN
   - 주어진 목록 안의 값들 중 하나와 일치하는 행 => OR 조건
   ```SQL
   SELECT 컬럼명, ...
    FROM 테이블명
    WHERE 컬럼명 IN (값1, 값2, ...);
   ```
   - IN : 컬럼 = 값1 OR 컬럼 = 값2;
   - NOT IN : 컬럼 !=값1 AND 컬럼 !=값2;

- LIKE
   - 문자열 패턴 매칭
   - '%': 0개 이상의 아무 문자, '_': 정확한 한 문자 대신
   ```SQL
   SELECT 컬럼명, ...
    FROM 테이블명
    WHERE 컬럼명 LIKE '패턴';
   ```
   - A로 시작하는 경우 'A%'
   - A를 포함하는 경우 '%A%'

 - ORDER BY
   - 단일열 또는 두 개 이상의 열을 기준으로 오름차순 또는 내림차순으로 정렬
   ```SQL
   SELECT 컬럼명, ...
    FROM 테이블명
    ORDER BY 컬럼명 ASC|DESC, ....;
   ```

 - LIMIT (+ OFFSET)
    - 출력 결과 수 제한
   ```SQL
   SELECT 컬럼명, ...
    FROM 테이블명
    LIMIT 제한할 행개수
    OFFSET 시작할 행번호;
   ```
    - OFFSET과 함께 사용하면 대량의 데이터 페이지네이션에 사용

  - DISTINCT
    - 중복된 결과 제거하고, 유일하고 고유한 값만 남기기 위해 사용
   ```SQL
   SELECT DISTINCT 컬럼명, ...
    FROM 테이블명;
   ```

#### * 집계 함수
  - 데이터베이스에서 여러 행으로부터 단일 결과 값을 도출하는 데 사용
  - 데이터 분석, 요약 등에 유용하게 활용
  - COUNT, SUM, AVG, MIN, MAX 등
  - GROUP BY
    ```sql
    SELECT 그룹기준 컬럼명 ... , 집계함수(집계컬럼)
      FROM 테이블명
      [WHERE 조건식]
      GROUP BY 그룹기준 컬럼명
      [HAVING 그룹 조건식]
      [ORDER BY 정렬기준 컬럼명];
    ```
    - 그룹기준 컬럼명 : 그룹화를 할 기준이되는 열
    - 집계컬럼 : 그룹에 적용할 집계함수의 대상이 되는 열
  - WITH ROLLUP
    - 총합 또는 중간합계가 필요할 때 GROUP BY 절과 함께 사용
    ```sql
    SELECT 그룹기준 컬럼명 ... , 집계함수(집계컬럼)
      FROM 테이블명
      GROUP BY 그룹기준 컬럼명
      WITH ROLLUP;
    ```

#### * 데이터 결합 - JOIN
  - Join : 두 개 이상의 테이블을 묶어서(결합하여) 새로운 결과 집합(result set)을 만들어내는 것
  - Join의 종류
    - 암시적 Join (Implicit Join) : WHERE 절에 JOIN 컨디션을 명시하는 방식
    - 명시적 Join (Explicit Join) : 키워드를 사용해서 테이블을 결합하고, ON 키워드에 JOIN 컨디션 명시하는 방식
        ```sql
          SELECT 테이블명.컬럼명, ..
            FROM 테이블명1
            [INNER|LEFT|RIGHT] JOIN 테이블명2 ON 테이블1.공통컬럼 = 테이블2.공통컬럼
        ```
        - JOIN 다음에 결합한 테이블명
        - ON 다음에 (join condition)
        - 일반적으로 테이블명을 줄인 약칭을 사용
        - JOIN 키워드 앞에 [INNER|LEFT|RIGHT] 생략할 경우 INNER JOIN
      1. Inner Join : 두 테이블의 교집합
          - 양쪽 테이블에 모두 존재하는 데이터를 결합    
      2. Outer Join
          - 다른 테이블 결합이 매칭 되지 않는 경우도 데이터 포함
          (1) Left Outer Join
          (2) Right Outer Join
          (3) Full Outer Join
      3. Self Join : 같은 테이블을 두 번 참조하여 결합
      4. Cross Join : 두 테이블 간의 가능한 모든 조합
          - Cartesian Product
    - 등가 Join (Equi Join) : 등호(=)을 통해서 2개 이상의 테이블 결합
    - 비등가 Join (Non-Equi Join) : 등호를 제외한 비교연산자를 통해 테이블 결합
  - USING 구문과 NATRUAL JOIN
    - USING : 두 테이블에서 공통된 열 이름이 있을 때 유용
    - NATURAL JOIN : 공통 열이 존재할 때 조건 명시 없이 사용
    - 가독성 및 간결성 향상
    - ※ 서로 다른 테이블의 조인 조건과 별개의 동일이름 동일타입이 존재할 경우, 예측 불가능한 결과를 가져올 수 있음

#### * SubQuery(서브쿼리, 부속질의)
  - 다른 SQL 쿼리 내부에 포함되어 있는 쿼리
    - 주 쿼리 (Main Query)
    - 부 쿼리 (Sub Query)
  - 서브쿼리는 괄호 ( ... ) 내부에 작성이 되어 주 쿼리와 구분됨
  - 서브쿼리의 결과는 단일 행 또는 다중 행 결과를 반환
  - 서브쿼리는 주 쿼리보다 먼저 실행되고, 서브쿼리의 결과 주 쿼리에 사용
  - 서브쿼리의 사용
    - WHERE절, SELECT절, FROM절, HAVING절 등 (WHERE절 : 데이터 필터링을 하기 위해 사용)
  1. 단일 행(single row) 서브쿼리
    - 반드시 하나의 행만 반환해야 함
    - 하나의 결과값만 나오는 쿼리를 서브쿼리로 작성하거나 집계함수 등을 사용하여 반드시 하나의 행이 결과값으로 갖도록 보장해야 함
    - 단일행 서브쿼리는 =, >, < 등의 비교연산자와 함께 사용
    ```sql
    SELECT 컬럼명, .. FROM 테이블명 WHERE 조건 = ( 서브쿼리 );
    ```
  2. 다중 행(multi row) 서브쿼리
    - 쿼리 실행 결과로 여러 행을 반환하는 서브쿼리
    - IN, ANY, ALL, EXISTS 등의 연산자와 함께 사용
    ```sql
    SELECT 컬럼명, .. FROM 테이블명 WHERE IN ( 서브쿼리 );
    ```
    (1) IN(서브쿼리) : 메인쿼리의 비교 조건이 서브쿼리 결과 중 하나라도 동일하면 참
    (2) ANY(서브쿼리) : 메인쿼리의 비교 조건이 서브쿼리 결과 중 하나라도 동일하면 참
        - IN은 비교연산자 사용 X, ANY는 비교 연산자 사용 O
    (3) ALL(서브쿼리) : 메인쿼리의 비교 조건이 서브쿼리 결과 중 모두 동일하면 참
        - 비교연산자 사용
        - 비교조건 < ALL (10, 20, 30) : 최소값 (10보다 작은)
        - 비교조건 > ALL (10, 20, 30) : 최대값 (30보다 큰)
    (4) EXISTS(서브쿼리) : 서브쿼리의 결과가 하나라도 존재하면 참
  - 서브쿼리를 사용하는 위치에 따라 분류
    (1) WHERE절 : 특정 기준에 맞는 데이터 필터링을 위해 서브쿼리 사용
    (2) SELECT절 : 서브쿼리를 사용한 결과 값을, 메인쿼리의 결과에 포함
    (3) FROM절 : 인라인 뷰(Inline View), 서브쿼리가 임시 테이블처럼 동작하게 하여 메인 쿼리에 사용

    
#### * 내장함수
  - MySQL에서 사용자 정의 변수 사용하기
      - 사용자 정의 변수는 '@' 기호로 시작
  - 변수 설정
      ```sql
      SET @변수이름 = 값;     -- 변수 선언
      SELECT @변수이름        -- 변수 사용
      ```
  1. 제어흐름 함수 (IF, CASE, IFNULL, NULLIF ...)
  2. 문자열 함수 (CONCAT, SUBSTRING, LENGTH ...)
  3. 수학 함수 (ABS, CEIL, ROUND, FLOOR, SQRT, RAND ...)
  4. 날짜시간 함수 (NOW, CURDATE, CURTIME, DATE, TIME)
  5. 시스템 정보 함수 (USER, DATABASE ...)

