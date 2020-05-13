# Installing Apache Cassandra 3.x on RHEL-based systems {#installRHEL .task}

Install using Yum repositories on RHEL, CentOS, and Oracle Linux.

The latest version of Apache Cassandra™ 3.x is 3.11.5.

Use these steps to install Apache Cassandra™ using Yum repositories on RHEL, CentOS, and Oracle Linux.

**Note:** To install on SUSE, use the [Cassandra binary tarball distribution](installTarball.md).

-   Yum Package Management application installed.
-   Root or sudo access to the install machine.
-   DataStax recommends using the latest version of either [OpenJDK 8](http://openjdk.java.net/) or Oracle Java Platform, Standard Edition 8 \(JDK\).
-   Python 2.7 if using cqlsh.

The packaged releases create a `cassandra` user. When starting Cassandra as a service, the service runs as this user.

1.  In a terminal window:
2.  Check which version of Java is installed by running the following command:

    ```language-bash
    java -version
    ```

    DataStax recommends using the latest version of Java 8 on all nodes. See [Installing the JDK and Python 2.7](installJDKabout.md).

3.  Add the Apache Cassandra repository to the /etc/yum.repos.d/cassandra.repo:

    ```no-highlight
    [cassandra]
    name=Apache Cassandra
    baseurl=https://www.apache.org/dist/cassandra/redhat/311x/
    gpgcheck=1
    repo_gpgcheck=1
    gpgkey=https://www.apache.org/dist/cassandra/KEYS
    ```

4.  Install the packages:

    **Note:** [Apache Cassandra](http://cassandra.apache.org/download/) only provides the latest patch version. If you need to install an earlier patch version, contact [DataStax Support](https://support.datastax.com/).

    ```language-bash
    sudo yum update
    ```

    ```language-bash
    sudo yum install cassandra
    ```

    Cassandra is ready for configuration.

5.  To change the location of the default directories \(/var/lib/cassandra\), see the following in /etc/cassandra/conf/cassandra.yaml:

    -   [data\_file\_directories](../configuration/configCassandra_yaml.md#data_file_directories)
    -   [commitlog\_directory](../configuration/configCassandra_yaml.md#commitlog_directory)
    -   [saved\_caches\_directory](../configuration/configCassandra_yaml.md#saved_caches_directory)
6.  To change the location of the log files \(/var/log/cassandra\), replace the path to the log directory in /usr/sbin/cassandra:

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

