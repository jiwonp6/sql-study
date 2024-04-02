-- * 사장님 : 모든 데이터베이스를 읽는 권한만
-- 데이터베이스 생성은 불가능
CREATE DATABASE test_db;

-- 모든 데이터베이스의 테이블을 읽을 수는 있지만, 삽입, 수정, 삭제 권한 x	
USE shopdb;
SELECT * FROM memberTBL;