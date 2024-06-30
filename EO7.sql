SELECT 
    c.category_name
FROM 
    categories c
WHERE 
    (SELECT COUNT(p.product_id)
     FROM products p
     WHERE p.product_category_id = c.category_id) > 5;

--Exercise 2

SELECT 
    o.order_id
FROM 
    orders o
WHERE 
    o.order_customer_id IN (
        SELECT 
            c.customer_id
        FROM 
            customers c
        JOIN 
            orders o ON c.customer_id = o.order_customer_id
        GROUP BY 
            c.customer_id
        HAVING 
            COUNT(o.order_id) > 10
    );


-- Exercise 3

SELECT 
    p.product_name,
    (SELECT AVG(product_price) 
     FROM products 
     WHERE product_id IN (
         SELECT DISTINCT order_item_product_id 
         FROM order_items 
         JOIN orders ON order_items.order_item_order_id = orders.order_id
         WHERE orders.order_date >= '2013-10-01' AND orders.order_date < '2013-11-01'
     )) AS avg_price_of_ordered_products
FROM 
    products p
WHERE 
    p.product_id IN (
        SELECT DISTINCT order_item_product_id 
        FROM order_items 
        JOIN orders ON order_items.order_item_order_id = orders.order_id
        WHERE orders.order_date >= '2013-10-01' AND orders.order_date < '2013-11-01'
    );

--Exercise 4

SELECT 
    o.order_id,
    o.order_date,
    o.order_customer_id,
    o.order_status,
    SUM(oi.order_item_subtotal) AS order_total
FROM 
    orders o
JOIN 
    order_items oi ON o.order_id = oi.order_item_order_id
GROUP BY 
    o.order_id, o.order_date, o.order_customer_id, o.order_status
HAVING 
    SUM(oi.order_item_subtotal) > (SELECT AVG(order_total) FROM (
        SELECT SUM(order_item_subtotal) AS order_total
        FROM order_items 
        GROUP BY order_item_order_id
    ) sub)
ORDER BY 
    o.order_id;


--Exercise 5

WITH CategoryProductCount AS (
    SELECT 
        c.category_id,
        c.category_name,
        COUNT(p.product_id) AS product_count
    FROM 
        categories c
    JOIN 
        products p ON c.category_id = p.product_category_id
    GROUP BY 
        c.category_id, c.category_name
)
SELECT TOP 3
    category_id,
    category_name,
    product_count
FROM 
    CategoryProductCount
ORDER BY 
    product_count DESC;


--Exercise 6

WITH CustomerSpending AS (
    SELECT 
        order_customer_id AS customer_id,
        SUM(order_item_subtotal) AS total_spending
    FROM 
        orders
    JOIN 
        order_items ON orders.order_id = order_items.order_item_order_id
    WHERE 
        order_date >= '2013-12-01' AND order_date < '2014-01-01'
    GROUP BY 
        order_customer_id
),
AverageSpending AS (
    SELECT 
        AVG(total_spending) AS avg_spending
    FROM 
        CustomerSpending
)
SELECT 
    cs.customer_id,
    cs.total_spending
FROM 
    CustomerSpending cs,
    AverageSpending
WHERE 
    cs.total_spending > AverageSpending.avg_spending;
