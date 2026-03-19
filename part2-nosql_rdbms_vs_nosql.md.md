part2-nosql/rdbms\_vs\_nosql.md

\## Database Recommendation

Healthcare Patient Management System



A healthcare system deals with critical and sensitive data (patient records, prescriptions, billing).These type of systems require high consistency, accuracy, and reliability.



MySQL (ACID) vs MongoDB (BASE):

MySQL (ACID properties):-



* Atomicity: Transactions are all-or-nothing (important for medical updates)



* Consistency: Data remains valid (no incorrect patient records)



* Isolation: Concurrent operations don’t interfere



* Durability: Data is permanently stored



Thus, it ensures strong data integrity, which is essential in healthcare.



MongoDB (BASE properties):-



It prioritizes availability and scalability over strict consistency.



Basically Available: The system always remains available to respond to requests, even during failures. Instead of rejecting requests, MongoDB may return slightly outdated data and partial results.



Soft State: The state of this system is not fixed and may change over time. The data may be temporarily inconsistent across nodes, for example, if patient data is updated in one server, other replicas may still show the old value for a short time.



Eventually Consistent: Data will become consistent after some time, but not immediately. For example, If a patient’s address is updated: one node shows the new address instantly, other nodes may show the old address briefly. After synchronization, all nodes show the correct value.



CAP Theorem Perspective



Healthcare systems prefer:



C (Consistency) and P (Partition Tolerance), which more easily aligns with MySQL, while MongoDB, which is NoSQL DB, leans more towards Availability + Partition Tolerance (AP). It uses  BASE model and ensures system always responds and has high uptime.



MySQL is recommended for patient management system as it prevents inconsistent or partial updates, ensures reliable medical records and supports strict transaction handling. 



If they also needed to add a fraud detection module, then MongoDB would be recommended. Fraud detection requires handling large volumes of data, for which it requires real-time analytics and flexible schema (logs, patterns). Hence, MongoDB is useful here.







