# SQL & Database Terminology

**Tags:** #learning/sql #databases #reference
**Status:** 📖 Reference
**Related:** [[learning/mysql/Databases MOC]] | [[learning/mysql/SQL - Fundamentals]] | [[learning/mysql/Joins Explained]] | [[learning/mysql/Advanced SQL]]

> [!info] How to use this note
> This is a **reference glossary** — not meant to be read top to bottom. Use `Ctrl+F` to jump to a term, or follow links from other notes. Terms are grouped thematically, not alphabetically.

-----

## 🗄️ Core Database Concepts

### Database

A structured collection of data stored and managed by a Database Management System (DBMS). In MySQL, one server can host many databases side by side (e.g. one per application).

### DBMS (Database Management System)

The software that manages databases — handles storage, querying, access control, and transactions. MySQL, PostgreSQL, SQLite, and MariaDB are all DBMSs.

### Relational Database

A database that organises data into **tables** with defined relationships between them. All data is stored in rows and columns, and related data is linked via keys rather than duplicated.

### Schema

The **structure** of a database — which tables exist, what columns they have, what types those columns are, and how tables relate to each other. The schema is the blueprint; the data is what fills it.

### Table

A collection of related data organised into rows and columns. Equivalent to a spreadsheet sheet. Each table represents one “thing” (e.g. users, orders, products).

### Row / Record / Tuple

A single entry in a table. Each row represents one instance of the thing the table describes (e.g. one user, one order). These three terms mean the same thing.

### Column / Field / Attribute

A named property of a table (e.g. `email`, `created_at`). Every row has a value for each column (or `NULL` if none). Again, these three terms are interchangeable.

### NULL

The absence of a value. Not zero, not an empty string — literally no value. Requires special handling in SQL (`IS NULL` / `IS NOT NULL` rather than `= NULL`).

-----

## 🔑 Keys & Relationships

### Primary Key (PK)

A column (or combination of columns) that **uniquely identifies each row** in a table. No two rows can share a primary key value, and it can never be `NULL`. Typically `id`.

```sql
id INT PRIMARY KEY AUTO_INCREMENT
```

### Foreign Key (FK)

A column in one table that **references the primary key of another table**. This is how relationships between tables are enforced. MySQL will reject inserts that reference a non-existent primary key (referential integrity).

```sql
FOREIGN KEY (user_id) REFERENCES users(id)
```

### Composite Key

A primary key made up of **two or more columns** together. Neither column alone is unique, but the combination is.

```sql
PRIMARY KEY (user_id, role_id)
```

### Candidate Key

Any column (or combination) that *could* serve as a primary key — it’s unique and non-null. A table may have several candidate keys; the one you pick becomes the primary key, the rest are **alternate keys**.

### Surrogate Key

An artificial primary key with no business meaning — typically an auto-incrementing integer (`id`) or a UUID. Preferred over natural keys in most modern database design.

### Natural Key

A primary key derived from real-world data that already exists (e.g. `email`, `national_insurance_number`). Risky because real-world data can change.

### Cardinality

Describes the nature of a relationship between two tables:

- **One-to-one** — one user has one profile
- **One-to-many** — one user has many orders
- **Many-to-many** — many users can enrol in many courses (requires a junction table)

Also used to describe **how many distinct values** a column has. A boolean column has low cardinality (2 values). An email column has high cardinality (unique per row).

-----

## 📐 Query Concepts

### Cartesian Product

What you get when you join two tables **with no ON condition** — every row from the left table is paired with every row from the right table. A table of 100 rows crossed with a table of 200 rows gives 20,000 rows back.

```sql
-- Accidental Cartesian product (missing ON clause)
SELECT * FROM users, orders;

-- Intentional (same as CROSS JOIN)
SELECT * FROM colours CROSS JOIN sizes;
```

> [!warning] Accidental Cartesian products are a common beginner mistake and can bring a database to its knees on large tables.

### Predicate

The condition in a `WHERE` or `HAVING` clause. `WHERE age > 30` — the predicate is `age > 30`. It evaluates to true or false for each row.

### Projection

Choosing **which columns** to return. `SELECT name, email FROM users` is projecting just `name` and `email` from all available columns.

### Selection (Filtering)

Choosing **which rows** to return, via `WHERE`. Not to be confused with the `SELECT` keyword — selection is the *concept* of filtering rows.

### Alias

A temporary name given to a column or table for the duration of a query.

```sql
SELECT name AS full_name FROM users AS u;
```

### Wildcard

`%` matches any sequence of characters in a `LIKE` clause. `_` matches exactly one character.

```sql
WHERE email LIKE '%@gmail.com'   -- ends with @gmail.com
WHERE code  LIKE 'A_C'           -- A, any one char, C
```

### Aggregate Function

A function that operates on a **set of rows** and returns a single value: `COUNT()`, `SUM()`, `AVG()`, `MIN()`, `MAX()`.

### Scalar Function

A function that operates on a **single value** and returns a single value: `UPPER()`, `LENGTH()`, `ROUND()`, `NOW()`.

### Subquery / Derived Table / Inline View

A query nested inside another query. When used in a `FROM` clause it’s sometimes called a **derived table** or **inline view** because it acts like a temporary table.

### CTE (Common Table Expression)

A named temporary result set defined with `WITH`. Makes complex queries readable by letting you build them in named steps. See [[learning/mysql/Advanced SQL]].

### Window Function

A function that calculates across a set of rows **related to the current row** without collapsing them into one. `RANK()`, `ROW_NUMBER()`, `LAG()`, `SUM() OVER()`. See [[learning/mysql/Advanced SQL]].

### Execution Plan

The strategy the database engine chooses to execute your query — which indexes to use, in what order to join tables, etc. Viewed with `EXPLAIN`.

-----

## ⚡ Performance Concepts

### Index

A separate data structure (usually a B-tree) built from one or more columns to make lookups faster. Trades slightly slower writes for much faster reads. See [[learning/mysql/Indexing]].

### Full Table Scan

When MySQL reads **every row** in a table to find matches because no suitable index exists. Fine for small tables, potentially catastrophic for large ones.

### Cardinality (Index)

In the context of indexes, cardinality is the number of distinct values in the indexed column. High cardinality = more selective = more useful index. Low cardinality (e.g. boolean) = index often skipped by the query planner.

### Query Planner / Optimiser

The part of the database engine that decides *how* to execute a query. It may choose different strategies (index scan vs full scan, join order) based on table statistics. You can inspect its decisions with `EXPLAIN`.

### B-Tree Index

The most common index type in MySQL. Data is stored in a balanced tree structure, making range queries (`>`, `<`, `BETWEEN`) and exact lookups equally efficient.

### Covering Index

An index that contains **all the columns a query needs** — so MySQL can answer the query entirely from the index without touching the actual table rows at all.

```sql
-- If the index covers (name, email), this query never touches the table
SELECT name, email FROM users WHERE name = 'Darren';
```

### N+1 Query Problem

A performance anti-pattern where you run one query to fetch a list of records, then one additional query **per record** to fetch related data — resulting in N+1 total queries instead of one well-written JOIN.

```
1 query:  SELECT * FROM users          → 100 users
100 queries: SELECT * FROM orders WHERE user_id = ?  (once per user)
= 101 queries total
```

> [!tip] Almost always solvable with a JOIN or eager loading in your ORM.

-----

## 💧 ORM & Application Layer

### ORM (Object-Relational Mapper)

A library that maps database rows to objects in your programming language, letting you interact with the database without writing raw SQL. Doctrine (PHP/Symfony), Eloquent (Laravel), and TypeORM (TypeScript) are common examples.

### Hydration

The process of taking raw database rows and **populating (hydrating) objects** with that data. When Doctrine runs a query and returns `User` objects, it is hydrating those objects from the result set.

The inverse is **dehydration** — converting an object back into data suitable for storage.

```
Database row → [hydration] → User object with properties populated
User object  → [dehydration/persist] → SQL INSERT or UPDATE
```

### Entity

In ORM terms, a class that maps to a database table. Each instance of the entity represents one row.

### Repository

A class responsible for querying a specific entity from the database. Keeps database logic out of your controllers and services.

### Migration

A versioned, code-based change to the database schema (add a column, create a table, add an index). Migrations let you evolve your schema in a controlled, repeatable, reversible way — and keep it in version control alongside your application code.

### Seed / Fixture

Test or default data inserted into the database — usually used to populate a fresh environment or set up known state for testing.

### Eager Loading

Loading related records **upfront in the same query** (via JOIN or a second bulk query) to avoid the N+1 problem.

### Lazy Loading

Loading related records **only when accessed**. Convenient but can silently trigger the N+1 problem if you’re not careful.

-----

## 🔒 Transactions & Integrity

### Transaction

A group of SQL statements treated as a single unit — all succeed or all are rolled back. See [[learning/mysql/Transactions & ACID]].

### ACID

The four guarantees of a reliable transaction: **Atomic**, **Consistent**, **Isolated**, **Durable**. See [[learning/mysql/Transactions & ACID]].

### Referential Integrity

The guarantee that a foreign key always points to a row that actually exists. MySQL enforces this when foreign keys are defined — you can’t insert an order for a user that doesn’t exist, and you can’t delete a user who has orders (without cascading).

### Cascade

An automatic action triggered on a related table when the parent row is updated or deleted.

```sql
FOREIGN KEY (user_id) REFERENCES users(id)
  ON DELETE CASCADE   -- delete user → their orders deleted too
  ON UPDATE CASCADE   -- update user id → orders updated to match
```

### Deadlock

Two transactions each holding a lock the other needs, causing both to wait forever. MySQL detects this and kills one transaction automatically.

### Optimistic Locking

Assumes conflicts are rare — lets transactions proceed without locking, then checks at commit time whether anyone else changed the data. Common in ORMs via a `version` column.

### Pessimistic Locking

Assumes conflicts are likely — locks rows immediately with `SELECT ... FOR UPDATE` so no other transaction can touch them until you’re done.

-----

## 📊 Data Types (MySQL)

|Type              |Use for                                                           |
|------------------|------------------------------------------------------------------|
|`INT` / `BIGINT`  |Whole numbers. BIGINT for very large IDs                          |
|`DECIMAL(m,d)`    |Exact decimals — use for money, never FLOAT                       |
|`FLOAT` / `DOUBLE`|Approximate decimals — fine for scientific data, not currency     |
|`VARCHAR(n)`      |Variable-length strings up to n characters                        |
|`TEXT`            |Long strings with no fixed limit                                  |
|`TINYINT(1)`      |Boolean (MySQL has no true BOOL type)                             |
|`DATE`            |Date only: `2024-01-15`                                           |
|`DATETIME`        |Date + time: `2024-01-15 13:45:00`                                |
|`TIMESTAMP`       |Like DATETIME but stored in UTC, auto-converts to session timezone|
|`JSON`            |Native JSON storage with queryable fields (MySQL 5.7+)            |
|`ENUM`            |A fixed set of string values — convenient but inflexible          |


> [!warning] Never store money in `FLOAT` or `DOUBLE`. Floating point arithmetic is imprecise. Use `DECIMAL(10,2)` instead.

-----

## 🧩 Normalisation

### Normalisation

The process of structuring a database to **reduce redundancy** and **improve integrity** by organising data into related tables. Each piece of information lives in one place.

### Denormalisation

Deliberately introducing redundancy for **read performance** — storing derived or duplicated data to avoid expensive joins at query time. Common in reporting databases and data warehouses.

### Normal Forms

A series of rules for how well-structured a table is:

|Form   |Rule (simplified)                                            |
|-------|-------------------------------------------------------------|
|**1NF**|No repeating groups; each column holds one value             |
|**2NF**|1NF + every non-key column depends on the *whole* primary key|
|**3NF**|2NF + no non-key column depends on another non-key column    |


> [!tip] In practice, aim for 3NF as a default. Denormalise only when you have a measured performance reason to.

-----

## 🌐 Other Terms Worth Knowing

### DDL (Data Definition Language)

SQL statements that define or alter structure: `CREATE`, `ALTER`, `DROP`, `TRUNCATE`.

### DML (Data Manipulation Language)

SQL statements that work with data: `SELECT`, `INSERT`, `UPDATE`, `DELETE`.

### DCL (Data Control Language)

SQL statements that manage access: `GRANT`, `REVOKE`.

### TCL (Transaction Control Language)

SQL statements that manage transactions: `COMMIT`, `ROLLBACK`, `SAVEPOINT`.

### Stored Procedure

A named, saved SQL routine that can be called by name. Lives inside the database. Useful for complex, reusable logic — but harder to version control than application code.

### View

A saved query that behaves like a virtual table. Doesn’t store data itself — just runs the underlying query each time it’s accessed.

```sql
CREATE VIEW active_users AS
SELECT * FROM users WHERE last_login > '2024-01-01';

-- Now queryable like a real table
SELECT * FROM active_users;
```

### Materialised View

Like a view, but the result is **physically stored** and periodically refreshed. Faster to read but data can be slightly stale. Not natively supported in MySQL (available in PostgreSQL).

### Cursor

A database object used to iterate over a result set row by row — typically inside stored procedures. Rarely needed in application code.

### Connection Pool

A cache of reusable database connections maintained by your application server. Opening a new connection is expensive; pooling means connections are borrowed, used, and returned rather than opened and closed per request.

### Query Cache

A now-removed MySQL feature that cached query results. Removed in MySQL 8.0 because it caused more problems than it solved at scale.

### Replication

Copying data from a **primary** (master) database server to one or more **replica** (slave) servers in near-real-time. Used for read scaling and failover.

### Sharding

Splitting a large database horizontally across multiple servers, each holding a **subset of the rows**. Complex to implement but allows horizontal scaling beyond what a single server can handle.

-----

*Last reviewed: {{date}}*