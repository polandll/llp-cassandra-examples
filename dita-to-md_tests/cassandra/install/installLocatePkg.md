# Package installation directories {#installLocatePkg .reference}

Configuration files directory locations.

The configuration files are located in the following directories:

|Configuration Files|Locations|Description|
|-------------------|---------|-----------|
|cassandra.yaml|/etc/cassandra|Main configuration file.|
|cassandra-env.sh|/etc/cassandra|Linux settings for Java, some JVM, and JMX.|
|jvm.options|/etc/cassandra|Static JVM settings for heap, garbage collection, and Cassandra startup parameters.|
|cassandra.in.sh|/usr/share/cassandra|Sets environment variables.|
|cassandra-rackdc.properties|/etc/cassandra|Defines the default datacenter and rack used by the GossipingPropertyFileSnitch, Ec2Snitch, Ec2MultiRegionSnitch, and GoogleCloudSnitch.|
|cassandra-topology.properties|/etc/cassandra|Defines the default datacenter and rack used by the PropertyFileSnitch.|
|commit\_archiving.properties|/etc/cassandra|Configures commitlog archiving.|
|cqlshrc.sample|/etc/cassandra|Example file for using cqlsh with SSL encryption.|
|logback.xml|/etc/cassandra|Configuration file for logback.|
|triggers|/etc/cassandra|The default location for the trigger JARs.|

The packaged releases install into these directories:

|Directories|Description|
|-----------|-----------|
|/etc/default| |
|/etc/init.d/cassandra|Service startup script.|
|/etc/security/limits.d|Cassandra user limits.|
|/etc/cassandra|Configuration files.|
|/usr/bin|Binary files.|
|/usr/sbin| |
|/usr/share/doc/cassandra/examples|Sample yaml files for stress testing.|
|/usr/share/cassandra|JAR files and environment settings \(cassandra.in.sh\).|
|/usr/share/cassandra/lib|JAR files.|
|/var/lib/cassandra|Data, commitlog, and saved\_caches directories.|
|/var/log/cassandra|Log directory.|
|/var/run/cassandra|Runtime files.|

**Parent topic:** [Install locations](../../cassandra/install/installLocationsTOC.md)

