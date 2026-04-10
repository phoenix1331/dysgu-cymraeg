---
type: reference
skill: SQL
tags:
  - work/skill
  - sql
  - reference
---

# SQL Commands Cheatsheet

Quick reference for commonly used SQL commands.

## SELECT Basics

```sql
SELECT column1, column2
FROM table_name
WHERE condition
ORDER BY column1 ASC;
```

## Filtering

```sql
-- Comparison operators
WHERE age > 25
WHERE status = 'active'
WHERE price BETWEEN 10 AND 50
WHERE city IN ('NYC', 'LA', 'Chicago')
WHERE name LIKE 'J%'

-- Logical operators
WHERE age > 25 AND status = 'active'
WHERE city = 'NYC' OR city = 'LA'
WHERE NOT status = 'deleted'
```

## JOINs

```sql
-- INNER JOIN
SELECT a.*, b.*
FROM table_a a
INNER JOIN table_b b ON a.id = b.a_id;

-- LEFT JOIN
SELECT a.*, b.*
FROM table_a a
LEFT JOIN table_b b ON a.id = b.a_id;
```

## Aggregates

```sql
SELECT
    COUNT(*) as total,
    SUM(amount) as total_amount,
    AVG(price) as avg_price,
    MIN(date) as earliest,
    MAX(date) as latest
FROM sales
GROUP BY category
HAVING COUNT(*) > 5;
```

## Common Patterns

### Pagination
```sql
SELECT * FROM users
ORDER BY created_at DESC
LIMIT 10 OFFSET 20;
```

### Deduplication
```sql
SELECT DISTINCT category
FROM products;
```

## Related
- [[Work/Skills/SQL Learning Path]]
