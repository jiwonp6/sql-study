-- Ex. TCL 연습문제
USE tcl;
-- 다음 테이블을 생성하고, TCL을 활용하여 트랜잭션 연습하세요.
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    quantity INT,
    price DECIMAL(10, 2)
);

INSERT INTO products (product_name, quantity, price) VALUES
('Laptop', 10, 990.00),
('Phone', 20, 290.00),
('Tablet', 15, 450.00);

/*
연습문제 1: 가격 업데이트 및 재고 감소
- 모든 제품의 가격을 10% 인상하세요. 
- 'Phone'의 재고를 5개 감소시키세요
- 트랜잭션을 커밋하여 변경사항을 확정하세요.
*/
-- 트랜잭션 시작
START TRANSACTION;
-- 전체 제품 가격 10% 인상
UPDATE products 
	SET price = price * 1.1;
-- 폰 재고 5개 감소
UPDATE products 
	SET quantity = quantity - 5
    WHERE product_name = 'Phone';
-- 수정 확인
SELECT * FROM products;
-- 확정
COMMIT;

/*
연습문제 2: SAVEPOINT와 ROLLBACK
- 'Phone'의 가격을 15% 인상하세요.
- 이후 SAVEPOINT를 설정하세요.
- 'Tablet'의 재고를 10개 감소시키세요.
- 'Tablet' 재고 감소 후 문제가 발생했다고 가정하고 
- SAVEPOINT 이후의 변경 사항을 롤백하세요.
- 반영된 트랜잭션을 커밋하여 변경사항을 확정하세요.
*/
-- 트랜잭션 시작
START TRANSACTION;
-- 폰 가격 15% 인상
UPDATE products 
	SET price = price * 1.15
    WHERE product_name = 'Phone';
-- SAVEPOINT 지정
SAVEPOINT phonePriceUpdate;
-- 태블릿 재고 10개 감소
UPDATE products 
	SET quantity = quantity - 10
    WHERE product_name = 'Tablet';
-- 확인
SELECT * FROM products;
-- 태블릿 재고 감소 전으로 롤백
ROLLBACK TO phonePriceUpdate;
-- 롤백 확인
SELECT * FROM products;
-- 확정
COMMIT;
