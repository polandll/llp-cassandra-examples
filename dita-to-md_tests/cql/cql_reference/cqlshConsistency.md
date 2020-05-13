# CONSISTENCY {#cqlshConsistency .reference}

Determines how many nodes in the replica must respond for the coordinator node to successfully process a non-lightweight transaction during the CQL shell session.

Consistency level determines how many nodes in the replica must respond for the coordinator node to successfully process a non-lightweight transaction.

**Restriction:** CQL shell only supports **read** requests \(SELECT statements\) when the consistency level is set to SERIAL or LOCAL\_SERIAL. For more information, see [Data consistency](/en/cassandra-oss/3.0/cassandra/dml/dmlDataConsistencyTOC.html). Set level for LWT, write requests that contain `IF EXISTS` or `IF NOT EXISTS`, using [SERIAL CONSISTENCY](cqlshSerialConsistency.md).

## Synopsis {#synopsis .section}

```
CONSISTENCY [level]
```

|Syntax conventions|Description|
|------------------|-----------|
|UPPERCASE|Literal keyword.|
|Lowercase|Not literal.|
|`Italics`|Variable value. Replace with a user-defined value.|
|`[]`|Optional. Square brackets \(`[]`\) surround optional command arguments. Do not type the square brackets.|
|`( )`|Group. Parentheses \( `( )` \) identify a group to choose from. Do not type the parentheses.|
|`|`|Or. A vertical bar \(`|`\) separates alternative elements. Type any one of the elements. Do not type the vertical bar.|
|`...`|Repeatable. An ellipsis \( `...` \) indicates that you can repeat the syntax element as often as required.|
|`'Literal string'`|Single quotation \(`'`\) marks must surround literal strings in CQL statements. Use single quotation marks to preserve upper case.|
|`{ key : value }`|Map collection. Braces \(`{ }`\) enclose map collections or key value pairs. A colon separates the key and the value.|
|`<datatype1,datatype2>`|Set, list, map, or tuple. Angle brackets \( `< >` \) enclose data types in a set, list, map, or tuple. Separate the data types with a comma.|
|`cql\_statement;`|End CQL statement. A semicolon \(`;`\) terminates all CQL statements.|
|`[--]`|Separate the command line options from the command arguments with two hyphens \( `--` \). This syntax is useful when arguments might be mistaken for command line options.|
|`' <schema\> ... </schema\> '`|Search CQL only: Single quotation marks \(`'`\) surround an entire XML schema declaration.|
|`@xml\_entity='xml\_entity\_type'`|Search CQL only: Identify the entity and literal value to overwrite the XML element in the schema and solrConfig files.|

## Displaying the current level {#currentLevel .section}

Use consistency with no options, to show the current consistency level:

```screen
CONSISTENCY
```

```
Current consistency level is ONE.
```

The default CQL shell level is `ONE`.

## Setting a level {#description .section}

Level determines data availability versus data accuracy for transactions during the CQL shell session, some settings also may have high impact other transactions occurring in the cluster, such as ALL and SERIAL. The CQL shell setting supersedes Cassandra consistency level global setting.

**Important:** Before changing this setting it is important to understand [How Cassandra reads and writes data](/en/cassandra-oss/3.x/cassandra/dml/dmlIntro.html), [Data replication strategy](/en/cassandra-oss/3.x/cassandra/architecture/archDataDistributeReplication.html), [How quorum is calculated](/en/cassandra-oss/3.x/cassandra/dml/dmlConfigConsistency.html#dmlConfigConsistency__about-the-quorum-level), and partition keys.

When you initiate a transaction from the CQL shell, the coordinator node is typically the node where you started cqlsh; if you connect to a remote host, then the remote node is the coordinator.

|Level|Replicas|Consistency|Availability|
|-----|--------|-----------|------------|
|`ALL`|All|Highest|Lowest|
|`EACH_QUORUM`|Quorum in each [data centers](/en/glossary/doc/glossary/gloss_data_center.html).*Reads NOT supported.* 

|Same across data centers| |
|`QUORUM`|Quorum of all nodes across all [data centers](/en/glossary/doc/glossary/gloss_data_center.html). Some level of failure.| | |
|`LOCAL_QUORUM`|Quorum of replicas in the same data center as the [coordinator](/en/glossary/doc/glossary/gloss_coordinator_node.html). Avoids latency of inter-datacenter communication.|Low in multi-data center| |
|`ONE`|Closest replica as determined by the [snitch](/en/cassandra-oss/3.x/cassandra/architecture/archSnitchesAbout.html?hl=snitches). Satisfies the needs of most users because consistency requirements are not stringent.|Lowest \(READ\)|Highest \(READ\)|
|`TWO`|Closest two replicas as determined by the [snitch](/en/cassandra-oss/3.x/cassandra/architecture/archSnitchesAbout.html?hl=snitches).| | |
|`THREE`|Closest three replicas as determined by the [snitch](/en/cassandra-oss/3.x/cassandra/architecture/archSnitchesAbout.html?hl=snitches).| | |
|`LOCAL_ONE`|Returns a response from the closest replica in the local data center. For security and quality, use in an off line datacenter to prevent automatic connection to online nodes in other datacenters.| | |
|ANY|Closest replica, as determined by the [snitch](/en/cassandra-oss/3.x/cassandra/architecture/archSnitchesAbout.html?hl=snitches). If all replica nodes are down, write succeeds after a [hinted handoff](/en/cassandra-oss/3.x/cassandra/operations/opsRepairNodesHintedHandoff.html?hl=hinted%2Chandoff). Provides low latency, guarantees writes never fail.

|Lowest \(WRITE\)|Highest \(WRITE\)|
|`SERIAL`|Returns results with the most recent data including inflight LWT \([uncommitted](/en/cassandra-oss/3.x/cassandra/dml/dmlHowDataWritten.html#dmlHowDataWritten__logging-writes-and-memtable-storage)\). Commits inflight LWT as part of the read. *Writes NOT supported*.

| | |
|`LOCAL_SERIAL`|Same as `SERIAL`, but confined to the data center. *Writes NOT supported*.

| | |

**Restriction:** SERIAL and LOCAL\_SERIAL settings support read transactions.

## Examples {#examples .section}

Set `CONSISTENCY` to force the majority of the nodes to respond:

```screen
CONSISTENCY QUORUM
```

Set level to serial for LWT read requests:

```screen
CONSISTENCY SERIAL
```

```no-highlight
Consistency level set to SERIAL.
```

List all winners.

```screen
SELECT * FROM cycling.race_winners ;
```

The results are shown; this example uses expand ON.

```no-highlight
@ Row 1
---------------+--------------------------------------------------
 race_name     | National Championships South Africa WJ-ITT (CN)
 race_position | 1
 cyclist_name  | {firstname: 'Frances', lastname: 'DU TOUT'}

@ Row 2
---------------+--------------------------------------------------
 race_name     | National Championships South Africa WJ-ITT (CN)
 race_position | 2
 cyclist_name  | {firstname: 'Lynette', lastname: 'BENSON'}

@ Row 3
---------------+--------------------------------------------------
 race_name     | National Championships South Africa WJ-ITT (CN)
 race_position | 3
 cyclist_name  | {firstname: 'Anja', lastname: 'GERBER'}

@ Row 4
---------------+--------------------------------------------------
 race_name     | National Championships South Africa WJ-ITT (CN)
 race_position | 4
 cyclist_name  | {firstname: 'Ame', lastname: 'VENTER'}

@ Row 5
---------------+--------------------------------------------------
 race_name     | National Championships South Africa WJ-ITT (CN)
 race_position | 5
 cyclist_name  | {firstname: 'Danielle', lastname: 'VAN NIEKERK'}

(5 rows)
```

**Note:** The query format above uses `expand ON` for legibility.

Inserts with CONSISTENCY SERIAL fail:

```screen
INSERT INTO cycling.race_winners (
   race_name , 
   race_position ,
   cyclist_name 
  ) 
  VALUES (
       'National Championships South Africa WJ-ITT (CN)' ,
        7 ,
        { firstname: 'Joe' , lastname: 'Anderson' } 
      ) 
IF NOT EXISTS ;
```

```no-highlight
InvalidRequest: Error from server: code=2200 [Invalid query] message="LOCAL_SERIAL is not supported as conditional update commit consistency. Use ANY if you mean "make sure it is accepted but I don't care how many replicas commit it for non-SERIAL reads""
```

Updates with CONSISTENCY SERIAL also fail:

```screen
UPDATE cycling.race_winners SET 
    cyclist_name = { firstname: 'JOHN' , lastname: 'DOE' } 
WHERE 
   race_name='National Championships South Africa WJ-ITT (CN)' 
   AND race_position = 6 
IF EXISTS ;
```

```no-highlight
InvalidRequest: Error from server: code=2200 [Invalid query] message="LOCAL_SERIAL is not supported as conditional update commit consistency. Use ANY if you mean "make sure it is accepted but I don't care how many replicas commit it for non-SERIAL reads""
```

**Parent topic:** [CQL shell commands](../../cql/cql_reference/cqlshCommandsTOC.md)

