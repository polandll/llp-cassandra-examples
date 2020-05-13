# CREATE KEYSPACE {#cqlCreateKeyspace .reference}

Define a new keyspace.

Creates a top-level namespace. Configure the replica placement strategy, replication factor, and durable writes setting.

## Synopsis {#synopsis .section}

```
CREATE  KEYSPACE [IF NOT EXISTS] keyspace\_name 
   WITH REPLICATION = { 
      'class' : 'SimpleStrategy', 'replication_factor' : N } 
     | 'class' : 'NetworkTopologyStrategy', 
       'dc1\_name' : N [, ...] 
   }
   [AND DURABLE_WRITES =  true|false] ;
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

 CREATE KEYSPACE \[IF NOT EXISTS\] keyspace\_name
 :   Keyspace names can have up to 48 alpha-numeric characters and contain underscores; only letters and numbers are supported as the first character. Cassandra forces keyspace names to lowercase when entered without quotes.

    If a keyspace with the same name already exists, an error occurs and the operation fails; use IF NOT EXISTS to suppress the error message.

  REPLICATION = \{ replication\_map \}
 :   The replication map determines how many copies of the data are kept in a given data center. This setting impacts consistency, availability and request speed, for more details see [replica placement strategy](/en/cassandra-oss/3.0/cassandra/architecture/archDataDistributeReplication.html).

    |Class|Replication factor|Value Description|
    |-----|------------------|-----------------|
    |'SimpleStrategy'|'replication\_factor' : N|Assign the same replication factor to the entire cluster. Use for evaluation and single data center test and development environments only.|
    |'NetworkTopologyStrategy'|'datacenter\_name' : N|Assign replication factors to each data center in a comma separated list. Use in production environments and multi-DC test and development environments. Data center names must match the snitch DC name; refer to [Snitches](/en/cassandra-oss/3.0/cassandra/architecture/archSnitchesAbout.html) for more details.|

    Simple Topolgy syntax:

    ```
    'class' : 'SimpleStrategy', 'replication_factor' : N 
    ```

    Network Topology syntax:

    ```
    'class' : 'NetworkTopologyStrategy', 
           'dc1\_name' : N [, ...] 
    ```

  DURABLE\_WRITES = true\|false
 :   Optionally \(not recommended\), bypass the commit log when writing to the keyspace by disabling durable writes \(DURABLE\_WRITES = false\). Default value is `true`.

    CAUTION:

    Never disable durable writes when using SimpleStrategy replication.

 ## Examples {#example-of-setting-the-simplestrategy-class .section}

Create a keyspace for a single node evaluation cluster

Create cycling keyspace on a single node evaluation cluster:

```
CREATE KEYSPACE cycling
  WITH REPLICATION = { 
   'class' : 'SimpleStrategy', 
   'replication_factor' : 1 
  };
```

Create a keyspace NetworkTopologyStrategy on an evaluation cluster

This example shows how to create a keyspace with network topology in a single node evaluation cluster.

```
CREATE KEYSPACE cycling 
  WITH REPLICATION = { 
   'class' : 'NetworkTopologyStrategy', 
   'datacenter1' : 1 
  } ;
```

**Note:** `datacenter1` is the default data center name. To display the data center name, use `nodetool status`.

```
nodetool status
```

The node tool returns the data center name, rack name, host name and IP address.

```
Datacenter: datacenter1
=======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address    Load       Tokens  Owns    Host ID                               Rack
UN  127.0.0.1  46.59 KB   256     100.0%  dd867d15-6536-4922-b574-e22e75e46432  rack1
```

Create the cycling keyspace in an environment with multiple data centers

Set the replication factor for the Boston, Seattle, and Tokyo data centers. The data center name must match the name configured in the snitch.

```
CREATE KEYSPACE "Cycling"
  WITH REPLICATION = {
   'class' : 'NetworkTopologyStrategy', 
   'boston'  : 3 , // Datacenter 1 
   'seattle' : 2 , // Datacenter 2
   'tokyo'   : 2 , // Datacenter 3
  };
```

**Note:** For more about replication strategy options, see [Changing keyspace replication strategy](/en/cassandra-oss/3.x/cassandra/operations/opsChangeKSStrategy.html)

Disabling durable writes

Disable write commit log for the cycling keyspace. Disabling the commit log increases the risk of data loss. Do not disable in SimpleStrategy environments.

```
CREATE KEYSPACE cycling
  WITH REPLICATION = { 
   'class' : 'NetworkTopologyStrategy',
   'datacenter1' : 3 
  } 
AND DURABLE_WRITES = false ;
```

**Parent topic:** [CQL commands](../../cql/cql_reference/cqlCommandsTOC.md)

