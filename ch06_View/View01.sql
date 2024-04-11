-- 뷰
USE scott;

-- 뷰 생성
CREATE VIEW view_emp 
	AS SELECT empno, ename, job, deptno FROM emp;

-- 생성된 뷰는 새로운 가상의 테이블처럼 접근
SELECT * FROM view_emp;

-- 뷰 삭제
DROP VIEW view_emp;

-- 뷰의 장점
-- 1. 보안 (뷰로 조건부 속성, 데이터 선택)
CREATE VIEW view_emp_30 AS
	SELECT * FROM emp WHERE deptno = 30;

SELECT * FROM view_emp_30;

-- 2. 복잡한 쿼리 단순화
CREATE VIEW emp_dept_view AS
	SELECT e.ename 'employee_name', d.dname 'department_name' 
	FROM emp e 
	INNER JOIN dept d ON e.deptno = d.deptno;

-- 2개 이상의 테이블이 조인된 복잡한 쿼리도 결과셋을 뷰로 단순화시킬 수 있음
-- 쿼리 결과 셋의 컬럼의 별칭은 뷰의 컬럼의 컬럼명이 됨
SELECT * FROM emp_dept_view;
