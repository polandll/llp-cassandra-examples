# Table schema collision fix {#useCreateTableCollisionFix .task}

How to fix schema collision problems.

Dynamic schema creation or updates can cause schema collision resulting in errors.

1.  Run a rolling restart on all nodes to ensure schema matches. Run `nodetool describecluster` on all nodes. Check that there is only one schema version.

2.  On each node, check the `data` directory, looking for two directories for the table in question. If there is only one directory, go on to the next node. If there are two or more directories, the old table directory before update and a new table directory for after the update, continue.

3.  Identify which `cf_id` \(column family ID\) is the newest table ID in `system.schema_columnfamilies`. The column family ID is fifth column in the results.

    ```
    $ cqlsh -e "SELECT * FROM system.schema_column_families" |grep <tablename>
    ```

4.  Move the data from the older table to the newer table's directory and remove the old directory. Repeat this step as necessary.

5.  Run `nodetool refresh`.


**Parent topic:** [Creating a table](../../cql/cql_using/useCreateTableTOC.md)

