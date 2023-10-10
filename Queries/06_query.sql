SELECT 
    c.category_name,
    CASE WHEN p.unit_price <10 THEN '1. Below $10'
         WHEN p.unit_price BETWEEN 10 AND 20 THEN '2. $10 - $20'
         WHEN p.unit_price > 20 AND p.unit_price <=50 THEN '3. $20 - $50'
         WHEN p.unit_price >50 THEN '4.Over $50'
    END AS price_range,
    CAST(SUM((od.unit_price * od.quantity) - od.discount) AS decimal(8,2)) AS total_amount,
    COUNT(DISTINCT od.order_id) AS total_number_orders 
FROM categories c 
INNER JOIN products AS p 
ON p.category_id = c.category_id
INNER JOIN order_details od 
ON od.product_id = p.product_id 
GROUP BY c.category_name, price_range
ORDER BY c.category_name , price_range ASC;
    