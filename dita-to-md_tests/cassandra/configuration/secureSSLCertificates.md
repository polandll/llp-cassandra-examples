# Preparing server certificates for development {#secureSSLCertificates .task}

Steps to generate SSL certificates for client-to-node encryption or node-to-node encryption in a development environment.

To use SSL encryption for client-to-node encryption or node-to-node encryption, SSL certificates must be generated using [keytool](http://docs.oracle.com/javase/8/docs/technotes/guides/security/SecurityToolsSummary.html). If you generate the certificates for one type of encryption, you do not need to generate them again for the other; the same certificates are used for both. All nodes must have all the relevant SSL certificates on all nodes. A keystore contains private keys. The truststore contains SSL certificates for each node. The certificates in the truststore don't require signing by a trusted and recognized public certification authority.

-   Generate a private and public key pair on each node of the cluster. Use an alias that identifies the node. Prompts for the keystore password, dname \(first and last name, organizational unit, organization, city, state, country\), and key password. The dname should be generated with the CN value as the IP address or FQDN for the node.

    ```language-bash
     keytool -genkey -keyalg RSA -alias node0 -validity 36500 -keystore keystore.node0
    ```

    **Note:** In this example, the value for `--validity` gives this key pair a validity period of 100 years. The default `validity` value for a key pair is 90 days.

-   The generation command can also include all prompted-for information in the command line. This example uses an alias of `node0`, a keystore name of `keystore.node0`, uses the same password of `cassandra` for both the keystore and the key, and a dname that identifies the IP address of node0 as `172.31.10.22`.

    ```language-bash
     keytool -genkey -keyalg RSA -alias node0 -keystore keystore.node0 -storepass cassandra -keypass cassandra -dname "CN=172.31.10.22, OU=None, O=None, L=None, C=None"
    ```

-   Export the public part of the certificate to a separate file.

    ```language-bash
     keytool -export -alias cassandra -file node0.cer -keystore .keystore
    ```

-   Add the `node0.cer` certificate to the node0 truststore of the node using the `keytool -import` command.

    ```language-bash
     keytool -import -v -trustcacerts -alias node0 -file node0.cer -keystore truststore.node0
    ```

-   `cqlsh` does not work with the certificate in the format generated. `openssl` is used to generate a PEM file of the certificate with no keys, `node0.cer.pem`, and a PEM file of the key with no certificate, `node0.key.pem`. First, the keystore is imported in PKCS12 format to a destination keystore, `node0.p12`, in the example. This is followed by the two commands that extract the two PEM files.

    ```language-bash
     keytool -importkeystore -srckeystore keystore.node0 -destkeystore node0.p12 -deststoretype PKCS12 -srcstorepass cassandra -deststorepass cassandra
    openssl pkcs12 -in node0.p12 -nokeys -out node0.cer.pem -passin pass:cassandra
    openssl pkcs12 -in node0.p12 -nodes -nocerts -out node0.key.pem -passin pass:cassandra
    ```

-   For client-to-remote-node encryption or node-to-node encryption, use a copying tool such as `scp` to copy the `node0.cer` file to each node. Import the file into the truststore after copying to each node. The example imports the certificate for node0 into the truststore for node1.

    ```language-bash
     keytool -import -v -trustcacerts -alias node0 -file node0.cer -keystore truststore.node1
    ```

-   Make sure keystore file is readable only to the Cassandra daemon and not by any user of the system.

-   Check that the certificates exist in the keystore and truststore files using `keytool -list`. The example shows checking for the node1 certificate in the keystore file and for the node0 and node1 certificates in the truststore file.

    ```language-bash
     keytool -list -keystore keystore.node1
    keytool -list -keystore truststore.node1
    ```

-   Import the user's certificate into every node's truststore using [keytool](http://docs.oracle.com/javase/8/docs/technotes/guides/security/SecurityToolsSummary.html):

    ```
    $  keytool -import -v -trustcacerts -alias <username> -file <certificate file> -keystore .truststore
    ```


**Parent topic:** [SSL encryption](../../cassandra/configuration/secureSSLEncryptTOC.md)

