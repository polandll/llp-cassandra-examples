# Client-to-node encryption {#secureSSLClientToNode .task}

Client-to-node encryption protects data in flight from client machines to a database cluster using SSL \(Secure Sockets Layer\).

Client-to-node encryption protects data in flight from client machines to a database cluster using SSL \(Secure Sockets Layer\). It establishes a secure channel between the client and the coordinator node.

The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra.yaml|
|Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

[Prepare SSL certificates with a self-signed CA](secureSSLCertWithCA.md) for production, or [prepare SSL certificates](secureSSLCertificates.md) for development.

To enable client-to-node SSL, set the [client\_encryption\_options](configCassandra_yaml.md#client_encryption_options) in the cassandra.yaml file.

1.  On each node under client\_encryption\_options:
2.  Enable encryption.

3.  **Enable `client_encryption_options` on each node**
4.  Modify the cassandra.yaml file with the following settings:

    **For production clusters:**

    ```
    client_encryption_options:
        enabled: true
        # If enabled and optional is set to true encrypted and unencrypted connections are handled.
        optional: false
        keystore: /usr/local/lib/cassandra/conf/server-keystore.jks
        keystore_password: myKeyPass
        
        require_client_auth: true
        # Set trustore and truststore_password if require_client_auth is true
        truststore: /usr/local/lib/cassandra/conf/server-truststore.jks
        truststore_password: truststorePass
        protocol: TLS
        algorithm: SunX509
        store_type: JKS
        cipher_suites: [TLS_RSA_WITH_AES_256_CBC_SHA]
    ```

    ```

    ```

    This file uses the [certificates prepared with a self-signed CA](secureSSLCertWithCA.md).

    **For development clusters:**

    ```
    client_encryption_options:
        enabled: true
        # If enabled and optional is set to true encrypted and unencrypted connections are handled.
        optional: false
        keystore: conf/keystore.node0 
        keystore_password: cassandra
        
        require_client_auth: true
        # Set trustore and truststore_password if require_client_auth is true
        truststore: conf/truststore.node0
        truststore_password: cassandra
        protocol: TLS
        algorithm: SunX509
        store_type: JKS
        cipher_suites: [TLS_RSA_WITH_AES_256_CBC_SHA]
    ```

    This file uses the [certificates prepared for development](secureSSLCertificates.md).

    Set appropriate paths to the `keystore` and `truststore` files. Set the passwords to the passwords set during keystore and truststore generation. If two-way certificate authentication is desired, set `require_client_auth` to `true`. Enabling two-way certificate authentication allows tools to connect to a remote node. For local access to run `cqlsh` on a local node with SSL encryption, `require_client_auth` can be set to `false`

    Enabling client encryption will encrypt all traffic on the `native_transport_port` \(default: 9042\). If both encrypted and unencrypted traffic is required, an additional cassandra.yaml setting must be enabled. The `native_transport_port_ssl` \(default: 9142\) sets an additional dedicated port to carry encrypted transmissions, while `native_transport_port` carries unencrypted transmissions.

    **Note:** It is beneficial to install the Java Cryptography Extension \(JCE\) Unlimited Strength Jurisdiction Policy Files if this option is enabled.

5.  **Restart cassandra**
6.  Restart cassandra to make changes effective.

    ```language-bash
    kill -9 *cassandra\_pid*
    $ cassandra
    ```


**Parent topic:** [SSL encryption](../../cassandra/configuration/secureSSLEncryptTOC.md)

