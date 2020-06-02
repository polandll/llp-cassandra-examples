About Apache Cassandra
======================

Documentation for developers and administrators on installing,
configuring, and using the features and capabilities of Apache Cassandra
scalable open source NoSQL database.

About this document
-------------------

The latest version of Apache Cassandra™ 3.x is 3.11.5.

Welcome to the Cassandra documentation provided by DataStax. To ensure
that you get the best experience in using this document, take a moment
to look at the `Tips for using DataStax
documentation </en/landing_page/doc/landing_page/docTips.html>`__.

The `landing pages </en>`__ provide information about supported
platforms, product compatibility, planning and testing cluster
deployments, recommended production settings, third-party software,
resources for additional information, administrator and developer
topics, and earlier documentation.

Overview of Apache Cassandra
----------------------------

Apache Cassandra is a massively scalable open source NoSQL database.
Cassandra is perfect for managing large amounts of structured,
semi-structured, and unstructured data across multiple datacenters and
the cloud. Cassandra delivers continuous availability, linear
scalability, and operational simplicity across many commodity servers
with no single point of failure, along with a powerful dynamic data
model designed for maximum flexibility and fast response times.

The latest version of Apache Cassandra™ 3.x is 3.9.

How does Cassandra work?
------------------------

Cassandra’s built-for-scale architecture means that it is capable of
handling petabytes of information and thousands of concurrent
users/operations per second.

**Cassandra is a partitioned row store database**

\| Cassandra's architecture allows any `authorized
user <configuration/secureIntro.md>`__ to connect to any node in any
datacenter and access data using the CQL language. For ease of use, CQL
uses a similar syntax to SQL. The most basic way to interact with
Cassandra is using the CQL shell,
`cqlsh </en/cql-oss/3.3/cql/cql_using/useAboutCQL.html>`__. Using
``cqlsh``, you can create keyspaces and tables, insert and query tables,
plus much more. This Cassandra release works with `CQL for Cassandra 2.2
and later </en/cql-oss/3.3/index.html>`__. If you prefer a graphical
tool, you can use `DataStax
DevCenter </en/archived/developer/devcenter/doc/devcenter/features.html>`__.
For production, DataStax supplies a number
`drivers </en/developer/driver-matrix/doc/common/driverMatrix.html>`__
so that CQL statements can be passed from client to cluster and back.

\| \| **Automatic data distribution**

\| Cassandra provides automatic data distribution across all nodes that
participate in a *ring* or database cluster. There is nothing
programmatic that a developer or administrator needs to do or code to
distribute data across a cluster because data is transparently
partitioned across all nodes in a cluster.

\| \| **Built-in and customizable replication**

\| Cassandra also provides built-in and customizable replication, which
stores redundant copies of data across nodes that participate in a
Cassandra ring. This means that if any node in a cluster goes down, one
or more copies of that node’s data is available on other machines in the
cluster. Replication can be configured to work across one datacenter,
many datacenters, and multiple cloud availability zones.

\| \| **Cassandra supplies linear scalability**

\| Cassandra supplies linear scalability, meaning that capacity may be
easily added simply by adding new nodes online. For example, if 2 nodes
can handle 100,000 transactions per second, 4 nodes will support 200,000
transactions/sec and 8 nodes will tackle 400,000 transactions/sec:

\| \| \| |image0|

\|

How is Cassandra different from relational databases?
-----------------------------------------------------

Cassandra is designed from the ground up as a distributed database with
peer-to-peer communication. As a best practice, queries should be one
per table. Data is denormalized to make this possible. For this reason,
the concept of JOINs between tables does not exist, although client-side
joins can be used in applications.

What is NoSQL?
--------------

Most common translation is "Not only SQL", meaning a database that uses
a method of storage different from a relational, or SQL, database. There
are many different types of NoSQL databases, so a direct comparison of
even the most used types is not useful. Database administrators today
must be polyglot-friendly, meaning they must know how to work with many
different RDBMS and NoSQL databases.

What is CQL?
------------

`Cassandra Query Language (CQL) </en/cql-oss/3.3/cql/cqlIntro.html>`__
is the primary interface into the Cassandra DBMS. Using CQL is similar
to using SQL (Structured Query Language). CQL and SQL share the same
abstract idea of a table constructed of columns and rows. The main
difference from SQL is that Cassandra does not support joins or
subqueries. Instead, Cassandra emphasizes denormalization through CQL
features like collections and clustering specified at the schema level.

CQL is the recommended way to interact with Cassandra. Performance and
the simplicity of reading and using CQL is an advantage of modern
Cassandra over older Cassandra APIs.

The `CQL documentation </en/cql-oss/3.3/index.html>`__ contains a `data
modeling topic </en/cql-oss/3.3/cql/ddl/dataModelingApproach.html>`__,
examples, and command reference.

How do I interact with Cassandra?
---------------------------------

The most basic way to interact with Cassandra is using the CQL shell,
``cqlsh``. `Using
cqlsh </en/cql-oss/3.3/cql/cql_using/startCqlLinuxMac.html>`__, you can
create keyspaces and tables, insert and query tables, plus much more. If
you prefer a graphical tool, you can use
`DevCenter </en/archived/developer/devcenter/doc/devcenter/features.html>`__.
For production, DataStax supplies a number of
`drivers </en/developer/driver-matrix/doc/common/driverMatrix.html>`__
in various programming languages, so that CQL statements can be passed
from client to cluster and back.

How can I move data to/from Cassandra?
--------------------------------------

Data is inserted using the CQL INSERT command, the CQL COPY command and
CSV files, or `sstableloader <tools/toolsBulkloader.md>`__. But in
reality, you need to consider how your client application will query the
tables, and do data modeling first. The paradigm shift between
relational and NoSQL means that a straight move of data from an RDBMS
database to Cassandra will be doomed to failure.

What other tools come with Cassandra?
-------------------------------------

Cassandra automatically installs `nodetool <tools/toolsNodetool.md>`__,
a useful command-line management tool for Cassandra. A tool for
load-stressing and basic benchmarking,
`cassandra-stress <tools/toolsCStress.md>`__, is also installed by
default.

What kind of hardware/cloud environment do I need to run Cassandra?
-------------------------------------------------------------------

Cassandra is designed to run on `commodity
hardware </en/landing_page/doc/landing_page/planning/planningHardware.html>`__
with common specifications. In the cloud, Cassandra is adapted for most
common offerings.

-  **`What's new in Apache Cassandra 3.x <../cassandra/features.md>`__**
   An overview of new features in Apache Cassandra 3.x.

.. |image0| image:: images/intro_cassandra.png
