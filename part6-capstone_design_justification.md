part6-capstone/design_justification.md

## Storage Systems

The architecture uses a combination of relational, NoSQL, analytical,
and streaming-oriented storage systems to meet the four goals of the
hospital network. For predicting patient readmission risk, structured
clinical data such as demographics, diagnoses, and treatment history are
stored in MySQL, ensuring strong consistency and reliability. In
addition, historical datasets are stored in Parquet format within a data
lake, enabling efficient large-scale processing and model training due
to its columnar storage.

For natural language querying of patient history, MongoDB is used to
store semi-structured data such as doctor notes, lab reports, and
discharge summaries. Its flexible schema allows easy handling of varied
medical records. A vector database complements this by storing
embeddings of these documents, enabling semantic search and supporting
queries in plain English.

For monthly reporting, DuckDB is used as the OLAP engine, querying data
directly from Parquet files. This setup allows fast aggregation and
analytical queries without requiring a heavy data warehouse. It is
well-suited for generating reports such as bed occupancy rates and
departmental costs.

For real-time ICU monitoring, Apache Kafka is used for streaming
ingestion of vitals data, while a time-series database stores this data
efficiently. Time-series databases are optimized for high-frequency,
timestamped data, making them ideal for continuous patient monitoring
and alerting systems.

## OLTP vs OLAP Boundary

In this architecture, the OLTP (Online Transaction Processing) system
consists primarily of MySQL and the time-series database. These systems
handle real-time operations such as patient record updates, ICU vitals
ingestion, and transactional consistency. They are optimized for
frequent inserts and updates with low latency.

The OLAP (Online Analytical Processing) system begins where data is
extracted from these transactional systems and stored in the data lake
(Parquet format). DuckDB operates on this analytical layer, performing
complex queries, aggregations, and trend analysis required for reporting
and machine learning. The boundary is therefore defined at the ETL/ELT
layer, where data transitions from operational use to analytical
processing. This separation ensures that analytical workloads do not
impact transactional performance.

## Trade-offs

A key trade-off in this design is the use of multiple specialized
storage systems instead of a unified database. While this improves
performance and scalability for specific use cases (e.g., time-series
for ICU data, NoSQL for flexible records, OLAP for analytics), it
increases system complexity. Managing data consistency, synchronization,
and integration across these systems can be challenging.

To mitigate this, a robust data pipeline using orchestration tools can
be implemented to ensure reliable data movement and consistency.
Additionally, clear data governance policies and schema standards can
help maintain uniformity across systems. Using centralized monitoring
and metadata management tools can further reduce operational overhead.
This approach balances the benefits of specialization with manageable
complexity.
