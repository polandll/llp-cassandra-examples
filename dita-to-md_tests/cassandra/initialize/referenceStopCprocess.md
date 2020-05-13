# Stopping Cassandra as a stand-alone process {#referenceStopCprocess .task}

Stop the Cassandra Java server process on tarball installations.

Stop the Cassandra Java server process on tarball installations.

1.  Find the Cassandra Java process ID \(PID\), and then kill the process using its PID number:

    ``` {#stop-cassandra-tarball .language-bash}
    ps auwx | grep cassandra
    ```

    ```language-bash
    sudo kill pid #Stop Cassandra
    ```


**Parent topic:** [Starting and stopping Cassandra](../../cassandra/initialize/referenceStartStopTOC.md)

