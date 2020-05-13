# Encrypting Cassandra with SSL {#secureSSLIntro .concept}

Cassandra can encrypt both internode and client-to-server communications using SSL.

The Secure Socket Layer \(SSL\) is a cryptographic protocol used to secure communications between computers. For reference, see [SSL in wikipedia](https://en.wikipedia.org/wiki/Transport_Layer_Security). Data is encrypted during communication to prevent accidental or deliberate attempts to read the data.

Briefly, SSL works in the following manner. Two entities, either software or hardware, that are communicating with one another. The entities an be a client and node or peers in a cluster. These entities must exchange information to set up trust between them. Each entity that will provide such information must have a generated key that consists of a private key that only the entity stores and a public key that can be exchanged with other entities. If the client wants to connect to the server, the client requests the secure connection and the server sends a certificate that includes its public key. The client checks the validity of the certificate by exchanging information with the server, which the server validates with its private key. If a two-way validation is desired, this process must be carried out in both directions. Private keys and certificates are stored in the *keystore* and public keys are stored in the *truststore*. For systems using a Certificate Authority \(CA\), the truststore can store certificates signed by the CA for verification. Both keystores and truststores have passwords assigned, referred to as the *keypass* and *storepass*.

Apache Cassandra provides these SSL encryption features for .

-   [Node-to-node encrypted communication](secureSSLNodeToNode.md)

    Node-to-node, or internode, encryption is used to secure data passed between nodes in a cluster.

-   [Client-to-node encrypted communication](secureSSLClientToNode.md)

    Client-to-node encryption is used to secure data passed between a client program, such as [cqlsh](secureCqlshSSL.md), [DevCenter](/en/archived/developer/devcenter/doc/devcenter/connecingClusterSsl.html), or [nodetool](secureNodetoolSSL.md), and the nodes in the cluster.


**Parent topic:** [SSL encryption](../../cassandra/configuration/secureSSLEncryptTOC.md)

