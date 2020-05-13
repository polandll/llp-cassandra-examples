# nodetool getsstables {#toolsGetSstables .reference}

Provides the SSTables that own the partition key.

Provides the SSTables that own the partition key.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> getsstables [(-hf | --hex-format)] *--* <*keyspace*> <*table*> <*key*>
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|keyspace|Name of keyspace.|
|table|One or more table names, separated by a space.|
|key|Partition key of the SSTables.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Description {#description .section}

This command can be used to retrieve an SSTable.

## Examples {#examples .section}

An example of this command retrieves the SSTable for `cycling.cyclist_name` with the key argument `fb372533-eb95-4bb4-8685-6ef61e994caa` for one of the cyclists listed:

```language-bash
nodetool getsstables cycling cyclist_name 'fb372533-eb95-4bb4-8685-6ef61e994caa' 
```

The output is:

```
/*homedir*/datastax-ddc-3.6.0/data/data/cycling/cyclist_name-612a64002ec211e6a92457e568fce26f/ma-1-big-Data.db
```

Sometimes it's useful to retrieve an SSTable from the hex string representation of its key, for instance, when you get this exception and you want to find out which SSTable owns the faulty key:

```
java.lang.AssertionError: row DecoratedKey(2769066505137675224, 00040000002e00000800000153441a3ef000) received out of order wrt DecoratedKey(2774747040849866654, 00040000019b0000080000015348847eb200)

```

The `nodetool getsstables` command will only work if the primary key of the given table is a blob.

```
nodetool getsstables keyspace table 00040000002e00000800000153441a3ef000
```

For such cases in Cassandra 3.6 and later, the option `--hex-key` can be used to retrieve the DecoratedKey from the hexstr representation of the key:

```
nodetool getsstables ks cf --hex-key 00040000002e00000800000153441a3ef000
```

```language-bash
nodetool getsstables keyspace1 standard1 3330394c344e35313730
```

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

