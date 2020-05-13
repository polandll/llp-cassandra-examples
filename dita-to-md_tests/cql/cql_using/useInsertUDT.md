# Inserting or updating data into a user-defined type \(UDT\) {#useInsertUDT .task}

How to insert or update data into a user-defined type \(UDT\).

If a table specifies a user-defined type \(UDT\) to hold data, then either `INSERT` or `UPDATE` is used to enter data.

-   **Inserting data into a UDT**
-   Set or replace user-defined type data, using the `INSERT` or `UPDATE` command, and enclosing the user-defined type with curly brackets, separating each key-value pair in the user-defined type by a colon.

    ```
    cqlsh> INSERT INTO cycling.cyclist_stats (id, lastname, basics) VALUES (
      e7ae5cf3-d358-4d99-b900-85902fda9bb0, 
      'FRAME', 
      { birthday : '1993-06-18', nationality : 'New Zealand', weight : null, height : null }
    );
    ```

    **Note:** Note the inclusion of null values for UDT elements that have no value. A value, whether null or otherwise, must be included for each element of the UDT.

-   Data can be inserted into a UDT that is nested in another column type. For example, a list of races, where the race name, date, and time are defined in a UDT has elements enclosed in curly brackets that are in turn enclosed in square brackets.

    ```
    cqlsh> INSERT INTO cycling.cyclist_races (id, lastname, firstname, races) VALUES (
      5b6962dd-3f90-4c93-8f61-eabfa4a803e2,
      'VOS',
      'Marianne',
      [{ race_title : 'Rabobank 7-Dorpenomloop Aalburg',race_date : '2015-05-09',race_time : '02:58:33' },
      { race_title : 'Ronde van Gelderland',race_date : '2015-04-19',race_time : '03:22:23' }]
    );
    ```

    **Note:** The UDT nested in the list is frozen, so the entire list will be read when querying the table.

-   **Updating individual field data in a UDT**
-   In Cassandra 3.6 and later, user-defined types that include only non-collection fields can update individual field values. Update an individual field in user-defined type data using the `UPDATE` command. The desired key-value pair are defined in the command. In order to update, the UDT must be defined in the `CREATE TABLE` command as an unfrozen data type.

    ```
    cqlsh> CREATE TABLE cycling.cyclist_stats ( id UUID, lastname text, basics basic_info, PRIMARY KEY (id) );
    INSERT INTO cycling.cyclist_stats (id, lastname, basics) 
        VALUES (220844bf-4860-49d6-9a4b-6b5d3a79cbfb, 'TIRALONGO', { birthday:'1977-07-08',nationality:'Italy',weight:'63 kg',height:'1.78 m' });
    UPDATE cyclist_stats SET basics.birthday = '2000-12-12' WHERE id = 220844bf-4860-49d6-9a4b-6b5d3a79cbfb;
    ```

    The UDT is defined in the table with `basics basic_info`. This example shows an inserted row, followed by an update that only updates the value of `birthday` inside the UDT `basics`.

    ```screen
    cqlsh:cycling> SELECT * FROM cycling.cyclist_stats WHERE id = 220844bf-4860-49d6-9a4b-6b5d3a79cbfb;
    
     id                                   | basics                                                                                                 | lastname
    --------------------------------------+--------------------------------------------------------------------------------------------------------+-----------
     220844bf-4860-49d6-9a4b-6b5d3a79cbfb | {birthday: '2000-12-12 08:00:00.000000+0000', nationality: 'Italy', weight: '63 kg', height: '1.78 m'} | TIRALONGO
    ```

    The resulting change is evident, as is the unchanged values for nationality, weight, and height.

    **Note:** UDTs with collection fields must be frozen in table creation, and individual field values cannot be updated.


**Parent topic:** [Inserting and updating data](../../cql/cql_using/useInsertDataTOC.md)

