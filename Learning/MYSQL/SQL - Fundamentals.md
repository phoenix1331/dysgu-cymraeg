# SQL — Fundamentals

> [!tip] What is SQL?
> **SQL** (Structured Query Language) is how you talk to a relational database. You use it to store, retrieve, update, and delete data — think of it as a very precise way of asking questions about organised information.

**Tags:** #learning/sql #databases #backend
**Status:** 🌱 Seedling
**Related:** [[Learning/MYSQL/Databases MOC]] | [[Learning/MYSQL/Joins Explained]] | [[Learning/MYSQL/Indexing]]

-----

## 🧠 Mental Model

Imagine a database as a **spreadsheet workbook**:

- The workbook = the **database**
- Each sheet = a **table**
- Each column heading = a **field/column**
- Each row = a **record**

SQL lets you ask questions like *“show me all the rows where the age is over 30”* — but precisely and consistently.

-----

## 🏗️ The Four Core Operations (CRUD)

|Operation|SQL Keyword|What it does|
|---------|-----------|------------|
|Create   |`INSERT`   |Add new rows|
|Read     |`SELECT`   |Fetch data  |
|Update   |`UPDATE`   |Modify rows |
|Delete   |`DELETE`   |Remove rows |

-----

## 📖 SELECT — Reading Data

The most common thing you’ll write. Start here.

```sql
-- Get everything from a table
SELECT * FROM users;

-- Get specific columns only
SELECT name, email FROM users;

-- Filter with WHERE
SELECT name, email FROM users
WHERE age > 30;

-- Sort results
SELECT name, age FROM users
ORDER BY age DESC;

-- Limit how many rows come back
SELECT name FROM users
LIMIT 10;
```

> [!note] `*` means “all columns”. It’s fine for exploration, but in production code you should name your columns explicitly.

-----

## ✏️ INSERT — Adding Data

```sql
-- Insert a single row
INSERT INTO users (name, email, age)
VALUES ('Darren', 'darren@example.com', 32);

-- Insert multiple rows at once
INSERT INTO users (name, email, age)
VALUES
  ('Alice', 'alice@example.com', 28),
  ('Bob',   'bob@example.com',   45);
```

-----

## 🔄 UPDATE — Changing Data

> [!warning] Always use a `WHERE` clause with UPDATE!
> Without it, you’ll update **every single row** in the table. That’s rarely what you want.

```sql
-- Update one user's email
UPDATE users
SET email = 'new@example.com'
WHERE id = 42;

-- Update multiple columns at once
UPDATE users
SET email = 'new@example.com', age = 33
WHERE id = 42;
```

-----

## 🗑️ DELETE — Removing Data

> [!danger] Same warning as UPDATE — always use `WHERE` unless you deliberately want to wipe the whole table.

```sql
-- Delete a specific user
DELETE FROM users
WHERE id = 42;

-- Delete based on a condition
DELETE FROM users
WHERE last_login < '2020-01-01';
```

-----

## 🔗 JOINs — Combining Tables

Real databases split data across multiple tables. JOINs let you bring them together.

### Example Schema

```
users          orders
---------      ------------------
id             id
name           user_id  ← links to users.id
email          product
               amount
```

### INNER JOIN — only matching rows

```sql
SELECT users.name, orders.product, orders.amount
FROM users
INNER JOIN orders ON users.id = orders.user_id;
```

Returns only users **who have orders**.

### LEFT JOIN — all rows from the left table

```sql
SELECT users.name, orders.product
FROM users
LEFT JOIN orders ON users.id = orders.user_id;
```

Returns **all users**, even those with no orders (their order columns will be `NULL`).

> [!tip] Use `LEFT JOIN` when you need “give me everything from A, and whatever matches from B.”

-----

## 🧮 Aggregates — Summarising Data

```sql
-- Count all users
SELECT COUNT(*) FROM users;

-- Count per group
SELECT country, COUNT(*) AS total
FROM users
GROUP BY country;

-- Average, sum, min, max
SELECT
  AVG(age)  AS avg_age,
  SUM(age)  AS total_age,
  MIN(age)  AS youngest,
  MAX(age)  AS oldest
FROM users;

-- Filter groups with HAVING (like WHERE but for aggregates)
SELECT country, COUNT(*) AS total
FROM users
GROUP BY country
HAVING COUNT(*) > 10;
```

-----

## 🔑 Keys & Constraints

|Term           |Meaning                                                 |
|---------------|--------------------------------------------------------|
|**Primary Key**|Unique identifier for each row. Usually `id`.           |
|**Foreign Key**|A column that references a primary key in another table.|
|**NOT NULL**   |The column must always have a value.                    |
|**UNIQUE**     |No two rows can have the same value in this column.     |
|**DEFAULT**    |A fallback value if none is provided.                   |

```sql
CREATE TABLE users (
  id    INT          PRIMARY KEY AUTO_INCREMENT,
  name  VARCHAR(100) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  age   INT          DEFAULT 0
);
```

-----

## ⚡ Quick Reference Cheatsheet

```sql
-- Pattern: SELECT what FROM where WHERE condition ORDER BY col LIMIT n
SELECT name, email
FROM users
WHERE age > 18
ORDER BY name ASC
LIMIT 25;

-- Alias columns for readability
SELECT name AS full_name, email AS contact FROM users;

-- Search with LIKE (% = wildcard)
SELECT * FROM users WHERE email LIKE '%@gmail.com';

-- Check against a list
SELECT * FROM users WHERE country IN ('Wales', 'Scotland', 'England');

-- Null checks
SELECT * FROM users WHERE last_login IS NULL;
SELECT * FROM users WHERE last_login IS NOT NULL;
```

-----

## 🪜 Learning Path

- [ ] Comfortable with SELECT, WHERE, ORDER BY
- [ ] Understand INSERT, UPDATE, DELETE safely
- [ ] Can write a basic INNER JOIN
- [ ] Understand GROUP BY and aggregates
- [ ] Know what indexes are and why they matter → [[Learning/MYSQL/Indexing]]
- [ ] Understand transactions → [[Learning/MYSQL/Transactions & ACID]]
- [ ] Explore subqueries and CTEs → [[Learning/MYSQL/Advanced SQL]]

-----

## 📚 Resources

- [SQLBolt](https://sqlbolt.com/) — interactive exercises, great for beginners
- [Use The Index, Luke](https://use-the-index-luke.com/) — performance deep dive
- PostgreSQL docs — the gold standard reference

-----

*Last reviewed: {{date}}*