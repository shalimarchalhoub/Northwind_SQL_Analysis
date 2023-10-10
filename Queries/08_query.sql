SELECT 
	c.category_name,
	p.product_name,
	p.unit_price,
    ROUND(AVG(od.unit_price)::NUMERIC,2) AS average_unit_price,
    ROUND((PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY od.unit_price))::NUMERIC,2) AS median_unit_price,
    CASE 
		WHEN p.unit_price < AVG(od.unit_price) THEN 'Below Average'
		WHEN p.unit_price = AVG(od.unit_price) THEN 'Average'
		WHEN p.unit_price > AVG(od.unit_price) THEN 'Over Average'
	END AS average_unit_price_position,
	CASE 
		WHEN p.unit_price < ROUND((PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY od.unit_price))::NUMERIC,2) THEN 'Below Median'
		WHEN p.unit_price = ROUND((PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY od.unit_price))::NUMERIC,2) THEN 'Median'
		WHEN p.unit_price > ROUND((PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY od.unit_price))::NUMERIC,2) THEN 'Over Median'
	END AS median_unit_price_position
FROM categories AS c 
INNER JOIN products AS p 
ON c.category_id = p.category_id 
INNER JOIN order_details AS od 
ON p.product_id  = od.product_id 
WHERE p.discontinued =0
GROUP BY c.category_name, p.product_name, p.unit_price  
ORDER BY c.category_name , p.product_name ASC;

    	
