# Creating User-Defined Aggregate Function \(UDA\) {#useCreateUDA .task}

User-Defined Aggregates\(UDAs\) can be used to manipulate stored data across rows of data, returning a result that is further manipulated by a final function.

Cassandra 2.2 and later allows users to define aggregate functions that can be applied to data stored in a table as part of a query result. The aggregate function must be created prior to its use in a SELECT statement and the query must only include the aggregate function itself, but no columns. The state function is called once for each row, and the value returned by the state function becomes the new state. After all rows are processed, the optional final function is executed with the last state value as its argument. Aggregation is performed by the coordinator.

The example shown computes the team average for race time for all the cyclists stored in the table. The race time is computed in seconds.

-   Create a state function, as a [user-defined function \(UDF](useCreateUDF.md)\), if needed. This function adds all the race times together and counts the number of entries.

    ```
    cqlsh> CREATE OR REPLACE FUNCTION avgState ( state tuple<int,bigint>, val int ) CALLED ON NULL INPUT RETURNS tuple<int,bigint> LANGUAGE java AS 
      'if (val !=null) { state.setInt(0, state.getInt(0)+1); state.setLong(1, state.getLong(1)+val.intValue()); } return state;'; 
    ```

-   Create a final function, as a [user-defined function \(UDF](useCreateUDF.md)\), if needed. This function computes the average of the values passed to it from the state function.

    ```
    cqlsh> CREATE OR REPLACE FUNCTION avgFinal ( state tuple<int,bigint> ) CALLED ON NULL INPUT RETURNS double LANGUAGE java AS 
      'double r = 0; if (state.getInt(0) == 0) return null; r = state.getLong(1); r/= state.getInt(0); return Double.valueOf(r);';
    ```

-   Create the aggregate function using these two functions, and add an `STYPE` to define the data type for the function. Different `STYPEs` will distinguish one function from another with the same name. An aggregate can be replaced with a different aggregate if `OR REPLACE` is used as shown in the examples above. Optionally, the `IF NOT EXISTS` keywords can be used to create the aggregate only if another aggregate with the same signature does not exist in the keyspace. `OR REPLACE` and `IF NOT EXISTS` cannot be used in the same command.

    ```
    cqlsh> CREATE AGGREGATE IF NOT EXISTS average ( int ) 
    SFUNC avgState STYPE tuple<int,bigint> FINALFUNC avgFinal INITCOND (0,0);
    ```


For more information on user-defined aggregates, see [Cassandra Aggregates - min, max, avg, group by](http://christopher-batey.blogspot.com/2015/05/cassandra-aggregates-min-max-avg-group.html) and [A few more Cassandra aggregates](http://christopher-batey.blogspot.com/2015/07/a-few-more-cassandra-aggregates.html).

**Parent topic:** [Creating functions](../../cql/cql_using/useCreateFunctionsTOC.md)

