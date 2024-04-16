USE tcl;

DROP TABLE IF EXISTS lock_demo;
CREATE TABLE lock_demo (
	id INT,
    data VARCHAR(255)
);

INSERT INTO lock_demo
	VALUES (1, '데이터1'), (2, '데이터2');
    
START TRANSACTION;

-- 테스트 데이터의 1번 행의 데이터에 접근 (해당 자원에 락)
UPDATE lock_demo SET data = '수정' WHERE id = 1;

-- 락 해제
COMMIT;

/* READ */ 
-- 현재 세션
-- 명시적 테이블 락
LOCK TABLE lock_demo READ;

-- 락 읽기 시도 (읽기 가능)
SELECT * FROM lock_demo;

-- 락 수정 시도 (수정 불가)
UPDATE lock_demo SET data = '읽기 락' WHERE id = 1;

-- 락 해제
UNLOCK TABLES;

/* WRITE */
-- 현재 세션
-- 명시적 테이블 락
LOCK TABLE lock_demo WRITE;

-- 락 읽기 시도 (읽기 가능)
SELECT * FROM lock_demo;

-- 락 수정 시도 (수정 가능)
UPDATE lock_demo SET data = '쓰기 락' WHERE id = 1;

-- 락 해제
UNLOCK TABLES;
