USE quiz;

PREPARE myQuery FROM 'SELECT * FROM salaries WHERE emp_no = ? ORDER BY from_date';

SET @empId = '10001';
EXECUTE myQuery USING @empId;

DEALLOCATE PREPARE myQuery;