# nodetool proxyhistograms {#toolsProxyHistograms .reference}

Provides a histogram of network statistics.

Provides a histogram of network statistics at the time of the command.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> proxyhistograms
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

The output of this command shows the full request latency recorded by the coordinator. The output includes the percentile rank of read and write latency values for inter-node communication. Typically, you use the command to see if requests encounter a slow node.

## Examples {#examples .section}

This example shows the output from nodetool proxyhistograms after running 4,500 insert statements and 45,000 select statements on a three [ccm](https://github.com/pcmanus/ccm) node-cluster on a local computer.

```language-bash
nodetool proxyhistograms
```

```
proxy histograms
Percentile      Read Latency     Write Latency     Range Latency
                    (micros)          (micros)          (micros)
50%                  1502.50            375.00            446.00
75%                  1714.75            420.00            498.00
95%                 31210.25            507.00            800.20
98%                 36365.00            577.36            948.40
99%                 36365.00            740.60           1024.39
Min                   616.00            230.00            311.00
Max                 36365.00          55726.00          59247.00
```

In Cassandra 3.6 and later, three metrics have been added to the output:

-   CAS Read Latency
-   CAS Write Latency
-   View Write Latency

CAS Read and Write Latency provides data for Cassandra compare-and-set operations, while View Write Latency provides data for materialized view write operations. The results are slightly different from previous versions:

```
proxy histograms
Percentile       Read Latency      Write Latency      Range Latency   CAS Read Latency  CAS Write Latency View Write Latency
                     (micros)           (micros)           (micros)           (micros)           (micros)           (micros)
50%                    454.83             379.02            1955.67               0.00               0.00               0.00
75%                   1358.10             943.13            4055.27               0.00               0.00               0.00
95%                   3379.39           12108.97           20924.30               0.00               0.00               0.00
98%                   7007.51          155469.30           89970.66               0.00               0.00               0.00
99%                   8409.01          155469.30          155469.30               0.00               0.00               0.00
Min                     73.46             126.94             126.94               0.00               0.00               0.00
Max                  14530.76          155469.30          155469.30               0.00               0.00               0.00
```

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

