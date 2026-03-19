# assignment-01--2511918-
Assignment for RDBMS, NoSQL, Data Warehouse, Vector Databases, Data Lakes &amp; DuckDB, Capstone Design
part1-rdbms/normalization.md

[part1-rdbmsnormalization.md.txt](https://github.com/user-attachments/files/26122871/part1-rdbmsnormalization.md.txt)
part1-rdbms/normalization.md

##Anomaly Analysis

For Insert Anomaly:

An insert anomaly occurs when we cannot insert certain data into the database without the knowledge of related data.
In this particular Table Orders_flat, a product cannot be inserted unless it has Order details: Order_id, Custumer_id, Sales_rep_id, hence the data is not normalized.

If we want to add a new product 'Monitor', it cannot be added as order details for it does not exist. 

For example: A new product is introduced, i.e., 'P020' as product Id, 'Keyboard' as product name, 'Electronics' as category and '2000' as unit price, but we cannot enter this data without the help of related data, as the table also requires order_id, customer_id, sales_rep_id, quantity, order_date.

For Update anomaly:
This anomaly occurs when the same information is stored in multiple rows and must be updated everywhere. So, in order to update the office address for the sales representative 'Ravi Kumar', we must update it at every row, any missing row will result in inconsistency in data.
 Therefore, in this Table Orders_flat, data is inconsistent for updation.

For Delete Anomaly:
This anomaly occurs when deleting one piece of information unintentionally removes other important data.
For example: Every order has a unique order_id, therefore each order is unique. Now, deleting a data related to 'Mouse' will delete that particular order entirely, and if by chance we have just one order for 'Mouse', that data is lost.


##Normalisation Justification

The argument "keeping everything in one table" may seem convenient at first but it leads to serious data integrity and maintenance issues. In the given dataset Orders_flat, combining customers, products, orders, and sales representatives into a single table introduces redundancy and anomalies.

Insert Anomaly:
Cannot insert independent data (e.g., 'Keyboard') without related order details.
Normalization separates tables (Products, Customers), allowing independent insertion.

Update Anomaly:
Same data repeated in multiple rows leads to inconsistency during updates. For example, updating order category for 'Neha Gupta' may results in data inconsistencies if some data is missed.
Normalization stores data once, reducing redundancy and ensuring consistency.

Delete Anomaly:
Deleting a record may remove important data, for example, deleting an order for 'Mouse' may delete other product info.
Normalization separates entities, preserving essential data.


