# Valid characters in names {#ref-lexical-valid-chars .reference}

Keyspace and table names can only contain alpha-number characters and underscores, all other identifier names support any characters.

Keyspace and table names must begin with an alpha-numeric character and can only contain alpha-numeric characters and underscores. All other names, such as COLUMN, FUNCTION, AGGREGATE, TYPE, etc., can begin with and contain any character.

To specify a name that contains a special character, like period \(.\) or hyphen \(-\), enclose the name in double quotes.

|Creations that Work|Creations that Don't Work|
|-------------------|-------------------------|
|CREATE TABLE foo ...|CREATE TABLE foo!$% ...|
|CREATE TABLE foo\_bar ...|CREATE TABLE foo\[\]"90 ...|
|CREATE TABLE foo \("what\#\*&" text, ...\)|CREATE TABLE foo \(what\#\*& text, ...\)|
|ALTER TABLE foo5 ...|ALTER TABLE "foo5$$"...|
|CREATE FUNCTION "foo5$$$^%" ...|CREATE FUNCTION foo5$$...|
|CREATE AGGREGATE "foo5!@\#" ...|CREATE AGGREGATE foo5$$|
|CREATE TYPE foo5 \("bar\#"9 text, ...|CREATE TYPE foo5 \(bar\#9 text ...|

**Parent topic:** [Uppercase and lowercase](../../cql/cql_reference/ucase-lcase_r.md)

