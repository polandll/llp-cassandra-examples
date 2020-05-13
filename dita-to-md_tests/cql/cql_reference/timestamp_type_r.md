# Timestamp type {#timestamp_type_r .reference}

Enter a timestamp type as an integer for CQL input, or as a string literal in ISO 8601 formats.

Values for the timestamp type are encoded as 64-bit signed integers representing a number of milliseconds since the standard base time known as the epoch: January 1 1970 at 00:00:00 GMT. Enter a timestamp type as an integer for CQL input, or as a string literal in any of the following ISO 8601 formats:

```
yyyy-mm-dd HH:mm
yyyy-mm-dd HH:mm:ss
yyyy-mm-dd HH:mmZ
yyyy-mm-dd HH:mm:ssZ
yyyy-mm-dd'T'HH:mm
yyyy-mm-dd'T'HH:mmZ
yyyy-mm-dd'T'HH:mm:ss
yyyy-mm-dd'T'HH:mm:ssZ
yyyy-mm-dd'T'HH:mm:ss.ffffffZ
yyyy-mm-dd
yyyy-mm-ddZ
```

where Z is the RFC-822 4-digit time zone, expressing the time zone's difference from UTC. For example, for example the date and time of Feb 3, 2011, at 04:05:00 AM, GMT:

```
2011-02-03 04:05+0000
2011-02-03 04:05:00+0000
2011-02-03T04:05+0000
2011-02-03T04:05:00+0000
```

In Cassandra 3.4 and later, timestamps are displayed in `cqlsh` in sub-second precision by default, as shown below. Applications reading a timestamp may use the sub-second portion of the timestamp, as Cassandra stored millisecond-precision timestamps in all versions.

```
%Y-%m-%d %H:%M:%S.%f%z
```

If no time zone is specified, the time zone of the Cassandra coordinator node handing the write request is used. For accuracy, DataStax recommends specifying the time zone rather than relying on the time zone configured on the Cassandra nodes.

If you only want to capture date values, you can also omit the time of day. For example:

```
2011-02-03
2011-02-03+0000
```

In this case, the time of day defaults to 00:00:00 in the specified or default time zone.

Timestamp output appears in the following format by default in `cqlsh`:

```
yyyy-mm-dd HH:mm:ssZ
```

You can change the format by setting the `time_format` property in the `[ui]` section of the cqlshrc file.

```
[ui]
time_format = %Y-%m-%d %H:%M
```

**Parent topic:** [CQL data types](../../cql/cql_reference/cql_data_types_c.md)

