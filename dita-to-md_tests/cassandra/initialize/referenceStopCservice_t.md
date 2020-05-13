# Stopping Cassandra as a service {#referenceStopCservice_t .task}

Stopping the Cassandra Java server process on packaged installations.

Stopping the Cassandra Java server process on packaged installations.

1.  You must have root or sudo permissions to stop the Cassandra service:

    ``` {#stop-cassandra-service .language-bash}
    sudo service cassandra stop
    ```

2.  Find the Cassandra Java process ID \(PID\), and then kill the process using its PID number:

    ``` {#stop-cassandra-tarball .language-bash}
    ps auwx | grep cassandra
    ```

    ```language-bash
    sudo kill pid #Stop Cassandra
    ```


**Parent topic:** [Starting and stopping Cassandra](../../cassandra/initialize/referenceStartStopTOC.md)

