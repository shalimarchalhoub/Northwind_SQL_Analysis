SELECT 
    product_name ,
    unit_price
FROM products p 
WHERE unit_price BETWEEN 10 AND 50 AND discontinued =0
ORDER BY product_name ASC;
    