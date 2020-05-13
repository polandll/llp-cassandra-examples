# Securing a table {#useSecureTOC}

How to secure a table.

Use role-based security commands to control access to keyspaces and objects.

Change the following settings in the cassandra.yamlto enable authentication and authorization:

```
authenicator: PasswordAuthenticator
authorizer: CassandraAuthorizer
```

And then restart Cassandra to apply the changes.

-   **[Database roles](../../cql/cql_using/useSecureRoles.md)**  
How to create and work with roles.
-   **[Database Permissions](../../cql/cql_using/useSecurePermission.md)**  
 How to set role permissions.
-   **[Database users](../../cql/cql_using/useSecureUsers.md)**  
How to create and work with users.

**Parent topic:** [Using CQL](../../cql/cql_using/useAboutCQL.md)

