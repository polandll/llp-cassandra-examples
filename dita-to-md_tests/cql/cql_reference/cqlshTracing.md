# TRACING {#cqlshTracing .reference}

Enables or disables request tracing for all nodes in the cluster.

Enables and disables tracing for transactions on all nodes in the cluster. Use tracing to troubleshoot performance problems. Detailed transaction information related Cassandra internal operations is captured in the `system_traces` keyspace. When a query runs a session id displays in the query results and an entry with the high-level details such as session id and client, and session length, is written to the `system_traces.session` table. More detailed data for each operation Cassandra performed is written to the `system_traces.events` table.

Tracing information is saved for 24 hours. To save tracing data longer than 24 hours, copy it to another location. For information about probabilistic tracing, see [Cassandra 3.0 documentation](/en/cassandra-oss/3.0/cassandra/tools/toolsSetTraceProbability.html).

**Note:** 

The session id is used by the [SHOW](cqlshShow.md) SESSION tracing\_session\_id command to display detailed event information.

## Synopsis {#synopsis .section}

```
TRACING [ON | OFF]
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

## Examples {#examples .section}

Tracing a write request

This example shows tracing activity on a 3-node cluster created by [ccm](https://github.com/pcmanus/ccm) on Mac OSX. Using a keyspace that has a replication factor of 3 and an employee table similar to the one in "[Using a compound primary key](../cql_using/useCompoundPrimaryKey.md)," the tracing shows that the coordinator performs the following actions:

-   Identifies the target nodes for replication of the row.
-   Writes the row to the commitlog and memtable.
-   Confirms completion of the request.

Turn on tracing:

```language-cql
TRACING ON
```

Insert a record into the cyclist\_name table:

```language-cql
INSERT INTO cycling.cyclist_name (
   id, 
   lastname, 
   firstname
  ) 
  VALUES (
   e7ae5cf3-d358-4d99-b900-85902fda9bb0, 
   'FRAME',
   'Alex'
  );
```

The request and each step are captured and displayed.

```no-highlight
Tracing session: 9b378c70-b114-11e6-89b5-b7fad52e1885

 activity                                                                                                                                                        | timestamp                  | source    | source_elapsed | client
-----------------------------------------------------------------------------------------------------------------------------------------------------------------+----------------------------+-----------+----------------+-----------
                                                                                                                                              Execute CQL3 query | 2016-11-22 16:34:34.300000 | 127.0.0.1 |              0 | 127.0.0.1
 Parsing INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES (e7ae5cf3-d358-4d99-b900-85902fda9bb0, 'FRAME','Alex'); [Native-Transport-Requests-1] | 2016-11-22 16:34:34.305000 | 127.0.0.1 |           5935 | 127.0.0.1
                                                                                                               Preparing statement [Native-Transport-Requests-1] | 2016-11-22 16:34:34.308000 | 127.0.0.1 |           9199 | 127.0.0.1
                                                                                                 Determining replicas for mutation [Native-Transport-Requests-1] | 2016-11-22 16:34:34.330000 | 127.0.0.1 |          30530 | 127.0.0.1
                                                                                                                        Appending to commitlog [MutationStage-3] | 2016-11-22 16:34:34.330000 | 127.0.0.1 |          30979 | 127.0.0.1
                                                                                                               Adding to cyclist_name memtable [MutationStage-3] | 2016-11-22 16:34:34.330000 | 127.0.0.1 |          31510 | 127.0.0.1
                                                                                                                                                Request complete | 2016-11-22 16:34:34.333633 | 127.0.0.1 |          33633 | 127.0.0.1
```

Tracing a sequential scan

A single row is spread across multiple SSTables. Reading one row involves reading pieces from multiple SSTables, as shown by this trace of a request to read the cyclist\_name table.

```screen
SELECT * FROM cycling.cyclist_name ;
```

The query results display first, followed by the session ID and session details.

```no-highlight
id                                   | firstname | lastname
--------------------------------------+-----------+-----------------
 e7ae5cf3-d358-4d99-b900-85902fda9bb0 |      Alex |           FRAME
 fb372533-eb95-4bb4-8685-6ef61e994caa |   Michael |        MATTHEWS
 5b6962dd-3f90-4c93-8f61-eabfa4a803e2 |  Marianne |             VOS
 220844bf-4860-49d6-9a4b-6b5d3a79cbfb |     Paolo |       TIRALONGO
 6ab09bec-e68e-48d9-a5f8-97e6fb4c9b47 |    Steven |      KRUIKSWIJK
 e7cd5752-bc0d-4157-a80f-7523add8dbcd |      Anna | VAN DER BREGGEN

(6 rows)

Tracing session: 117c1440-b116-11e6-89b5-b7fad52e1885

 activity                                                                                                                      | timestamp                  | source    | source_elapsed | client
-------------------------------------------------------------------------------------------------------------------------------+----------------------------+-----------+----------------+-----------
                                                                                                            Execute CQL3 query | 2016-11-22 16:45:02.212000 | 127.0.0.1 |              0 | 127.0.0.1
                                                    Parsing SELECT * FROM cycling.cyclist_name ; [Native-Transport-Requests-1] | 2016-11-22 16:45:02.212000 | 127.0.0.1 |            372 | 127.0.0.1
                                                                             Preparing statement [Native-Transport-Requests-1] | 2016-11-22 16:45:02.212000 | 127.0.0.1 |            541 | 127.0.0.1
                                                                       Computing ranges to query [Native-Transport-Requests-1] | 2016-11-22 16:45:02.213000 | 127.0.0.1 |            807 | 127.0.0.1
 Submitting range requests on 257 ranges with a concurrency of 257 (0.3 rows per range expected) [Native-Transport-Requests-1] | 2016-11-22 16:45:02.213000 | 127.0.0.1 |           1632 | 127.0.0.1
                                                           Submitted 1 concurrent range requests [Native-Transport-Requests-1] | 2016-11-22 16:45:02.215000 | 127.0.0.1 |           3002 | 127.0.0.1
                 Executing seq scan across 1 sstables for (min(-9223372036854775808), min(-9223372036854775808)] [ReadStage-2] | 2016-11-22 16:45:02.215000 | 127.0.0.1 |           3130 | 127.0.0.1
                                                                               Read 6 live and 0 tombstone cells [ReadStage-2] | 2016-11-22 16:45:02.216000 | 127.0.0.1 |           3928 | 127.0.0.1
                                                                                                              Request complete | 2016-11-22 16:45:02.216252 | 127.0.0.1 |           4252 | 127.0.0.1
```

**Parent topic:** [CQL shell commands](../../cql/cql_reference/cqlshCommandsTOC.md)

