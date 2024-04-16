-- SAVEPOINT 예시
USE tcl;
START TRANSACTION;

-- 첫 번째 거래
-- 1. 인출
UPDATE accounts 
	SET balance = balance - 30000
	WHERE account_id = 1;
 
-- 2. 입금
UPDATE accounts 
	SET balance = balance + 30000
	WHERE account_id = 2;
    
SELECT * FROM accounts;

-- 3. 거래 기록 저장
INSERT INTO transaction_log (from_account, to_account, amount)
	VALUES (
		(SELECT account_id FROM accounts WHERE account_name = '홍길동'),
		(SELECT account_id FROM accounts WHERE account_name = '전우치'),
        30000
    );
    
SAVEPOINT midway;		-- 첫 번째 거래 (입출금) 기록저장 및 중간점 설정

-- 두 번째 거래
-- 1. 인출
UPDATE accounts 
	SET balance = balance - 100000
	WHERE account_id = 1;
 
-- 2. 입금
UPDATE accounts 
	SET balance = balance + 100000
	WHERE account_id = 2;


    
SELECT * FROM transaction_log;
SELECT * FROM accounts;

ROLLBACK TO midway;

-- 첫 번째 거래내역(중간점)까지 확정
COMMIT;