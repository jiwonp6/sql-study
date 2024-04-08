# ● 초보 개발자의 개발 뿌수기!
> 초보 개발자가 되기 위한 걸음마 과정을 학습하는 공간입니다. :grin:   
> 블로그는 여기 :point_right: <https://blog.naver.com/applyzz99>
---
# ● SQL 기초 프로그래밍
### [Index]
1. mySQL 설치 및 GIT 연결
    * SQL (Structured Query Language)
    : 관계형 데이터베이스(RDBMS)에서 데이터를 관리하기 위해 사용하는 표준화된 언어

    * SQL 종류
    1. 데이터 정의 언어 (Data Definition Language) : DDL
        -> CREATE, ALTER, DROP
    2. 데이터 조작 언어 (Data Manipulation Language) : DML
        -> INSERT, UPDATE, DELETE
    3. 데이터 질의 언어 (Data Query Language) : DQL
        -> SELECT, GROUPING, JOIN
    4. 데이터 제어 언어 (Data Control Language) : DCL
        -> GRANT, REVOKE
    5. 트랜잭션 제어 언어 (Transaction Control Language) : TCL
        -> 
2. DCL
    - GRANT
        : 특정 사용자나 사용자 그룹에게 특정 데이터베이스(스키마)나 특정 테이블에서 명령할 수 있는 권한 부여
    - REVOKE
        : 사용자에게 부여된 권한이 더이상 필요하지 않거나 보안 상의 이유로 권한 회수할 때 사용
3. DDL
    - CREATE
        : DDL, 데이터베이스 생성
    - ALTER
	    : DDL, 데이터베이스 및 객체의 구조 수정 시 사용
4. DML
    - INSERT
        : DB의 테이블에 새로운 데이터 행을 추가하는데 사용하는 SQL
    - UPDATE
        : 테이블의 기존 행(튜플)에서, 하나 이상의 열(속성) 데이터를 수정할 때 사용
    - DELETE
        : 테이블에서 특정 조건을 만족하는 행을 삭제
5. DQL
    - SELECT
        : 선택 조건을 만족하는 정보 조회 시 사용
    - GROUPING (집계 함수)
        : 데이터베이스에서 여러 행으로부터 단일 결과 값을 도출하는 데 사용 (COUNT, SUM, AVG, MIN, MAX 등)
    - JOIN
        : 두 개 이상의 테이블을 묶어서(결합하여) 새로운 결과 집합(result set)을 만들어내는 것