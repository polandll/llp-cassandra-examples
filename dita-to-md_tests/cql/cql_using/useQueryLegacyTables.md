# Querying a legacy table {#useQueryLegacyTables .concept}

Using CQL, you can query a legacy table. A legacy table managed in CQL includes an implicit WITH COMPACT STORAGE directive.

Using a music service example, select all the columns in the playlists table that was created in CQL. This output appears:

```no-highlight

[default@music] GET playlists  [62c36092-82a1-3a00-93d1-46196ee77204];
                 =>  ( column =7db1a490-5878-11e2-bcfd-0800200c9a66:,value =,  timestamp =1357602286168000 ) 
                 =>  ( column =7db1a490-5878-11e2-bcfd-0800200c9a66:album,
                   value =4e6f204f6e6520526964657320666f722046726565,  timestamp =1357602286168000 )
                 .
                 .
                 .
                 =>  ( column =a3e64f8f-bd44-4f28-b8d9-6938726e34d4:title,
                   value =4c61204772616e6765,  timestamp =1357599350478000 )
                 Returned 16 results.
```

The output of cell values is unreadable because GET returns the values in byte format.

**Parent topic:** [Legacy tables](../../cql/cql_using/useLegacyTableTOC.md)

