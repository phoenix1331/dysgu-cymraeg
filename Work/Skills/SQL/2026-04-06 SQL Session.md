---
date: 2026-04-06
type: learning-session
skill: SQL
duration: 1hr
tags:
  - work/skill
  - sql
  - learning-session
---

# SQL Learning - 2026-04-06

**Duration:** 1 hour
**Topic:** SELECT Basics
**Related:** [[Work/Skills/SQL Learning Path]]

## Today's Focus
- Basic SELECT statements
- WHERE clauses
- ORDER BY and filtering

## What I Learned
- SELECT statement structure: `SELECT column FROM table WHERE condition`
- Comparison operators: =, !=, <, >, <=, >=
- Logical operators: AND, OR, NOT

## Code Examples

### Basic SELECT
```sql
SELECT first_name, last_name, email
FROM customers
WHERE country = 'USA'
ORDER BY last_name ASC;
```

### Filtering with multiple conditions
```sql
SELECT product_name, price, stock
FROM products
WHERE price > 50 AND stock > 0
ORDER BY price DESC;
```

## Key Takeaways
- Always specify columns instead of using SELECT * for better performance
- WHERE clause filters rows before they're returned
- ORDER BY comes last in the query

## Practice Exercises
- [x] Write 5 basic SELECT queries
- [x] Practice WHERE clause with different operators
- [ ] Try combining AND/OR conditions (tomorrow)

## Questions for Further Exploration
- How do NULL values work in WHERE clauses?
- What's the difference between WHERE and HAVING?

## Next Session Plan
- Learn LIKE operator and pattern matching
- Explore IN and BETWEEN operators
- Practice with more complex WHERE conditions

## Resources Used
- [Tutorial link]
- [Practice database]

## Links
- Previous: N/A
- Next: (create next session when ready)
- Main: [[Work/Skills/SQL Learning Path]]
- Daily Note: [[Work/Daily Notes/2026-04-06]]
