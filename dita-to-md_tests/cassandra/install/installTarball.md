# Installing Apache 3.x on any Linux-based platform {#installTarball .task}

Install on Linux-based platforms using a binary tarball.

The latest version of Cassandra 3.x is 3.11.5.

Use these steps to install Apache Cassandra™ on all Linux-based platforms using a binary tarball.

You can use this install for Mac OS X and other platforms without package support, or if you do not have or want a root installation.

-   DataStax recommends using the latest version of either [OpenJDK 8](http://openjdk.java.net/) or Oracle Java Platform, Standard Edition 8 \(JDK\).
-   Python 2.7 if using cqlsh.
-   If you are using an older RHEL-based Linux distribution, such as CentOS-5, you may see the following error: `GLIBCXX_3.4.9 not found`. You must replace the Snappy compression/decompression library \(snappy-java-1.0.5.jar\) with the [snappy-java-1.0.4.1.jar](https://github.com/xerial/snappy-java).

The binary tarball runs as a stand-alone process.

1.  In a terminal window:
2.  Check which version of Java is installed by running the following command:

    ```language-bash
    java -version
    ```

    DataStax recommends using the latest version of Java 8 on all nodes. See [Installing the JDK and Python 2.7](installJDKabout.md).

3.  Download Apache Cassandra:

    -   From [Download Cassandra](http://cassandra.apache.org/download/).
    -   Use curl to download from one of the mirrors. For example:

        ```language-bash
        curl -OL http://apache.mirrors.tds.net/cassandra/3.11.5/apache-cassandra-3.11.5-bin.tar.gz
        ```

    **Note:** [Apache Cassandra](http://cassandra.apache.org/download/) only provides the latest patch version. If you need to install an earlier patch version, contact [DataStax Support](https://support.datastax.com/).

4.  [Verify the integrity](https://www.apache.org/info/verification.html) of the downloaded tarball using one of the methods described [here](https://www.apache.org/dyn/closer.cgi#verify).

5.  Extract the tarball to the desired location:

    ```language-bash
    tar -xzvf apache-cassandra-3.11.5-bin.tar.gz
    ```

    Cassandra is ready for configuration.

6.  To change the location of the default directories \(install\_location/data\), see the following in install\_location/conf/cassandra.yaml:

    -   [data\_file\_directories](../configuration/configCassandra_yaml.md#data_file_directories)
    -   [commitlog\_directory](../configuration/configCassandra_yaml.md#commitlog_directory)
    -   [saved\_caches\_directory](../configuration/configCassandra_yaml.md#saved_caches_directory)
7.  To change the location of the log files \(install\_location/logs\), set the path to log directory in bin/cassandra:

    ```
    if [ -z "$CASSANDRA_LOG_DIR" ]; then
      CASSANDRA_LOG_DIR=/var/log/cassandra
    fi
    ```


-   [Starting Cassandra as a stand-alone process](../initialize/referenceStartCprocess.md)
-   [Tarball installation directories](installLocateTar.md)
-   [Initializing a multiple node cluster \(single datacenter\)](../initialize/initSingleDS.md)
-   [Initializing a multiple node cluster \(multiple datacenters\)](../initialize/initMultipleDS.md)
-   [Recommended production settings](installRecommendSettings.md)
-   [Key components for configuring Cassandra](../architecture/archIntro.md#key-tasks)

**Parent topic:** [Installing Apache Cassandra](../../cassandra/install/install_cassandraTOC.md)

