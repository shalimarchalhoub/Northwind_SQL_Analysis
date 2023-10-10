WITH prices AS (
SELECT 
    p.product_name,
    ROUND(LEAD(od.unit_price) OVER (PARTITION BY p.product_name ORDER BY o.order_date)::NUMERIC,2) AS current_price,
    ROUND(LAG(od.unit_price) OVER (PARTITION BY p.product_name ORDER BY o.order_date)::NUMERIC,2) AS previous_unit_price
FROM products AS p 
INNER JOIN order_details As od 
ON p.product_id = od.product_id 
INNER JOIN orders AS o
ON od.order_id = o.order_id
)
SELECT 
	pr.product_name,
	pr.current_price,
	pr.previous_unit_price,
	ROUND(((pr.current_price / pr.previous_unit_price)-1)::NUMERIC, 4)*100 AS percentage_increase
FROM prices AS pr
WHERE (ROUND(((pr.current_price / pr.previous_unit_price)-1)::NUMERIC, 4)*100) NOT BETWEEN 10 AND 30 
AND (ROUND(((pr.current_price / pr.previous_unit_price)-1)::NUMERIC, 4)*100) != 0
GROUP BY pr.product_name, pr.current_price, pr.previous_unit_price 
ORDER BY ROUND(((pr.current_price / pr.previous_unit_price)-1)::NUMERIC, 4)*100 ASC;

