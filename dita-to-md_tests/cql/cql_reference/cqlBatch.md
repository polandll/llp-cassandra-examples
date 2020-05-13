# BATCH {#cqlBatch .reference}

Applies multiple data modification language \(DML\) statements with atomicity and/or in isolation.

Combines multiple DML statements to achieve atomicity and isolation when targeting a single partition or only atomicity when targeting multiple partitions. A batch applies all DMLs within a single partition before the data is available, ensuring atomicity and isolation. For multiple partition batches, [logging](cqlBatch.md#cql-log-unlog) can ensure that all DMLs are applied before data is available \(isolation\), while atomicity is achieved per partition.

A well constructed batch targeting a single partition can reduce client-server traffic and more efficiently update a table with a single row mutation. A batch *can* also target multiple partitions, when atomicity and isolation is required. Multi-partition batches may decrease throughput and increase latency. Only use a multi-partition batch when there is no other viable option, such as [asynchronous statements](https://www.datastax.com/blog/2014/10/asynchronous-queries-java-driver).

**Important:** Before implementing or executing a batch see [Batching inserts and updates](../cql_using/useBatch.md).

Optionally, a batch can apply a client-supplied timestamp.

## Synopsis {#synopsis .section}

```
BEGIN [UNLOGGED | LOGGED] BATCH 
[USING TIMESTAMP [epoch\_microseconds]]
   dml\_statement [USING TIMESTAMP [epoch\_microseconds]];
   [dml\_statement; ...]
APPLY BATCH;
```

|Syntax conventions|Description|
|------------------|-----------|
|UPPERCASE|Literal keyword.|
|Lowercase|Not literal.|
|`Italics`|Variable value. Replace with a user-defined value.|
|`[]`|Optional. Square brackets \(`[]`\) surround optional command arguments. Do not type the square brackets.|
|`( )`|Group. Parentheses \( `( )` \) identify a group to choose from. Do not type the parentheses.|
|`|`|Or. A vertical bar \(`|`\) separates alternative elements. Type any one of the elements. Do not type the vertical bar.|
|`...`|Repeatable. An ellipsis \( `...` \) indicates that you can repeat the syntax element as often as required.|
|`'Literal string'`|Single quotation \(`'`\) marks must surround literal strings in CQL statements. Use single quotation marks to preserve upper case.|
|`{ key : value }`|Map collection. Braces \(`{ }`\) enclose map collections or key value pairs. A colon separates the key and the value.|
|`<datatype1,datatype2>`|Set, list, map, or tuple. Angle brackets \( `< >` \) enclose data types in a set, list, map, or tuple. Separate the data types with a comma.|
|`cql\_statement;`|End CQL statement. A semicolon \(`;`\) terminates all CQL statements.|
|`[--]`|Separate the command line options from the command arguments with two hyphens \( `--` \). This syntax is useful when arguments might be mistaken for command line options.|
|`' <schema\> ... </schema\> '`|Search CQL only: Single quotation marks \(`'`\) surround an entire XML schema declaration.|
|`@xml\_entity='xml\_entity\_type'`|Search CQL only: Identify the entity and literal value to overwrite the XML element in the schema and solrConfig files.|

A batch can contain the following types of dml\_statements:

-   **`[INSERT](cqlInsert.md)`**
-   **`[UPDATE](cqlUpdate.md)`**
-   **`[DELETE](cqlDelete.md)`**

 LOGGED \| UNLOGGED
 :   If multiple partitions are involved, batches are logged by default. Running a batch with logging enabled ensures that either all or none of the batch operations will succeed, ensuring atomicity. Cassandra first writes the serialized batch to the [batchlog system table](../cql_using/useQuerySystem.md#table_k5f_h1w_4v) that consumes the serialized batch as blob data. After Cassandra has successfully written and persisted \(or hinted\) the rows in the batch, it removes the batchlog data. There is a performance penalty associated with the batchlog, as it is written to two other nodes. Thresholds for [warning about or failure due to batch size](/en/cassandra-oss/3.0/cassandra/configuration/configCassandra_yaml.html#configCassandra_yaml__advProps) can be set.

    If you do not want to incur a penalty for logging, run the batch operation without using the batchlog table by using the `UNLOGGED` keyword. Unlogged batching will [issue a warning](/en/cassandra-oss/3.0/cassandra/configuration/configCassandra_yaml.html#configCassandra_yaml__advProps) if too many operations or too many partitions are involved. Single partition batch operations are unlogged by default, and are the only unlogged batch operations recommended.

    Although a logged batch enforces atomicity \(that is, it guarantees if all DML statements in the batch succeed or none do\), Cassandra does no other transactional enforcement at the batch level. For example, there is no batch isolation unless the batch operation is writing to a single partition. In multiple partition batch operations, clients are able to read the first updated rows from the batch, while other rows are still being updated on the server. In single partition batch operations, clients cannot read a partial update from any row until the batch is completed.

  USING TIMESTAMPS
 :   Sets the write time for transactions executed in a BATCH.

**Restriction:** `USING TIMESTAMP` does not support LWT \(lightweight transactions\), such as DML statements that have an `IF NOT EXISTS` clause.

    By default, Cassandra applies the same timestamp to all data modified by the batch; therefore statement order does not matter within a batch, thus a batch statement is not very useful for writing data that must be timestamped in a particular order. Use client-supplied timestamps to achieve a particular order.

    User-defined timestamp

    Specify the epoch time in micoseconds after USING TIMESTAMP:

    ```
    USING TIMESTAMP [epoch\_microseconds]
    ```

    When the time is not specified, Cassandra inserts the current time.

    Same timestamp for all DMLs

    Insert on first line of batch.

    ```
    BEGIN BATCH USING TIMESTAMP [epoch\_microseconds]
       DML_statement1;
       DML_statement2;
       DML_statement3;
    APPLY BATCH;
    ```

    Individual transactions

    Insert at the end of a DML:

    ```
    BEGIN BATCH
       DML\_statement1;
       DML\_statement2 USING TIMESTAMP [epoch\_microseconds];
       DML\_statement3;
    APPLY BATCH;
    ```

 ## Examples {#examples .section}

Applying a client supplied timestamp to all DMLs

Insert meals paid for Vera Adrian using the user-defined date when inserting the records:

```screen
BEGIN BATCH USING TIMESTAMP 1481124356754405
INSERT INTO cycling.cyclist_expenses 
   (cyclist_name, expense_id, amount, description, paid) 
   VALUES ('Vera ADRIAN', 2, 13.44, 'Lunch', true);
INSERT INTO cycling.cyclist_expenses 
   (cyclist_name, expense_id, amount, description, paid) 
   VALUES ('Vera ADRIAN', 3, 25.00, 'Dinner', true);
APPLY BATCH;
```

**Note:** Combining two statements for the same partition results in a single table mutation.

View the records vertically:

```screen
expand ON
```

Verify that the timestamps are all the same:

```screen
SELECT cyclist_name, expense_id,
        amount, WRITETIME(amount),
        description, WRITETIME(description),
        paid,WRITETIME(paid)
   FROM cycling.cyclist_expenses
WHERE cyclist_name = 'Vera ADRIAN';
```

Both records were entered with the same timestamp.

```
@ Row 1
------------------------+------------------
 cyclist_name           | Vera ADRIAN
 expense_id             | 2
 amount                 | 13.44
 writetime(amount)      | 1481124356754405
 description            | Lunch
 writetime(description) | 1481124356754405
 paid                   | True
 writetime(paid)        | 1481124356754405

@ Row 2
------------------------+------------------
 cyclist_name           | Vera ADRIAN
 expense_id             | 3
 amount                 | 25
 writetime(amount)      | 1481124356754405
 description            | Dinner
 writetime(description) | 1481124356754405
 paid                   | False
 writetime(paid)        | 1481124356754405

(2 rows)
```

If any DML statement in the batch uses compare-and-set \(CAS\) logic, for example the following batch with `IF NOT EXISTS`, an error is returned:

```screen
BEGIN BATCH USING TIMESTAMP 1481124356754405
  INSERT INTO cycling.cyclist_expenses 
     (cyclist_name, expense_id, amount, description, paid) 
     VALUES ('Vera ADRIAN', 2, 13.44, 'Lunch', true);
  INSERT INTO cycling.cyclist_expenses 
     (cyclist_name, expense_id, amount, description, paid) 
     VALUES ('Vera ADRIAN', 3, 25.00, 'Dinner', false) IF NOT EXISTS;
APPLY BATCH;
```

```
InvalidRequest: Error from server: code=2200 [Invalid query] message="Cannot provide custom timestamp for conditional BATCH"
```

Batching conditional updates

Batch conditional updates introduced as lightweight transactions. However, a batch containing conditional updates can only operate within a single partition, because the underlying Paxos implementation only works at partition-level granularity. If one statement in a batch is a conditional update, the conditional logic must return true, or the entire batch fails. If the batch contains two or more conditional updates, all the conditions must return true, or the entire batch fails. This example shows batching of conditional updates:

The statements for inserting values into purchase records use the `IF` conditional clause.

```screen
BEGIN BATCH
  INSERT INTO purchases (user, balance) VALUES ('user1', -8) IF NOT EXISTS;
  INSERT INTO purchases (user, expense_id, amount, description, paid)
    VALUES ('user1', 1, 8, 'burrito', false);
APPLY BATCH;
```

```screen
BEGIN BATCH
  UPDATE purchases SET balance = -208 WHERE user='user1' IF balance = -8;
  INSERT INTO purchases (user, expense_id, amount, description, paid)
    VALUES ('user1', 2, 200, 'hotel room', false);
APPLY BATCH;
```

Conditional batches cannot provide custom timestamps. `UPDATE` and `DELETE` statements within a conditional batch cannot use `IN` conditions to filter rows.

A [continuation of this example](../cql_using/useBatchGoodExample.md) shows how to use a static column with conditional updates in batch.

Batching counter updates

A batch of counters should use the `COUNTER` option because, unlike other writes in Cassandra, a counter update is not an [idempotent](/en/glossary/doc/glossary/gloss_idempotent.html) operation.

```screen
BEGIN COUNTER BATCH
  UPDATE UserActionCounts SET total = total + 2 WHERE keyalias = 523;
  UPDATE AdminActionCounts SET total = total + 2 WHERE keyalias = 701;
APPLY BATCH;
```

Counter batches cannot include non-counter columns in the DML statements, just as a non-counter batch cannot include counter columns. Counter batch statements cannot provide custom timestamps.

**Parent topic:** [CQL commands](../../cql/cql_reference/cqlCommandsTOC.md)

