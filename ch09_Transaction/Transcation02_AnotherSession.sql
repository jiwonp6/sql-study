-- 세션 : 데이터 베이스를 사용하는 동안 유지되는 상태 정보
USE tcl;

-- 세션2 : 계좌 테이블 정보를 확인
SELECT * FROM accounts;

-- 트랜잭션(작업단위)이 시작된 상태에서 다른 세션에서 조회를 하면 부분완료된 업데이트 내용(중간처리 과정)은 확인 불가 -> Isolation (고립성)
SELECT * FROM accounts;
SELECT * FROM transaction_log;

-- 세션1에서 커밋이 완료되면 작업단위 내의 모든 SQL 문이 한꺼번에 수행된 것을 확인 -> Atomicity (원자성)
-- 변경사항이 영구적으로 반영된 상태(Commited), 시스템 장애가 되어도 유지 -> Durability (지속성)
-- 트랜잭션이 수행된 후에도 모든 무결성 제약조건 만족 -> Consistency (일관성)
SELECT * FROM accounts;
SELECT * FROM transaction_log;

/* SAVEPOINT */
-- SAVEPOINT에서 저장된 내용(커밋 되지 않은 수정사항)은 다른 세션에서 커밋되기 전까지 반영되지 않는다.

/* AUTOCOMMIT */
-- AUTOCOMMIT 확인 : 활성화된 상태에서는 다른 세션에서도 바로 확인 가능
-- 비활성화된 상태에서는 다른 세션에서 확인 불가(DB에 반영이 안됨)
-- commit 실행시 트랜잭션에 수행되어 DB 반영 확인 가능

/* LOCK */
-- 현재 트랜잭션 중인 테이블의 행에 접근하게 될 경우 -> 락이 걸림 (해당 자원에 접근 X)
-- 수정 불가 (조회는 가능)
UPDATE lock_demo SET data = '다른세션에서 수정' WHERE id = 1;

/* LOCK -> READ */
-- 다른 세션
-- 락 읽기 시도 (읽기 가능)
SELECT * FROM lock_demo;

-- 락 수정 시도 (수정 불가 => 대기) 
UPDATE lock_demo SET data = '읽기 락' WHERE id = 1;

/* LOCK -> WRITE */
-- 다른 세션
-- 락 읽기 시도 (읽기 불가)
SELECT * FROM lock_demo;

-- 락 수정 시도 (수정 불가)
UPDATE lock_demo SET data = '쓰기 락' WHERE id = 1;
