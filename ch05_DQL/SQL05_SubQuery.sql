-- subQuery
USE scott;

-- 1. 특정 직원보다 급여를 더 많이 받는 직원 조회
-- 서브쿼리
SELECT ename, sal 
	FROM emp
    WHERE ename = 'ALLEN';
-- 메인쿼리
SELECT ename, sal
	FROM emp
    WHERE sal > 1600;
-- 메인쿼리의 WHERE절 조건에 서브쿼리 삽입
SELECT ename, sal
	FROM emp
    WHERE sal > (SELECT sal FROM emp WHERE ename = 'ALLEN');
-- 단일 행(Single row) 서브쿼리
-- 서브쿼리의 결과가 반드시 하나의 행만 반환해야 함.

-- 2. 특정 부서의 평균 급여보다 높은 급여를 받는 직원 조회
-- 서브 쿼리
SELECT deptno, avg(sal)
	FROM emp
    WHERE deptno = 30;
-- 메인 쿼리
SELECT * 
	FROM emp 
    WHERE sal > (SELECT avg(sal) FROM emp WHERE deptno = 30);
    
-- 3. IN 함수 사용
-- 서브쿼리
SELECT empno FROM emp WHERE sal > 2000;
-- 메인쿼리
SELECT * 
	FROM emp
    WHERE emp.empno IN(SELECT empno FROM emp WHERE sal > 2000);

-- 4. ANY 함수 사용
-- 하나라도 큰 것이 있으면 참
-- 서브쿼리
SELECT sal FROM emp WHERE deptno = 20;
-- 메인쿼리
SELECT * 
	FROM emp 
    WHERE sal > ANY(SELECT sal FROM emp WHERE deptno = 20);

-- 5. ALL 함수 사용
-- 모든 결과값보다 커야 참 
-- 서브쿼리
SELECT sal FROM emp WHERE deptno = 20;
-- 메인쿼리
SELECT * 
	FROM emp 
    WHERE sal > ALL(SELECT sal FROM emp WHERE deptno = 20);

-- 6. EXISTS 함수 사용
-- 상호 연관 서브쿼리에서 유용하게 사용
-- 상호 연관 쿼리 : 메인 쿼리의 칼럼을 서브쿼리에서 사용하는 것
-- 각 부서에 대해 직원이 존재하는 경우 참
SELECT dname, loc 
	FROM dept d
    WHERE EXISTS(SELECT * FROM emp e WHERE e.deptno = d.deptno);
    
-- 7. SELECT 절에서 서브쿼리 사용
-- 서브쿼리
SELECT avg(sal) 
	FROM emp
    WHERE deptno = '30';
-- 메인쿼리
SELECT e.ename, e.sal, e.deptno, (SELECT avg(sal) FROM emp WHERE deptno = e.deptno) '부서별 평균급여'
	FROM emp e;
-- 단일 행을 반환하여 사용
-- 쿼리의 결과를 유연하게 동적으로 표현하고 싶을 때 사용
-- 데이터베이스에 따라 성능 및 비용 문제 발생할 수 있음 (데이터 양이 많을 경우 다른 방법 사용)

-- 8. FROM 절에서 서브쿼리 사용
-- 인라인 뷰(Inline View) 
-- 서브쿼리가 임시 테이블처럼 동작하게 하여 메인 쿼리에 사용
-- 생성된 임시 테이블은 쿼리 실행 시점에만 존재하고 사라짐 => 쿼리문 안에서만 사용가능
-- FROM 절의 임시 테이블은 약칭을 주어 사용해야 한다.
SELECT deptno, avg(sal)		-- 부서별 급여평균
	FROM emp
    GROUP BY deptno;
SELECT *
	FROM (SELECT deptno, avg(sal) FROM emp GROUP BY deptno) AS dept_avg
    WHERE dept_avg.deptno IN (10, 20);
