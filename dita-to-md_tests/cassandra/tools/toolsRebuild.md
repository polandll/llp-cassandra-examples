# nodetool rebuild {#toolsRebuild .reference}

Rebuilds data by streaming from other nodes.

Rebuilds data by streaming from other nodes.

## Synopsis {#synopsis .section}

```
$ nodetool options rebuild 
[ -ks | --keyspace keyspace\_name [ , keyspace\_name ] . . . ] 
[ -ts | --tokens token\_spec ]
[ -- source-dc-name ]
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-ks specific\_keyspace`|`--keyspace specific\_keyspace`|Rebuild specific keyspace.|
|source-dc-name|Name of datacenter from which to select sources for streaming. By default, choose any datacenter.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Parameters {#section_ory_zxn_hx .section}

 keyspace\_name \(Cassandra 3.6 and later\)
 :   The name of the keyspace to rebuild. The rebuild command works with a single keyspace or a comma-delimited list of keyspaces.

  token\_spec \(Cassandra 3.6 and later\)
 :   One or more tokens, and/or one or more ranges of tokens. The token\_spec can be:

-   One specific token.
-   A comma-delimited list of single tokens.
-   A range of tokens, specified as \( start\_token,end\_token\).
-   A comma-delimited list of token ranges — for example, \( start\_token1,end\_token1\) , \( start\_token2,end\_token2, . . .
-   A comma-delimited list of mixed single tokens and token ranges — for example, token1, \( start\_token2,end\_token2\) , \( start\_token3,end\_token3\) , token4, . . .

  --
 :   Separates an option and argument that could be mistaken for a option.

  source-dc-name
 :   The name of the datacenter Cassandra uses as the source for streaming. Cassandra rebuilds from any datacenter. If the statement does not specify one, Cassandra chooses at random.

 ## Description {#description .section}

This command operates on multiple nodes in a cluster. Like [nodetool bootstrap](toolsBootstrap.md), rebuild only streams data from a single source replica when rebuilding a token range. Use this command to [add a new datacenter](../operations/opsAddDCToCluster.md) to an existing cluster.

If rebuild fails because some token ranges cannot be retrieved, you can rebuild selectively by using the -ts or --token option to specify a list of tokens, or one or more token ranges.

**Note:** If rebuild is interrupted before completion, you can restart it by re-entering the command. The process resumes from the point at which it was interrupted.

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

