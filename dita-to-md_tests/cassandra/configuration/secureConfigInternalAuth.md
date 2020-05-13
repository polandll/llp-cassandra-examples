# Configuring internal authorization {#secureConfigInternalAuth .task}

Steps for adding the CassandraAuthorizer.

CassandraAuthorizer is one of many possible IAuthorizer implementations. Its advantage is that it stores permissions in the `system_auth.permissions` table to support all authorization-related CQL statements. To activate it, change the `authorizer` option in cassandra.yaml to use the `CassandraAuthorizer`.

**Note:** To configure authentication, see [Internal authentication](secureInternalAuthenticationTOC.md).

The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra.yaml|
|Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

1.  In the cassandra.yaml file, comment out the default `AllowAllAuthorizer` and add the `CassandraAuthorizer`.

    ```
    authorizer: CassandraAuthorizer
    ```

    You can use any authenticator except AllowAll.

2.   [Increase the replication factor](secureConfigNativeAuth.md#incRFsystemAuth) for the `system_auth` keyspace if not already configured.

3.  Fetching role permissions can be a costly operation. Role permissions can be cached to decrease the burden. Adjust the validity period for permission caching by setting the [permissions\_validity\_in\_ms](configCassandra_yaml.md#permissions_validity_in_ms) option in the cassandra.yaml file. The default value is 2000 milliseconds. The caching can be disabled by setting the option to 0. This setting is disabled automatically if the authorizer is set to `AllowAllAuthorizer`

    ```
    permissions_validity_in_ms: 2000
    ```

4.  A refresh interval for role caches can also be configured by setting the [permissions\_update\_interval\_in\_ms](configCassandra_yaml.md#permissions_update_interval_in_ms) option in the cassandra.yaml file. The default value is the same value as the `permissions_validity_in_ms` setting. If `permissions_validity_in_ms` is non-zero, this setting must be set.

    ```
    permissions_update_interval_in_ms: 2000
    ```


CQL supports these authorization statements:

-   [GRANT](/en/cql-oss/3.3/cql/cql_reference/cqlGrant.html)
-   [LIST PERMISSIONS](/en/cql-oss/3.3/cql/cql_reference/cqlListPermissions.html)
-   [REVOKE](/en/cql-oss/3.3/cql/cql_reference/cqlRevoke.html)

**Parent topic:** [Internal authorization](../../cassandra/configuration/secureInternalAuthorizationTOC.md)

