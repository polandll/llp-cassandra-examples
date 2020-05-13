# Sharing a static column {#refStaticCol .concept}

In a table that uses clustering columns, non-clustering columns can be declared static in the table definition.

In a table that uses clustering columns, non-clustering columns can be declared static in the table definition. Static columns are only static within a given partition.

```
CREATE TABLE t (
  k text,
  s text STATIC,
  i int,
  PRIMARY KEY (k, i)
);
INSERT INTO t (k, s, i) VALUES ('k', 'I''m shared', 0);
INSERT INTO t (k, s, i) VALUES ('k', 'I''m still shared', 1);
SELECT * FROM t;
```

Output is:

```
 k |                  s | i   
----------------------------
k  | "I'm still shared" | 0 
k  | "I'm still shared" | 1       
```

**Restriction:** 

-   A table that does not define any clustering columns cannot have a static column. The table having no clustering columns has a one-row partition in which every column is inherently static.
-   A table defined with the COMPACT STORAGE directive cannot have a static column.
-   A column designated to be the partition key cannot be static.

You can [batch conditional updates to a static column](useBatchGoodExample.md).

In Cassandra 2.0.9 and later, you can use the DISTINCT keyword to select static columns. In this case, Cassandra retrieves only the beginning \(static column\) of the partition.

**Parent topic:** [Inserting and updating data](../../cql/cql_using/useInsertDataTOC.md)

