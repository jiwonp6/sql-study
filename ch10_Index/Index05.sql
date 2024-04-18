DROP SCHEMA IF EXISTS db_index;
CREATE SCHEMA db_index;
USE db_index;

/* 인덱스 성능확인 */
-- 대량의 샘플 데이터 복사 (무작위)
CREATE TABLE emp SELECT * FROM employees.employees ORDER BY rand();
CREATE TABLE emp_cl SELECT * FROM employees.employees ORDER BY rand();
CREATE TABLE emp_se SELECT * FROM employees.employees ORDER BY rand();

-- 정렬 순서 무작위
SELECT * FROM emp LIMIT 5;		-- 인덱스 없는 테이블
SELECT * FROM emp_cl LIMIT 5;	-- 클러스터형 인덱스
SELECT * FROM emp_se LIMIT 5;	-- 보조 인덱스

-- 클러스터형 인덱스가 생성되면서 emp_no 기준으로 정렬
ALTER TABLE emp_cl ADD PRIMARY KEY (emp_no);
SELECT * FROM emp_cl LIMIT 5;	-- 오름차순 정렬됨

-- 보조 인덱스 생성 (emp_no 기준)
ALTER TABLE emp_se ADD INDEX idx_emp_no (emp_no);
SELECT * FROM emp_se LIMIT 5;	-- 보조 인덱스 생성과 별개로 데이터들은 정렬 X

-- 테이블 상태 확인 데이터 약 17MB
-- 인덱스 길이는 보조 인덱스만 약 5MB
SHOW TABLE STATUS;
ANALYZE TABLE emp, emp_cl, emp_se;

-- 서버 종료 후 재시작 (cmd 관리자 -> net stop mysql80; net start mysql80;)
USE db_index;

/* 인덱스 X인 테이블 읽기 */
-- 읽은 페이지의 수 / 2164
SHOW GLOBAL STATUS LIKE 'innodb_pages_read';

SELECT * FROM emp WHERE emp_no = 100000;
EXPLAIN SELECT * FROM emp WHERE emp_no = 100000;

-- 읽은 페이지의 수 / 3216 => 3216 - 2164, 대략 1000페이지 이상을 읽었음
SHOW GLOBAL STATUS LIKE 'innodb_pages_read';

/* 클러스터형 인덱스의 테이블 읽기 */
SELECT * FROM emp_cl WHERE emp_no = 100000;
-- 실행 계획 확인: 쿼리 코스트 -> 1, 읽은 줄 -> 1, 시간 -> 0.00sec
EXPLAIN SELECT * FROM emp_cl WHERE emp_no = 100000;
-- 읽은 페이지의 수 / 3217 => 3217 - 3216, 1페이지 읽음
SHOW GLOBAL STATUS LIKE 'innodb_pages_read';

/* 보조 인덱스의 테이블 읽기 */
SELECT * FROM emp_se WHERE emp_no = 100000;
-- 실행 계획 확인: 쿼리 코스트 -> 0.35, 찾은 행 수 -> 1, 시간 -> 0.0sec
EXPLAIN SELECT * FROM emp_se WHERE emp_no = 100000;
-- 읽은 페이지의 수 / 3218 => 3218 - 3217, 1페이지 읽음
SHOW GLOBAL STATUS LIKE 'innodb_pages_read';

/* 인덱스 X인 테이블 범위로 조회 */
SELECT * FROM emp WHERE emp_no < 12000;
-- 실행 계획 확인: 전체 테이블 스캔
EXPLAIN SELECT * FROM emp WHERE emp_no < 12000;

/* 클러스터형 인덱스의 테이블 범위로 조회 */
SELECT * FROM emp_cl WHERE emp_no < 12000;
-- 실행 계획 확인: 인덱스 사용, Index Range Scan
EXPLAIN SELECT * FROM emp_cl WHERE emp_no < 12000;
-- 실행 타입 range, 범위만큼의 행수를 리턴

/* 보조 인덱스의 테이블 범위로 조회 */
SELECT * FROM emp_se WHERE emp_no < 12000;
-- 실행 계획 확인: 인덱스 사용, Index Range Scan
EXPLAIN SELECT * FROM emp_se WHERE emp_no < 12000;
-- 실행 타입 range, 범위만큼의 행수를 리턴
