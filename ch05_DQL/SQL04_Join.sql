-- JOIN
USE scott;

SELECT * FROM emp;
SELECT * FROM dept;

-- 암시적 조인
-- 직원 조회 시 부서 이름과 위치까지 출력 (dept 테이블 이용 - 교집합)
SELECT empno, ename, e.deptno, dname, loc
	FROM emp e, dept d
    WHERE e.deptno = d.deptno;

-- 두 개의 테이블을 결합하고, 결과 셋에서 필요한 속성들만 프로젝션(투영)
SELECT e.ename, e.job, e.sal, e.deptno, d.dname, d.loc
	FROM emp e, dept d
    WHERE e.deptno = d.deptno;
	-- => 일반적으로 프로젝션하는 모든 필드의 이름에 테이블을 함께 명시
	-- => 코드가 길어지기 때문에 각 테이블명에 별칭을 주어 간결화

-- 명시적 조인
-- JOIN 과 ON 키워드를 함께 사용
-- 1. Inner Join
SELECT e.ename, d.dname
	FROM emp e
    JOIN dept d ON e.deptno = d.deptno;
    
-- 2. Left Join : 테이블1에 공통칼럼이 없는 경우도 포함하여 테이블2 조회
-- INSERT INTO emp VALUES (9999, 'John', 'Doe', NULL, NULL, NULL, NULL, NULL);
SELECT e.ename, d.dname
	FROM emp e
    LEFT JOIN dept d ON e.deptno = d.deptno;
-- => 9999번 사원은 포함, 40번 부서는 포함하지 않음
    
-- INNER LEFT(테이블1)와 RIGHT(테이블2) 모두 존재하는 경우    
-- INNER(테이블1)에는 존재하고, RIGHT(테이블2)에는 존재하지 않는 행을 포함    
-- RIGHT 테이블1에는 존재하지 않고, 테이블2에는 존재하는 행을 포함    

-- 3. Right Join : 테이블2에 공통칼럼이 없는 경우로 토함하여 테이블1 조회
SELECT e.ename, d.dname
	FROM emp e
    RIGHT JOIN dept d ON e.deptno = d.deptno;
-- => 40번 부서는 포함, 9999번 사원은 포함하지 않음

-- 4. Self Join : 별칭을 사용해서 동일 테이블을 마치 2개의 테이블인 것처럼 같은 테이블을 2번 참조하여 결합하는 방식
SELECT e1.empno '사원번호', e1.ename '사원 이름', e2.ename '담당 상사' 
	FROM emp e1
    JOIN emp e2 ON e1.mgr = e2.empno;
    
-- 5. Non-equi Join(비등가 조인)
SELECT * FROM emp;
SELECT * FROM salgrade;

SELECT e.ename, s.grade
	FROM emp e
    JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;

-- 3개 이상의 테이블을 결합하는 경우
SELECT e.ename, e.deptno, e.sal, s.grade
	FROM emp e
    JOIN dept d ON e.deptno = d.deptno
    JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
    ORDER BY s.grade DESC;
    
-- 그룹화 집계함수와 함께 사용
SELECT d.dname '부서명', round(avg(e.sal), 2) '평균 급여'
	FROM emp e
    JOIN dept d ON e.deptno = d.deptno
    GROUP BY d.dname;
    
-- USING 키워드와 함께 사용
-- 두 테이블이 공통적으로 가지고 있는 열을 기준으로 JOIN할 때 사용
-- 두 테이블에서 열 이름이 동일해야 사용 가능
-- ON e.deptno = d.deptno 간소화 한 형태
SELECT *
	FROM emp e
    JOIN dept USING (deptno);
    
-- NATURAL JOIN
-- 두 테이블 간의 이름과 데이터타입이 같은 모든 열을 자동으로 찾아서 해당 열을 기준으로 JOIN
-- ON e.deptno = d.deptno 간소화 한 형태
SELECT *
	FROM emp e
    NATURAL JOIN dept d;
    
-- CROSS JOIN
-- 양 테이블의 모든 행을 조인, 결과는 두 테이블을 곱한 개수, 카티션 프로덕트
SELECT * 
	FROM emp
	CROSS JOIN dept;
    