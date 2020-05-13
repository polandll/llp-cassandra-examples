# Configuring the heap dump directory {#configHeapDump .task}

Analyzing the heap dump file can help troubleshoot memory problems.

Analyzing the heap dump file can help troubleshoot memory problems. Cassandra starts Java with the option -XX:+HeapDumpOnOutOfMemoryError. Using this option triggers a heap dump in the event of an out-of-memory condition. The heap dump file consists of references to objects that cause the heap to overflow. By default, Cassandra puts the file a subdirectory of the working, root directory when running as a service. If Cassandra does not have write permission to the root directory, the heap dump fails. If the root directory is too small to accommodate the heap dump, the server crashes.

To ensure that a heap dump succeeds and to prevent crashes, configure a heap dump directory that is:

-   Accessible to Cassandra for writing
-   Large enough to accommodate a heap dump

The location of the cassandra-env.sh file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra-env.sh|
|Tarball installations|install\_location/conf/cassandra-env.sh|

Base the size of the directory on the value of the Java -mx option.

1.  Set the location of the heap dump in the cassandra-env.sh file.

2.  Open the cassandra-env.sh file for editing.

3.  Scroll down to the comment about the heap dump path:

    ```
    # set jvm HeapDumpPath with CASSANDRA_HEAPDUMP_DIR
    if [ "x$CASSANDRA_HEAPDUMP_DIR" != "x" ]; then
    JVM_OPTS="$JVM_OPTS -XX:HeapDumpPath=$CASSANDRA_HEAPDUMP_DIR/cassandra-`date +%s`-pid$$.hprof"
    fi
    ```

4.  On the line after the comment, set the CASSANDRA\_HEAPDUMP\_DIR to the path you want to use:

    ```
    # set jvm HeapDumpPath with CASSANDRA_HEAPDUMP_DIR 
    export CASSANDRA_HEAPDUMP_DIR=path
    if [ "x$CASSANDRA_HEAPDUMP_DIR" != "x" ]; then
    JVM_OPTS="$JVM_OPTS -XX:HeapDumpPath=$CASSANDRA_HEAPDUMP_DIR/cassandra-`date +%s`-pid$$.hprof"
    fi
    ```

5.  Save the cassandra-env.sh file and restart.


**Parent topic:** [Configuration](../../cassandra/configuration/configTOC.md)

