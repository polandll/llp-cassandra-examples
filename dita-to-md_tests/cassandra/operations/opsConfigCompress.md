# Configuring compression {#opsConfigCompress .task}

Steps for configuring compression.

You configure a table property and subproperties to manage compression. The [CQL table properties documentation](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#tabProp__moreCompression) describes the types of compression options that are available. Compression is enabled by default.

1.  Disable compression, using CQL to set the compression parameter `enabled` to `false`.

    ```
    CREATE TABLE DogTypes (
                  block_id uuid,
                  species text,
                  alias text,
                  population varint,
                  PRIMARY KEY (block_id)
                )
                WITH compression = { 'enabled' : false };
    ```

2.  Enable compression on an existing table, using ALTER TABLE to set the compression algorithm `class` to LZ4Compressor \(Cassandra 1.2.2 and later\), SnappyCompressor, or DeflateCompressor.

    ```
    CREATE TABLE DogTypes (
                  block_id uuid,
                  species text,
                  alias text,
                  population varint,
                  PRIMARY KEY (block_id)
                )
                WITH compression = { 'class' : 'LZ4Compressor' };
    ```

3.  Change compression on an existing table, using ALTER TABLE and setting the compression algorithm `class` to `DeflateCompressor`.

    ```
    ALTER TABLE CatTypes
      WITH compression = { 'class' : 'DeflateCompressor', 'chunk_length_in_kb' : 64 }
    ```

    You tune data compression on a per-table basis using CQL to alter a table.


**Parent topic:** [Compression](../../cassandra/operations/opsAboutConfigCompress.md)

