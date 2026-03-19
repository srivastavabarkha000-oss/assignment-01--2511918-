-- DIMENSION TABLES
CREATE TABLE dim_date (
    date_id INT,
    date_dw DATE,
    day INT,
    month INT,
    year INT,
    PRIMARY KEY(date_id)
);

CREATE TABLE dim_store (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100),
    store_city VARCHAR(50)
);

CREATE TABLE dim_product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50)
);
CREATE TABLE fact_sales (
    sales_id INT PRIMARY KEY,
    date_id INT,
    store_id INT,
    product_id INT,
    units_sold INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(12,2),

    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);
-- INSERT INTO DIM_DATE (cleaned data)
INSERT INTO dim_date VALUES
(1, '2023-08-29', 29, 8, 2023),
(2, '2023-12-12', 12, 12, 2023),
(3, '2023-02-05', 5, 2, 2023),
(4, '2023-02-20', 20, 2, 2023),
(5, '2023-01-15', 15, 1, 2023),
(6, '2023-03-10', 10, 3, 2023),
(7, '2023-04-18', 18, 4, 2023),
(8, '2023-05-22', 22, 5, 2023),
(9, '2023-06-30', 30, 6, 2023),
(10, '2023-07-14', 14, 7, 2023);

-- INSERT INTO DIM_STORE
INSERT INTO dim_store VALUES
(1, 'Chennai Anna', 'Chennai'),
(2, 'Delhi South', 'Delhi'),
(3, 'Mumbai Central', 'Mumbai');

-- INSERT INTO DIM_PRODUCT
INSERT INTO dim_product VALUES
(1, 'Laptop', 'Electronics'),
(2, 'Mobile Phone', 'Electronics'),
(3, 'Refrigerator', 'Appliances'),
(4, 'Washing Machine', 'Appliances'),
(5, 'Television', 'Electronics');

-- INSERT INTO FACT_SALES
-- (calculated total_amount)
INSERT INTO fact_sales VALUES
(1, 1, 1, 1, 3, 49262.78, 147788.34),
(2, 2, 1, 2, 11, 23226.12, 255487.32),
(3, 3, 1, 3, 20, 48703.39, 974067.80),
(4, 4, 2, 2, 14, 23226.12, 325165.68),
(5, 5, 1, 5, 10, 58851.01, 588510.10),
(6, 6, 3, 1, 5, 50000.00, 250000.00),
(7, 7, 2, 4, 8, 30000.00, 240000.00),
(8, 8, 3, 3, 6, 45000.00, 270000.00),
(9, 9, 1, 2, 12, 22000.00, 264000.00),
(10, 10, 2, 5, 7, 60000.00, 420000.00);

SELECT 
    d1.year,
    d1.month,
    p1.category,
    SUM(f1.total_amount) AS total_revenue
FROM fact_sales f1
JOIN dim_date d1 
    ON f1.date_id = d1.date_id
JOIN dim_product p1 
    ON f1.product_id = p1.product_id
GROUP BY 
    d1.year, d1.month, p1.category
ORDER BY 
    d1.year, d1.month, p1.category;
    
    SELECT 
    s1.store_name,
    SUM(f1.total_amount) AS total_revenue
FROM fact_sales f1
JOIN dim_store s1 
    ON f1.store_id = s1.store_id
GROUP BY 
    s1.store_name
ORDER BY 
    total_revenue DESC
LIMIT 2;

SELECT 
    year,
    month,
    total_revenue,
    LAG(total_revenue) OVER (ORDER BY year, month) AS prev_month_revenue,
    ROUND(
        (total_revenue - LAG(total_revenue) OVER (ORDER BY year, month)) 
        / LAG(total_revenue) OVER (ORDER BY year, month) * 100, 2
    ) AS growth_percent
FROM (
    SELECT 
        d1.year,
        d1.month,
        SUM(f1.total_amount) AS total_revenue
    FROM fact_sales f1
    JOIN dim_date d1
        ON f1.date_id = d1.date_id
    GROUP BY d1.year, d1.month
) t1
ORDER BY year, month;
