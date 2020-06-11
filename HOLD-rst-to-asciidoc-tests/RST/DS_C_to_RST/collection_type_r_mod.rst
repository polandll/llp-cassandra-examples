Collection type
===============

A collection column is declared using the collection type, followed by
another type.

A collection column is declared using the collection type, followed by
another type, such as ``int`` or ``text``, in angle brackets. For
example, you can `create a table <../cql_using/useCollections.md>`__
having a list of textual elements, a list of integers, or a list of some
other element types.

::

    list<text>
    list<int>

Collection types cannot be nested, but frozen collection types can be
nested inside frozen or non-frozen collections. For example, you may
define a list within a list, provided the inner list is frozen:

::

    list<frozen <list<int>>>

Indexes may be created on a collection column of any type.

Using frozen in a collection
----------------------------

A frozen value serializes multiple components into a single value.
Non-frozen types allow updates to individual fields. Cassandra treats
the value of a frozen type as a blob. The entire value must be
overwritten.

::

    column_name collection_type<data_type, frozen<column_name>>

For example:

::

    CREATE TABLE mykeyspace.users (
      id uuid PRIMARY KEY,
      name frozen <fullname>,
      direct_reports set<frozen <fullname>>,     // a collection set
      addresses map<text, frozen <address>>     // a collection map
      score set<frozen <set<int>>>              // a set with a nested frozen set
    );

**Parent topic:** `CQL data
types <../../cql/cql_reference/cql_data_types_c.md>`__
