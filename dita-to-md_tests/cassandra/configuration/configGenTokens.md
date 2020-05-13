# Generating tokens {#configGenTokens .concept}

If not using virtual nodes \(vnodes\), you must calculate tokens for your cluster.

If not using virtual nodes \(vnodes\), you must calculate tokens for your cluster.

The following topics in the Cassandra 1.1 documentation provide conceptual information about tokens:

-   [Data Distribution in the Ring](/en/archived/cassandra/1.1/docs/cluster_architecture/partitioning.html#data-distribution-in-the-ring)
-   [Replication Strategy](/en/archived/cassandra/1.1/docs/cluster_architecture/replication.html#replication-strategy)

## About calculating tokens for single or multiple datacenters in Cassandra 1.2 and later {#calc-tokens-1.2 .section}

-   Single datacenter deployments: calculate tokens by dividing the hash range by the number of nodes in the cluster.
-   Multiple datacenter deployments: calculate the tokens for each datacenter so that the hash range is evenly divided for the nodes in each datacenter.

For more explanation, see be sure to read the conceptual information mentioned above.

The method used for calculating tokens depends on the type of partitioner:

## Calculating tokens for the Murmur3Partitioner {#calc-tokens-m3p .section}

Use this method for generating tokens when you are **not** using virtual nodes \(vnodes\) and using the [Murmur3Partitioner](../architecture/archPartitionerM3P.md) \(default\). This partitioner uses a maximum possible range of hash values from -263 to +263-1. To calculate tokens for this partitioner:

```language-bash
 python -c "print [str(((2**64 / number_of_tokens) * i) - 2**63) for i in range(number_of_tokens)]"
```

For example, to generate tokens for 6 nodes:

```language-bash
 python -c "print [str(((2**64 / 6) * i) - 2**63) for i in range(6)]"
```

The command displays the token for each node:

```screen
[ '-9223372036854775808', '-6148914691236517206', '-3074457345618258604', 
  '-2', '3074457345618258600', '6148914691236517202' ]
```

## Calculating tokens for the RandomPartitioner {#calculating-tokens-for-the-randompartitioner .section}

To calculate tokens when using the [RandomPartitioner](../architecture/archPartitionerRandom.md) in Cassandra 1.2 clusters, use the Cassandra 1.1 [Token Generating Tool](/en/archived/cassandra/1.1/docs/initialize/token_generation.html).

**Parent topic:** [Configuration](../../cassandra/configuration/configTOC.md)

