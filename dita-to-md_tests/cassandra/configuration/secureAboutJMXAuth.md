# JMX Authentication and Authorization {#secureAboutJMXAuth .concept}

JMX authentication is based on either JMX usernames and passwords or Cassandra-controlled roles and passwords.

JMX authentication and authorization allows selective users to access JMX tools and JMX metrics. In Cassandra 3.5 and earlier, JMX is configured with password and access files. In Cassandra 3.6 and later, JMX connections can use the same internal authentication and authorization mechanisms as CQL clients.

If usernames and passwords exist and Cassandra is configured to use authentication and authorization, JMX tools must be executed with authentication and authorization options.

-   [nodetool with authentication](secureNodetool.md)
-   [jconsole with authentication](secureJconsole.md)

**Parent topic:** [JMX authentication and authorization](../../cassandra/configuration/secureJMXAuthenticationTOC.md)

