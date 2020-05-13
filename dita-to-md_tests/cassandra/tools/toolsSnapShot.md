# nodetool snapshot {#toolsSnapShot .reference}

Take a snapshot of one or more keyspaces, or of a table, to backup data.

Take a snapshot of one or more keyspaces, or of a table, to backup data.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> snapshot
     ( *-cf <table\>* | *--column-family <table\>* )
     (*-kc <ktlist\>* | *--kc.list <ktlist\>* | *-kt <ktlist\>* | *--kt-list <ktlist\>*)
     (*-sf* | *--skip-flush*) 
     (*-t <tag\>* | *--tag <tag\>* )
     *--* ( <*keyspace*>  |  <*keyspace*> *...* )
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|`-cf table`|`--column-family table`|Name of the table to snapshot. You must specify one and only one keyspace.|
| |`--table table`|Name of the table to snapshot. You must specify one and only one keyspace.|
|`-kc ktlist`|`--kc.list ktlist`|The list of keyspace.tables to snapshot. Requires list of keyspaces.|
|`-kt ktlist`|`--kt-list` ktlist|The list of keyspace.tablea to snapshot. Requires list of keyspaces.|
|`-sf`|`--skip-flush`|Executes the snapshot without flushing the tables first \(Cassandra 3.4 and later\).|
|`-t`|`--tag`|Name of snapshot.|
|keyspace|One or more optional keyspace names, separated by a space. Default: all keyspaces|
|`--`| |Separates an option from an argument that could be mistaken for a option.|

## Description {#description .section}

Use this command to [back up data](../operations/opsBackupRestore.md) using a snapshot. See the examples below for various options.

Cassandra [flushes](../dml/dmlHowDataWritten.md#flushing-data-from-the-memtable) the node before taking a snapshot, takes the snapshot, and stores the data in the [snapshots directory](../install/installLocationsTOC.md)of each keyspace in the data directory. If you do not specify the name of a snapshot directory using the -t option, Cassandra names the directory using the timestamp of the snapshot, for example 1391460334889. Follow the procedure for [taking a snapshot](../operations/opsBackupTakesSnapshot.md) before upgrading Cassandra. When upgrading, backup all keyspaces. For more information about snapshots, see [Apache documentation](http://wiki.apache.org/cassandra/Operations#Backing_up_data).

## Example: All keyspaces {#snapshot-all-ks .section}

Take a snapshot of all keyspaces on the node. On Linux, in the Cassandra bin directory, for example:

```language-bash
nodetool snapshot
```

The following message appears:

```
Requested creating snapshot(s) for [all keyspaces] with snapshot name [1391464041163]
Snapshot directory: 1391464041163
```

Because you did not specify a snapshot name, Cassandra names snapshot directories using the timestamp of the snapshot. If the keyspace contains no data, empty directories are not created.

## Example: Single keyspace snapshot {#example:-single-keyspace-snapshot .section}

Assuming you created the keyspace cycling, took a snapshot of the keyspace and named the snapshot 2015.07.17.:

```language-bash
nodetool snapshot -t 2015.07.17 cycling
```

The following output appears:

```
Requested creating snapshot(s) for [cycling] with snapshot name [2015.07.17]
Snapshot directory: 2015.07.17
```

Assuming the cycling keyspace contains two tables, cyclist\_name and upcoming\_calendar, taking a snapshot of the keyspace creates multiple snapshot directories named 2015.07.17. A number of .db files containing the data are located in these directories. For example, from the installation directory:

```screen
$ cd data/data/cycling/cyclist\_name-a882dca02aaf11e58c7b8b496c707234/snapshots/2015.07.17
$ ls

```

```
la-1-big-CompressionInfo.db  la-1-big-Index.db       la-1-big-TOC.txt
la-1-big-Data.db             la-1-big-Statistics.db  la-1-big-Digest.adler32
la-1-big-Filter.db           la-1-big-Summary.db  manifest.json
```

```screen
$ cd data/data/cycling/cyclist\_name-a882dca02aaf11e58c7b8b496c707234/snapshots/2015.07.17
$ ls
 

```

```
la-1-big-CompressionInfo.db  la-1-big-Index.db       la-1-big-TOC.txt
la-1-big-Data.db             la-1-big-Statistics.db  la-1-big-Digest.adler32
la-1-big-Filter.db           la-1-big-Summary.db  manifest.json
```

## Example: Multiple keyspaces snapshot {#example:-multiple-keyspaces-snapshot .section}

Assuming you created a keyspace named mykeyspace in addition to the cycling keyspace, take a snapshot of both keyspaces.

```language-bash
nodetool snapshot mykeyspace cycling
```

The following message appears:

```
Requested creating snapshot(s) for [mykeyspace, cycling] with snapshot name [1391460334889]
Snapshot directory: 1391460334889
```

## Example: Single table snapshot {#example:-single-table-snapshot .section}

Take a snapshot of only the cyclist\_name table in the cycling keyspace.

```language-bash
nodetool snapshot --table cyclist_name cycling
```

```
Requested creating snapshot(s) for [cycling] with snapshot name [1391461910600]
Snapshot directory: 1391461910600
```

Cassandra creates the snapshot directory named 1391461910600 that contains the backup data of cyclist\_name table in data/data/cycling/cyclist\_name-a882dca02aaf11e58c7b8b496c707234/snapshots, for example.

## Example: List of different keyspace.tables snapshot { .section}

Take a snapshot of several tables in different keyspaces, such as the cyclist\_name table in the cycling keyspace and the sample\_times table in the test keyspace. The keyspace.table list should be comma-delimited with no spaces.

```language-bash
nodetool snapshot -kt cycling.cyclist_name,test.sample_times
```

```
Requested creating snapshot(s) for [cycling.cyclist_name,test.sample_times] with snapshot name [1431045288401]
Snapshot directory: 1431045288401 
```

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

