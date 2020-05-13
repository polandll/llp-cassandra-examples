# Retrieval using JSON {#useQueryJSON .task}

Using the SELECT command to return JSON data.

In Cassandra 2.2 and later, you can use CQL SELECT keywords to retrieve data from a table in the JSON format. For more information, see [What's New in Cassandra 2.2: JSON Support](https://www.datastax.com/dev/blog/whats-new-in-cassandra-2-2-json-support).

## Retrieving all results in the JSON format {#section_bft_hdp_cx .section}

To get this result, insert the JSON keyword between the SELECT command and the data specifications. For example, :

```
cqlsh:cycling> select json name, checkin_id, timestamp from checkin;
 [json]
------------------------------------------------------------------------------------------------------------------
 {"name": "BRAND", "checkin_id": "50554d6e-29bb-11e5-b345-feff8194dc9f", "timestamp": "2016-08-28 21:45:10.406Z"}
  {"name": "VOSS", "checkin_id": "50554d6e-29bb-11e5-b345-feff819cdc9f", "timestamp": "2016-08-28 21:44:04.113Z"}
(2 rows)

```

## Retrieving selected columns in JSON format {#section_ht2_v2p_cx .section}

To specify the JSON format for a selected column, enclose its name in `toJson()`. For example:

```
cqlsh:cycling> select name, checkin_id, toJson(timestamp) from checkin;

 name  | checkin_id                           | system.tojson(timestamp)
-------+--------------------------------------+----------------------------
 BRAND | 50554d6e-29bb-11e5-b345-feff8194dc9f | "2016-08-28 21:45:10.406Z"
  VOSS | 50554d6e-29bb-11e5-b345-feff819cdc9f | "2016-08-28 21:44:04.113Z"


```

**Note:** Cassandra2.2 and later return a JSON-formatted `timestamp` with complete time zone information.

**Parent topic:** [Querying tables](../../cql/cql_using/useQueryDataTOC.md)

