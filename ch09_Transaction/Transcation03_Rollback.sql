-- Rollback 예시
USE tcl;
START TRANSACTION;

-- 1. 인출
UPDATE accounts 
	SET balance = balance - 150000
	WHERE account_id = 1;
    
SELECT * FROM accounts;

-- 2. 입금
UPDATE accounts 
	SET balance = balance + 150000
	WHERE account_id = 2;
    
SELECT * FROM accounts;

-- 데이터 수정 시 문제 발생 -> 변경사항 취소
-- 트랜잭션 시작 이전, 최종 커밋으로 데이터가 취소됨
ROLLBACK;
