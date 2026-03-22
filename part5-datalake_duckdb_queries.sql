--These codes have been run on DuckDB shell interface and have sucessfully returned the desired output
-- Q1: List all customers along with the total number of orders they have placed
SELECT
    c.customer_id,
   COUNT(o.order_id)
FROM "C:\Users\sriva\Downloads\Assignment2\customers.csv" c
LEFT JOIN "C:\Users\sriva\Downloads\Assignment2\orders.json" o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

-- Q2: Find the top 3 customers by total order value
SELECT
  c.customer_id,
  SUM(o.total_amount) AS total_order_value
FROM "C:\Users\sriva\Downloads\Assignment2\customers.csv" AS c
JOIN  "C:\Users\sriva\Downloads\Assignment2\orders.json" AS o
ON  c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_order_value DESC
LIMIT 3;

-- Q3: List all products purchased by customers from Bangalore
WITH orders_fixed AS (
     SELECT
       *,
       ROW_NUMBER() OVER () AS rn
   FROM "C:\Users\sriva\Downloads\Assignment2\orders.json"
),
products_fixed AS (
  SELECT
      *,
     ROW_NUMBER() OVER () AS rn
  FROM "C:\Users\sriva\Downloads\Assignment2\products.parquet"
)
SELECT
    c.customer_id,
     p.product_name
 FROM "C:\Users\sriva\Downloads\Assignment2\customers.csv" c
 JOIN orders_fixed o
 ON c.customer_id = o.customer_id
JOIN products_fixed p
 ON o.rn = p.rn
WHERE c.city = 'Bangalore';

-- Q4: Join all three files to show: customer name, order date, product name, and quantity
WITH orders_fixed AS (
   SELECT
       *,
      ROW_NUMBER() OVER () AS rn
   FROM  "C:\Users\sriva\Downloads\Assignment2\orders.json"
),
products_fixed AS (
 SELECT
        *,
        ROW_NUMBER() OVER () AS rn
 FROM "C:\Users\sriva\Downloads\Assignment2\products.parquet"
)
SELECT
   c.name,
 o.order_date,
    p.product_name,
     o.num_items AS quantity
    
FROM "C:\Users\sriva\Downloads\Assignment2\customers.csv" c
JOIN orders_fixed o
     ON c.customer_id = o.customer_id
JOIN products_fixed p
     ON o.rn = p.rn;
