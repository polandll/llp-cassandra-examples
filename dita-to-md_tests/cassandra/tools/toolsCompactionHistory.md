# nodetool compactionhistory {#toolsCompactionHistory .reference}

Provides the history of compaction operations.

Provides the history of compaction operations.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> compactionhistory
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Example {#compHistExample .section}

The actual output of compaction history is seven columns wide. The first three columns show the id, keyspace name, and table name of the compacted SSTable.

```language-bash
nodetool compactionhistory
```

```no-highlight
Compaction History: 
id                                       keyspace_name      columnfamily_name
d06f7080-07a5-11e4-9b36-abc3a0ec9088     system             schema_columnfamilies
d198ae40-07a5-11e4-9b36-abc3a0ec9088     libdata            users
0381bc30-07b0-11e4-9b36-abc3a0ec9088     Keyspace1          Standard1
74eb69b0-0621-11e4-9b36-abc3a0ec9088     system             local
e35dd980-07ae-11e4-9b36-abc3a0ec9088     system             compactions_in_progress
8d5cf160-07ae-11e4-9b36-abc3a0ec9088     system             compactions_in_progress
ba376020-07af-11e4-9b36-abc3a0ec9088     Keyspace1          Standard1
d18cc760-07a5-11e4-9b36-abc3a0ec9088     libdata            libout
64009bf0-07a4-11e4-9b36-abc3a0ec9088     libdata            libout
d04700f0-07a5-11e4-9b36-abc3a0ec9088     system             sstable_activity
c2a97370-07a9-11e4-9b36-abc3a0ec9088     libdata            users
cb928a80-07ae-11e4-9b36-abc3a0ec9088     Keyspace1          Standard1
cd8d1540-079e-11e4-9b36-abc3a0ec9088     system             schema_columns
62ced2b0-07a4-11e4-9b36-abc3a0ec9088     system             schema_keyspaces
d19cccf0-07a5-11e4-9b36-abc3a0ec9088     system             compactions_in_progress
640bbf80-07a4-11e4-9b36-abc3a0ec9088     libdata            users
6cd54e60-07ae-11e4-9b36-abc3a0ec9088     Keyspace1          Standard1
c29241f0-07a9-11e4-9b36-abc3a0ec9088     libdata            libout
c2a30ad0-07a9-11e4-9b36-abc3a0ec9088     system             compactions_in_progress
e3a6d920-079d-11e4-9b36-abc3a0ec9088     system             schema_keyspaces
62c55cd0-07a4-11e4-9b36-abc3a0ec9088     system             schema_columnfamilies
62b07540-07a4-11e4-9b36-abc3a0ec9088     system             schema_columns
cdd038c0-079e-11e4-9b36-abc3a0ec9088     system             schema_keyspaces
b797af00-07af-11e4-9b36-abc3a0ec9088     Keyspace1          Standard1
8c918b10-07ae-11e4-9b36-abc3a0ec9088     Keyspace1          Standard1
377d73f0-07ae-11e4-9b36-abc3a0ec9088     system             compactions_in_progress
62b9c410-07a4-11e4-9b36-abc3a0ec9088     system             local
d0566a40-07a5-11e4-9b36-abc3a0ec9088     system             schema_columns
ba637930-07af-11e4-9b36-abc3a0ec9088     system             compactions_in_progress
cdbc1480-079e-11e4-9b36-abc3a0ec9088     system             schema_columnfamilies
e3456f80-07ae-11e4-9b36-abc3a0ec9088     Keyspace1          Standard1
d086f020-07a5-11e4-9b36-abc3a0ec9088     system             schema_keyspaces
d06118a0-07a5-11e4-9b36-abc3a0ec9088     system             local
cdaafd80-079e-11e4-9b36-abc3a0ec9088     system             local
640fde30-07a4-11e4-9b36-abc3a0ec9088     system             compactions_in_progress
37638350-07ae-11e4-9b36-abc3a0ec9088     Keyspace1          Standard1
```

The four columns to the right of the table name show the timestamp, size of the SSTable before and after compaction, and the number of partitions merged. The notation means \{tables:rows\}. For example: \{1:3, 3:1\} means 3 rows were taken from one SSTable \(1:3\) and 1 row taken from 3 SSTables \(3:1\) to make the one SSTable in that compaction operation.

```

. . . compacted_at        bytes_in       bytes_out      rows_merged
. . . 1404936947592       8096           7211           {1:3, 3:1}
. . . 1404936949540       144            144            {1:1}
. . . 1404941328243       1305838191     1305838191     {1:4647111}
. . . 1404770149323       5864           5701           {4:1}
. . . 1404940844824       573            148            {1:1, 2:2}
. . . 1404940700534       576            155            {1:1, 2:2}
. . . 1404941205282       766331398      766331398      {1:2727158}
. . . 1404936949462       8901649        8901649        {1:9315}
. . . 1404936336175       8900821        8900821        {1:9315}
. . . 1404936947327       223            108            {1:3, 2:1}
. . . 1404938642471       144            144            {1:1}
. . . 1404940804904       383020422      383020422      {1:1363062}
. . . 1404933936276       4889           4177           {1:4}
. . . 1404936334171       441            281            {1:3, 2:1}
. . . 1404936949567       379            79             {2:2}
. . . 1404936336248       144            144            {1:1}
. . . 1404940645958       307520780      307520780      {1:1094380}
. . . 1404938642319       8901649        8901649        {1:9315}
. . . 1404938642429       416            165            {1:3, 2:1}
. . . 1404933543858       692            281            {1:3, 2:1}
. . . 1404936334109       7760           7186           {1:3, 2:1}
. . . 1404936333972       4860           4724           {1:2, 2:1}
. . . 1404933936715       441            281            {1:3, 2:1}
. . . 1404941200880       1269180898     1003196133     {1:2623528, 2:946565}
. . . 1404940699201       297639696      297639696      {1:1059216}
. . . 1404940556463       592            148            {1:2, 2:2}
. . . 1404936334033       5760           5680           {2:1}
. . . 1404936947428       8413           5316           {1:2, 3:1}
. . . 1404941205571       429            42             {2:2}
. . . 1404933936584       7994           6789           {1:4}
. . . 1404940844664       306699417      306699417      {1:1091457}
. . . 1404936947746       601            281            {1:3, 3:1}
. . . 1404936947498       5840           5680           {3:1}
. . . 1404933936472       5861           5680           {3:1}
. . . 1404936336275       378            80             {2:2}
. . . 1404940556293       302170540      281000000      {1:924660, 2:75340}
```

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

