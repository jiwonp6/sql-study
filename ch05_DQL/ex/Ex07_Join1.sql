-- Ex. JOIN
-- employees 데이터베이스에서 연습해보세요.
-- employees(first_name, last_name, emp_no), titles(emp_no, title, from_date, to_date)
-- dept_emp(dept_no, emp_no, from_date, to_date), salaries(emp_no, salary, from_date, to_date)
-- departments(dept_no, dept_name)
USE employees;
select * from employees;
select * from dept_emp;
select * from salaries;
select * from titles;

-- 문제 1: 직원의 이름(first_name, last_name)과 직원의 현재 직책(title)을 조회하세요.
SELECT e.first_name, e.last_name, t.title
	FROM employees e
    JOIN titles t ON e.emp_no = t.emp_no
    WHERE t.to_date >= current_date();

-- 문제 2: 각 부서의 이름(dept_name)과 그 부서에 현재 속해있는 직원 수를 조회하세요.
SELECT d.dept_name '부서명', count(e.emp_no) '직원 수'
	FROM dept_emp e
    JOIN departments d ON e.dept_no = d.dept_no
    WHERE e.to_date >= current_date()
    GROUP BY d.dept_name;

-- 문제 3: 현재 직원 중 급여가 80000 이상인 직원의 이름(first_name, last_name)과 급여(salary)를 조회하세요.
SELECT e.first_name, e.last_name, s.salary
	FROM employees e
    JOIN salaries s ON e.emp_no = s.emp_no
    WHERE s.salary >= 80000 AND s.to_date >= current_date();

-- 문제 4: 'Marketing' 부서에 현재 속해있는 직원의 이름(first_name, last_name)과 부서 이름(dept_name)을 조회하세요.
SELECT e.first_name, e.last_name, d.dept_name
	FROM employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    JOIN departments d ON de.dept_no = d.dept_no
    WHERE d.dept_name = 'Marketing' AND de.to_date > current_date();

-- 문제 5: 각 직원의 이름과 해당 직원이 현재 속한 부서 이름을 조회하세요. (LEFT JOIN 사용)
SELECT e.first_name, e.last_name, d.dept_name
	FROM employees e
    LEFT JOIN dept_emp de ON e.emp_no = de.emp_no
    LEFT JOIN departments d ON de.dept_no = d.dept_no
    WHERE de.to_date > current_date()
    ORDER BY d.dept_name;
