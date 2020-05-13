# Tuple type {#tupleType .reference}

Use a tuple as an alternative to a user-defined type.

The `tuple` data type holds fixed-length sets of typed positional fields. Use a `tuple` as an alternative to a user-defined type. A `tuple` can accommodate many fields \(32768\), more than can be prudently used. Typically, create a `tuple` with a few fields.

In the table creation statement, use angle brackets and a comma delimiter to declare the `tuple` component types. Surround `tuple` values in parentheses to insert the values into a table, as shown below:

```
CREATE TABLE collect_things (
  k int PRIMARY KEY,
  v tuple<int, text, float>
);

INSERT INTO collect_things (k, v) VALUES(0, (3, 'bar', 2.1));

SELECT * FROM collect_things;

 k | v
---+-----------------
 0 | (3, 'bar', 2.1)
```

**Note:** Cassandra no longer requires the use of frozen for tuples:

```
frozen <tuple <int, tuple<text, double>>>
```

You can filter a selection using a tuple.

```
CREATE INDEX on collect_things (v);

SELECT * FROM collect_things WHERE v = (3, 'bar', 2.1);

 k | v
---+-----------------
 0 | (3, 'bar', 2.1)
```

You can nest tuples as shown in the following example:

```
CREATE TABLE nested (k int PRIMARY KEY, t tuple <int, tuple<text, double>>);

INSERT INTO nested (k, t) VALUES (0, (3, ('foo', 3.4)));
```

**Parent topic:** [CQL data types](../../cql/cql_reference/cql_data_types_c.md)

