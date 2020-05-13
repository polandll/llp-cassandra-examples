# Creating user-defined function \(UDF\) {#useCreateUDF .task}

User-Defined Functions \(UDFs\) can be used to manipulate stored data with a function of the user's choice.

Cassandra 2.2 and later allows users to define functions that can be applied to data stored in a table as part of a query result. The function must be created prior to its use in a SELECT statement. The function will be performed on each row of the table. To use user-defined functions with Java or Javascript in Cassandra 2.2 or Javascript in Cassandra 3.0, `enable_user_defined_functions` must be set `true` incassandra.yaml file setting to enable the functions; it is not required for Java in Cassandra 3.0. User-defined functions are defined within a keyspace; if no keyspace is defined, the current keyspace is used. User-defined functions are executed in a sandbox in Cassandra 3.0 and later. In Cassandra 2.2, there is no security manager to prevent execution of malicious code; see thecassandra.yaml file for more details.

By default, Cassandra 2.2 and later supports defining functions in `java` and `javascript`. Other scripting languages, such as `Python`, `Ruby`, and `Scala` can be added by adding a JAR to the classpath. Install the JAR file into $CASSANDRA\_HOME/lib/jsr223/\[language\]/\[jar-name\].jar where language is 'jruby', 'jython', or 'scala'

-   Create a function, specifying the data type of the returned value, the language, and the actual code of the function to be performed. The following function, `fLog()`, computes the logarithmic value of each input. It is a built-in `java` function and used to generate linear plots of non-linear data. For this example, it presents a simple math function to show the capabilities of user-defined functions.

    ```
    cqlsh> CREATE OR REPLACE FUNCTION fLog (input double) CALLED ON NULL INPUT RETURNS double LANGUAGE java AS 'return Double.valueOf(Math.log(input.doubleValue()));';
    ```

    **Note:** 

    -   `CALLED ON NULL INPUT` ensures the function will always be executed.
    -   `RETURNS NULL ON NULL INPUT` ensures the function will always return `NULL` if any of the input arguments is `NULL`.
    -   `RETURNS` defines the data type of the value returned by the function.
-   A function can be replaced with a different function if `OR REPLACE` is used as shown in the example above. Optionally, the `IF NOT EXISTS` keywords can be used to create the function only if another function with the same signature does not exist in the keyspace. `OR REPLACE` and `IF NOT EXISTS` cannot be used in the same command.

    ```
    cqlsh> CREATE FUNCTION IF NOT EXISTS fLog (input double) CALLED ON NULL INPUT RETURNS double LANGUAGE java AS 'return Double.valueOf(Math.log(input.doubleValue()));';
    ```


**Parent topic:** [Creating functions](../../cql/cql_using/useCreateFunctionsTOC.md)

