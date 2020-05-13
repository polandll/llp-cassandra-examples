# Clearing the data as a service {#referenceClearCpkgData .task}

Remove all data from a package installation. Special instructions for AMI restart.

Remove all data from a package installation.

1.  To clear the data from the **default** directories:
2.  After [stopping](referenceStopCservice_t.md) the service, run the following command:

    ```language-bash
    sudo rm -rf /var/lib/cassandra/*
    ```


**Parent topic:** [Starting and stopping Cassandra](../../cassandra/initialize/referenceStartStopTOC.md)

