# Starting Cassandra as a stand-alone process {#referenceStartCprocess .task}

Start the Cassandra Java server process for tarball installations.

Start the Cassandra Java server process for tarball installations.

-   On initial start-up, each node must be started one at a time, starting with your seed nodes.
-   To start Cassandra in the background:

    ``` {#start-cassandra-tarball .language-bash}
    cd install\_location
    ```

    ```language-bash
    bin/cassandra #Starts Cassandra
    ```

-   To start Cassandra in the foreground:

    ```language-bash
    cd install\_location
    ```

    ```language-bash
    bin/cassandra -f #Starts Cassandra
    ```

-   To monitor the progress of the startup:

    ```language-bash
    tail -f logs/system.log
    ```

    Cassandra is ready when it shows an entry like this in the system.log:

    ```
    INFO  [main] 2019-12-31 03:03:37,526 Server.java:156 - Starting listening for CQL clients on /x.x.x.x:9042 (unencrypted)...
    ```

-   To check the status of Cassandra:

    ```language-bash
    bin/nodetool status
    ```

    The status column in the output should report UN which stands for Up/Normal.

    ```
    Datacenter: datacenter1
    =======================
    Status=Up/Down
    |/ State=Normal/Leaving/Joining/Moving
    --  Address    Load       Tokens       Owns (effective)  Host ID                               Rack
    UN  127.0.0.1  163.39 KB  256          100.0%            054b5c11-32dd-43c3-8f30-abcd66ba977b  rack1
    
    ```


**Parent topic:** [Starting and stopping Cassandra](../../cassandra/initialize/referenceStartStopTOC.md)

