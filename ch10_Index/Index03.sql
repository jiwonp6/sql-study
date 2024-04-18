-- 테이블 스페이스
-- 시스템 변수에서 데이터 파일 확인
-- '파일명:파일크기:최대파일크기'
SHOW VARIABLES LIKE 'innodb_data_file_path';

-- 
SHOW VARIABLES LIKE 'innodb_file_per_table';
-- 기본값 ON, 테이블마다 데이터와 인덱스를 위한 별도 파일 생성
-- OFF : 테이블들이 공통 테이블 스페이스를 공유

-- 테이블 스페이스 생성 (3개)
-- 확장명 ibd(innodb 엔진 데이터파일)
CREATE TABLESPACE ts_a ADD DATAFILE 'ts_a.ibd';
CREATE TABLESPACE ts_b ADD DATAFILE 'ts_b.ibd';
CREATE TABLESPACE ts_c ADD DATAFILE 'ts_c.ibd';

USE db_index;
-- 테이블을 생성하면서 테이블 스페이스 지정
CREATE TABLE table_a
	(id INT)
    TABLESPACE ts_a;

-- 만들어진 테이블에 테이블 스페이스 지정
CREATE TABLE table_b (id INT);
ALTER TABLE table_b TABLESPACE ts_b;

-- 대용량 데이터 테이블 복사
CREATE TABLE table_c
	(SELECT * FROM employees.salaries);
ALTER TABLE table_c TABLESPACE ts_c;
