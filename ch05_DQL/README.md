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

