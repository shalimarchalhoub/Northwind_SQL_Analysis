WITH retrospection AS(
    SELECT 
        CONCAT(EXTRACT (YEAR FROM order_date), '-' , EXTRACT (MONTH FROM order_date), '-01') AS year_month,
        COUNT(*) AS total_number_orders,
        ROUND(SUM(freight)) AS total_freight
    FROM orders
    WHERE order_date >= '1996-01-01' AND order_date <='1997-12-31'
    GROUP BY CONCAT(EXTRACT (YEAR FROM order_date), '-' , EXTRACT (MONTH FROM order_date), '-01')
)
SELECT * FROM retrospection
WHERE total_number_orders > 20 AND total_freight >2500
ORDER BY total_freight DESC;