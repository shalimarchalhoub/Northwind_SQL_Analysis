WITH sales AS(
SELECT 
	CONCAT(e.first_name , ' ' , e.last_name) AS employee_full_name,
	e.title AS employee_title,
	ROUND(
		SUM(od.unit_price * od.quantity* (1-od.discount))::NUMERIC 
		, 2) AS total_sale_amount_excluding_discount,
	COUNT(DISTINCT(od.order_id)) AS number_unique_orders,
	COUNT(od.order_id) AS number_orders,
	ROUND(
		AVG((od.unit_price*od.quantity)/(od.quantity))::NUMERIC 
		,2) AS average_product_amount,
	ROUND(
		SUM(od.quantity * od.unit_price * od.discount)::NUMERIC,
		2) AS total_discount_amount,
	ROUND(
		SUM(od.unit_price * od.quantity)::NUMERIC 
		, 2) AS total_sale_amount_including_discount,
	ROUND(((SUM(od.unit_price * od.quantity) - SUM(od.unit_price * od.quantity* (1-od.discount)))
		/SUM(od.unit_price * od.quantity)*100)::NUMERIC ,2)
		 AS total_discount_percentage
FROM orders AS o
INNER JOIN employees AS e
ON o.employee_id = e.employee_id
INNER JOIN order_details AS od
ON od.order_id = o.order_id
INNER JOIN products AS p
ON od.product_id = p.product_id
GROUP BY employee_full_name, employee_title)
SELECT 
	sales.employee_full_name,
	sales.employee_title,
	sales.total_sale_amount_excluding_discount,
	sales.number_unique_orders,
	sales.number_orders,
	sales.average_product_amount,
	ROUND(
		AVG((sales.total_sale_amount_excluding_discount)/sales.number_unique_orders)::NUMERIC 
		,2) AS average_order_amount,
	sales.total_discount_amount,
	sales.total_sale_amount_including_discount,
	sales.total_discount_percentage
FROM sales AS sales
GROUP BY employee_full_name,
		employee_title, 
		sales.total_sale_amount_excluding_discount,
		sales.number_unique_orders,
		sales.number_orders, 
		sales.average_product_amount, 
		sales.total_discount_amount, 
		sales.total_sale_amount_including_discount,
		sales.total_discount_percentage
ORDER BY total_sale_amount_excluding_discount DESC;

