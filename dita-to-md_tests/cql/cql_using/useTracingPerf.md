# How consistency affects performance {#useTracingPerf .task}

Changing the consistency level can affect read performance. The tracing output shows that as you change the consistency level, performance is affected.

Changing the consistency level can affect read performance. The tracing output shows that as you change the consistency level from ONE to QUORUM to ALL, performance degrades in from 1714 to 1887 to 2391 microseconds, respectively. If you follow the steps in this tutorial, it is not guaranteed that you will see the same trend because querying a one-row table is a degenerate case, used for example purposes. The difference between QUORUM and ALL is slight in this case, so depending on conditions in the cluster, performance using ALL might be faster than QUORUM.

Under the following conditions, performance using ALL is worse than QUORUM:

-   The data consists of thousands of rows or more.
-   One node is slower than others.
-   A particularly slow node was not selected to be part of the quorum.

## Tracing queries on large datasets {#tracing-queries-on-large-datasets .section}

You can use probabilistic tracing on databases having at least ten rows, but this capability is intended for tracing through much more data. After configuring probabilistic tracing using the [nodetool settraceprobability](/en/cassandra-oss/3.0/cassandra/tools/toolsSetTraceProbability.html) command, you query the system\_traces keyspace.

```
SELECT * FROM system_traces.events;
```

**Parent topic:** [Tracing consistency changes](../../cql/cql_using/useTracing.md)

