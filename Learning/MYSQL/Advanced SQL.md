# Advanced SQL

**Tags:** #learning/sql #databases #advanced
**Status:** 🌱 Seedling
**Related:** [[learning/mysql/Databases MOC]] | [[learning/mysql/SQL - Fundamentals]] | [[learning/mysql/Joins Explained]] | [[learning/mysql/Indexing]]

-----

## 🧠 What Counts as “Advanced”?

Once you’re comfortable with SELECT, JOINs, and GROUP BY, the next tier is:

- **Subqueries** — queries inside queries
- **CTEs** — named, readable building blocks for complex queries
- **Window functions** — aggregate-style calculations without collapsing rows

These aren’t exotic — you’ll reach for them regularly once you know they exist.

-----

## 🔁 Subqueries

A subquery is a query nested inside another query.

### In a WHERE clause

```sql
-- Find users who have placed at least one order
SELECT name FROM users
WHERE id IN (
  SELECT DISTINCT user_id FROM orders
);
```

### In a FROM clause (derived table)

```sql
-- Average order value per user, then filter on it
SELECT user_id, avg_amount
FROM (
  SELECT user_id, AVG(amount) AS avg_amount
  FROM orders
  GROUP BY user_id
) AS user_averages
WHERE avg_amount > 100;
```

### Correlated subquery

A subquery that references the outer query — runs once per row.

```sql
-- Find users whose latest order is in 2024
SELECT name FROM users u
WHERE (
  SELECT MAX(created_at)
  FROM orders o
  WHERE o.user_id = u.id
) >= '2024-01-01';
```

> [!warning] Correlated subqueries can be slow on large tables — they re-run for every row. Consider rewriting as a JOIN or CTE if performance matters.

-----

## 🧱 CTEs — Common Table Expressions

A CTE is like giving a subquery a name. It makes complex queries far more readable.

```sql
WITH recent_orders AS (
  SELECT user_id, COUNT(*) AS order_count
  FROM orders
  WHERE created_at >= '2024-01-01'
  GROUP BY user_id
)
SELECT users.name, recent_orders.order_count
FROM users
JOIN recent_orders ON users.id = recent_orders.user_id
WHERE recent_orders.order_count > 5;
```

### Chaining multiple CTEs

```sql
WITH
  active_users AS (
    SELECT id FROM users WHERE last_login > '2024-01-01'
  ),
  their_orders AS (
    SELECT * FROM orders WHERE user_id IN (SELECT id FROM active_users)
  )
SELECT product, COUNT(*) AS times_ordered
FROM their_orders
GROUP BY product
ORDER BY times_ordered DESC;
```

> [!tip] When a query has more than one level of nesting, reach for CTEs. They read top-to-bottom like a story rather than inside-out like nested subqueries.

### Recursive CTEs

CTEs can reference themselves — useful for hierarchical data like categories or org charts.

```sql
WITH RECURSIVE category_tree AS (
  -- Base case: top-level categories
  SELECT id, name, parent_id, 0 AS depth
  FROM categories
  WHERE parent_id IS NULL

  UNION ALL

  -- Recursive case: children
  SELECT c.id, c.name, c.parent_id, ct.depth + 1
  FROM categories c
  JOIN category_tree ct ON c.parent_id = ct.id
)
SELECT * FROM category_tree ORDER BY depth, name;
```

-----

## 🪟 Window Functions

Window functions let you perform aggregate-style calculations **without collapsing rows**. The result is added as an extra column alongside the original rows.

```sql
-- Rank users by total spend (highest first)
SELECT
  name,
  total_spend,
  RANK() OVER (ORDER BY total_spend DESC) AS spend_rank
FROM user_totals;
```

### Common window functions

|Function      |What it does                            |
|--------------|----------------------------------------|
|`ROW_NUMBER()`|Unique sequential number per row        |
|`RANK()`      |Rank with gaps on ties (1, 2, 2, 4)     |
|`DENSE_RANK()`|Rank without gaps on ties (1, 2, 2, 3)  |
|`LAG(col, n)` |Value from n rows before the current row|
|`LEAD(col, n)`|Value from n rows after the current row |
|`SUM() OVER()`|Running or grouped total                |
|`AVG() OVER()`|Running or grouped average              |

### PARTITION BY — grouping within a window

```sql
-- Rank orders within each user separately
SELECT
  user_id,
  order_id,
  amount,
  RANK() OVER (PARTITION BY user_id ORDER BY amount DESC) AS rank_within_user
FROM orders;
```

### Running totals with SUM OVER

```sql
SELECT
  created_at,
  amount,
  SUM(amount) OVER (ORDER BY created_at) AS running_total
FROM orders;
```

### LAG and LEAD — comparing to adjacent rows

```sql
-- Show each month's revenue and the previous month's for comparison
SELECT
  month,
  revenue,
  LAG(revenue, 1) OVER (ORDER BY month) AS prev_month_revenue
FROM monthly_revenue;
```

-----

## 🔀 UNION and UNION ALL

Combine results from multiple queries (columns must match):

```sql
-- UNION removes duplicates
SELECT name FROM customers
UNION
SELECT name FROM suppliers;

-- UNION ALL keeps duplicates (faster)
SELECT name FROM customers
UNION ALL
SELECT name FROM suppliers;
```

-----

## 🪜 Learning Path

- [ ] Can write a basic subquery in a WHERE clause
- [ ] Understand the difference between a subquery and a JOIN
- [ ] Can write a CTE with `WITH`
- [ ] Understand when CTEs are clearer than nested subqueries
- [ ] Can use ROW_NUMBER() or RANK() with OVER()
- [ ] Understand PARTITION BY
- [ ] Can write a running total with SUM OVER
- [ ] Know when to use UNION vs UNION ALL

-----

## 📚 Resources

- [Mode SQL Tutorial — Advanced](https://mode.com/sql-tutorial/sql-subqueries/) — subqueries and window functions with interactive examples
- [Use The Index, Luke](https://use-the-index-luke.com/) — performance implications of advanced queries

-----

*Last reviewed: {{date}}*