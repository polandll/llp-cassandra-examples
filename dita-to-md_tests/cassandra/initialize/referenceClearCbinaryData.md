# Clearing the data as a stand-alone process {#referenceClearCbinaryData .task}

Remove all data from a tarball installation.

Remove all data from a tarball installation.

-   To clear all data from the **default** directories, including the commitlog and saved\_caches:

    1.  [Stop](referenceStopCprocess.md) the process.

    2.  Run the following command from the install directory:

        ```language-bash
        cd install\_location
        ```

        ```language-bash
        sudo rm -rf data/*
        ```

-   To clear the only the data directory:

    1.  [Stop](referenceStopCprocess.md) the process.

    2.  Run the following command from the install directory:

        ```language-bash
        cd install\_location
        ```

        ```language-bash
        sudo rm -rf data/data/*
        ```


**Parent topic:** [Starting and stopping Cassandra](../../cassandra/initialize/referenceStartStopTOC.md)

