# Transactions & ACID

**Tags:** #learning/sql #databases #reliability
**Status:** 🌱 Seedling
**Related:** [[learning/mysql/Databases MOC]] | [[learning/mysql/SQL - Fundamentals]] | [[learning/mysql/Advanced SQL]]

-----

## 🧠 Mental Model

A **transaction** is a group of SQL statements that are treated as a single unit of work. Either **all of them succeed**, or **none of them do**.

Classic example: transferring money between bank accounts.

```sql
-- These two updates must BOTH succeed or BOTH fail
UPDATE accounts SET balance = balance - 500 WHERE id = 1;
UPDATE accounts SET balance = balance + 500 WHERE id = 2;
```

If the server crashes between those two lines, you’d lose £500 into thin air. A transaction prevents that.

-----

## 🔤 ACID — The Four Guarantees

Every proper database transaction is **ACID compliant**:

|Property      |Meaning                                                |
|--------------|-------------------------------------------------------|
|**Atomic**    |All or nothing — partial success is not allowed        |
|**Consistent**|The database moves from one valid state to another     |
|**Isolated**  |Concurrent transactions don’t interfere with each other|
|**Durable**   |Once committed, the data survives crashes and restarts |


> [!tip] You don’t need to memorise the definitions deeply at first — just remember: transactions mean “this whole batch either works or it doesn’t.”

-----

## 🏗️ Basic Transaction Syntax

```sql
START TRANSACTION;

UPDATE accounts SET balance = balance - 500 WHERE id = 1;
UPDATE accounts SET balance = balance + 500 WHERE id = 2;

COMMIT; -- saves everything
```

If something goes wrong mid-way, you roll back:

```sql
START TRANSACTION;

UPDATE accounts SET balance = balance - 500 WHERE id = 1;
-- something fails...

ROLLBACK; -- undoes everything since START TRANSACTION
```

-----

## 💾 COMMIT vs ROLLBACK

|Command   |What it does                                      |
|----------|--------------------------------------------------|
|`COMMIT`  |Permanently saves all changes in the transaction  |
|`ROLLBACK`|Discards all changes since the transaction started|

-----

## 🔒 Isolation Levels

Isolation controls what a transaction can **see** from other concurrent transactions. MySQL supports four levels:

|Level             |Dirty Reads|Non-repeatable Reads|Phantom Reads|
|------------------|-----------|--------------------|-------------|
|`READ UNCOMMITTED`|✅ possible |✅ possible          |✅ possible   |
|`READ COMMITTED`  |❌ prevented|✅ possible          |✅ possible   |
|`REPEATABLE READ` |❌ prevented|❌ prevented         |✅ possible   |
|`SERIALIZABLE`    |❌ prevented|❌ prevented         |❌ prevented  |


> [!note] MySQL’s default is `REPEATABLE READ`. This is a sensible default — you rarely need to change it unless you have specific performance or consistency requirements.

### What do those terms mean?

- **Dirty read** — reading data that another transaction hasn’t committed yet (and might roll back)
- **Non-repeatable read** — reading the same row twice in one transaction and getting different values because another transaction changed it
- **Phantom read** — running the same query twice and getting different *rows* because another transaction inserted or deleted data

```sql
-- Check current isolation level
SELECT @@transaction_isolation;

-- Change it for the current session
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
```

-----

## 🔐 Locking

Transactions often lock rows or tables to prevent conflicts.

```sql
-- Lock rows for update (other transactions must wait)
SELECT * FROM accounts WHERE id = 1 FOR UPDATE;

-- Lock rows for reading (allows other reads, blocks writes)
SELECT * FROM accounts WHERE id = 1 FOR SHARE;
```

> [!warning] Long-running transactions that hold locks can cause other queries to queue up and time out. Keep transactions as short as possible.

-----

## ⚙️ SAVEPOINT — Partial Rollbacks

You can set checkpoints within a transaction and roll back to them without abandoning the whole thing:

```sql
START TRANSACTION;

INSERT INTO orders (user_id, product) VALUES (1, 'Widget');
SAVEPOINT after_order;

INSERT INTO payments (order_id, amount) VALUES (LAST_INSERT_ID(), 50);
-- something goes wrong with payment...

ROLLBACK TO SAVEPOINT after_order; -- undoes payment, keeps order

COMMIT;
```

-----

## 🪜 Learning Path

- [ ] Understand why transactions exist (the bank transfer problem)
- [ ] Can write START TRANSACTION / COMMIT / ROLLBACK
- [ ] Know what ACID stands for and roughly what each means
- [ ] Understand the default MySQL isolation level
- [ ] Know what locks are and why long transactions are risky

-----

*Last reviewed: {{date}}*