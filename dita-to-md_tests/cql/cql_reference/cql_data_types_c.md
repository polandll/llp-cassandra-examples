# CQL data types {#cql_data_types_c .concept}

Built-in data types for columns.

CQL defines built-in data types for columns. The [counter type](counter_type.md) is unique.

|CQL Type|Constants supported|Description|
|--------|-------------------|-----------|
|ascii|strings|US-ASCII character string|
|bigint|integers|64-bit signed long|
|blob|blobs|Arbitrary bytes \(no validation\), expressed as hexadecimal|
|boolean|booleans|true or false|
|counter|integers|Distributed counter value \(64-bit long\)|
|date|strings|Value is a date with no corresponding time value; Cassandra encodes date as a 32-bit integer representing days since epoch \(January 1, 1970\). Dates can be represented in queries and inserts as a string, such as 2015-05-03 \(yyyy-mm-dd\)|
|decimal|integers, floats|Variable-precision decimalJava type

**Note:** When dealing with currency, it is a best practice to have a currency class that serializes to and from an int or use the Decimal form.

|
|double|integers, floats|64-bit IEEE-754 floating pointJava type

|
|float|integers, floats|32-bit IEEE-754 floating pointJava type

|
|frozen|user-defined types, collections, tuples|A frozen value serializes multiple components into a single value. Non-frozen types allow updates to individual fields. Cassandra treats the value of a frozen type as a blob. The entire value must be overwritten.**Note:** Cassandra no longer requires the use of frozen for tuples:

```
frozen <tuple <int, tuple<text, double>>>
```

|
|inet|strings|IP address string in IPv4 or IPv6 format, used by the python-cql driver and CQL native protocols|
|int|integers|32-bit signed integer|
|list|n/a|A collection of one or more ordered elements: \[literal, literal, literal\]. CAUTION:

Lists have limitations and specific performance considerations. Use a frozen list to decrease impact. In general, use a [set](http://cassandra.apache.org/doc/latest/cql/types.html#sets) instead of list.

|
|map|n/a|A JSON-style array of literals: \{ literal : literal, literal : literal ... \}|
|set|n/a|A collection of one or more elements: \{ literal, literal, literal \}|
|smallint|integers|2 byte integer|
|text|strings|UTF-8 encoded string|
|time|strings|Value is encoded as a 64-bit signed integer representing the number of nanoseconds since midnight. Values can be represented as strings, such as 13:30:54.234.|
|timestamp|integers, strings|Date and time with millisecond precision, encoded as 8 bytes since epoch. Can be represented as a string, such as 2015-05-03 13:30:54.234.|
|timeuuid|uuids|Version 1 UUID only|
|tinyint|integers|1 byte integer|
|tuple|n/a|Cassandra 2.1 and later. A group of 2-3 fields.|
|uuid|uuids|A UUID in [standard UUID](http://en.wikipedia.org/wiki/Universally_unique_identifier) format|
|varchar|strings|UTF-8 encoded string|
|varint|integers|Arbitrary-precision integerJava type

|

In addition to the CQL types listed in this table, you can use a string containing the name of a JAVA class \(a sub-class of AbstractType loadable by Cassandra\) as a CQL type. The class name should either be fully qualified or relative to the org.apache.cassandra.db.marshal package.

Enclose ASCII text, timestamp, and inet values in single quotation marks. Enclose names of a keyspace, table, or column in double quotation marks.

## Java types {#ref-COMM-192 .section}

The Java types, from which most CQL types are derived, are obvious to Java programmers. The derivation of the following types, however, might not be obvious:

|CQL type|Java type|
|--------|---------|
|decimal|[java.math.BigDecimal](http://docs.oracle.com/javase/7/docs/api/java/math/BigDecimal.html)|
|float|[java.lang.Float](http://docs.oracle.com/javase/7/docs/api/java/lang/Float.html)|
|double|[java.lang.Double](http://docs.oracle.com/javase/7/docs/api/java/lang/Double.html)|
|varint|[java.math.BigInteger](http://docs.oracle.com/javase/7/docs/api/java/math/BigInteger.html)|

## CQL type compatibility {#cql_data_type_compatibility .section}

CQL data types have strict requirements for conversion compatibility. The following table shows the allowed alterations for data types:

|Data type may be altered to:|Data type|
|----------------------------|---------|
|ascii, bigint, boolean, decimal, double, float, inet, int, timestamp, timeuuid, uuid, varchar, varint|blob|
|int|varint|
|text|varchar|
|timeuuid|uuid|
|varchar|text|

Clustering columns have even stricter requirements, because clustering columns mandate the order in which data is written to disk. The following table shows the allow alterations for data types used in clustering columns:

|Data type may be altered to:|Data type|
|----------------------------|---------|
|int|varint|
|text|varchar|
|varchar|text|

-   **[Blob type](../../cql/cql_reference/blob_r.md)**  
Cassandra blob data type represents a constant hexadecimal number.
-   **[Collection type](../../cql/cql_reference/collection_type_r.md)**  
A collection column is declared using the collection type, followed by another type.
-   **[Counter type](../../cql/cql_reference/counter_type.md)**  
A counter column value is a 64-bit signed integer.
-   **[UUID and timeuuid types](../../cql/cql_reference/uuid_type_r.md)**  
The UUID \(universally unique id\) comparator type for avoiding collisions in column names.
-   **[UUID and timeuuid functions](../../cql/cql_reference/timeuuid_functions_r.md)**  
About using Timeuuid functions.
-   **[Timestamp type](../../cql/cql_reference/timestamp_type_r.md)**  
Enter a timestamp type as an integer for CQL input, or as a string literal in ISO 8601 formats.
-   **[Tuple type](../../cql/cql_reference/tupleType.md)**  
Use a tuple as an alternative to a user-defined type.
-   **[User-defined type](../../cql/cql_reference/cqlRefUDType.md)**  
A user-defined type facilitates handling multiple fields of related information in a table.

**Parent topic:** [CQL reference](../../cql/cql_reference/cqlReferenceTOC.md)

