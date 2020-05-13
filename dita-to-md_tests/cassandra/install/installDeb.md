# Installing Apache Cassandra 3.x on Debian-based systems {#installDeb .task}

Install using APT repositories on Debian and Ubuntu.

The latest version of Cassandra 3.x is 3.11.5.

Use these steps to install Apache Cassandra™ using APT repositories on Debian and Ubuntu Linux.

-   APT \(Advanced Package Tool\) is installed.
-   Root or sudo access to the install machine.
-   Python 2.7 if using cqlsh.
-   DataStax recommends using the latest version of either [OpenJDK 8](http://openjdk.java.net/) or Oracle Java Platform, Standard Edition 8 \(JDK\).

The packaged releases create a `cassandra` user. When starting Cassandra as a service, the service runs as this user.

1.  In a terminal window:
2.  Check which version of Java is installed by running the following command:

    ```language-bash
    java -version
    ```

    DataStax recommends using the latest version of Java 8 on all nodes. See [Installing the JDK and Python 2.7](installJDKabout.md).

3.  Add the Apache Cassandra repository to the /etc/apt/sources.list.d/cassandra.sources.list:

    ```language-bash
    echo "deb http://www.apache.org/dist/cassandra/debian 311x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
    ```

4.  If using Oracle Java on Debian systems:

    1.  In /etc/apt/sources.list, find the line that describes your source repository for Debian and add `contrib non-free` to the end of the line. For example:

        ```
        deb http://some.debian.mirror/debian/ $distro main contrib non-free
        ```

        This allows installation of the Oracle JVM instead of the OpenJDK JVM.

    2.  Save and close the file when you are done adding/editing your sources.

5.  Add the Apache Cassandra repository key to your aptitude trusted keys.

    ```language-bash
    curl https://www.apache.org/dist/cassandra/KEYS | sudo apt-key add -
    ```

6.  Install the packages:

    **Note:** [Apache Cassandra](http://cassandra.apache.org/download/) only provides the latest patch version. If you need to install an earlier patch version, contact [DataStax Support](https://support.datastax.com/).

    ```language-bash
    sudo apt-get update
    ```

    If you encounter this error:

    ```no-highlight
    GPG error: http://dl.bintray.com/apache/cassandra 311x InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY A278B781FE4B2BDA
    ```

    1.  Add the public key A278B781FE4B2BDA as follows:

        ```language-bash
        sudo apt-key adv --keyserver pool.sks-keyservers.net --recv-key A278B781FE4B2BDA
        ```

        **Note:** The key may be different. If this happens, use key listed in the error message. For a full list of Apache contributors public keys, refer to [https://www.apache.org/dist/cassandra/KEYS](https://www.apache.org/dist/cassandra/KEYS).

    2.  Update the packages:

        ```language-bash
        sudo apt-get update
        ```

7.  Install Cassandra:

    ```language-bash
    sudo apt-get install cassandra
    ```

8.  Install the optional tools:

    ```language-bash
    sudo apt-get install cassandra-tools=3.11.x.x ## Optional utilities
    ```

9.  Because the Debian packages start the Cassandra service automatically, you must stop the server and clear the data:

    Doing this removes the default [cluster\_name](../configuration/configCassandra_yaml.md#cluster_name) \(Test Cluster\) from the system table. All nodes must use the same cluster name.

    ```language-bash
    sudo service cassandra stop
    ```

    ```language-bash
    sudo rm -rf /var/lib/cassandra/*
    ```

    Cassandra is ready for configuration.

10. To change the location of the default directories \(/var/lib/cassandra\), see the following in /etc/cassandra/conf/cassandra.yaml:

    -   [data\_file\_directories](../configuration/configCassandra_yaml.md#data_file_directories)
    -   [commitlog\_directory](../configuration/configCassandra_yaml.md#commitlog_directory)
    -   [saved\_caches\_directory](../configuration/configCassandra_yaml.md#saved_caches_directory)
11. To change the location of the log files \(/var/log/cassandra\), replace the path to the log directory in /usr/sbin/cassandra:

    ```
    if [ -z "$CASSANDRA_LOG_DIR" ]; then
      CASSANDRA_LOG_DIR=/var/log/cassandra
    fi
    ```


-   [Starting Cassandra as a service](../initialize/referenceStartCservice.md)
-   [Package installation directories](installLocatePkg.md)
-   [Initializing a multiple node cluster \(single datacenter\)](../initialize/initSingleDS.md)
-   [Initializing a multiple node cluster \(multiple datacenters\)](../initialize/initMultipleDS.md)
-   [Recommended production settings](installRecommendSettings.md)
-    [Key components for configuring Cassandra](../architecture/archIntro.md#key-tasks)

**Parent topic:** [Installing Apache Cassandra](../../cassandra/install/install_cassandraTOC.md)

