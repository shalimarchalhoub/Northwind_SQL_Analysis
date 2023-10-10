WITH emp AS(
SELECT 
		c.category_name,
	 CONCAT(e.first_name, ' ' ,e.last_name) AS employee_full_name,
	 ROUND(SUM(od.unit_price * od.quantity + od.discount)::NUMERIC , 2) AS total_sale_amount_including_discount
	 FROM categories AS c
	 INNER JOIN products AS p
	 	ON c.category_id = p.category_id 
	 INNER JOIN order_details AS od  
	 	ON od.product_id = p.product_id 
	 INNER JOIN orders AS o 
	 	ON o.order_id = od.order_id 
	 INNER JOIN employees AS e 
	 	ON e.employee_id = o.employee_id
	 GROUP BY category_name, employee_full_name)
SELECT 
	category_name, 
	emp.employee_full_name,
	emp.total_sale_amount_including_discount,
 ROUND(emp.total_sale_amount_including_discount/SUM(SUM(emp.total_sale_amount_including_discount))
 	OVER (PARTITION BY emp.employee_full_name) ,5) AS percent_of_employee_sales,
 ROUND(emp.total_sale_amount_including_discount/SUM(SUM(emp.total_sale_amount_including_discount))
 	OVER (PARTITION BY category_name) ,5) AS percent_of_category_sales
FROM emp AS emp
GROUP BY category_name, emp.employee_full_name, emp.total_sale_amount_including_discount
ORDER BY category_name, total_sale_amount_including_discount DESC;