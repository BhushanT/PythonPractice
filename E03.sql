USE retail_db;

SELECT * FROM categories;

SELECT * FROM customers;

SELECT * FROM departments;

SELECT * FROM order_items;

SELECT * FROM orders;

SELECT * FROM products;

SELECT 
    c.customer_id, 
    c.customer_fname AS customer_first_name, 
    c.customer_lname AS customer_last_name, 
    COUNT(o.order_id) AS customer_order_count
FROM 
    customers c
JOIN 
    orders o ON c.customer_id = o.order_customer_id
WHERE 
    o.order_date >= '2014-01-01' 
    AND o.order_date < '2014-02-01'
GROUP BY 
    c.customer_id, 
    c.customer_fname, 
    c.customer_lname
ORDER BY 
    customer_order_count DESC, 
    c.customer_id ASC;

--Exercise 2
SELECT 
    c.*
FROM 
    customers AS c
LEFT JOIN 
    orders AS o ON c.customer_id = o.order_customer_id 
    AND o.order_date >= '2014-01-01' 
    AND o.order_date < '2014-02-01'
WHERE 
    o.order_id IS NULL
ORDER BY 
    c.customer_id ASC;

--Exercise 3
SELECT 
    c.customer_id,
    c.customer_fname AS customer_first_name,
    c.customer_lname AS customer_last_name,
    COALESCE(SUM(oi.order_item_subtotal),0) AS customer_revenue
FROM 
    customers c
LEFT JOIN 
    orders o ON c.customer_id = o.order_customer_id 
	AND (o.order_status = 'COMPLETE' OR o.order_status = 'CLOSED')
    AND o.order_date >= '2014-01-01' 
    AND o.order_date < '2014-02-01'
LEFT JOIN 
    order_items oi ON o.order_id = oi.order_item_order_id
GROUP BY 
    c.customer_id, 
    c.customer_fname, 
    c.customer_lname
ORDER BY 
    customer_revenue DESC, 
    c.customer_id ASC;

-- Exercise 4

SELECT 
    cat.category_id,
    cat.category_department_id,
    cat.category_name,
    COALESCE(SUM(oi.order_item_subtotal), 0) AS category_revenue
FROM 
    categories cat
JOIN 
    products p ON cat.category_id = p.product_category_id
LEFT JOIN 
    order_items oi ON p.product_id = oi.order_item_product_id
LEFT JOIN 
    orders o ON oi.order_item_order_id = o.order_id
    AND o.order_status IN ('COMPLETE', 'CLOSED')
    AND o.order_date >= '2014-01-01'
    AND o.order_date < '2014-02-01'
GROUP BY 
    cat.category_id, cat.category_department_id, cat.category_name
ORDER BY 
    cat.category_id ASC;

--Exercise 5

SELECT 
    d.department_id,
    d.department_name,
    COUNT(p.product_id) AS product_count
FROM 
    departments d
LEFT JOIN 
    categories c ON d.department_id = c.category_department_id
LEFT JOIN 
    products p ON c.category_id = p.product_category_id
GROUP BY 
    d.department_id, d.department_name
ORDER BY 
    d.department_id ASC;
