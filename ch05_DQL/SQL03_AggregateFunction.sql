-- 집계함수
-- 집계함수의 결과는 단일행
-- 관심있는 attribute에 주로 사용
-- null 값들은 제외하고 요약 값을 추출
USE scott;

SELECT * FROM emp;

-- count : 주어진 조건을 만족하는 행의 개수를 반환
SELECT count(*) FROM emp;		-- 직원수
SELECT count(ename) FROM emp;	-- 직원 이름의 수
SELECT count(mgr) FROM emp;		-- 매니저의 수 (행의 값이 null 인 결우는 제외됨)
SELECT count(comm) FROM emp;	-- 커미션의 수 (행의 값이 null 인 결우는 제외됨)

-- sum : 숫자로 이루어진 열(속성, 애트리뷰트)의 총합을 계산
SELECT sum(sal) FROM emp;

-- avg : 숫자로 이루어진 열(속성, 애트리뷰트)의 평균을 계산
SELECT avg(sal) FROM emp;
SELECT avg(comm) FROM emp;		-- null 값인 경우 제외하고 계산

-- round(소수숫자, 자리수) : avg 함수와 같이 사용하여 반올림 값 계산
SELECT round(avg(sal)) FROM emp;	 -- 2073, 0의 자리 반올림
SELECT round(avg(sal), 2) FROM emp;	 -- 2073.21, 소수점 2째 자리에서 반올림
SELECT round(avg(sal), -2) FROM emp; -- 2100, 십의 자리에서 반올림

-- min, max : 열에서 최소값, 최대값 반환 
-- 숫자 이외의 다양한 데이터 형식에도 사용 가능
SELECT min(sal) '최소급여', max(sal) '최대급여' FROM emp;
SELECT min(ename) , max(ename) FROM emp;	-- 이름 알파벳 순 정렬
SELECT min(hiredate) , max(hiredate) FROM emp;

-- stddev : 표준편차, var_samp: 분산
SELECT stddev(sal), var_samp(sal) FROM emp;

-- GROUP BY : 특정 컬럼의 값에 따라 행들 그룹화
-- GROUP BY 절의 순서 : WHERE 절 다음 ORDER BY 절 이전에 위치해야 함
-- ※ GROUP BY 절에 지정된 열 외의 다른 열을 SELECT 절에 포함시킬 수 없음!
SELECT job 직무, sum(sal) 평균급여 			-- 직무별 평균급여 계산
	FROM emp
	GROUP BY job;
SELECT job , deptno, sum(sal) 			-- 직무별, 부서별 평균급여 계산
	FROM emp
	GROUP BY job, deptno;
SELECT deptno 부서번호, sum(sal) 평균급여 	-- 부서별 평균급여 계산 & 급여가 많은 순으로 출력
	FROM emp
	GROUP BY deptno
    ORDER BY 평균급여 DESC;

-- HAVING : GROUP BY 로 인해 생성된 그룹에 조건 적용
-- ※ WHERE 절과의 차이점
	-- WHERE 절 : 테이블의 각 개별행에 대해 조건을 정의
	-- HAVING 절 : 그룹화된 결과에 대해 조건을 정의
SELECT job 직무, sum(sal) 평균급여
	FROM emp
    WHERE sal > 1500			-- 급여가 1500 이상인 급여의 평균을 계산
	GROUP BY job
    HAVING 평균급여 >= 5000		-- 평균 급여가 5000 이상인 부서의 급여 조회
	ORDER BY 평균급여 DESC;

-- WITH ROLLUP : 각 그룹별 소합계 및 총합계 계산 (요약 보고서 작성이나 데이터 분석에 사용)
SELECT deptno, job, sum(sal)
	FROM emp
    GROUP BY deptno, job
    WITH ROLLUP;
