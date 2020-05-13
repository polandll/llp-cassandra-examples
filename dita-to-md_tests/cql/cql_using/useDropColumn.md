# Deleting columns and rows {#useDropColumn .task}

How to use the DELETE command to delete a column or row.

CQL provides the DELETE command to delete a column or row. Deleted values are removed completely by the first compaction following deletion.

1.  Delete the values of the column lastname from the table cyclist\_name.

    ```
    cqlsh> DELETE lastname FROM cycling.cyclist_name WHERE id = c7fceba0-c141-4207-9494-a29f9809de6f;
    ```

2.  Delete entire row for a particular race from the table calendar.

    ```
    cqlsh> DELETE FROM cycling.calendar WHERE race_id = 200;
    ```

    You can also define a [Time To Live](/en/glossary/doc/glossary/gloss_ttl.html)value for an individual column or an entire table. This property causes Cassandra to delete the data automatically after a certain amount of time has elapsed. For details, see Expiring data with [Time-To-Live](useExpire.md).


**Parent topic:** [Removing a keyspace, schema, or data](../../cql/cql_using/useRemoveData.md)

