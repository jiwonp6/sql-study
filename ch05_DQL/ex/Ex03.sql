-- Ex
USE scott;

-- 문제 1: EMP 테이블에서 모든 직원을 급여(SAL)의 내림차순으로 정렬하여 조회하세요.
SELECT sal
	FROM emp
    ORDER BY sal DESC;

-- 문제 2: EMP 테이블에서 모든 직원을 입사 날짜(HIREDATE)의 오름차순으로 정렬하여 상위 5명의 직원 정보를 조회하세요.
SELECT hiredate
	FROM emp
    ORDER BY hiredate
    LIMIT 5;

-- 문제 3: EMP 테이블에서 모든 직원을 이름(ENAME)으로 알파벳 순으로 정렬하고, 3번째부터 7번째 직원까지의 정보를 조회하세요.
SELECT *
	FROM emp
    ORDER BY ename
    LIMIT 5
    OFFSET 2;

-- 문제 4: EMP 테이블에서 JOB이 'SALESMAN'인 직원들을 급여(SAL)의 오름차순으로 정렬하여 조회하세요.
SELECT *
	FROM emp
    WHERE job = 'salesman'
    ORDER BY sal;

-- 문제 5: EMP 테이블에서 가장 최근에 입사한 직원 3명의 ENAME, JOB, HIREDATE를 조회하세요.
SELECT ename, job, hiredate
	FROM emp
    ORDER BY hiredate DESC
    LIMIT 3;
