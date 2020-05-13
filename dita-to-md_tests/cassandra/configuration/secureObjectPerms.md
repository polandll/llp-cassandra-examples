# Object permissions {#secureObjectPerms .concept}

Granting or revoking permissions to access Cassandra data.

Object permissions may be assigned using Cassandra's internal authorization mechanism for the following objects:

-   keyspace
-   table
-   function
-   aggregate
-   roles
-   MBeans \(in Cassandra 3.6 and later\)

Authenticated roles with passwords stored in Cassandra are authorized selective access. The permissions are [stored in Cassandra tables](secureAboutNativeAuth.md#securityTables).

[Permission is configurable](/en/cql-oss/3.3/cql/cql_using/useSecurePermission.html) for CQL commands `CREATE`, `ALTER`, `DROP`, `SELECT`, `MODIFY`, and `DESCRIBE`, which are used to interact with the database. The `EXECUTE` command may be used to grant permission to a role for the `SELECT`, `INSERT`, and `UPDATE` commands. In addition, the `AUTHORIZE` command may be used to grant permission for a role to `GRANT`, `REVOKE` or `AUTHORIZE` another role's permissions.

Read access to these system tables is implicitly given to every authenticated user or role because the tables are used by most Cassandra tools:

-   system\_schema.keyspaces
-   system\_schema.columns
-   system\_schema.tables
-   system.local
-   system.peers

**Parent topic:** [Internal authorization](../../cassandra/configuration/secureInternalAuthorizationTOC.md)

