# ALTER KEYSPACE {#cqlAlterKeyspace .reference}

Changes keyspace replication and enable/disable commit log.

Modifies the keyspace replication strategy, the number of copies of the data Cassandra creates in each data center, [REPLICATION](cqlAlterKeyspace.md#cqlKeyspaceReplication), and/or disable the commit log for writes, [DURABLE\_WRITES](cqlAlterKeyspace.md#cqlKeyspaceDURABLE_WRITES).

**Restriction:** Changing the keyspace name is not supported.

## Synopsis {#synopsis .section}

```
ALTER  KEYSPACE keyspace\_name 
   WITH REPLICATION = { 
      'class' : 'SimpleStrategy', 'replication_factor' : N  
     | 'class' : 'NetworkTopologyStrategy', 'dc1\_name' : N [, ...] 
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

 REPLICATION
 :   Simple strategy

    Assign the same replication factor to the entire cluster. Use for evaluation and single data center test and development environments only.

    ```
    REPLICATION = { 
     'class' : 'SimpleStrategy', 
     'replication_factor' : N 
    }
    ```

    Network topography strategy

    Assign replication factors to each data center in a comma separated list. Use in production environments and multi-DC test and development environments. Data center names must match the snitch DC name; refer to [Snitches](/en/cassandra-oss/3.0/cassandra/architecture/archSnitchesAbout.html) for more details.

    ```
    REPLICATION = { 
     class' : 'NetworkTopologyStrategy', 
     'datacenter\_name' : N [, 
     'datacenter\_name' : N] 
     }
    ```

  DURABLE\_WRITES
 :   Optionally \(not recommended\), bypass the commit log when writing to the keyspace by disabling durable writes \(DURABLE\_WRITES = false\). Default value is `true`.

    CAUTION:

    Never disable durable writes when using SimpleStrategy replication.

 ## Example {#example .section}

Change the `cycling` keyspace to `NetworkTopologyStrategy` in a single data center and turn off durable writes \(not recommended\). This example uses the default data center name in Cassandra with a replication factor of 3.

```screen
ALTER KEYSPACE cycling
WITH REPLICATION = { 
  'class' : 'NetworkTopologyStrategy',
  'datacenter1' : 3 } 
 AND DURABLE_WRITES = false ;
```

**Parent topic:** [CQL commands](../../cql/cql_reference/cqlCommandsTOC.md)

