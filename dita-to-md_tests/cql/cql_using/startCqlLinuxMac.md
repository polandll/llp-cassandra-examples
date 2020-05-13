# Starting cqlsh on Linux and Mac OS X {#startCqlLinuxMac .task}

A brief description on starting cqlsh on Linux and Mac OS X.

This procedure briefly describes how to start `cqlsh` on Linux and Mac OS X. The [`cqlsh` command](../cql_reference/cqlsh.md) is covered in detail later.

1.  Navigate to the Cassandra installation directory.

2.  Start `cqlsh` on the Mac OSX, for example.

    ```screen
    $ bin/cqlsh
    ```

    If you use security features, provide a user name and password.

3.  Print the help menu for `cqlsh`.

    ```screen
    $ bin/cqlsh --help
    ```

4.  Optionally, specify the IP address and port to start `cqlsh` on a different node.

    ```screen
    $ bin/cqlsh 1.2.3.4 9042
    ```

    **Note:** You can use [tab completion](http://docs.python.org/release/2.6.8/library/readline.html#module-readline) to see hints about how to complete a `cqlsh` command. Some platforms, such as Mac OSX, do not ship with tab completion installed. You can use [easy\_install](https://pypi.python.org/pypi/setuptools/) to install tab completion capabilities on Mac OSX:

    ```screen
    $ easy_install readline
    ```


**Parent topic:** [Starting the CQL shell \(cqlsh\)](../../cql/cql_using/useStartingCqlshTOC.md)

