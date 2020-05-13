# SSL encryption {#secureSSLEncryptTOC}

Topics for using SSL in Cassandra.

-   **[Encrypting Cassandra with SSL](../../cassandra/configuration/secureSSLIntro.md)**  
Cassandra can encrypt both internode and client-to-server communications using SSL.
-   **[Installing Java Cryptography Extension \(JCE\) Files](../../cassandra/configuration/installJCE.md)**  
Installing the Java Cryptography Extension \(JCE\) Unlimited Strength Jurisdiction Policy Files.
-   **[Preparing server certificates for development](../../cassandra/configuration/secureSSLCertificates.md)**  
Steps to generate SSL certificates for client-to-node encryption or node-to-node encryption in a development environment.
-   **[Preparing SSL certificates for production](../../cassandra/configuration/secureSSLCertWithCA.md)**  
Steps to generate SSL certificates for client-to-node encryption or node-to-node encryption using a self-signed Certificate Authority \(CA\) in a production environment.
-   **[Node-to-node encryption](../../cassandra/configuration/secureSSLNodeToNode.md)**  
Node-to-node \(internode\) encryption protects data transferred between nodes in a cluster, including gossip communications, using SSL \(Secure Sockets Layer\).
-   **[Client-to-node encryption](../../cassandra/configuration/secureSSLClientToNode.md)**  
Client-to-node encryption protects data in flight from client machines to a database cluster using SSL \(Secure Sockets Layer\).
-   **[Using cqlsh with SSL](../../cassandra/configuration/secureCqlshSSL.md)**  
Using a cqlshrc file with SSL encryption using a self-signed CA.
-   **[Using nodetool \(JMX\) with SSL encryption](../../cassandra/configuration/secureNodetoolSSL.md)**  
Using nodetool with SSL encryption.
-   **[Using jconsole \(JMX\) with SSL encryption](../../cassandra/configuration/secureJconsoleSSL.md)**  
Using jconsole with SSL encryption.

**Parent topic:** [Security](../../cassandra/configuration/secureTOC.md)

