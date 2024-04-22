USE quiz;

-- 1. 인덱스 생성 전 `employees` 테이블에 `first_name`과  `last_name`  컬럼을 조건으로 하는 쿼리문 실행
SELECT * FROM employees WHERE first_name = 'Georgi' AND last_name = 'Facello';

-- 2. `EXPLAIN`과 Execution Plan을 사용하여 `first_name`과  `last_name`을 조건으로 하는 SELECT 쿼리의 실행 계획 확인
EXPLAIN SELECT * FROM employees WHERE first_name = 'Georgi' AND last_name = 'Facello';

-- 3. 복합 인덱스 생성
CREATE INDEX idx_firstName_lastName
	ON employees (first_name, last_name);

-- 4. 인덱스 생성 전후의 쿼리문의 실행 시간을 비교
SELECT * FROM employees WHERE first_name = 'Georgi' AND last_name = 'Facello';

-- 5. `employees` 테이블의 모든 인덱스 정보 조회
SHOW INDEX FROM employees;