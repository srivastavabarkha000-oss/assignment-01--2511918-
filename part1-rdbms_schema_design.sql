CREATE TABLE Customers (
    customer_id VARCHAR(10),
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100) NOT NULL,
    customer_city VARCHAR(50) NOT NULL,
    PRIMARY KEY (customer_id)
);
INSERT INTO Customers VALUES
('C001','Rohan Mehta','rohan@gmail.com','Mumbai'),
('C002','Priya Sharma','priya@gmail.com','Delhi'),
('C003','Amit Verma','amit@gmail.com','Bangalore'),
('C004', 'Sneha Iyer', 'sneha@gmail.com', 'Chennai'),
('C005', 'Vikram Singh', 'vikram@gmail.com','Mumbai'),
('C006', 'Neha Gupta', 'neha@gmail.com', 'Delhi');


CREATE TABLE Products (
product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL
);
INSERT INTO Products VALUES
('P005', 'Headphones', 'Electronics',3200),
('P001', 'Laptop','Electronics',55000),
('P004', 'Notebook', 'Stationery', 120),
('P002', 'Mouse', 'Electronics', 800),
('P006', 'Standing Desk', 'Furniture', 22000);

CREATE TABLE Sales_rep (
    sales_rep_id VARCHAR(10) PRIMARY KEY,
    sales_rep_name VARCHAR(100) NOT NULL,
    sales_rep_email VARCHAR(100) NOT NULL,
    office_address VARCHAR(100) NOT NULL
);
INSERT INTO Sales_rep VALUES
('SR01', 'Deepak Joshi','deepak@corp.com','Mumbai HQ, Nariman Point, Mumbai- 400021'),
('SR03', 'Ravi Kumar', 'ravi@corp.com','South Zone, MG Road, Bangalore - 560001'),
('SR02', 'Anita Desai', 'anita@corp.com','Delhi Office, Connaught Place, New Delhi - 110001');

CREATE TABLE Orders(
    order_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10) NOT NULL,
    sales_rep_id VARCHAR(10) NOT NULL,
    order_date DATE NOT NULL
    );
INSERT INTO Orders VALUES
('ORD1004', 'C001','SR01',  '2023-11-29'),
('ORD1000', 'C002', 'SR03', '2023-05-21'),
('ORD1156', 'C003', 'SR01', '2023-07-01'),
('ORD1033', 'C004', 'SR02', '2023-03-24'),
('ORD1073', 'C005', 'SR01', '2023-03-10'),
('ORD1015', 'C006', 'SR03', '2023-05-17');

CREATE TABLE Order_Items (
    order_id VARCHAR(10),
    product_id VARCHAR(10),
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, product_id)
);

INSERT INTO Order_Items VALUES
('ORD1004','P005',5),
('ORD1000','P001',2),
('ORD1156','P002',3),
('ORD1033','P004',5),
('ORD1073','P006',3),
('ORD1011','P005',1);


-- 1.3 SQL Queries Q1: List all customers from Mumbai along with their total order value
SELECT 
    c1.customer_id,
    c1.customer_name,
    SUM(t1.quantity * p.unit_price) AS total_order_value
FROM Customers c1
LEFT JOIN Orders o1 
    ON c1.customer_id = o1.customer_id
LEFT JOIN Order_Items t1
    ON o1.order_id = t1.order_id
LEFT JOIN Products p 
    ON t1.product_id = p.product_id
WHERE c1.customer_city = 'Mumbai'
GROUP BY c1.customer_id, c1.customer_name;
 -- Q2: Find the top 3 products by total quantity sold
SELECT 
    p.product_id,
    p.product_name,
    SUM(t1.quantity) AS total_quantity_sold
FROM Order_Items t1
JOIN Products p 
    ON t1.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 3;

-- Q3: List all sales representatives and the number of unique customers they have handled
SELECT 
    sr.sales_rep_id,
    sr.sales_rep_name,
    COUNT(DISTINCT o.customer_id) AS unique_customers
FROM Sales_rep sr
LEFT JOIN Orders o
    ON sr.sales_rep_id = o.sales_rep_id
GROUP BY sr.sales_rep_id, sr.sales_rep_name;

-- Q4: Find all orders where the total value exceeds 10,000, sorted by value descending
SELECT 
    o1.order_id,
    SUM(t1.quantity * p.unit_price) AS total_order_value
FROM Orders o1
JOIN Order_Items t1
    ON o1.order_id = t1.order_id
JOIN Products p 
    ON t1.product_id = p.product_id
GROUP BY o1.order_id
HAVING SUM(t1.quantity * p.unit_price) > 10000
ORDER BY total_order_value DESC;

-- Q5: Identify any products that have never been ordered
SELECT 
    p.product_id,
    p.product_name
FROM Products p
LEFT JOIN Order_Items t1
    ON p.product_id = t1.product_id
WHERE t1.product_id IS NULL;

