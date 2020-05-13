# sstabledump {#ToolsSSTabledump .task}

Dump the contents of the specified SSTable in JSON format

This tool outputs the contents of the specified SSTable in the JSON format.

Depending on your task, you may wish to flush the table to disk \(using [nodetool flush](toolsFlush.md)\)before dumping its contents.

Usage:

-   Package installations: 

    ```screen
    $ sstabledump [options]  sstable\_file
    ```

-   Tarball installations: 

    ```screen
    $ cd install\_location
    $ bin/sstabledump [options] sstable\_file
    ```


The file is located in the data directory and has a .db extension.

-   Package installations: /var/lib/cassandra/data
-   Tarball installations: install\_location/data/data

|Flag|Description|
|----|-----------|
|-d|Outputs an internal representation, one CQL row per line.|
|-e|Limits output to the list of keys.|
|-k key|Limits output to information about the row identified by the specified key.|
|-xkey|Excludes information about the row identified by the specified key from output.|

**Parent topic:** [SSTable utilities](../../cassandra/tools/toolsSSTableUtilitiesTOC.md)

