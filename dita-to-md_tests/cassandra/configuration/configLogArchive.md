# Commit log archive configuration {#configLogArchive .task}

Cassandra provides commit log archiving and point-in-time recovery.

Cassandra provides commit log archiving and point-in-time recovery. The commit log is archived at node startup and when a commit log is written to disk, or at a specified point-in-time. You configure this feature in the commitlog\_archiving.properties configuration file.

The location of the [commitlog\_archiving.properties](/en/archived/cassandra/3.x/cassandra/configuration/configLogArchive.html) file depends on the type of installation:

|Package installations|/etc/cassandra/commitlog\_archiving.properties|
|Tarball installations|install\_location/conf/commitlog\_archiving.properties|

The commands archive\_command and restore\_command expect only a single command with arguments. The parameters must be entered verbatim. STDOUT and STDIN or multiple commands cannot be executed. To workaround, you can script multiple commands and add a pointer to this file. To disable a command, leave it blank.

-   Archive a commit log segment:

    |Command|archive\_command=|
    |-------|-----------------|
    |Parameters|%path|Fully qualified path of the segment to archive.|
    |%name|Name of the commit log.|
    |Example|archive\_command=/bin/ln %path /backup/%name|

-   Restore an archived commit log:

    |Command|restore\_command=|
    |-------|-----------------|
    |Parameters|%from|Fully qualified path of the an archived commitlog segment from the restore\_directories.|
    |%to|Name of live commit log directory.|
    |Example|restore\_command=cp -f %from %to|

-   Set the restore directory location:

    |Command|restore\_directories=|
    |-------|---------------------|
    |Format|`restore_directories=restore\_directory\_location`|

-   Restore mutations created up to and including the specified timestamp:

    |Command|restore\_point\_in\_time=|
    |-------|-------------------------|
    |Format|<timestamp\> \(YYYY:MM:DD HH:MM:SS\)|
    |Example|restore\_point\_in\_time=2013:12:11 17:00:00 |

    Restore stops when the first client-supplied timestamp is greater than the restore point timestamp. Because the order in which Cassandra receives mutations does not strictly follow the timestamp order, this can leave some mutations unrecovered.


**Parent topic:** [Configuration](../../cassandra/configuration/configTOC.md)

