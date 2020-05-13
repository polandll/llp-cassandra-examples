# How do I discover consistency level performance? {#dmlCLDiscovery .concept}

Use tracing to discover what the consistency level is currently set to, and how it affects performance.

Before changing the consistency level on read and write operations, discover how your CQL commands are performing using the `TRACING` command in CQL. Using `cqlsh`, you can vary the consistency level and trace read and write operations. The tracing output includes latency times for the operations.

The CQL documentation includes a [tutorial](/en/cql-oss/3.3/cql/cql_using/useTracingTrace.html) comparing consistency levels.

**Parent topic:** [Data consistency](../../cassandra/dml/dmlDataConsistencyTOC.md)

