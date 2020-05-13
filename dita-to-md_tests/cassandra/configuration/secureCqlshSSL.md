# Using cqlsh with SSL {#secureCqlshSSL .task}

Using a cqlshrc file with SSL encryption using a self-signed CA.

Using a cqlshrc file is the easiest method of getting `cqlshrc` settings. The cqlshrc.sample provides an example that can be copied as a starting point.

The location of the cqlshrc.sample file depends on the type of installation:

|Package installations|/etc/cassandra/cqlshrc.sample|
|Tarball installations|install\_location/conf/cqlshrc.sample|

[Prepare SSL certificates with a self-signed CA](secureSSLCertWithCA.md) for production, or [prepare SSL certificates](secureSSLCertificates.md) for development. Additionally, configure [client-to-node encryption](secureSSLClientToNode.md).

1.  To run cqlsh with SSL encryption, create a .cassandra/cqlshrc file in your home or client program directory with the following settings:

    **For production clusters:**

    ```no-highlight
    [authentication]
    username = fred
    password = !!bang!!$
    
    [connection]
    hostname = 127.0.0.1
    port = 9042
    factory = cqlshlib.ssl.ssl_transport_factory
    
    [ssl]
    certfile = ~/.cassandra/rootCa.crt
    ;; Optional, true by default
    validate = true 
    
    ;; To be provided when require_client_auth=true
    userkey = ~/.cassandra/rootCa.key 
    
    ;; To be provided when require_client_auth=true
    usercert = ~/.cassandra/rootCa.crt
    ```

    This file uses the [certificates prepared with a self-signed CA](secureSSLCertWithCA.md).

    **For development clusters:**

    ```no-highlight
    [authentication]
    username = fred
    password = !!bang!!$
    
    [connection]
    hostname = 127.0.0.1
    port = 9042
    factory = cqlshlib.ssl.ssl_transport_factory
    
    [ssl]
    certfile = ~/keys/node0.cer.pem
    # Optional, true by default
    validate = true 
    # The next 2 lines must be provided when require_client_auth = true in the cassandra.yaml file
    userkey = ~/node0.key.pem 
    usercert = ~/node0.cer.pem 
    
    [certfiles]  
    # Optional section, overrides the default certfile in the [ssl] section for 2 way SSL
    172.31.10.22 = ~/keys/node0.cer.pem
    172.31.8.141 = ~/keys/node1.cer.pem
    ```

    This file uses the [certificates prepared for development](secureSSLCertificates.md). The use of the same IP addresses in the `[certfiles]` section, as is used to generate the *dname* of the certificates, is required for two-way SSL encryption. Each node must have a line in the `[certfiles]` section for client-to-remote-node or node-to-node.

    When `validate` is enabled, to verify that the certificate is trusted the host in the certificate is compared to the host of the machine to which it is connected. Note that the rootCa certificate and key are supplied to access the trustchain. The SSL certificate must be provided either in the configuration file or as an environment variable. The environment variables \(SSL\_CERTFILE and SSL\_VALIDATE\) override any options set in this file.

    **Note:** Additional settings in the cqlshrc file are described in [Creating and using the cqlshrc file](/en/cql-oss/3.3/cql/cql_reference/cqlshUsingCqlshrc.html).

    An optional section, `[certfiles]`, will override the default `certfile` in the `[ssl]` section. The use of the same IP addresses in the `[certfiles]` section, as is used to generate the `dname` of the certificates, is required for two-way SSL encryption. Each node must have a line in the `[certfiles]` section for client-to-remote-node or node-to-node. Using `certfiles]` is more common for development clusters.

2.  Start [cqlsh](/en/cql-oss/3.3/cql/cql_reference/cqlsh.html) with the --ssl option for `cqlsh` to local node encrypted connection.

    ```screen
    $ cqlsh --ssl ## Package installations
    $ install\_location/bin/cqlsh --ssl ## Tarball installations
    ```

3.  A username and password can also be supplied at [cqlsh](/en/cql-oss/3.3/cql/cql_reference/cqlsh.html) startup. This example provides the username *cassandra* with password *cassandra*.

    ```screen
    $ cqlsh --ssl ## Package installations
    $ install\_location/bin/cqlsh --ssl -u cassandra -p cassandra ## Tarball installations
    ```

    Note that a username and password can be entered in the cqlshrc file so that it will be automatically read each time `cqlsh` is started.

4.  For a remote node encrypted connection, start [cqlsh](/en/cql-oss/3.3/cql/cql_reference/cqlsh.html) with the --ssl option and an IP address:

    ```screen
    $ cqlsh --ssl ## Package installations
    $ install\_location/bin/cqlsh --ssl 172.31.10.22 ## Tarball installations
    ```


**Parent topic:** [SSL encryption](../../cassandra/configuration/secureSSLEncryptTOC.md)

