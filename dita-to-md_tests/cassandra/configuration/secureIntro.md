# Securing Cassandra {#secureIntro .concept}

Cassandra provides various security features to the open source community.

Cassandra provides these security features to the open source community.

-   [Authentication based on internally controlled rolename/passwords](secureInternalAuthenticationTOC.md)

    Cassandra authentication is roles-based and stored internally in Cassandra system tables. Administrators can create, alter, drop, or list roles using CQL commands, with an associated password. Roles can be created with superuser, non-superuser, and login privileges. The internal authentication is used to access Cassandra keyspaces and tables, and by [cqlsh](/en/cql-oss/3.3/cql/cql_reference/cqlshCommandsTOC.html) and [DevCenter](/en/archived/developer/devcenter/doc) to authenticate connections to Cassandra clusters and [sstableloader](../tools/toolsBulkloader.md) to load SSTables.

-   [Authorization based on object permission management](secureInternalAuthorizationTOC.md) 

    Authorization grants access privileges to Cassandra cluster operations based on role authentication. Authorization can grant permission to access the entire database or restrict a role to individual table access. Roles can grant authorization to authorize other roles. Roles can be granted to roles. CQL commands GRANT and REVOKE are used to manage authorization.

-   [Authentication and authorization based on JMX username/passwords](secureJMXAuthenticationTOC.md)

    JMX \(Java Management Extensions\) technology provides a simple and standard way of managing and monitoring resources related to an instance of a Java Virtual Machine \(JVM\). This is achieved by instrumenting resources with Java objects known as Managed Beans \(MBeans\) that are registered with an MBean server. JMX authentication stores username and associated passwords in two files, one for passwords and one for access. JMX authentication is used by [nodetool](../tools/toolsNodetool.md) and external monitoring tools such as [jconsole](http://docs.oracle.com/javase/1.5.0/docs/guide/management/jconsole.html).In Cassandra 3.6 and later, JMX authentication and authorization can be accomplished using Cassandra's internal authentication and authorization capabilities.

-   [SSL encryption](secureSSLEncryptTOC.md)

    Cassandra provides secure communication between a client and a database cluster, and between nodes in a cluster. Enabling SSL encryption ensures that data in flight is not compromised and is transferred securely. Client-to-node and node-to-node encryption are independently configured. Cassandra tools \(cqlsh, nodetool, DevCenter\) can be configured to use SSL encryption. The DataStax drivers can be configured to secure traffic between the driver and Cassandra.

-   [General security measures](secureFireWall.md)

    Typically, production Cassandra clusters will have all non-essential firewall ports closed. Some ports must be open in order for nodes to communicate in the cluster. These ports are detailed.


**Parent topic:** [Security](../../cassandra/configuration/secureTOC.md)

