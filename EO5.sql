use retail_db;

-- Step 1: Create the Partition Function
CREATE PARTITION FUNCTION MonthPartitionFunction (DATE)
AS RANGE RIGHT FOR VALUES ('2014-02-01');  -- Starting February as the boundary for January

-- Step 2: Create the Partition Scheme
CREATE PARTITION SCHEME MonthPartitionScheme
AS PARTITION MonthPartitionFunction
ALL TO ([PRIMARY]);  -- Assuming using PRIMARY filegroup

-- Step 3: Create the Table using the Partition Scheme
CREATE TABLE orders_part (
    order_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_customer_id INT NOT NULL,
    order_status VARCHAR(255),
    PRIMARY KEY (order_id, order_date)
) ON MonthPartitionScheme(order_date);


--Exercise 2

-- Load data from orders into orders_part
INSERT INTO orders_part (order_id, order_date, order_customer_id, order_status)
SELECT order_id, order_date, order_customer_id, order_status FROM orders;

-- Get total count of records in orders_part
SELECT COUNT(*) AS TotalRecords FROM orders_part;

-- Get counts from each partition
-- This requires dynamic management views to fetch partition-wise counts
SELECT 
    $PARTITION.MonthPartitionFunction(order_date) AS PartitionNumber,
    COUNT(*) AS RecordsInPartition
FROM 
    orders_part
GROUP BY 
    $PARTITION.MonthPartitionFunction(order_date);
