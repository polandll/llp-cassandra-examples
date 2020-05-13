# Building and maintaining indexes {#useBuildIndex .concept}

Indexes provide operational ease for populating and maintaining the index.

An advantage of indexes is the operational ease of populating and maintaining the index. Indexes are built in the background automatically, without blocking reads or writes. Client-maintained *tables as indexes* must be created manually; for example, if the artists column had been indexed by creating a table such as songs\_by\_artist, your client application would have to populate the table with data from the songs table.

To perform a hot rebuild of an index, use the `nodetool rebuild_index` command.

**Parent topic:** [Indexing tables](../../cql/cql_using/useCreateQueryIndexes.md)

