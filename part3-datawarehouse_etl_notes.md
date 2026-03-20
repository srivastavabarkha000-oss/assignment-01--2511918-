part3-datawarehouse/etl\_notes.md



\## ETL Decisions



\### Decision 1 — Standardizing Date Formats



Problem: The raw dataset contained dates in a non-standard format (e.g., DD-MM-YYYY), which is not ideal for database storage and time-based analysis.



Resolution: All dates were converted into a standard ISO format (YYYY-MM-DD) during the transformation phase. Additionally, separate attributes like day, month, and year were derived and stored in the dim\_date table to support efficient time-based analysis.



\### Decision 2 — Handling Inconsistent Category



Problem: Product categories in the dataset had inconsistent casing (e.g., 'electronics', 'Electronics'), or inconsistent category name (e.g., 'Grocery', 'Groceries'), which could lead to incorrect aggregations and duplicate category entries.



Resolution: Category values were cleaned and standardized to a consistent sentence-case format (e.g., capitalized as Electronics, Appliances) using transformation rules before loading into the dim\_product table. This ensured accurate grouping and reporting.



\### Decision 3 — Deriving Calculated Fields



Problem: The dataset did not include a precomputed **total sales value**, which is essential for analytical queries.



Resolution: A new column total\_amount was derived using the formula units\_sold × unit\_price during transformation and stored in the fact\_sales table for efficient reporting.



