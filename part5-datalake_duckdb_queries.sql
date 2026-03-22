--These codes have been run on DuckDB shell interface and have sucessfully returned the desired output
SELECT
    c.customer_id,
   COUNT(o.order_id)
FROM "C:\Users\sriva\Downloads\Assignment2\customers.csv" c
LEFT JOIN "C:\Users\sriva\Downloads\Assignment2\orders.json" o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

 SELECT
  c.customer_id,
  SUM(o.total_amount) AS total_order_value
FROM "C:\Users\sriva\Downloads\Assignment2\customers.csv" AS c
JOIN  "C:\Users\sriva\Downloads\Assignment2\orders.json" AS o
ON  c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_order_value DESC
LIMIT 3;

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