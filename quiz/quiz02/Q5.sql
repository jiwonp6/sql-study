USE quiz;

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100),
    order_date DATE,
    order_amount DECIMAL(10, 2)
);

CREATE TABLE order_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    log_message VARCHAR(255),
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER updateTrg
	AFTER UPDATE		-- 업데이트 작업이 일어난 이후
    ON orders			-- 해당 테이블에서 데이터가 변경되면
    FOR EACH ROW		-- 각 행마다 적용
BEGIN
	-- 백업 테이블에 수정 이전 정보 추가
	INSERT INTO order_logs 
		VALUES (null, NEW.order_id, '주문', current_timestamp());
END$$
DELIMITER ;

-- UPDATE문이 수행된 후 트리거 작동
INSERT INTO orders VALUES (null, '홍길동', curdate(), 2);
UPDATE orders SET order_amount = 5 WHERE customer_name = '홍길동';

SELECT * FROM orders;
SELECT * FROM order_logs;