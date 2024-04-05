# ◎ SQL (Structured Query Language)
 : 관계형 데이터베이스(RDBMS)에서 데이터를 관리하기 위해 사용하는 표준화된 언어

 - 데이터 정의 언어 (Data Definition Language) : **DDL**
 - 데이터 조작 언어 (Data Manipulation Language) : **DML**
 - 데이터 질의 언어 (Data Query Language) : **DQL**
 - 데이터 제어 언어 (Data Control Language) : **DCL**
     -> GRANT, REVOKE
 - 트랜잭션 제어 언어 (Transaction Control Language) : **TCL**

## * **DCL** (Data Control Language)
 : 데이터의 접근 권한을 제어하고 관리하는 명령어들의 집합
 1. GRANT : 권한 부여
     - 특정 사용자나 사용자 그룹에게
     - 특정 데이터베이스(스키마)나 특정 테이블에서
     - 명령할 수 있는 권한 부여
     - 예시
    ```SQL
    GRANT SELECT ON database_name.table_name
    TO '사용자명'@'호스트명';
    ```
 2. REVOKE : 권한 회수
     - 사용자에게 부여된 권한이 더이상 필요하지 않거나
     - 보안 상의 이유로 권한 회수할 때 사용
    ```SQL
    REVOKE SELECT ON database_name.table_name
    FROM '사용자명'@'호스트명';
     ```
     - 권한 부여나 회수는 DB의 보안과 직접적인 관련이 있으므로 신중히 할 것.
     - 일반적으로 사용자에게 최소한(필요한)의 권한만 부여하는 **최소 권한 원칙** 따름.
     - 데이터에 대한 무단 접근을 방지하고, 시스템 보안 수준을 높일 수 있음.
