# CQL lexical structure {#cql_lexicon_c .concept}

CQL input consists of statements that change data, look up data, store data, or change the way data is stored.

CQL input consists of statements. Like SQL, statements change data, look up data, store data, or change the way data is stored. Statements end in a semicolon \(;\).

For example, the following is valid CQL syntax:

```
SELECT * FROM MyTable;

UPDATE MyTable
  SET SomeColumn = 'SomeValue'
  WHERE columnName = B70DE1D0-9908-4AE3-BE34-5573E5B09F14;
```

This is a sequence of two CQL statements. This example shows one statement per line, although a statement can usefully be split across lines as well.

-   **[Uppercase and lowercase](../../cql/cql_reference/ucase-lcase_r.md)**  
Keyspace, column, and table names created using CQL are case-insensitive unless enclosed in double quotation marks.
-   **[Escaping characters](../../cql/cql_reference/escape_char_r.md)**  
Using single and double quotation marks in CQL.
-   **[Valid literals](../../cql/cql_reference/valid_literal_r.md)**  
Values and definitions of valid literals.
-   **[Exponential notation](../../cql/cql_reference/exponential_notation_r.md)**  
Cassandra supports exponential notation.
-   **[CQL code comments](../../cql/cql_reference/cqlRefComment.md)**  
Add comments to CQL code.
-   **[CQL Keywords](../../cql/cql_reference/keywords_r.md)**  
 Table of keywords and whether or not the words are reserved.

**Parent topic:** [CQL reference](../../cql/cql_reference/cqlReferenceTOC.md)

