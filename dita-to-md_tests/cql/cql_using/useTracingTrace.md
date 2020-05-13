# Trace reads at different consistency levels {#useTracingTrace .task}

Running and tracing queries that read data at different consistency levels.

After performing the setup steps, run and trace queries that read data at different consistency levels. The tracing output shows that using three replicas on a five-node cluster, a consistency level of ONE processes responses from one of three replicas, QUORUM from two of three replicas, and ALL from three of three replicas.

1.  On the cqlsh command line, create a keyspace that specifies using three replicas for data distribution in the cluster.

    ```
    cqlsh> CREATE KEYSPACE cycling_alt WITH replication = {'class':'SimpleStrategy', 'replication_factor':3};
    ```

2.  Create a table, and insert some values:

    ```
    cqlsh> USE cycling_alt;
    cqlsh> CREATE TABLE cycling_alt.tester ( id int PRIMARY KEY, col1 int, col2 int );
    cqlsh> INSERT INTO cycling_alt.tester (id, col1, col2) VALUES (0, 0, 0);
    ```

3.  [Turn on tracing](../cql_reference/cqlshTracing.md) and use the [CONSISTENCY command](../cql_reference/cqlshConsistency.md) to check that the consistency level is ONE, the default.

    ```
    cqlsh> TRACING on;
    cqlsh> CONSISTENCY;
    
    ```

    The output should be:

    ```
    Current consistency level is 1.
    ```

4.  Query the table to read the value of the primary key.

    ```
    cqlsh> SELECT * FROM cycling_alt.tester WHERE id = 0;
    ```

    The output includes tracing information:

    ```
      id | col1 | col2
    ----+------+------
      0 |    0 |    0
    
    (1 rows)
    
    Tracing session: 65bd3150-0109-11e6-8b46-15359862861c
    
     activity                                                                     | timestamp                  | source    | source_elapsed
    ------------------------------------------------------------------------------+----------------------------+-----------+----------------
                                                               Execute CQL3 query | 2016-04-12 16:50:55.461000 | 127.0.0.1 |              0
     Parsing SELECT * FROM cycling_alt.tester WHERE id = 0; [SharedPool-Worker-1] | 2016-04-12 16:50:55.462000 | 127.0.0.1 |            276
                                        Preparing statement [SharedPool-Worker-1] | 2016-04-12 16:50:55.462000 | 127.0.0.1 |            509
                 Executing single-partition query on tester [SharedPool-Worker-2] | 2016-04-12 16:50:55.463000 | 127.0.0.1 |           1019
                               Acquiring sstable references [SharedPool-Worker-2] | 2016-04-12 16:50:55.463000 | 127.0.0.1 |           1106
                                  Merging memtable contents [SharedPool-Worker-2] | 2016-04-12 16:50:55.463000 | 127.0.0.1 |           1159
                          Read 1 live and 0 tombstone cells [SharedPool-Worker-2] | 2016-04-12 16:50:55.463000 | 127.0.0.1 |           1372
                                                                 Request complete | 2016-04-12 16:50:55.462714 | 127.0.0.1 |           1714
    ```

    The tracing results list all the actions taken to complete the `SELECT` statement.

5.  Change the consistency level to QUORUM to trace what happens during a read with a QUORUM consistency level.

    ```
    cqlsh> CONSISTENCY quorum;
    cqlsh> SELECT * FROM cycling_alt.tester WHERE id = 0;
    ```

    ```
     id | col1 | col2
    ----+------+------
      0 |    0 |    0
    
    (1 rows)
    
    Tracing session: 5e3601f0-0109-11e6-8b46-15359862861c
    
     activity                                                                     | timestamp                  | source    | source_elapsed
    ------------------------------------------------------------------------------+----------------------------+-----------+----------------
                                                               Execute CQL3 query | 2016-04-12 16:50:42.831000 | 127.0.0.1 |              0
     Parsing SELECT * FROM cycling_alt.tester WHERE id = 0; [SharedPool-Worker-1] | 2016-04-12 16:50:42.831000 | 127.0.0.1 |            259
                                        Preparing statement [SharedPool-Worker-1] | 2016-04-12 16:50:42.831000 | 127.0.0.1 |            557
                 Executing single-partition query on tester [SharedPool-Worker-3] | 2016-04-12 16:50:42.832000 | 127.0.0.1 |           1076
                               Acquiring sstable references [SharedPool-Worker-3] | 2016-04-12 16:50:42.832000 | 127.0.0.1 |           1182
                                  Merging memtable contents [SharedPool-Worker-3] | 2016-04-12 16:50:42.832000 | 127.0.0.1 |           1268
                          Read 1 live and 0 tombstone cells [SharedPool-Worker-3] | 2016-04-12 16:50:42.832000 | 127.0.0.1 |           1632
                                                                 Request complete | 2016-04-12 16:50:42.832887 | 127.0.0.1 |           1887
    ```

6.  Change the consistency level to ALL and run the SELECT statement again.

    ```
    cqlsh> CONSISTENCY ALL;
    cqlsh> SELECT * FROM cycling_alt.tester WHERE id = 0;
    ```

    ```
     id | col1 | col2
    ----+------+------
      0 |    0 |    0
    
    (1 rows)
    
    Tracing session: 6c4678b0-0109-11e6-8b46-15359862861c
    
     activity                                                                     | timestamp                  | source    | source_elapsed
    ------------------------------------------------------------------------------+----------------------------+-----------+----------------
                                                               Execute CQL3 query | 2016-04-12 16:51:06.427000 | 127.0.0.1 |              0
     Parsing SELECT * FROM cycling_alt.tester WHERE id = 0; [SharedPool-Worker-1] | 2016-04-12 16:51:06.427000 | 127.0.0.1 |            324
                                        Preparing statement [SharedPool-Worker-1] | 2016-04-12 16:51:06.427000 | 127.0.0.1 |            524
                                       Read-repair DC_LOCAL [SharedPool-Worker-1] | 2016-04-12 16:51:06.428000 | 127.0.0.1 |           1016
                 Executing single-partition query on tester [SharedPool-Worker-3] | 2016-04-12 16:51:06.428000 | 127.0.0.1 |           1793
                               Acquiring sstable references [SharedPool-Worker-3] | 2016-04-12 16:51:06.429000 | 127.0.0.1 |           1886
                                  Merging memtable contents [SharedPool-Worker-3] | 2016-04-12 16:51:06.429000 | 127.0.0.1 |           1951
                          Read 1 live and 0 tombstone cells [SharedPool-Worker-3] | 2016-04-12 16:51:06.429000 | 127.0.0.1 |           2176
                                                                 Request complete | 2016-04-12 16:51:06.429391 | 127.0.0.1 |           2391
    ```


**Parent topic:** [Tracing consistency changes](../../cql/cql_using/useTracing.md)

