-- 정렬 및 결과 제한
USE scott;

-- ORDER BY (ASC: 오름차순, DESC: 내림차순)
-- 특정 컬럼의 값에 따라 오름차순 또는 내림차순으로 정렬
-- 기본적으로 ASC는 디폴트 값이라서 생략 가능
SELECT * 
	FROM emp
	ORDER BY deptno ASC, sal DESC;

-- LIMIT : 출력하는 결과 개수 제한
SELECT ename, sal 
	FROM emp
	ORDER BY sal DESC
	LIMIT 5;	-- 1위~ (5명)
    
-- OFFSET : 몇 번째 행부터 데이터 반환할지 지정
-- LIMIT 와 함께 사용, 데이터 페이지네이션(Pagination)
SELECT ename, sal 
	FROM emp
	ORDER BY sal DESC
	LIMIT 5
    OFFSET 5;	-- 6위~ (5명)
-- LIMIT ~ OFFSET 은 대규모의 데이터 셋에서 필요한 부분만 조회하여 응답시간 및 성능을 최적화하여 사용자 경험을 개선할 수 있음
-- 페이지네이션을 구현하여 효율적인 데이터 관리에 사용

-- DISTINCT
-- 중복된 결과를 제거하고, 유잃고 고유한 값만 남기기 위하여 사용
SELECT DISTINCT deptno 
	FROM emp 
    ORDER BY deptno;
