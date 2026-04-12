# Indexing

**Tags:** #learning/sql #databases #performance
**Status:** 🌱 Seedling
**Related:** [[Learning/Dev/MYSQL/Databases MOC]] | [[Learning/Dev/MYSQL/SQL - Fundamentals]] | [[Learning/Dev/MYSQL/Advanced SQL]]

-----

## 🧠 Mental Model

An index in a database works like the index at the back of a book. Without it, MySQL has to read every single page to find what you’re looking for (a **full table scan**). With it, it jumps straight to the right place.

Indexes make **reads faster** but **writes slightly slower** (because the index must be updated too).

-----

## 🏗️ Creating an Index

```sql
-- Basic index on a single column
CREATE INDEX idx_email ON users (email);

-- Unique index (also enforces no duplicates)
CREATE UNIQUE INDEX idx_unique_email ON users (email);

-- Composite index (covers multiple columns)
CREATE INDEX idx_name_age ON users (name, age);

-- Index added at table creation time
CREATE TABLE users (
  id    INT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(255) NOT NULL,
  age   INT,
  INDEX idx_email (email)
);
```

-----

## 🔍 When Does an Index Help?

Indexes help most on columns used in:

- `WHERE` clauses → `WHERE email = 'x@y.com'`
- `JOIN` conditions → `ON users.id = orders.user_id`
- `ORDER BY` → `ORDER BY created_at DESC`
- `GROUP BY` → `GROUP BY country`

> [!tip] Foreign key columns are almost always worth indexing — MySQL doesn’t do this automatically.

-----

## ⚠️ When Indexes Don’t Help (or Hurt)

```sql
-- Functions on indexed columns break index usage
WHERE YEAR(created_at) = 2024       -- ❌ won't use index
WHERE created_at >= '2024-01-01'    -- ✅ will use index

-- Leading wildcard breaks index usage
WHERE name LIKE '%smith'    -- ❌
WHERE name LIKE 'smith%'    -- ✅

-- Low-cardinality columns (e.g. boolean) rarely benefit
-- An index on `is_active` with only true/false values is often ignored
```

-----

## 🔎 Checking if Your Query Uses an Index

Use `EXPLAIN` to see what MySQL is doing:

```sql
EXPLAIN SELECT * FROM users WHERE email = 'darren@example.com';
```

Key columns to look at in the output:

|Column|What to look for                                      |
|------|------------------------------------------------------|
|`type`|`ref` or `range` = good. `ALL` = full table scan = bad|
|`key` |Which index was used (or `NULL` if none)              |
|`rows`|Estimated rows MySQL will examine — lower is better   |

-----

## 🗑️ Dropping an Index

```sql
DROP INDEX idx_email ON users;
```

-----

## 🪜 Learning Path

- [ ] Understand what a full table scan is
- [ ] Can create a basic index on a column
- [ ] Know when NOT to add an index
- [ ] Can use EXPLAIN to inspect a query
- [ ] Understand composite indexes and column order

-----

## 📚 Resources

- [Use The Index, Luke](https://use-the-index-luke.com/) — the definitive free guide to SQL indexing

-----

*Last reviewed: {{date}}*