SELECT 
    CASE WHEN sup.country IN ('Brazil', 'Canada', 'USA' ) THEN 'America'
         WHEN sup.country IN ('Denmark', 'Finland', 'France', 'Germany', 'Italy', 'Netherlands', 'Norway', 'Spain', 'Sweden', 'UK') THEN 'Europe'
         WHEN sup.country IN ('Japan', 'Singapore') THEN 'Asia'
         WHEN sup.country LIKE 'Australia' THEN 'Oceania' 
    END AS supplier_region,
    c.category_name,
    SUM(p.unit_in_stock) AS units_in_stock,
    SUM(p.unit_on_order) AS units_on_order,
    SUM(p.reorder_level) AS reorder_level
FROM suppliers AS sup
INNER JOIN products AS p  
ON sup.supplier_id = p.supplier_id 
INNER JOIN categories AS c 
ON p.category_id = c.category_id 
GROUP BY supplier_region, c.category_name 
ORDER BY supplier_region, c.category_name ,reorder_level ASC 
