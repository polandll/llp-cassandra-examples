# nodetool clearsnapshot {#toolsClearSnapShot .reference}

Removes one or more snapshots.

Removes one or more snapshots.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> clearsnapshot *-t* <*snapshot*> *--*  <*keyspace*>* ...* 
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|-t|Remove the snapshot with a designated name.|
|keyspace|Remove snapshots from the designated keyspaces, separated by a space.|
|snapshot|Name of the snapshot.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Description {#description .section}

Deletes snapshots in one or more keyspaces. To remove all snapshots, omit the snapshot name.

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

