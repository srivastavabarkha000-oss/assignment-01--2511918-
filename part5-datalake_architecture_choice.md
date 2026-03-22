part5-datalake/architecture_choice.md



## Architecture Recommendation



A Data Lakehouse is the most suitable architecture for this food delivery startup because it combines the flexibility of a Data Lake with the performance and structure of a Data Warehouse.

1. The startup deals with diverse data types—GPS logs (structured/semi-structured), customer reviews (unstructured text), payment transactions (structured), and menu images (unstructured). A Data Lakehouse can store all these formats in one unified system, unlike a traditional Data Warehouse which mainly handles structured data.
2. The company needs both real-time analytics and advanced processing. For example, analyzing delivery routes from GPS data, performing sentiment analysis on reviews, and detecting fraud in transactions. A Data Lakehouse supports both batch and near real-time processing, making it ideal for such mixed workloads.
3. It provides schema enforcement and governance like a Data Warehouse while still allowing schema-on-read flexibility. This ensures data quality for critical operations like payments, while still enabling exploration of raw data such as customer reviews or images.



A Data Lakehouse is cost-efficient and scalable, as it uses cloud object storage while enabling high-performance queries through engines like DuckDB or Spark. Hence, a Data Lakehouse offers the best balance of flexibility, performance, and scalability, making it ideal for a fast-growing, data-intensive startup.





