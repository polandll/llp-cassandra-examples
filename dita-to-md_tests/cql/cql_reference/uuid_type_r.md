# UUID and timeuuid types {#uuid_type_r .reference}

The UUID \(universally unique id\) comparator type for avoiding collisions in column names.

The UUID \(universally unique id\) comparator type is used to avoid collisions in column names. Alternatively, you can use the timeuuid.

Timeuuid types can be entered as integers for CQL input. A value of the timeuuid type is a Type 1 [UUID](http://en.wikipedia.org/wiki/Universally_unique_identifier). A Version 1 UUID includes the time of its generation and are sorted by timestamp, making them ideal for use in applications requiring conflict-free timestamps. For example, you can use this type to identify a column \(such as a blog entry\) by its timestamp and allow multiple clients to write to the same partition key simultaneously. Collisions that would potentially overwrite data that was not intended to be overwritten cannot occur.

A valid timeuuid conforms to the timeuuid format shown in [valid literals](valid_literal_r.md).

**Parent topic:** [CQL data types](../../cql/cql_reference/cql_data_types_c.md)

