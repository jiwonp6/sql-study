-- 사용자 역할 및 권한
-- [Administration] > [Users and Preivileges]
-- [Add Account] 를 클릭하여 추가 가능

-- USER 생성 SQL 문
	-- @ 뒤의 %는 모든 호스트를 가리킴
	-- IDENTIFIED BY : 비밀번호
CREATE USER director@'%' IDENTIFIED BY '1234';

-- 권한 부여 sql 문
	-- GRANT : 권한 부여
    -- ALL : 모든 권한
    -- *.* : 모든 데이터베이스의 모든 테이블
    -- TO director@'%' : 누구에게 부여할 것인지
    -- WITH GRANT OPTION : 다른 사용자에게도 권한 부여 권한을 가짐
/* director : 모든 권한 */
GRANT ALL ON *.* TO director@'%' WITH GRANT OPTION;
/* ceo : 모든 데이터베이스를 읽는 권한 */
GRANT SELECT ON *.* TO ceo@'%';		
/* staff : shopdb = CRUD 권한, employees = 읽기 권한 */
GRANT SELECT, INSERT, UPDATE, DELETE ON shopdb.* TO staff@'%';		
GRANT SELECT ON employees.* TO staff@'%';




