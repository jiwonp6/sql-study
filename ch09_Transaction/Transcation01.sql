-- 트랜잭션(Transaction)
DROP SCHEMA IF EXISTS tcl;
CREATE SCHEMA tcl;
USE tcl;

-- 초기 테이블 생성 (계좌)
CREATE TABLE accounts (
	account_id INT AUTO_INCREMENT PRIMARY KEY,
    account_name VARCHAR(255) NOT NULL,		-- 계좌명
    balance BIGINT NOT NULL DEFAULT 0		-- 잔고 (기본값 0)
);

-- 로그 테이블 생성
CREATE TABLE transaction_log (
	transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    from_account INT,		-- 보낸 계좌 ID
    to_account INT,			-- 받는 계좌 ID
    amount BIGINT,			-- 보낸 금액
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,		-- 보낸 시간 (기본값 현재시간)
    FOREIGN KEY (from_account) REFERENCES accounts(account_id),
    FOREIGN KEY (to_account) REFERENCES accounts(account_id)
);

DESC accounts;
DESC transaction_log;

INSERT INTO accounts (account_name, balance)
	VALUES ('홍길동', 100000), ('전우치', 200000);

SELECT * FROM accounts;

-- 계좌 거래 트랜잭션 (작업단위) 예시
START TRANSACTION;		-- 트랜잭션 시작

-- 1. 인출
UPDATE accounts 
	SET balance = balance - 50000
	WHERE account_id = 1;
    
SELECT * FROM accounts;

-- 2. 입금
UPDATE accounts 
	SET balance = balance + 50000
	WHERE account_id = 2;
    
SELECT * FROM accounts;		-- 세션 1 (현재 세션)에서 부분완료

-- 3. 거래 기록 저장
INSERT INTO transaction_log (from_account, to_account, amount)
	VALUES (
		(SELECT account_id FROM accounts WHERE account_name = '홍길동'),
		(SELECT account_id FROM accounts WHERE account_name = '전우치'),
        50000
    );
    
SELECT * FROM transaction_log;		-- 거래기록 부분완료

-- 모든 변경사항 확정
COMMIT;
