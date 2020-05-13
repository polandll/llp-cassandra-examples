# Node-to-node encryption {#secureSSLNodeToNode .task}

Node-to-node \(internode\) encryption protects data transferred between nodes in a cluster, including gossip communications, using SSL \(Secure Sockets Layer\).

Node-to-node encryption protects data transferred between nodes in a cluster, including gossip communications, using SSL \(Secure Sockets Layer\).

[Prepare SSL certificates with a self-signed CA](secureSSLCertWithCA.md) for production, or [prepare SSL certificates](secureSSLCertificates.md) for development.

To enable node-to-node SSL, you must set the [server\_encryption\_options](configCassandra_yaml.md#server_encryption_options) in the cassandra.yaml file.

The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra.yaml|
|Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

1.  **Enable `server_encryption_options` on each node**
2.  Modify the cassandra.yaml file with the following settings:

    **For production clusters:**

    ```
    server_encryption_options:
        internode_encryption: all
        keystore: /usr/local/lib/cassandra/conf/server-keystore.jks
        keystore_password: myKeyPass
        truststore: /usr/local/lib/cassandra/conf/server-truststore.jks
        truststore_password: truststorePass
        # More advanced defaults below:
        protocol: TLS
        algorithm: SunX509
        store_type: JKS
        cipher_suites: [TLS_RSA_WITH_AES_256_CBC_SHA]
        require_client_auth: true
    ```

    This file uses the [certificates prepared with a self-signed CA](secureSSLCertWithCA.md).

    **Note:** `cipher_suites` can be [configured for FIPS-140 compliance](configCassandra_yaml.md#server_encryption_options) if required.

    **For development clusters:**

    ```
    server_encryption_options:
        internode_encryption: all
        keystore: /conf/keystore.node0
        keystore_password: cassandra
        truststore: /conf/truststore.node0
        truststore_password: cassandra
        # More advanced defaults below:
        protocol: TLS
        algorithm: SunX509
        store_type: JKS
        cipher_suites: [TLS_RSA_WITH_AES_256_CBC_SHA]
        require_client_auth: true
    ```

    This file uses the [certificates prepared for development](secureSSLCertificates.md).

    Internode encryption can be set to four different choices:

     all
     :   All traffic is encrypted.

      none
     :   No traffic is encrypted.

      dc
     :   Traffic between datacenters is encrypted.

      rack
     :   Traffic between racks is encrypted.

     Set appropriate paths to the `keystore` and `truststore` files. Set the passwords to the passwords set during keystore and truststore generation. If two-way certificate authentication is desired, set `require_client_auth` to `true`.

3.  **Restart cassandra**
4.  Restart cassandra to make changes effective.

    ```language-bash
    kill -9 *cassandra\_pid*
    $ cassandra
    ```

5.  Check the logs to discover if SSL encryption has been started. On Linux, use the `grep` command:

    ```language-bash
    grep SSL *install\_location*/logs/system.log
    
    ```

    ```screen
    grep SSL %CASSANDRA\_HOME%\logs\system.log
    ```

    The resulting line will be similar to this example:

    ```
    INFO  [main] 2016-09-12 18:34:14,478 MessagingService.java:511 - Starting Encrypted Messaging Service on SSL port 7001
    ```


**Parent topic:** [SSL encryption](../../cassandra/configuration/secureSSLEncryptTOC.md)

