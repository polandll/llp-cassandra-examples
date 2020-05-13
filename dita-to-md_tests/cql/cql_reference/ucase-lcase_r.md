# Uppercase and lowercase {#ucase-lcase_r .reference}

Keyspace, column, and table names created using CQL are case-insensitive unless enclosed in double quotation marks.

[Identifiers](valid_literal_r.md) created using CQL are case-insensitive unless enclosed in double quotation marks. If you enter names for these objects using any uppercase letters, Cassandra stores the names in lowercase. You can force the case by using double quotation marks. For example:

```
CREATE TABLE test (
  Foo int PRIMARY KEY,
  "Bar" int
);
```

The following table shows partial queries that work and do not work to return results from the test table:

|Queries that Work|Queries that Don't Work|
|-----------------|-----------------------|
|SELECT foo FROM . . .|SELECT "Foo" FROM . . .|
|SELECT Foo FROM . . .|SELECT "BAR" FROM . . .|
|SELECT FOO FROM . . .|SELECT bar FROM . . .|
|SELECT "Bar" FROM . . .|SELECT Bar FROM . . .|
|SELECT "foo" FROM . . .|SELECT "bar" FROM . . .|

SELECT "foo" FROM ... works because internally, Cassandra stores foo in lowercase. The double-quotation mark character can be used as an escape character for the double quotation mark.

Case sensitivity rules in earlier versions of CQL apply when handling legacy tables.

CQL keywords are case-insensitive. For example, the keywords SELECT and select are equivalent. This document shows keywords in uppercase.

-   **[Valid characters in names](../../cql/cql_reference/ref-lexical-valid-chars.md)**  
Keyspace and table names can only contain alpha-number characters and underscores, all other identifier names support any characters.

**Parent topic:** [CQL lexical structure](../../cql/cql_reference/cql_lexicon_c.md)

