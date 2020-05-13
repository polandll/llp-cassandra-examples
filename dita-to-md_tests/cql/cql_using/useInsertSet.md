# Inserting and updating data into a set {#useInsertSet .task}

How to insert or update data into a set.

If a table specifies a set to hold data, then either `INSERT` or `UPDATE` is used to enter data.

-   Insert data into the set, enclosing values in curly brackets.

    Set values must be unique, because no order is defined in a set internally.

    ```
    cqlsh>INSERT INTO cycling.cyclist_career_teams (id,lastname,teams) 
      VALUES (5b6962dd-3f90-4c93-8f61-eabfa4a803e2, 'VOS', 
      { 'Rabobank-Liv Woman Cycling Team','Rabobank-Liv Giant','Rabobank Women Team','Nederland bloeit' } );
    ```

-   Add an element to a set using the `UPDATE` command and the addition \(+\) operator.

    ```
    cqlsh> UPDATE cycling.cyclist_career_teams 
      SET teams = teams + {'Team DSB - Ballast Nedam'} WHERE id = 5b6962dd-3f90-4c93-8f61-eabfa4a803e2;
    ```

-   Remove an element from a set using the subtraction \(-\) operator.

    ```
    cqlsh> UPDATE cycling.cyclist_career_teams
      SET teams = teams - {'WOMBATS - Womens Mountain Bike & Tea Society'} WHERE id = 5b6962dd-3f90-4c93-8f61-eabfa4a803e2;
    ```

-   Remove all elements from a set by using the UPDATE or DELETE statement.

    A set, list, or map needs to have at least one element because an empty set, list, or map is stored as a null set.

    ```
    cqlsh> UPDATE cyclist.cyclist_career_teams SET teams = {} WHERE id = 5b6962dd-3f90-4c93-8f61-eabfa4a803e2;
    
    DELETE teams FROM cycling.cyclist_career_teams WHERE id = 5b6962dd-3f90-4c93-8f61-eabfa4a803e2;
    ```

    A query for the teams returns null.

    ```
    cqlsh> SELECT id, teams FROM users WHERE id = 5b6962dd-3f90-4c93-8f61-eabfa4a803e2;
    ```

    ![](../images/screenshots/useInsertSet.png)


**Parent topic:** [Inserting and updating data](../../cql/cql_using/useInsertDataTOC.md)

