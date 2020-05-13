# nodetool settraceprobability {#toolsSetTraceProbability .reference}

Sets the probability for tracing a request.

Sets the probability for tracing a request.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> settraceprobability *--* <value>
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|value|Trace probability between 0 and 1. For example: 0.2.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Description {#description .section}

Probabilistic tracing is useful to determine the cause of intermittent query performance problems by identifying which queries are responsible. This option traces some or all statements sent to a cluster. Tracing a request usually requires at least 10 rows to be inserted.

A probability of 1.0 will trace everything whereas lesser amounts \(for example, 0.10\) only sample a certain percentage of statements. Care should be taken on large and active systems, as system-wide tracing will have a performance impact. Unless you are under very light load, tracing all requests \(probability 1.0\) will probably overwhelm your system. Start with a small fraction, for example, 0.001 and increase only if necessary. The trace information is stored in a system\_traces keyspace that holds two tables – sessions and events, which can be easily queried to answer questions, such as what the most time-consuming query has been since a trace was started. Query the parameters map and thread column in the system\_traces.sessions and events tables for probabilistic tracing information.

To discover the current trace probability setting, use [nodetool gettraceprobability](toolsGetTraceProbability.md).

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

