USE quiz;

select * from salaries;

DELIMITER $$
CREATE PROCEDURE getEmployeeSalariesByYear (IN empNo INT, IN year INT)
BEGIN
	SELECT * FROM salaries WHERE (emp_no = empNo) AND (year = year(from_date));
END$$
DELIMITER ;

CALL getEmployeeSalariesByYear(10001, 2000);