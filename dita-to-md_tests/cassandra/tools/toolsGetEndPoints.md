# nodetool getendpoints {#toolsGetEndPoints .reference}

Provides the IP addresses or names of replicas that own the partition key.

Provides the IP addresses or names of replicas that own the partition key.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> getendpoints *--* <*keyspace*> <*table*> key
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|keyspace|Name of keyspace.|
|table|Name of table.|
|key|Partition key of the end points you want to get.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Example {#toolsGetEndPtEx .section}

For example, which nodes own partition key\_1, key\_2, and key\_3?

**Note:** The partitioner returns a token for the key. Cassandra will return an endpoint whether or not data exists on the identified node for that token.

```language-bash
nodetool -h 127.0.0.1 -p 7100 getendpoints myks mytable key_1
```

```
127.0.0.2
```

```language-bash
nodetool -h 127.0.0.1 -p 7100 getendpoints myks mytable key_2
```

```
127.0.0.2
```

```language-bash
nodetool -h 127.0.0.1 -p 7100 getendpoints myks mytable key_2
```

```
127.0.0.1
```

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

