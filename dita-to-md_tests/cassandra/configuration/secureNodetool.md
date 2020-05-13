# Using nodetool with authentication {#secureNodetool .task}

How to use nodetool with authentication.

After configuring JMX authentication, using `nodetool` requires the -u and -p options to the nodetool commands.

1.  Run `nodetool` using a pre-configured JMX username and password for `<username>` and `<password>`:

    ```screen
    $ nodetool -u <username> -pw <password>
    ```

    For Cassandra 3.6 and later, the username and password can be an internally configured Cassandra role and password.

    **Note:** In Cassandra 3.0.8 and later, a user designated `readonly` access can run `nodetool info` so that cluster monitoring is available. In earlier versions, the user must have `readwrite` permission.


**Parent topic:** [JMX authentication and authorization](../../cassandra/configuration/secureJMXAuthenticationTOC.md)

