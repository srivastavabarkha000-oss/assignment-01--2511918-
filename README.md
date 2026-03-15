# assignment-01--2511918-
Assignment for RDBMS, NoSQL, Data Warehouse, Vector Databases, Data Lakes &amp; DuckDB, Capstone Design
part1-rdbms/normalization.md
#Anamoly Analysis
In this particular Table a product cannot be inserted unless it has Order details: Order_id, Custumer_id, Sales_rep_id is required.
If you want to add a new product Monitor, it cannot be added as order details for it does not exist.
For Update anomaly
Data is inconsistent for updation
