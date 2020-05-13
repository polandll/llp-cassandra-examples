# Enabling JMX authentication and authorization {#secureJmxAuthentication .task}

Steps to enable remote JMX connections.

By default, JMX security is disabled and accessible only from *localhost* without authentication as shown in the following lines from the cassandra-env.sh file:

```no-highlight
if [ "$LOCAL_JMX" = "yes" ]; then
  JVM_OPTS="$JVM_OPTS -Dcassandra.jmx.local.port=$JMX_PORT -XX:+DisableExplicitGC"
```

Configuring JMX authentication and authorization can be accomplished using local password and access files to set the usernames, passwords and access permissions. In Cassandra 3.6 and later, Cassandra's internal authentication and authorization can optionally be configured for JMX security.

These two methods work for remote authentication and authorization; the difference is just the location of the configuration settings in the cassandra-env.sh file. Local configuration is placed within the `if ["$LOCAL_JMX" = "yes']; then` block in the file, whereas remote configuration is placed with the `else` block.

-   **AUTHENTICATION AND AUTHORIZATION USING LOCAL FILES**
-   By default, JMX security is disabled and accessible only from *localhost* as shown in the following lines from the cassandra-env.sh file:

    ```no-highlight
    if [ "$LOCAL_JMX" = "yes" ]; then
      JVM_OPTS="$JVM_OPTS -Dcassandra.jmx.local.port=$JMX_PORT -XX:+DisableExplicitGC"
    ```

-   Change `$LOCAL_JMX` to `no`. Add the following lines in the remote block in the cassandra-env.sh file:

    ```no-highlight
    JVM_OPTS="$JVM_OPTS -Dcom.sun.management.jmxremote.authenticate=true"
      JVM_OPTS="$JVM_OPTS -Dcom.sun.management.jmxremote.password.file=/etc/cassandra/jmxremote.password"
    JVM_OPTS="$JVM_OPTS -Dcom.sun.management.jmxremote.access.file=/etc/cassandra/jmxremote.access"
    ```

-   Create a password file and add the user and password for JMX-compliant utilities, specifying the credentials for your environment. The default location of the password file in the cassandra-env.sh is /etc/cassandra/jmxremote.password.

    ```
    cassandra cassandra
    <new_superuser> <new_superuser_password>
    <some_other_user> <some_other_user_password>
    controlRole someOtherHardToRememberPassword
    ```

    **Important:** The default superuser account is a security hazard! This account is used only for the purposes of illustration.

-   The password file must be secured from unauthorized readers. Change the ownership of the jmxremote.password file to the user who starts `cassandra` and change permissions to read only:

    ```screen
    $ chown cassandra:cassandra /etc/cassandra/jmxremote.password
    $ chmod 400 /etc/cassandra/jmxremote.password
    ```

    This example presumes that `cassandra` is run by the default user `cassandra`.

-   Create an access file and enter the following information. The default location of the access file in the cassandra-env.sh is /etc/cassandra/jmxremote.access.

    ```
    cassandra readwrite
    <new_superuser> readwrite
    <some_other_user> readonly
    controlRole readwrite \
    create javax.management.monitor.,javax.management.timer. \
    unregister
    ```

    **Important:** The default superuser account is a security hazard! This account is used only for the purposes of illustration.

    The `readonly` permission allows the JMX client to read an MBean's attributes and receive notifications. The `readwrite` permission allows the JMX client to set attributes, invoke operations, and create and remove MBeans, in addition to reading an MBean's attributes and receives notifications.

-   The access file must be secured from unauthorized readers. Change the ownership of the jmxremote.access file to the user who starts `cassandra` and change permissions to read only:

    ```screen
    $ chown cassandra:cassandra /etc/cassandra/jmxremote.access
    $ chmod 400 /etc/cassandra/jmxremote.access
    ```

    This example presumes that `cassandra` is run by the default user `cassandra`.

-   [Restart Cassandra](../initialize/referenceStartStopTOC.md) to make the change effective.

-   Check that `nodetool status` requires the username and password in order to execute. The command should fail without authentication if everything is configured correctly.

    ```language-bash
    nodetool status
    ```

-   Run nodetool status with the cassandra user and password.

    ```language-bash
    nodetool -u cassandra -pw cassandra status
    ```

-   **AUTHENTICATION AND AUTHORIZATION WITH CASSANDRA INTERNALS - CASSANDRA 3.6 AND LATER**
-   By default, JMX security is disabled and accessible only from *localhost* as shown in the following lines from the cassandra-env.sh file:

    ```no-highlight
    if [ "$LOCAL_JMX" = "yes" ]; then
      JVM_OPTS="$JVM_OPTS -Dcassandra.jmx.local.port=$JMX_PORT -XX:+DisableExplicitGC"
    ```

    ```

    ```

-   Comment out the existing line and add or uncomment the following lines in either the local or remote block in the cassandra-env.sh file:

    ```no-highlight
    JVM_OPTS="$JVM_OPTS -Dcom.sun.management.jmxremote.authenticate=true"
    JVM_OPTS="$JVM_OPTS -Dcassandra.jmx.remote.login.config=CassandraLogin"'
    JVM_OPTS="$JVM_OPTS -Djava.security.auth.login.config=$CASSANDRA_HOME/conf/cassandra-jaas.config"
    JVM_OPTS="$JVM_OPTS -Dcassandra.jmx.authorizer=org.apache.cassandra.auth.jmx.AuthorizationProxy"
    ```

-   And comment out the following lines in the cassandra-env.sh file:

    ```no-highlight
    JVM_OPTS="$JVM_OPTS -Dcom.sun.management.jmxremote.password.file=/etc/cassandra/jmxremote.password"
    JVM_OPTS="$JVM_OPTS -Dcom.sun.management.jmxremote.access.file=/etc/cassandra/jmxremote.access"
    ```

-   Change authentication in the cassandra.yaml file to `PasswordAuthenticator`.

    ```
    authenticator: PasswordAuthenticator
    ```

-   Change authorization in the cassandra.yaml file to `CassandraAuthorizer`.

    ```
    authorizer: CassandraAuthorizer
    ```

-   [Restart Cassandra](../initialize/referenceStartStopTOC.md) to make the change effective.

-   Check that `nodetool status` requires the username and password in order to execute. The command should fail without authentication if everything is configured correctly.

    ```screen
    $ nodetool -u cassandra -pw cassandra status
    ```

    The location of the cassandra-env.sh file depends on the type of installation:

        |Package installations|/etc/cassandra/cassandra-env.sh|
    |Tarball installations|install\_location/conf/cassandra-env.sh|

-   [Cassandra authorization](secureConfigInternalAuth.md) can be used to grant and revoke permissions to database objects, including MBeans.

-   **SPECIFYING JMX AUTHENTICATION ON COMMAND LINE**
-   Generally, JMX settings are inserted into the cassandra-env.sh file. However, these options can be specified at the command line:

    ```no-highlight
    cassandra -Dcom.sun.management.jmxremote.authenticate=true
      -Dcom.sun.management.jmxremote.password.file=/etc/cassandra/jmxremote.password
    ```


If you run nodetool status without user and password when authentication and authorization are configured, you'll see an error similar to:

```
Exception in thread "main" java.lang.SecurityException: Authentication failed! Credentials required
at com.sun.jmx.remote.security.JMXPluggableAuthenticator.authenticationFailure(Unknown Source)
at com.sun.jmx.remote.security.JMXPluggableAuthenticator.authenticate(Unknown Source)
at sun.management.jmxremote.ConnectorBootstrap$AccessFileCheckerAuthenticator.authenticate(Unknown Source)
at javax.management.remote.rmi.RMIServerImpl.doNewClient(Unknown Source)
at javax.management.remote.rmi.RMIServerImpl.newClient(Unknown Source)
at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
at sun.reflect.NativeMethodAccessorImpl.invoke(Unknown Source)
at sun.reflect.DelegatingMethodAccessorImpl.invoke(Unknown Source)
at java.lang.reflect.Method.invoke(Unknown Source)
at sun.rmi.server.UnicastServerRef.dispatch(Unknown Source)
at sun.rmi.transport.Transport$1.run(Unknown Source)
at sun.rmi.transport.Transport$1.run(Unknown Source)
at java.security.AccessController.doPrivileged(Native Method)
at sun.rmi.transport.Transport.serviceCall(Unknown Source)
at sun.rmi.transport.tcp.TCPTransport.handleMessages(Unknown Source)
at sun.rmi.transport.tcp.TCPTransport$ConnectionHandler.run0(Unknown Source)
at sun.rmi.transport.tcp.TCPTransport$ConnectionHandler.run(Unknown Source)
at java.util.concurrent.ThreadPoolExecutor.runWorker(Unknown Source)
at java.util.concurrent.ThreadPoolExecutor$Worker.run(Unknown Source)
at java.lang.Thread.run(Unknown Source)
at sun.rmi.transport.StreamRemoteCall.exceptionReceivedFromServer(Unknown Source)
at sun.rmi.transport.StreamRemoteCall.executeCall(Unknown Source)
at sun.rmi.server.UnicastRef.invoke(Unknown Source)
at javax.management.remote.rmi.RMIServerImpl_Stub.newClient(Unknown Source)
at javax.management.remote.rmi.RMIConnector.getConnection(Unknown Source)
at javax.management.remote.rmi.RMIConnector.connect(Unknown Source)
at javax.management.remote.JMXConnectorFactory.connect(Unknown Source)
at org.apache.cassandra.tools.NodeProbe.connect(NodeProbe.java:146)
at org.apache.cassandra.tools.NodeProbe.<init>(NodeProbe.java:116)
at org.apache.cassandra.tools.NodeCmd.main(NodeCmd.java:1099)
```

**Parent topic:** [JMX authentication and authorization](../../cassandra/configuration/secureJMXAuthenticationTOC.md)

