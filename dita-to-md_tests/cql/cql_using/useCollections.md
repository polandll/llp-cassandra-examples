# Creating collections {#useCollections .concept}

Collection types provide a way to group and store data together in a table column.

Cassandra provides collection types as a way to group and store data together in a column. For example, in a relational database a grouping such as a user's multiple email addresses is related with a many-to-one joined relationship between a user table and an email table. Cassandra avoids joins between two tables by storing the user's email addresses in a collection column in the user table. Each collection specifies the data type of the data held.

A collection is appropriate if the data for collection storage is limited. If the data has unbounded growth potential, like messages sent or sensor events registered every second, do not use collections. Instead, use a table with a [compound primary key](useCompoundPrimaryKeyConcept.md) where data is stored in the clustering columns.

CQL contains these collection types:

-   [set](useSet.md)
-   [list](useList.md)
-   [map](useMap.md)

Observe the following limitations of collections:

-   Never insert more than 2 billion items in a collection, as only that number can be queried.
-   The maximum number of keys for a `map` collection is 65,535.
-   The maximum size of an item in a `list` or a `map` collection is 2GB.
-   The maximum size of an item in a `set` collection is 65,535 bytes.
-   Keep collections small to prevent delays during querying.

    Collections cannot be "sliced"; Cassandra reads a collection in its entirety, impacting performance. Thus, collections should be much smaller than the maximum limits listed. The collection is not paged internally.

-   Lists can incur a read-before-write operation for some insertions. Sets are preferred over lists whenever possible.

**Note:** The limits specified for collections are for non-frozen collections.

You can [expire each element](useExpire.md) of a collection by setting an individual time-to-live \(TTL\) property.

Also see [Using frozen in a collection](../cql_reference/collection_type_r.md#using-frozen-in-collection).

-   **[Creating the set type](../../cql/cql_using/useSet.md)**  
 Using the set data type, store unordered multiple items.
-   **[Creating the list type](../../cql/cql_using/useList.md)**  
Use a list when the order of elements matter or when you need to store same value multiple times.
-   **[Creating the map type](../../cql/cql_using/useMap.md)**  
 Use a map when pairs of related elements must be stored as a key-value pair.

**Parent topic:** [Creating advanced data types in tables](../../cql/cql_using/useAdvancedDataTypesTOC.md)

