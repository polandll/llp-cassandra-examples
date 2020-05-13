# Blob type {#blob_r .reference}

Cassandra blob data type represents a constant hexadecimal number.

The Cassandra blob data type represents a constant hexadecimal number defined as 0\[xX\]\(hex\)+ where hex is a hexadecimal character, such as \[0-9a-fA-F\]. For example, 0xcafe. The maximum theoretical size for a blob is 2 GB. The practical limit on blob size, however, is less than 1 MB. A blob type is suitable for storing a small image or short string.

## Blob conversion functions {#blob-conversion-functions .section}

These functions convert the native types into binary data \(blob\):

-   typeAsBlob\(value\)
-   blobAsType\(value\)

For every native, nonblob data type supported by CQL, the typeAsBlob function takes a argument of that data type and returns it as a blob. Conversely, the blobAsType function takes a 64-bit blob argument and converts it to a value of the specified data type, if possible.

This example shows how to use bigintAsBlob:

```
CREATE TABLE bios ( user_name varchar PRIMARY KEY, 
   bio blob
 );

INSERT INTO bios (user_name, bio) VALUES ('fred', bigintAsBlob(3));
 
SELECT * FROM bios;
 
 user_name | bio
-----------+--------------------
      fred | 0x0000000000000003
      
```

This example shows how to use blobAsBigInt.

```
ALTER TABLE bios ADD id bigint;

INSERT INTO bios (user_name, id) VALUES ('fred', blobAsBigint(0x0000000000000003));

SELECT * FROM bios;

 user_name | bio                | id
-----------+--------------------+----
      fred | 0x0000000000000003 |  3
```

**Parent topic:** [CQL data types](../../cql/cql_reference/cql_data_types_c.md)

