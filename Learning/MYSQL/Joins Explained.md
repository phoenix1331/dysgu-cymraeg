# Joins Explained

**Tags:** #learning/sql #databases
**Status:** 🌱 Seedling
**Related:** [[Learning/MYSQL/Databases MOC]] | [[Learning/MYSQL/SQL - Fundamentals]]

-----

## 🧠 Mental Model

Think of two overlapping circles (a Venn diagram). Each circle is a table. JOINs control which part of that overlap — or non-overlap — you get back.

-----

## 🔗 JOIN Types

### INNER JOIN

Returns only rows that have a match **in both tables**.

```sql
SELECT users.name, orders.product
FROM users
INNER JOIN orders ON users.id = orders.user_id;
```

> Use when: you only want records that exist on both sides.

-----

### LEFT JOIN (LEFT OUTER JOIN)

Returns **all rows from the left table**, and matched rows from the right. Unmatched right-side columns are `NULL`.

```sql
SELECT users.name, orders.product
FROM users
LEFT JOIN orders ON users.id = orders.user_id;
```

> Use when: you want all users, regardless of whether they’ve placed an order.

-----

### RIGHT JOIN (RIGHT OUTER JOIN)

The mirror of LEFT JOIN — returns **all rows from the right table**.

```sql
SELECT users.name, orders.product
FROM users
RIGHT JOIN orders ON users.id = orders.user_id;
```

> [!note] RIGHT JOIN is rare in practice. Most people flip the table order and use LEFT JOIN instead — it reads more naturally.

-----

### FULL OUTER JOIN

Returns **all rows from both tables**. Where there’s no match, the missing side is `NULL`.

```sql
SELECT users.name, orders.product
FROM users
FULL OUTER JOIN orders ON users.id = orders.user_id;
```

> [!warning] MySQL does not support `FULL OUTER JOIN` directly. Simulate it with a `LEFT JOIN` + `UNION` + `RIGHT JOIN`.

```sql
SELECT users.name, orders.product
FROM users
LEFT JOIN orders ON users.id = orders.user_id

UNION

SELECT users.name, orders.product
FROM users
RIGHT JOIN orders ON users.id = orders.user_id;
```

-----

### CROSS JOIN

Returns every combination of rows from both tables (the Cartesian product).

```sql
SELECT colours.name, sizes.label
FROM colours
CROSS JOIN sizes;
```

> Use when: you genuinely need every combination — e.g. generating a size/colour matrix. Rarely needed.

-----

## 🔑 ON vs USING

If the join column has the **same name** in both tables, you can use `USING` as a shorthand:

```sql
-- These are equivalent
SELECT * FROM users INNER JOIN orders ON users.id = orders.id;
SELECT * FROM users INNER JOIN orders USING (id);
```

-----

## 🪜 Cheatsheet

|JOIN type        |What you get                            |
|-----------------|----------------------------------------|
|`INNER JOIN`     |Only matching rows                      |
|`LEFT JOIN`      |All left rows + matches from right      |
|`RIGHT JOIN`     |All right rows + matches from left      |
|`FULL OUTER JOIN`|All rows from both (not native in MySQL)|
|`CROSS JOIN`     |Every combination of rows               |

-----

## 🪜 Learning Path

- [ ] Understand INNER JOIN
- [ ] Understand LEFT JOIN and when to use it over INNER
- [ ] Know what NULL means in a JOIN result
- [ ] Can join more than two tables in one query
- [ ] Understand the FULL OUTER JOIN workaround in MySQL

-----

*Last reviewed: {{date}}*