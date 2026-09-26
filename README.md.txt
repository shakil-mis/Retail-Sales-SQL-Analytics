# 🛒 Retail & E-Commerce Sales Analytics (PostgreSQL)

## 📌 Project Overview
This project focuses on solving **17 real-world business & analytics problems** using **PostgreSQL**. It covers various data analysis scenarios including customer segmentation, sales revenue analysis, inventory management, and financial insights.

The project transitions from basic SQL queries to advanced techniques like **Window Functions, CTEs, Multi-table Joins, and Aggregations**.

---

## 🗄️ Database Schema & Dataset
The database models a multi-channel Retail & E-Commerce ecosystem containing 13 relational tables:
- **Core Entities:** `customers`, `employees`, `departments`, `categories`, `products`, `suppliers`, `stores`
- **Transactions:** `orders`, `order_items`, `payments`, `shipments`, `returns`, `reviews`

---

## 🚀 Key Topics & SQL Techniques Covered
1. **Basic SQL:** Data Filtering (`LIKE`, `WHERE`), Handling Missing Values (`IS NULL`).
2. **Aggregations & Grouping:** Sales summaries, Inventory stock counts (`COUNT`, `SUM`, `AVG`, `GROUP BY`, `HAVING`).
3. **Multi-Table Joins:** Combining customer, sales, and employee data across multiple entities (`INNER JOIN`).
4. **Subqueries & CTEs:** Filtering based on calculated metrics and structured query design (`WITH` clause).
5. **Advanced Window Functions:** 
   - Top earners per department (`ROW_NUMBER() OVER (PARTITION BY)`)
   - Cumulative Cash Flow (`SUM() OVER (ORDER BY)`)
   - Payment Interval Analysis (`LAG()`)
6. **Business Metrics:** Customer Lifetime Value (CLV) analysis.

---

## 📂 Project Structure
- `solutions.sql`: Contains step-by-step SQL queries for all 17 interview/business tasks.
- `schema.sql`: Database schema definition script.
- `data/`: Raw CSV files used for database population.

---

## 🛠️ How to Run
1. Execute `schema.sql` to create database tables in PostgreSQL.
2. Import CSV files from the `/data` folder into their respective tables in the order listed in `README.txt`.
3. Run queries from `solutions.sql` to analyze the data.

---
*Author: Md.Shakil Ahmed