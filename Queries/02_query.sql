WITH retrospection AS (
    SELECT 
        ship_country,
        ROUND(AVG(shipped_date - order_date),2) AS average_days_between_order_shipping,
        count(DISTINCT(order_id)) AS total_volume_orders
    FROM orders
    WHERE EXTRACT(YEAR from order_date) = 1997 
    GROUP BY ship_country
    )
SELECT * FROM retrospection
WHERE average_days_between_order_shipping BETWEEN 3 AND 20
AND total_volume_orders>5
ORDER BY average_days_between_order_shipping DESC;