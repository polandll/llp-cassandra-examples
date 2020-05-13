# Configuring authentication {#secureConfigNativeAuth .task}

Steps for configuring authentication.

Steps for configuring authentication.

1.  Change the authenticator option in the cassandra.yaml file to `PasswordAuthenticator`:

    ```
    authenticator: PasswordAuthenticator
    ```

    By default, the authenticator option is set to `AllowAllAuthenticator`.

    The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

        |Package installations|/etc/cassandra/cassandra.yaml|
    |Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

2.  [Restart Cassandra](../initialize/referenceStartStopTOC.md).

3.  Start `cqlsh` using the default [superuser](/en/glossary/doc/glossary/gloss_superuser.html) name and password:

    ```language-bash
     cqlsh -u cassandra -p cassandra
    ```

4.  To ensure that the keyspace is always available, [increase the replication factor](/en/cql-oss/3.3/cql/cql_reference/cqlAlterKeyspace.html) for the *system\_auth* keyspace to 3 to 5 nodes per datacenter \(recommended\):

    ```
    cqlsh> ALTER KEYSPACE "system_auth" 
    WITH REPLICATION = {'class' : 'NetworkTopologyStrategy', 'dc1' : 3, 'dc2' : 2};
    ```

    The `system_auth` keyspace uses a QUORUM consistency level when checking authentication for the default *cassandra* user. For all other users created, superuser or otherwise, a LOCAL\_ONE consistency level is used for authenticating.

    CAUTION:

    Leaving the default replication factor of 1 set for the *system\_auth* keyspace results in denial of access to the cluster if the single replica of the keyspace goes down. For multiple datacenters, be sure to set the replication class to `NetworkTopologyStrategy`.

5.  After increasing the replication factor of a keyspace, run `nodetool repair` to make certain the change is propagated:

    ```
    $  nodetool repair system_auth
    ```

6.  [Restart Cassandra](../initialize/referenceStartStopTOC.md).

7.  Start `cqlsh` using the superuser name and password:

    ```language-bash
     cqlsh -u cassandra -p cassandra
    ```

8.  To prevent security breaches, replace the default superuser, *cassandra*, with another superuser with a different name:

    ```
    cqlsh> CREATE ROLE <new_super_user> WITH PASSWORD = '<some_secure_password>' 
        AND SUPERUSER = true 
        AND LOGIN = true;
    ```

    The default user `cassandra` reads with a [consistency level](../dml/dmlDataConsistencyTOC.md) of QUORUM by default, whereas another superuser reads with a consistency level of LOCAL\_ONE.

9.  Log in as the newly created superuser:

    ```language-bash
     cqlsh -u <new_super_user> -p <some_secure_password>
    ```

10. The *cassandra* superuser cannot be deleted from Cassandra. To neutralize the account, change the password to something long and incomprehensible, and alter the user's status to `NOSUPERUSER`:

    ```
    cqlsh> ALTER ROLE cassandra WITH PASSWORD='SomeNonsenseThatNoOneWillThinkOf'
        AND SUPERUSER=false;
    ```

11. Once you create some new roles, you are ready to [authorize those roles](secureInternalAuthorizationTOC.md) to access database objects.

12. Fetching role authentication can be a costly operation. To decrease the burden, adjust the validity period for role caching with the [roles\_validity\_in\_ms](configCassandra_yaml.md#roles_validity_in_ms) option in the cassandra.yaml file \(default 2000 milliseconds\):

    ```
    roles_validity_in_ms: 2000
    ```

    To disable, set this option to 0. This setting is automatically disabled when the authenticator is set to `AllowAllAuthenticator`.

13. Configure the refresh interval for role caches by setting the [roles\_update\_interval\_in\_ms](configCassandra_yaml.md#roles_update_interval_in_ms) option in the cassandra.yaml file \(default 2000 ms\):

    ```
    roles_update_interval_in_ms: 2000
    ```

    If `roles_validity_in_ms` is non-zero, this setting must be set.

    **Note:** The credentials are cached in their encrypted form.

14. **The following steps apply only to Cassandra 3.4 and later:**
15. Fetching credentials authentication can be a costly operation. To decrease the burden, adjust the validity period for credential caching with the [credentials\_validity\_in\_ms](configCassandra_yaml.md#credentials_validity_in_ms) option in the cassandra.yaml file \(default 2000 ms\):

    ```
    credentials_validity_in_ms: 2000
    ```

    To disable, set this option to 0. This setting is automatically disabled when the authenticator is set to `AllowAllAuthenticator`.

16. To set the refresh interval for credentials caches, use the [credentials\_update\_interval\_in\_ms](configCassandra_yaml.md#credentials_update_interval_in_ms) option \(default 2000 ms\):

    ```
    credentials_update_interval_in_ms: 2000
    ```

    If `credentials_validity_in_ms` is non-zero, this setting must be set.

17. To disable configuration of authentication and authorization caches \(credentials, roles, and permissions\) via JMX, uncomment the following line in the jvm.options file:

    ```
    #-Dcassandra.disable_auth_caches_remote_configuration=true
    ```

    After setting this option, cache options can only be set in the cassandra.yaml file. To make the new setting take effect, restart Cassandra.


**Parent topic:** [Internal authentication](../../cassandra/configuration/secureInternalAuthenticationTOC.md)

