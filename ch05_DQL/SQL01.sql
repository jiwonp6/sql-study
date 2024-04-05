USE scott;

-- SCOTT 데이터베이스 탐색
SHOW TABLES;
DESC emp;		-- 직원 정보 저장 테이블
				-- 사원번호, 이름, 직업, 매니저, 고용일, 급여, 커미션, 부서번호
DESC dept;		-- 부서 정보 테이블
				-- 부서번호, 부서이름, 위치
DESC salgrade;	-- 급여 등급 테이블
				-- 급여등급, 최소급여, 최대급여

-- 1. 전체 데이터 확인하기
SELECT * FROM emp;

-- 2. 프로젝션 애트리뷰트 : 속성 투영
-- 사원 이름만 확인
SELECT ename FROM emp;

-- 3. 셀렉션 컨디션 (조건식) : 조건 선택
-- 급여 1000달러 이상인 직원 선택
SELECT * FROM emp
	WHERE sal > 1000;
-- 셀렉션(복합조건) + 프로젝션
-- 급여 1000달러 이상이고 부서번호 10번인 직원의 이름만 선택
SELECT ename FROM emp
	WHERE sal > 1000 AND deptno = 10;

-- 4. 별칭 (AS) 사용 -> AS 생략가능
-- (1) 컬럼명에 별칭 지정 -> 쿼리 결과의 헤더에 사용
SELECT ename AS "직원명" FROM emp;
SELECT ename "직원명", sal "급여" FROM emp;	
-- (2) 테이블에 별칭 지정 -> 주로 JOIN 문에 사용
SELECT e.empno, e.ename, e.deptno, d.dname 
	FROM emp AS e
	JOIN dept AS d 
    ON e.deptno = d.deptno;

-- 5. WHERE 절 조건식
-- (1) NOT : 부정 / IS NOT NULL : NULL 아닌 경우
SELECT ename, deptno
	FROM emp
    WHERE NOT deptno = 10;
SELECT * FROM emp
    WHERE comm IS NOT NULL;
-- (2) BETWEEN ~ AND : 특정 범위내 값 찾기(경계 값 모두 포함)
SELECT ename, sal
	FROM emp
    WHERE sal BETWEEN 1000 AND 1500;
SELECT ename		-- 문자열 범위도 가능
	FROM emp
    WHERE ename BETWEEN 'a' AND 'd';
-- (3) IN() : 주어진 목록 안의 값들 중 하나와 일치하는 행 반환
			-- OR 조건 여러 개와 대체 가능
			-- 쿼리문을 간결하게 만들고, 동적으로 여러 조건을 포함해야 할 때 사용
SELECT ename, job
	FROM emp
    WHERE job IN ('manager', 'analyst');
-- (4) LIKE : 문자열 패턴 매칭을 위해 사용
			-- <와일드카드> 
			-- %   : 0개 이상, 어느 위치에나 일치하는 문자를 대신
            -- '_' : 정확히 일치하는 한 문자를 대신
SELECT ename		-- 이름이 A로 시작하는 모든 직원 조회
	FROM emp
    WHERE ename LIKE 'A%';
SELECT ename		-- 이름에 A를 포함하는 모든 직원 조회
	FROM emp
    WHERE ename LIKE '%A%';
SELECT ename		-- 이름의 3번째 글자가 A인 모든 직원 조회
	FROM emp
    WHERE ename LIKE '__A%';
