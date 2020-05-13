# Inserting and updating data into a map {#useInsertMap .task}

How to insert or update data into a map.

If a table specifies a map to hold data, then either `INSERT` or `UPDATE` is used to enter data.

-   Set or replace map data, using the `INSERT` or `UPDATE` command, and enclosing the integer and text values in a map collection with curly brackets, separated by a colon.

    ```
    cqlsh> INSERT INTO cycling.cyclist_teams (id, lastname, firstname, teams) 
    VALUES (
      5b6962dd-3f90-4c93-8f61-eabfa4a803e2,
      'VOS', 
      'Marianne', 
      {2015 : 'Rabobank-Liv Woman Cycling Team', 2014 : 'Rabobank-Liv Woman Cycling Team', 2013 : 'Rabobank-Liv Giant', 
        2012 : 'Rabobank Women Team', 2011 : 'Nederland bloeit' }); 
    
    ```

    **Note:** Using `INSERT` in this manner will replace the entire map.

-   Use the `UPDATE` command to insert values into the map. Append an element to the map by enclosing the key-value pair in curly brackets and using the addition \(+\) operator.

    ```
    cqlsh> UPDATE cycling.cyclist_teams SET teams = teams + {2009 : 'DSB Bank - Nederland bloeit'} WHERE id = 5b6962dd-3f90-4c93-8f61-eabfa4a803e2;
    ```

-   Set a specific element using the `UPDATE` command, enclosing the specific key of the element, an integer, in square brackets, and using the equals operator to map the value assigned to the key.

    ```
    cqlsh> UPDATE cycling.cyclist_teams SET teams[2006] = 'Team DSB - Ballast Nedam' WHERE id = 5b6962dd-3f90-4c93-8f61-eabfa4a803e2;
    ```

-   Delete an element from the map using the `DELETE` command and enclosing the specific key of the element in square brackets:

    ```
    cqlsh> DELETE teams[2009] FROM cycling.cyclist_teams WHERE id=e7cd5752-bc0d-4157-a80f-7523add8dbcd;
    ```

-   Alternatively, remove all elements having a particular value using the UPDATE command, the subtraction operator \(-\), and the map key values in curly brackets.

    ```
    cqlsh> UPDATE cycling.cyclist_teams SET teams = teams - {'2013','2014'} WHERE id=e7cd5752-bc0d-4157-a80f-7523add8dbcd;
    ```


**Parent topic:** [Inserting and updating data](../../cql/cql_using/useInsertDataTOC.md)

