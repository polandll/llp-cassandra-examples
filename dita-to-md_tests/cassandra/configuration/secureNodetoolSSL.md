# Using nodetool \(JMX\) with SSL encryption {#secureNodetoolSSL .task}

Using nodetool with SSL encryption.

Using `nodetool` with SSL requires some JMX setup. Changes to cassandra-env.sh are required, and a configuration file, `~/.cassandra/nodetool-ssl.properties`, is created.

The location of the cassandra-env.sh file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra-env.sh|
|Tarball installations|install\_location/conf/cassandra-env.sh|

[Prepare SSL certificates with a self-signed CA](secureSSLCertWithCA.md) for production, or [prepare SSL certificates](secureSSLCertificates.md) for development. Additionally, configure [client-to-node encryption](secureSSLClientToNode.md).

1.  First, follow steps \#1-8 in [Enabling JMX authentication and authorization](secureJmxAuthentication.md) if authentication and authorization are required.

2.  To run `nodetool` with SSL encryption, some additional changes are required to cassandra-env.sh. The following settings must be added to the file. Use the file path to the keystore and truststore, and appropriate passwords for each file. These changes must be made on each node in the cluster.

    **For production:**

    ```
    JVM_OPTS="$JVM_OPTS -Dcom.sun.management.jmxremote.ssl=true"
      JVM_OPTS="$JVM_OPTS -Dcom.sun.management.jmxremote.ssl.need.client.auth=true"
      JVM_OPTS="$JVM_OPTS -Dcom.sun.management.jmxremote.registry.ssl=true"
      #JVM_OPTS="$JVM_OPTS -Dcom.sun.management.jmxremote.ssl.enabled.protocols=<enabled-protocols>"
      #JVM_OPTS="$JVM_OPTS -Dcom.sun.management.jmxremote.ssl.enabled.cipher.suites=<enabled-cipher-suites>"
      
      JVM_OPTS="$JVM_OPTS -Djavax.net.ssl.keyStore=/usr/local/lib/cassandra/conf/server-keystore.jks"
      JVM_OPTS="$JVM_OPTS -Djavax.net.ssl.keyStorePassword=myKeyPass"
      JVM_OPTS="$JVM_OPTS -Djavax.net.ssl.trustStore=/usr/local/lib/cassandra/conf/server-truststore.jks"
      JVM_OPTS="$JVM_OPTS -Djavax.net.ssl.trustStorePassword=truststorePass"
    ```

    **For development:**

    ```
       JVM_OPTS="$JVM_OPTS -Dcom.sun.management.jmxremote.ssl=true"
      JVM_OPTS="$JVM_OPTS -Dcom.sun.management.jmxremote.ssl.need.client.auth=true"
      JVM_OPTS="$JVM_OPTS -Dcom.sun.management.jmxremote.registry.ssl=true"
      #JVM_OPTS="$JVM_OPTS -Dcom.sun.management.jmxremote.ssl.enabled.protocols=<enabled-protocols>"
      #JVM_OPTS="$JVM_OPTS -Dcom.sun.management.jmxremote.ssl.enabled.cipher.suites=<enabled-cipher-suites>"
    
      JVM_OPTS="$JVM_OPTS -Djavax.net.ssl.keyStore=keystore.node0"
      JVM_OPTS="$JVM_OPTS -Djavax.net.ssl.keyStorePassword=cassandra"
      JVM_OPTS="$JVM_OPTS -Djavax.net.ssl.trustStore=truststore.node0"
      JVM_OPTS="$JVM_OPTS -Djavax.net.ssl.trustStorePassword=cassandra"
    ```

    Enable SSL for JMX by setting `com.sun.management.jmxremote.ssl` to `true`. If two-way certificate authentication is desired, set `com.sun.management.jmxremote.ssl.need.client.auth` to `true`. If `com.sun.management.jmxremote.registry.ssl` is set to `true`, an RMI registry protected by SSL will be created and configured by the out-of-the-box management agent when the Java VM is started. If the `com.sun.management.jmxremote.registry.ssl` property is set to `true`, to have full security then `com.sun.management.jmxremote.ssl.need.client.auth` must also be enabled. Set appropriate paths to the `keystore` and `truststore` files. Set the passwords to the passwords set during keystore and truststore generation.

3.  [Restart Cassandra](../initialize/referenceStartStopTOC.md).

4.  To run `nodetool` with SSL encryption, create a `.cassandra/nodetool-ssl.properties` file in your home or client program directory with the following settings on the node on which `nodetool` will run.

    **For production:**

    ```
    -Dcom.sun.management.jmxremote.ssl=true
    -Dcom.sun.management.jmxremote.ssl.need.client.auth=true
    -Dcom.sun.management.jmxremote.registry.ssl=true  
    -Djavax.net.ssl.keyStore=/usr/local/lib/cassandra/conf/server-keystore.jks
    -Djavax.net.ssl.keyStorePassword=myKeyPass
    -Djavax.net.ssl.trustStore=/usr/local/lib/cassandra/conf/server-truststore.jks
    -Djavax.net.ssl.trustStorePassword=truststorePass
    ```

    **For development:**

    ```
    -Djavax.net.ssl.keyStore=keystore.node0
    -Djavax.net.ssl.keyStorePassword=cassandra
    -Djavax.net.ssl.trustStore=truststore.node0
    -Djavax.net.ssl.trustStorePassword=cassandra
    -Dcom.sun.management.jmxremote.ssl.need.client.auth=true
    -Dcom.sun.management.jmxremote.registry.ssl=true
    ```

5.  Start `nodetool` with the --ssl option for encrypted connection for any `nodetool` operation.

    ```screen
    $ nodetool --ssl info ## Package installations
    $ install\_location/bin/nodetool -ssl info ## Tarball installations
    ```

6.  Start `nodetool` with the --ssl option for encrypted connection and a username and password for authentication and authorization for any `nodetool` operation.

    ```screen
    $ nodetool --ssl -u cassandra -pw cassandra status ## Package installations
    $ install\_location/bin/nodetool -ssl -u cassandra -pw cassandra status ## Tarball installations
    ```


**Parent topic:** [SSL encryption](../../cassandra/configuration/secureSSLEncryptTOC.md)

