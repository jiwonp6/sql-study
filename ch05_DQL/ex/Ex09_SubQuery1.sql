-- Ex 서브쿼리 문제 
USE scott;

-- 문제 1: 회사 전체 평균 급여보다 많이 받는 모든 직원의 이름을 조회하세요.
-- 사용 테이블: EMP (ENAME, SAL)
SELECT ename
	FROM emp
    WHERE sal > (SELECT avg(sal) FROM emp);

-- 문제 2: 가장 많은 급여를 받는 직원의 이름을 조회하세요.
-- 사용 테이블: EMP (ENAME, SAL)
SELECT ename
	FROM emp e, (SELECT max(sal) maxSal FROM emp) max
    WHERE e.sal = max.maxSal;

-- 문제 3: SMITH보다 먼저 입사한 모든 직원의 이름을 조회하세요.
-- 사용 테이블: EMP (ENAME, HIREDATE)
SELECT ename
	FROM emp
    WHERE hiredate < (SELECT hiredate FROM emp WHERE ename = 'SMITH');

-- 문제 4: 자신의 부서에서 평균보다 더 많은 급여를 받는 직원의 이름을 조회하세요.
-- 사용 테이블: EMP (ENAME, SAL, DEPTNO)
SELECT e.ename, e.sal, e.deptno '부서번호', dept_avgSal.avgSal '부서별 평균급여'
	FROM emp e, (SELECT deptno, avg(SAL) 'avgSal' FROM emp GROUP BY deptno) dept_avgSal
    WHERE e.deptno = dept_avgSal.deptno AND e.sal > dept_avgSal.avgSal;
