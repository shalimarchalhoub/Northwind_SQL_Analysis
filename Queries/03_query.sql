SELECT 
    CONCAT(emp.first_name , ' ', emp.last_name) AS employee_full_name,
    emp.title AS employee_title,
    EXTRACT (YEAR FROM AGE(emp.hire_date, emp.birth_date)) AS employee_age,
    EXTRACT (YEAR FROM AGE(CURRENT_DATE, emp.hire_date)) AS employee_tenure,
    CONCAT(mang.first_name, ' ', mang.last_name) AS manager_full_name,
    mang.title AS manager_title
FROM employees AS emp
INNER JOIN employees AS mang
ON mang.employee_id = emp.reports_to 
ORDER BY employee_age 
, employee_full_name ASC ; 