# Uninstalling Apache Cassandra {#installRemove .task}

Steps for uninstalling Apache Cassandra by install type.

This topic provides information on completely removing Apache Cassandra™ from your machine.

**Note:** If you want to keep the installation or if you don't remove the installation immediately, see [Preventing the node from re-joining the cluster](installRemove.md#prevent).

Select the uninstall method for your type of installation.

## Uninstalling Debian- and RHEL-based packages {#uninstallPackages .section}

Use this method when you have installed Apache Cassandra™ using APT or Yum.

1.  Stop the Cassandra services:

    ```language-bash
    sudo service cassandra stop
    ```

2.  Make sure all services are stopped:

    ```language-bash
    ps auwx | grep cassandra
    ```

3.  If services are still running, use the PID to kill the service:

    ```language-bash
    sudo kill cassandra\_pid
    ```

4.  Remove the library and log directories:

    ```language-bash
    sudo rm -r /var/lib/cassandra
    ```

    ```language-bash
    sudo rm -r /var/log/cassandra
    ```

5.  Remove the installation directories:

    **RHEL-based packages:**

    ```language-bash
    sudo yum remove "cassandra-*"
    ```

    **Debian-based packages:**

    ```language-bash
    sudo apt-get purge "cassandra-*"
    ```


## Uninstalling the binary tarball {#uninstallingTarball .section}

Use this method when you have installed Cassandra using the [binary tarball](installTarball.md).

1.  Stop the node:

    ```language-bash
    ps auwx | grep cassandra
    ```

2.  ```language-bash
sudo  kill <pid>
```

3.  Stop the DataStax Agent if installed:

    ```language-bash
    sudo kill datastax_agent_pid
    ```

4.  Remove the installation directory.

## Preventing the node from re-joining the cluster {#prevent .section}

The following steps will prevent the node from re-joining the cluster if someone inadvertently starts Cassandra again.

1.  Stop Cassandra using one of the above methods.
2.  In the cassandra.yaml:
    1.  Change the [cassandra.yaml configuration file](../configuration/configCassandra_yaml.md#cluster_name) to DECOMMISSIONED.
    2.  Set the [- seeds list](../configuration/configCassandra_yaml.md#seed_provider) to 127.0.0.1.
    3.  Restart the node.

**Parent topic:** [Installing Apache Cassandra](../../cassandra/install/install_cassandraTOC.md)

