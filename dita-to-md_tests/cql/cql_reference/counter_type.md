# Counter type {#counter_type .reference}

A counter column value is a 64-bit signed integer.

A counter column value is a 64-bit signed integer. You cannot set the value of a counter, which supports two operations: increment and decrement.

Use counter types as described in the ["Using a counter"](../cql_using/useCounters.md) section. Do not assign this type to a column that serves as the primary key or partition key. Also, do not use the counter type in a table that contains anything other than counter types and the primary key. To generate sequential numbers for surrogate keys, use the timeuuid type instead of the counter type. You cannot create an index on a counter column or set data in a counter column to expire using the Time-To-Live \(TTL\) property.

**Parent topic:** [CQL data types](../../cql/cql_reference/cql_data_types_c.md)

