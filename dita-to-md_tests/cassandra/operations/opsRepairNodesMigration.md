# Migrating to incremental repairs {#opsRepairNodesMigration .task}

To start using incremental repairs, migrate the SSTables on each node.

Repairing SSTables using [anti-entropy repair](opsRepairNodesManualRepair.md)is a necessary part of Cassandra maintenance. A full repair of all SSTables on a node takes a lot of time and is resource-intensive. You can manage repairs with less service disruption using [incremental repair](opsRepairNodesManualRepair.md#full-vs-incremental-repair). Incremental repair consumes less time and resources because it skips SSTables that are already marked as repaired.

Incremental repair works equally well with any compaction scheme — [Size-Tiered Compaction \(STCS\)](../dml/dmlHowDataMaintain.md#stcs-compaction), [Date-Tiered Compaction\(DTCS\)](../dml/dmlHowDataMaintain.md#dtcs-compaction), [Time-Window Compaction\(TWCS\)](../dml/dmlHowDataMaintain.md#twcs), or [Leveled Compaction \(LCS\)](../dml/dmlHowDataMaintain.md#lcs-compaction).

In Cassandra 3.0 and later, switching from full repair to incremental repair is easier than before. However, the first system-wide incremental repair can take a long time, as Cassandra recompacts all SSTables according to the chosen compaction shceme. You can make this process less disruptive by *migrating* the cluster to incremental repair one node at a time.

Overview of the procedure

To migrate one Cassandra node to incremental repair:

1.  Disable autocompaction on the node.
2.  Run a full, sequential repair.
3.  Stop the node.
4.  Set the `repairedAt` metadata value to each SSTable that existed before you disabled compaction.
5.  Restart Cassandra on the node.
6.  Re-enable autocompaction on the node.

Listing SSTables

Before you run a full repair on the node, list its SSTables. The existing SSTables may not be changed by the repair process, and the incremental repair process you run later will not process these SSTables unless you set the `repairedAt` value for each SSTable \(see [Step 4](opsRepairNodesMigration.md#mark-all-tables-repaired) below\).

You can find the node's SSTables in one of the following locations:

-   Package installations: /var/lib/cassandra/data
-   Tarball installations: install\_location/data/data

This directory contains a subdirectory for each keyspace. Each of these subdirectories contains a set of files for each SSTable. The name of the file that contains the SSTable data has the following format:

```
<version_code>-<generation>-<format>-Data.db
```

**Note:** You can mark multiple SSTables as a batch by running sstablerepairedset with a text file of filenames — see [Step 4](opsRepairNodesMigration.md#mark-all-tables-repaired).

## Migrating the node to incremental repair {#migrating-node-to-incremental .section}

**Note:** In RHEL and Debian installations, you must install the tools packages before you can follow these steps.

1.  **Disable autocompaction on the node**

    From the install\_directory:

    ```
    $ bin/nodetool disableautocompaction
    ```

    Running this command without parameters disables autocompaction for all keyspaces. For details, see [disableautocompaction](../tools/toolsDisableAutoCompaction.md).

2.  **Run the default full, sequential repair**

    From the install\_directory:

    ```
    $ bin/nodetool repair
    ```

    Running this command without parameters starts a full sequential repair of all SSTables on the node. This may take a substantial amount of time. For details, see [repair](../tools/toolsRepair.md).

3.  **Stop the node**.
4.  **Set the `repairedAt` metadata value to each SSTable that existed before you disabled compaction**.

    Use [sstablerepairedset](../tools/toolsSStabRepairedSet.md). To mark a single SSTable SSTable-example-Data.db:

    ```
    sudo bin/sstablerepairedset --really-set --is-repaired SSTable-example-Data.db
    ```

    To do this as a batch process using a text file of SSTable names:

    ```
    sudo bin/sstablerepairedset --really-set --is-repaired -f SSTable-names.txt
    ```

    **Note:** The value of the repairedAt metadata is the timestamp of the last repair. The sstablerepairedset command applies the current date/time. To check the value of the `repairedAt` metadata for an SSTable, use:

    ```
    $ bin/sstablemetadata example-keyspace-SSTable-example-Data.db | grep "Repaired at"
    ```

5.  **Restart the node**.

After you have migrated all nodes, you will be able to run incremental repairs using nodetool repair with the -inc option. For details, see [https://www.datastax.com/dev/blog/more-efficient-repairs](https://www.datastax.com/dev/blog/more-efficient-repairs).

**Parent topic:** [Repairing nodes](../../cassandra/operations/opsRepairNodesTOC.md)

**Related information**  


[https://www.datastax.com/dev/blog/repair-in-cassandra](https://www.datastax.com/dev/blog/repair-in-cassandra)

[https://www.datastax.com/dev/blog/more-efficient-repairs](https://www.datastax.com/dev/blog/more-efficient-repairs)

[https://www.datastax.com/dev/blog/anticompaction-in-cassandra-2-1](https://www.datastax.com/dev/blog/anticompaction-in-cassandra-2-1)

