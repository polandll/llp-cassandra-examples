# Exponential notation {#exponential_notation_r .reference}

Cassandra supports exponential notation.

Cassandra supports exponential notation. This example shows exponential notation in the output from a cqlsh command.

```
CREATE TABLE test(
  id varchar PRIMARY KEY,
  value_double double,
  value_float float
);

INSERT INTO test (id, value_float, value_double)
  VALUES ('test1', -2.6034345E+38, -2.6034345E+38);

SELECT * FROM test;
```

```

 id    | value_double | value_float
-------+--------------+-------------
 test1 |  -2.6034e+38 | -2.6034e+38
```

**Parent topic:** [CQL lexical structure](../../cql/cql_reference/cql_lexicon_c.md)

