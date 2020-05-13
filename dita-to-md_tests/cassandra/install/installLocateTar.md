# Tarball installation directories {#installLocateTar .reference}

Configuration files directory locations.

The configuration files are located in the following directories:

|Configuration and sample files|Locations|Description|
|------------------------------|---------|-----------|
|cassandra.yaml|install\_location/conf|Main configuration file.|
|cassandra-env.sh|install\_location/conf|Linux settings for Java, some JVM, and JMX.|
|jvm.options|install\_location/conf|Static JVM settings for heap, garbage collection, and Cassandra startup parameters.|
|cassandra.in.sh|install\_location/bin|Sets environment variables.|
|cassandra-rackdc.properties|install\_location/conf|Defines the default datacenter and rack used by the GossipingPropertyFileSnitch, Ec2Snitch, Ec2MultiRegionSnitch, and GoogleCloudSnitch.|
|cassandra-topology.properties|install\_location/conf|Defines the default datacenter and rack used by the PropertyFileSnitch.|
|commit\_archiving.properties |install\_location/conf|Configures commitlog archiving.|
|cqlshrc.sample|install\_location/conf|Example file for using cqlsh with SSL encryption.|
|metrics-reporter-config-sample.yaml|install\_location/conf|Example file for configuring [metrics](http://wiki.apache.org/cassandra/Metrics) in Cassandra.|
|logback.xmlcat|install\_location/conf|Configuration file for logback.|
|triggers|install\_location/conf|The default location for the trigger JARs.|

The binary tarball releases install into the installation directory.

|Directories|Description|
|-----------|-----------|
|bin|Utilities and start scripts.|
|conf|Configuration files and environment settings.|
|data|Directory containing the files for commitlog, data, and saved\_caches \(unless set in cassandra.yaml.\)|
|interface|Thrift legacy API.|
|javadoc|Cassandra Java API documentation.|
|lib|JAR and license files.|
|tools|Cassandra tools and sample cassandra.yaml files for stress testing.|

**Parent topic:** [Install locations](../../cassandra/install/installLocationsTOC.md)

