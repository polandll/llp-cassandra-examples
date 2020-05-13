# CREATE AGGREGATE {#cqlCreateAggregate .reference}

Create user-defined aggregate.

Executes a user-define function \(UDF\) on each row in a selected data set, optionally runs a final UDF on the result set and returns a value, for example average or standard deviation.

## Synopsis {#synopsis .section}

```
CREATE [OR REPLACE] AGGREGATE [IF NOT EXISTS] 
keyspace\_name.aggregate\_name ( cql\_type )
SFUNC udf\_name 
STYPE cql\_type
FINALFUNC udf\_name 
INITCOND [value] 
```

|Syntax conventions|Description|
|------------------|-----------|
|UPPERCASE|Literal keyword.|
|Lowercase|Not literal.|
|`Italics`|Variable value. Replace with a user-defined value.|
|`[]`|Optional. Square brackets \(`[]`\) surround optional command arguments. Do not type the square brackets.|
|`( )`|Group. Parentheses \( `( )` \) identify a group to choose from. Do not type the parentheses.|
|`|`|Or. A vertical bar \(`|`\) separates alternative elements. Type any one of the elements. Do not type the vertical bar.|
|`...`|Repeatable. An ellipsis \( `...` \) indicates that you can repeat the syntax element as often as required.|
|`'Literal string'`|Single quotation \(`'`\) marks must surround literal strings in CQL statements. Use single quotation marks to preserve upper case.|
|`{ key : value }`|Map collection. Braces \(`{ }`\) enclose map collections or key value pairs. A colon separates the key and the value.|
|`<datatype1,datatype2>`|Set, list, map, or tuple. Angle brackets \( `< >` \) enclose data types in a set, list, map, or tuple. Separate the data types with a comma.|
|`cql\_statement;`|End CQL statement. A semicolon \(`;`\) terminates all CQL statements.|
|`[--]`|Separate the command line options from the command arguments with two hyphens \( `--` \). This syntax is useful when arguments might be mistaken for command line options.|
|`' <schema\> ... </schema\> '`|Search CQL only: Single quotation marks \(`'`\) surround an entire XML schema declaration.|
|`@xml\_entity='xml\_entity\_type'`|Search CQL only: Identify the entity and literal value to overwrite the XML element in the schema and solrConfig files.|

 CREATE AGGREGATE \[OR REPLACE\] aggregate\_name\(cql\_type\) \[IF EXISTS\]
 :   Creates an aggregate with specified name or replaces an existing one.

    -   CREATE AGGREGATE without *OR REPLACE* fails if an aggregate with the same signature already exists.
    -   CREATE AGGREGATE with the optional IF NOT EXISTS keywords creates an aggregate if it does not already exist and displays no error if it does.
    -   Only use *OR REPLACE* or *IF NOT EXISTS*.

    Specify the CQL type returned by the aggregate function.

    **Restriction:** Frozen collections are not supported as cql types for aggregates.

  SFUNC udf\_name
 :   Specify a user-defined function. Calls the state function \(SFUNC\) for each row. The first parameter declared in the user-defined function is the *state* parameter; the function's return value is assigned to the state parameter, which is passed to the next call. Pass multiple values using collection types, such as tuples.

  STYPE cql\_type
 :   CQL type of the parameter returned by the state function.

  FINALFUNC udf\_name
 :   User-defined function executed on the final values in the state parameter.

  INITCOND \[value\]
 :   Define the initial condition, values, of the first parameter in the SFUNC. Set to null when no value defined.

 ## Examples {#examples .section}

Create an aggregate that calculates average in the cycling keyspace.

1.  Set up a test table with data:

    ```screen
    CREATE TABLE cycling.team_average (
       team_name text, 
       cyclist_name text, 
       cyclist_time_sec int, 
       race_title text, 
       PRIMARY KEY (team_name, race_title,cyclist_name));
    INSERT INTO cycling.team_average (team_name, cyclist_name, cyclist_time_sec, race_title) VALUES ('UnitedHealthCare Pro Cycling Womens Team','Katie HALL',11449,'Amgen Tour of California Women''s Race presented by SRAM - Stage 1 - Lake Tahoe > Lake Tahoe');
    INSERT INTO cycling.team_average (team_name, cyclist_name, cyclist_time_sec, race_title) VALUES ('UnitedHealthCare Pro Cycling Womens Team','Linda VILLUMSEN',11485,'Amgen Tour of California Women''s Race presented by SRAM - Stage 1 - Lake Tahoe > Lake Tahoe');
    INSERT INTO cycling.team_average (team_name, cyclist_name, cyclist_time_sec, race_title) VALUES ('UnitedHealthCare Pro Cycling Womens Team','Hannah BARNES',11490,'Amgen Tour of California Women''s Race presented by SRAM - Stage 1 - Lake Tahoe > Lake Tahoe');
    INSERT INTO cycling.team_average (team_name, cyclist_name, cyclist_time_sec, race_title) VALUES ('Velocio-SRAM','Alena AMIALIUSIK',11451,'Amgen Tour of California Women''s Race presented by SRAM - Stage 1 - Lake Tahoe > Lake Tahoe');
    INSERT INTO cycling.team_average (team_name, cyclist_name, cyclist_time_sec, race_title) VALUES ('Velocio-SRAM','Trixi WORRACK',11453,'Amgen Tour of California Women''s Race presented by SRAM - Stage 1 - Lake Tahoe > Lake Tahoe');
    INSERT INTO cycling.team_average (team_name, cyclist_name, cyclist_time_sec, race_title) VALUES ('TWENTY16 presented by Sho-Air','Lauren KOMANSKI',11451,'Amgen Tour of California Women''s Race presented by SRAM - Stage 1 - Lake Tahoe > Lake Tahoe');
    ```

2.  Create a function with a state parameter as a tuple that counts the rows \(by incrementing 1 for each record\) in the first position and finds the total by adding the current row value to the existing subtotal the second position, and returns the updated state.

    ```screen
    CREATE OR REPLACE FUNCTION cycling.avgState ( state tuple<int,bigint>, val int ) 
    CALLED ON NULL INPUT 
    RETURNS tuple<int,bigint> 
    LANGUAGE java AS 
    $$ if (val !=null) { 
          state.setInt(0, state.getInt(0)+1); 
          state.setLong(1, state.getLong(1)+val.intValue()); 
          } 
       return state; $$
    ; 
    ```

    **Note:** Use a simple test to verify that your function works properly.

    ```screen
    CREATE TABLE cycling.test_avg (
        id int PRIMARY KEY,
        state frozen<tuple<int, bigint>>,
        val int PRIMARY KEY);
    INSERT INTO test_avg (id,state,val) values (1,(6,9949),51);
    INSERT INTO test_avg (id,state,val) values (2,(79,10000),9999);
    ```

    ```screen
    select state, avgstate(state,val) , val from test_avg;
    ```

    The first value was incremented by one and the second value is the results of the initial state value and val.

    ```
    
     state      | cycling.avgstate(state, val) | val
    ------------+------------------------------+------
      (0, 9949) |                   (1, 10000) |   51
     (1, 10000) |                   (2, 19999) | 9999
    ```

3.  Create a function that divides the total value for the selected column by the number of records.

    ```screen
    CREATE OR REPLACE FUNCTION cycling.avgFinal ( state tuple<int,bigint> ) 
    CALLED ON NULL INPUT 
    RETURNS double 
    LANGUAGE java AS 
      $$ double r = 0; 
         if (state.getInt(0) == 0) return null; 
         r = state.getLong(1); 
         r/= state.getInt(0); 
         return Double.valueOf(r); $$ 
    ;
    ```

4.  Create the user-defined aggregate to calculate the average value in the column:

    ```
    CREATE AGGREGATE cycling.average(int) 
    SFUNC avgState 
    STYPE tuple<int,bigint> 
    FINALFUNC avgFinal 
    INITCOND (0,0);
    ```

5.  Test the function using a select statement.

    ```screen
    SELECT cycling.average(cyclist_time_sec) FROM cycling.team_average 
    WHERE team_name='UnitedHealthCare Pro Cycling Womens Team' 
     AND race_title='Amgen Tour of California Women''s Race presented by SRAM - Stage 1 - Lake Tahoe > Lake Tahoe';
    ```


**Parent topic:** [CQL commands](../../cql/cql_reference/cqlCommandsTOC.md)

