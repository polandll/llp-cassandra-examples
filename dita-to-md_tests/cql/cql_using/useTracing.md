# Tracing consistency changes {#useTracing .concept}

This tutorial shows the difference between these consistency levels and the number of replicas that participate to satisfy a request.

In a distributed system such as Cassandra, the most recent value of data is not necessarily on every node all the time. The client application configures the consistency level per request to manage response time versus data accuracy. By tracing activity on a five-node cluster, this tutorial shows the difference between these consistency levels and the number of replicas that participate to satisfy a request:

-   ONE

    Returns data from the nearest replica.

-   QUORUM

    Returns the most recent data from the majority of replicas.

-   ALL

    Returns the most recent data from all replicas.


Follow instructions to setup five nodes on your local computer, trace reads at different consistency levels, and then compare the results.

-   **[Setup to trace consistency changes](../../cql/cql_using/useTracingSetup.md)**  
Steps for tracing consistency changes.
-   **[Trace reads at different consistency levels](../../cql/cql_using/useTracingTrace.md)**  
Running and tracing queries that read data at different consistency levels.
-   **[How consistency affects performance](../../cql/cql_using/useTracingPerf.md)**  
Changing the consistency level can affect read performance. The tracing output shows that as you change the consistency level, performance is affected.

**Parent topic:** [Using CQL](../../cql/cql_using/useAboutCQL.md)

