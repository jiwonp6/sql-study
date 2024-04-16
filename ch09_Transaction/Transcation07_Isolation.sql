-- 트랜잭션 고립 수준
USE tcl;

-- 시스템의 고립수준 확인
SELECT @@transaction_isolation;

/* 1. READ UNCOMMITTED */
-- 고립수준 변경
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
START TRANSACTION;

-- 읽기 (다른 세션에서 쓰기 전 : 나이 30/ 쓴 후 : 나이 35)
-- 다른 세션 내용 커밋하지 않아도 변경한 내용 반영 => READ UNCOMMITTED
-- 더티 리드 (오손 읽기, dirty read) : 무효화 되는 데이터를 읽음 -> 결과적으로 잘못된 결과를 읽게 됨
SELECT * FROM person;

-- ROLLBACK 후 읽기 -> 원상복귀
SELECT * FROM person;

COMMIT;

/* 2. READ COMMITTED */
-- 고립수준 변경
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;

-- 읽기 (다른 세션 커밋 전 : 30)
SELECT * FROM person WHERE name = '홍길동';

-- 반복 읽기 (다른 세션 커밋 후 : 35)
SELECT * FROM person WHERE name = '홍길동';

-- 반복 읽기 시 다른 트랜잭션 작업 여부에 따라 이전의 결과와 다른 결과가 나오고, 동일한 이전 결과를 읽을 수 없는 현상 => 반복 불가능 읽기
COMMIT;

/* 3. REPEATABLE READ */
-- 고립수준 변경
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;

-- 읽기 (다른 세션 커밋 전 : 30)
SELECT * FROM person WHERE name = '홍길동';

-- 반복 읽기 (다른 세션 커밋 후 : 35)
-- 트랜잭션 시작했을 때 처음 읽은 값을 스냅샷으로 저장하여, 반복하여 읽더라도(트랜잭션 중 다른 트랜잭션이 값 변경) 처음 값을 읽어옴 
SELECT * FROM person WHERE name = '홍길동';

COMMIT;

/* 4. SERIALIZABLE */
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION;

-- 읽기 (다른 세션에서 쓰기 자체가 불가능!) => 해당 트랜잭션의 수정이 배타 LOCK 설정한 효과
-- 현재 트랜잭션이 완료될 때까지 다른 트랜잭션은 데이터를 변경할 수 없음
SELECT * FROM person WHERE name = '홍길동';

COMMIT;




