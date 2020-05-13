# Change Data Capture \(CDC\) logging {#configCDCLogging .concept}

Change Data Capture \(CDC\) logging captures changes to data.

Apache Cassandra provides Change Data Capture \(CDC\) logging to capture and track data that has changed. CDC logging is configured per table, with limits on the amount of disk space to consume for storing the CDC logs. CDC logs use the same binary format as the commit log. Cassandra tables can be created or altered with a [table property](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#tabProp) to use CDC logging.

CDC logging must be enabled in the cassandra.yaml file to begin logging. A plan should be in place for moving and consuming the CDC log information before enabling. Upon flushing the memtable to disk, CommitLogSegments containing data for CDC-enabled tables are moved to the configured `cdc_raw` directory. Once the disk space limit is reached, writes to CDC enabled tables will be rejected until space is freed. Four [CDC settings are configured](configCassandra_yaml.md) in the cassandra.yaml file.

**Parent topic:** [Configuration](../../cassandra/configuration/configTOC.md)

