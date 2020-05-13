# Escaping characters {#escape_char_r .reference}

Using single and double quotation marks in CQL.

Column names that contain characters that CQL cannot parse need to be enclosed in double quotation marks in CQL.

Dates, IP addresses, and strings need to be enclosed in single quotation marks. To use a single quotation mark itself in a string literal, escape it using a single quotation mark.

```
INSERT INTO cycling.calendar (race_id, race_start_date, race_end_date, race_name) VALUES 
  (201, '2015-02-18', '2015-02-22', 'Women''s Tour of New Zealand');
```

An alternative is to use dollar-quoted strings. Dollar-quoted string constants can be used to create functions, insert data, and select data when complex quoting is needed. Use double dollar signs to enclose the desired string.

```
INSERT INTO cycling.calendar (race_id, race_start_date, race_end_date, race_name) VALUES 
  (201, '2015-02-18', '2015-02-22', $$Women's Tour of New Zealand$$);
```

**Parent topic:** [CQL lexical structure](../../cql/cql_reference/cql_lexicon_c.md)

