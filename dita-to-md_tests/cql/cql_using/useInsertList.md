# Inserting and updating data into a list {#useInsertList .task}

How to insert or update data into a list.

If a table specifies a list to hold data, then either `INSERT` or `UPDATE` is used to enter data.

-   Insert data into the list, enclosing values in square brackets.

    ```
    INSERT INTO cycling.upcoming_calendar (year, month, events) VALUES (2015, 06, ['Criterium du Dauphine','Tour de Suisse']);
    ```

-   Use the `UPDATE` command to insert values into the list. Prepend an element to the list by enclosing it in square brackets and using the addition \(+\) operator.

    ```
    cqlsh> UPDATE cycling.upcoming_calendar SET events = ['The Parx Casino Philly Cycling Classic'] + events WHERE year = 2015 AND month = 06;
    ```

-   Append an element to the list by switching the order of the new element data and the list name in the `UPDATE` command.

    ```
    cqlsh> UPDATE cycling.upcoming_calendar SET events = events + ['Tour de France Stage 10'] WHERE year = 2015 AND month = 06;
    ```

    These update operations are implemented internally without any read-before-write. Appending and prepending a new element to the list writes only the new element.

-   Add an element at a particular position using the list index position in square brackets.

    ```
    cqlsh> UPDATE cycling.upcoming_calendar SET events[2] = 'Vuelta Ciclista a Venezuela' WHERE year = 2015 AND month = 06;
    ```

    To add an element at a particular position, Cassandra reads the entire list, and then rewrites the part of the list that needs to be shifted to the new index positions. Consequently, adding an element at a particular position results in greater latency than appending or prefixing an element to a list.

-   Remove an element from a list, use the `DELETE` command and the list index position in square brackets. For example, remove the event just placed in the list in the last step.

    ```
    cqlsh> DELETE events[2] FROM cycling.upcoming_calendar WHERE year = 2015 AND month = 06;
    ```

    The method of removing elements using an indexed position from a list requires an internal read. In addition, the client-side application could only discover the indexed position by reading the whole list and finding the values to remove, adding additional latency to the operation. If another thread or client prepends elements to the list before the operation is done, incorrect data will be removed.

-   Remove all elements having a particular value using the UPDATE command, the subtraction operator \(-\), and the list value in square brackets.

    ```
    cqlsh> UPDATE cycling.upcoming_calendar SET events = events - ['Tour de France Stage 10'] WHERE year = 2015 AND month = 06;
    ```

    Using the `UPDATE` command as shown in this example is recommended over the last example because it is safer and faster.


**Parent topic:** [Inserting and updating data](../../cql/cql_using/useInsertDataTOC.md)

