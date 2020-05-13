# nodetool gettraceprobability {#toolsGetTraceProbability .reference}

Get the probability for tracing a request.

Get the current trace probability.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> gettraceprobability 
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Description {#description .section}

Provides the current trace probability. To set the trace probability, see [nodetool settraceprobability](toolsSetTraceProbability.md).

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

