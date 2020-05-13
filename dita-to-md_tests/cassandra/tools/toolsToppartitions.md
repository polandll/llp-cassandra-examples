# nodetool toppartitions {#toolsToppartitions .reference}

Samples database reads and writes and reports the most active partitions in a specified table.

Samples database reads and writes and reports the most active partitions in a specified table.

## Synopsis {#synopsis .section}

```language-bash
nodetool [ options ] toppartitions
[ -a samplers ] [ -k topcount ] [ -s size ] [ -- ]
keyspace table duration
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|`-a samplers` |``|Comma separated list of samplers to use \(default: all\)|
|`-k topCount` |``|The number of the top partitions to list \(default: 10\)|
|`-s size`| |The capacity of stream summary. A value closer to the actual cardinality of partitions yields more accurate results. \(default: 256\)|
|keyspace|Name of keyspace.|
|table|Name of table.|
|duration|The duration in milliseconds|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Description { .section}

The `nodetool toppartitions` command samples the activity in a table during the specified duration and prints lists of the most active partitions during that time period. To run this command you must specify the keyspace and table to focus on and the time interval \(in milliseconds\) during which Cassandra samples the table's activity.

## Examples {#examples .section}

Sample the most active partitions for the table `test.users` for 1,000 milliseconds

```
nodetool toppartitions test users 1000
```

The output of nodetool toppartitions is similar to the following:

```
WRITES Sampler:
  Cardinality: ~2 (256 capacity)
  Top 4 partitions:
	Partition                Count       +/-
	4b504d39354f37353131        15        14
	3738313134394d353530        15        14
	4f363735324e324e4d30        15        14
	303535324e4b4d504c30        15        14

READS Sampler:
  Cardinality: ~3 (256 capacity)
  Top 4 partitions:
	Partition                Count       +/-
       4d4e30314f374e313730        42        41
	4f363735324e324e4d30        42        41
	303535324e4b4d504c30        42        41
	4e355030324e344d3030        41        40
```

For each of the samplers used \(`WRITES` and `READS` in the example\), toppartitions reports:

-   The [cardinality](/en/glossary/doc/glossary/gloss_cardinality.html) of the sampled operations \(that is, the number of unique operations in the sample set\)
-   The `n` partitions in the specified table that had the most traffic in the specified time period \(where `n` is the value of the `-k` argument, or ten if `-k` is not explicitly set in the command\).

    For each Partition, toppartitions reports:

     Partition
     :   The partition key

      Count
     :   The number of operations of the specified type that occurred during the specified time period.

      +/-
     :   The margin of error for the **Count** statistic

        **Note:** To keep the toppartitions reporting from slowing performance, Cassandra does not keep an exact count of operations, but uses sampling techniques to create an approximate number. \(This example reports on a sample cluster; a production system might generate millions of reads or writes in a few seconds.\) The `+/-` figure allows you to judge the accuracy of the toppartitions reporting.

 
**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

