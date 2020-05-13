# Using cqlsh with authentication {#secureLoginCqlsh .task}

How to create a cqlshrc file to default to set credentials when launching cqlsh.

Typically, after configuring authentication, logging into cqlsh requires the -u and -p options to the `cqlsh` command. To set credentials for use when launching `cqlsh`, create or modify the .cassandra/cqlshrc file. When present, this file passes default login information to `cqlsh`. The cqlshrc.sample file provides an example.

The location of the cqlshrc.sample file depends on the type of installation:

|Package installations|/etc/cassandra/cqlshrc.sample|
|Tarball installations|install\_location/conf/cqlshrc.sample|

1.  Create or modify the cqlshrc file that specifies a role name and password.

    ```no-highlight
    [authentication]
    username = fred
    password = !!bang!!$
    ```

    **Note:** Additional settings in the cqlshrc file are described in [Creating and using the cqlshrc file](/en/cql-oss/3.3/cql/cql_reference/cqlshUsingCqlshrc.html).

2.  Save the file in home/.cassandra directory and name it cqlshrc.

3.  Set permissions on the file to prevent unauthorized access, as the password is stored in plain text. The file must be readable by the user that starts `cassandra`.

    ```language-bash
    chmod 440 home/.cassandra/cqlshrc
    ```

4.  Check the permissions on home/.cassandra/cqlshrc\_history to ensure that plain text passwords are not compromised.


**Parent topic:** [Internal authentication](../../cassandra/configuration/secureInternalAuthenticationTOC.md)

