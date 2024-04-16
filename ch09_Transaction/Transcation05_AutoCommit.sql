-- 오토커밋(AutoCommit)
USE tcl;

-- autocommit 활성화 여부 확인
SHOW VARIABLES LIKE 'autocommit';

-- ON 활성화 (1)
SET autocommit = 1;

-- OFF 비활성화 (0) 
SET autocommit = 0;

CREATE TABLE person (
	name VARCHAR(255),
	age INT
);

-- autocommit이 활성화 되어있는 상태
-- 데이터 조작을 가할 시 즉시 반영
INSERT INTO person 
	VALUES ('홍길동', 30);    
SELECT * FROM person;

-- autocommit이 비활성화 되어있는 상태
SET autocommit = 0;

INSERT INTO person 			-- 삽입 내용이 현재 세션에서만 확인 가능, 변경내용 반영 위해 COMMIT 필요
	VALUES ('임꺽정', 40);
SELECT * FROM person;

-- autocommit 재활성화
SET autocommit = 1;
SHOW VARIABLES LIKE 'autocommit';
