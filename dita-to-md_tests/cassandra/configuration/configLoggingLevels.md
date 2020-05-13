# Configuring logging {#configLoggingLevels .concept}

Cassandra logging functionality using Simple Logging Facade for Java \(SLF4J\) with a logback backend.

Cassandra provides logging functionality using Simple Logging Facade for Java \(SLF4J\) with a [logback](http://logback.qos.ch/) backend. Logs are written to the system.log and debug.login the Cassandra logging directory. You can configure logging [programmatically](http://logback.qos.ch/manual/configuration.html) or manually. Manual ways to configure logging are:

-   Run the [nodetool setlogginglevel](../tools/toolsSetLogLev.md) command.
-   Configure the logback-test.xml or logback.xml file installed with Cassandra.
-   Use the [JConsole](../operations/opsMonitoring.md#opsMonitoringJconsole) tool to configure logging through JMX.

Logback looks for logback-test.xml first, and then for logback.xml file.

The location of the logback.xml file depends on the type of installation:

|Package installations|/etc/cassandra/logback.xml|
|Tarball installations|install\_location/conf/logback.xml|

The XML configuration files looks like this:

```
<configuration scan="true">
  <jmxConfigurator />
  <appender name="FILE" class="ch.qos.logback.core.rolling.RollingFileAppender">
    <file>${cassandra.logdir}/system.log</file>
    <rollingPolicy class="ch.qos.logback.core.rolling.FixedWindowRollingPolicy">
      <fileNamePattern>${cassandra.logdir}/system.log.%i.zip</fileNamePattern>
      <minIndex>1</minIndex>
      <maxIndex>20</maxIndex>
    </rollingPolicy>

    <triggeringPolicy class="ch.qos.logback.core.rolling.SizeBasedTriggeringPolicy">
      <maxFileSize>20MB</maxFileSize>
    </triggeringPolicy>
    <encoder>
      <pattern>%-5level [%thread] %date{ISO8601} %F:%L - %msg%n</pattern>
      <!-- old-style log format
      <pattern>%5level [%thread] %date{ISO8601} %F (line %L) %msg%n</pattern>
      -->
    </encoder>
  </appender>
  
  <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
    <encoder>
      <pattern>%-5level %date{HH:mm:ss,SSS} %msg%n</pattern>
    </encoder>
  </appender>
        
  <root level="INFO">
    <appender-ref ref="FILE" />
    <appender-ref ref="STDOUT" />
  </root>
  
  <logger name="com.thinkaurelius.thrift" level="ERROR"/>
</configuration>
```

The appender configurations specify where to print the log and its configuration. The first appender directs logs to a file. The second appender directs logs to the console. You can change the following logging functionality:

-   Rolling policy
    -   The policy for rolling logs over to an archive
    -   Location and name of the log file
    -   Location and name of the archive
    -   Minimum and maximum file size to trigger rolling
-   Format of the message
-   The log level

## Log levels {#configLogLevSec .section}

The valid values for setting the log level include ALL for logging information at all levels, TRACE through ERROR, and OFF for no logging. TRACE creates the most verbose log, and ERROR, the least.

-   ALL
-   TRACE
-   DEBUG
-   INFO \(Default\)
-   WARN
-   ERROR
-   OFF

**Note:** Increasing logging levels can generate heavy logging output on a moderately trafficked cluster.

You can use the nodetool getlogginglevels command to see the current logging configuration.

```language-bash
nodetool getlogginglevels
Logger Name                                        Log Level
ROOT                                               INFO
com.thinkaurelius.thrift                           ERROR
```

To add debug logging to a class permanently using the logback framework, use `nodetool setlogginglevel` to check you have the right class before you set it in the logback.xml file in install\_location/conf. Modify to include the following line or similar at the end of the file:

```screen
<logger name="org.apache.cassandra.gms.FailureDetector" level="DEBUG"/>
```

Restart the node to invoke the change.

## Migrating to logback from log4j {#configLoggingMigr .section}

If you upgrade from a previous version of Cassandra that used log4j, you can convert *log4j.properties* files to *logback.xml* using the logback [PropertiesTranslator](http://logback.qos.ch/translator/) web-application.

## Using log file rotation {#configLogFileRot .section}

The default policy rolls the system.log file after the size exceeds 20MB. Archives are compressed in zip format. Logback names the log files system.log.1.zip, system.log.2.zip, and so on. For more information, see [logback documentation](http://logback.qos.ch/manual/appenders.html#FixedWindowRollingPolicy).

## Enabling extended compaction logging {#enabling-extended-compaction-logging .section}

You can configure Casandra to collect in-depth information about compaction activity on a node, and write it to a dedicated log file. For details, see [Enabling extended compaction logging](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#compactSubprop__cqlTableCompSizeTieredCompactionStrategy).

**Parent topic:** [Configuration](../../cassandra/configuration/configTOC.md)

