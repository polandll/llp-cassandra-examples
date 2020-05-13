# Setup to trace consistency changes {#useTracingSetup .task}

Steps for tracing consistency changes.

To setup five nodes on your local computer, trace reads at different consistency levels, and then compare the results. This example uses [ccm](https://github.com/pcmanus/ccm), a tool for running multiple nodes of Cassandra on a local computer.

1.  Get the [ccm library of scripts](https://github.com/pcmanus/ccm) from github.

    You will use this library in subsequent steps to perform the following actions:

    -   Download Apache Cassandra source code.
    -   Create and launch an Apache Cassandra cluster on a single computer.
    Refer to the ccm README for prerequisites.

2.  Optional: For Mac computers, set up loopback aliases. All other platforms, skip this step.

    ```screen
    $ sudo ifconfig lo0 alias 127.0.0.2 up
    $ sudo ifconfig lo0 alias 127.0.0.3 up
    $ sudo ifconfig lo0 alias 127.0.0.4 up
    $ sudo ifconfig lo0 alias 127.0.0.5 up
    ```

3.  Download Apache [Cassandra source code](http://cassandra.apache.org/download/) into the /.ccm/repository.

4.  Start the ccm cluster named `trace_consistency` using Cassandra version 3.0.5. The source code to run the cluster will automatically download and compile.

    ```screen
    $ ccm create trace_consistency -v 3.0.5
    ```

    ```
    Current cluster is now: trace_consistency
    ```

5.  Use the following commands to populate and check the cluster:

    ```screen
    $ ccm populate -n 5
    $ ccm start
    ```

6.  Check that the cluster is up:

    ```screen
    $ ccm node1 ring
    ```

    The output shows the status of all five nodes.

7.  Connect cqlsh to the first node in the ring.

    ```screen
    $ ccm node1 cqlsh
    ```


**Parent topic:** [Tracing consistency changes](../../cql/cql_using/useTracing.md)

**Related information**  


[Cassandra 2.0 cassandra.yaml](/en/cassandra/2.0/cassandra/configuration/configCassandra_yaml.html)

[Cassandra 2.1 cassandra.yaml](/en/cassandra/2.1/cassandra/configuration/configCassandra_yaml_r.html)

[Cassandra 2.2 cassandra.yaml](/en/cassandra/2.2/cassandra/configuration/configCassandra_yaml.html)

[Cassandra 3.0 cassandra.yaml](/en/cassandra-oss/3.0/cassandra/configuration/configCassandra_yaml.html)

