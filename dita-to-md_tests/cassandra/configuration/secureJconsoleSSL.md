# Using jconsole \(JMX\) with SSL encryption {#secureJconsoleSSL .task}

Using jconsole with SSL encryption.

Using `jconsole` with SSL requires the same JMX changes to cassandra-env.sh as `nodetool`. See [using nodetool \(JMX\) with SSL encryption](secureNodetoolSSL.md). There is no need to create `nodetool-ssl.properties`, but the same JVM keystore and truststore options must be specified with `jconsole` on the command line.

The location of the cassandra-env.sh file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra-env.sh|
|Tarball installations|install\_location/conf/cassandra-env.sh|

[Prepare SSL certificates with a self-signed CA](secureSSLCertWithCA.md) for production, or [prepare SSL certificates](secureSSLCertificates.md) for development. Additionally, configure [client-to-node encryption](secureSSLClientToNode.md).

1.  Copy the keystore and truststore files created in the prerequisite to the node where jconsole will be run. In this example, the files are `server-keystore.jks` and `server-truststore.jks`.

2.  Run `jconsole` using the JVM options:

    ```screen
    jconsole -J-Djavax.net.ssl.keyStore=server-keystore.jks 
    -J-Djavax.net.ssl.keyStorePassword=myKeyPass 
    -J-Djavax.net.ssl.trustStore=server-truststore.jks 
    -J-Djavax.net.ssl.trustStorePassword=truststorePass
    ```

    If no errors occur, `jconsole` will start. If connecting to a remote node, enter the hostname and JMX port, in *Remote Process*. If using authentication, enter the username and password.


**Parent topic:** [SSL encryption](../../cassandra/configuration/secureSSLEncryptTOC.md)

