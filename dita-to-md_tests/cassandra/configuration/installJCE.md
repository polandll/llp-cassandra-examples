# Installing Java Cryptography Extension \(JCE\) Files {#installJCE .task}

Installing the Java Cryptography Extension \(JCE\) Unlimited Strength Jurisdiction Policy Files.

Installing the JCE Unlimited Strength Jurisdiction Policy Files can ensure support for all encryption algorithms when using Oracle Java with SSL on Apache Cassandra, and it highly recommended. The files must be installed on every node in the Cassandra cluster.

Some of the cipher suites in the default cassandra.yaml are included only in the Java Cryptography Extension \(JCE\) Unlimited Strength Jurisdiction Policy Files. To ensure support for all encryption algorithms, install the JCE Unlimited Strength Jurisdiction Policy Files.

The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra.yaml|
|Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

Install the JCE files using the appropriate method for your Cassandra installation:

-   Installing the JCE on RHEL-based systems
-   Install the EPEL repository:

    ```screen
    $ sudo yum install epel-release
    ```

-   Installing the JCE on Debian-based systems
-   Install JCE using [webupd8 PPA repository](http://www.webupd8.org/2014/03/how-to-install-oracle-java-8-in-debian.html):

    ```screen
    $ sudo apt-get install oracle-java8-unlimited-jce-policy
    ```

-   Installing the JCE using the Oracle jar files
-   Download the Cryptography Extension \(JCE\) Unlimited Strength Jurisdiction Policy Files from [Oracle Java SE download page](http://www.oracle.com/technetwork/java/javase/downloads/index.html).

-   Unzip the downloaded file.

-   Copy `local_policy.jar` and `US_export_policy.jar` to the `$JAVA_HOME/jre/lib/security` directory to overwrite the existing jar files.


**Parent topic:** [SSL encryption](../../cassandra/configuration/secureSSLEncryptTOC.md)

