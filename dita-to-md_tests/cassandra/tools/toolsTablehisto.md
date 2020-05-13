# nodetool tablehistograms {#toolsTablehisto .reference}

Provides statistics about a table that could be used to plot a frequency function.

Provides statistics about a table that could be used to plot a frequency function.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> tablehistograms *--* <*keyspace*><*table*>
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|keyspace|Name of keyspace.|
|table|One or more table names, separated by a space.**Note:** Either keyspace.table or keyspace table can be used to designate the table.

|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Description {#description .section}

The `nodetool tablehistograms` command provides statistics about a table, including read/write latency, partition size, column count, and number of SSTables. The report is incremental, not cumulative. It covers all operations since the last time `nodetool tablehistograms` was run in the current session. The use of the metrics-core library makes the output more informative and easier to understand.

## Example {#toolsCFhistoEx21 .section}

For example, to get statistics about the libout table in the libdata keyspace, use this command:

```screen
$ %CASSANDRA\_HOME%/bin/nodetool tablehistograms libdata libout
```

Output:

```
libdata/libout histograms
Percentile  SSTables     Write Latency      Read Latency    Partition Size        Cell Count
                              (micros)          (micros)           (bytes)                  
50%             0.00             39.50             36.00              1597                42
75%             0.00             49.00             55.00              1597                42
95%             0.00             95.00             82.00              8239               258
98%             0.00            126.84            110.42             17084               446
99%             0.00            155.13            123.71             24601               770
Min             0.00              3.00              3.00              1110                36
Max             0.00          50772.00            314.00            126934              3973
```

The output shows the percentile rank of read and write latency values, the partition size, and the cell count for the table.

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

