# ◎ SQL (Structured Query Language)
 : 관계형 데이터베이스(RDBMS)에서 데이터를 관리하기 위해 사용하는 표준화된 언어

 - 데이터 정의 언어 (Data Definition Language) : **DDL**
 - 데이터 조작 언어 (Data Manipulation Language) : **DML**
 - 데이터 질의 언어 (Data Query Language) : **DQL**
     -> SELECT 
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


