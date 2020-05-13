# Starting Cassandra as a service {#referenceStartCservice .task}

Start the Cassandra Java server process for packaged installations.

Start the Apache Cassandra™ Java server process for packaged installations.

Start-up scripts are provided in the /etc/init.d directory. The service runs as the cassandra user.

1.  You must have root or sudo permissions to start Cassandra as a service.

2.  On initial start-up, each node must be started one at a time, starting with your seed nodes:

    ``` {#start-cassandra-srv .language-bash}
    sudo service cassandra start #Starts Cassandra
    ```

    If Cassandra fails to start:

    ```
    Reloading systemd:                                         [  OK  ]
    Starting cassandra (via systemctl):  Job for cassandra.service failed because a configured resource limit was exceeded. 
    See "systemctl status cassandra.service" and "journalctl -xe" for details.
                                                               [FAILED]
    ```

    The Cassandra service is not enabled on newer Linux systems, which use `systemd`. To verify use:

    ```language-bash
    sudo systemctl is-enabled cassandra.service
    ```

    ```
    cassandra.service is not a native service, redirecting to /sbin/chkconfig.
    Executing /sbin/chkconfig cassandra --level=5disabled
    ```

    To start Cassandra:

    1.  Enable the service:

        ```language-bash
        sudo systemctl enable cassandra.service
        ```

        ```
        cassandra.service is not a native service, redirecting to /sbin/chkconfig.
        Executing /sbin/chkconfig cassandra on
        ```

    2.  Start Cassandra:

        ```language-bash
        sudo service cassandra start
        ```

3.  To check the status of Cassandra:

    ```language-bash
    nodetool status
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

