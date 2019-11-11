source '0_create_keyspace.cql';

DROP TABLE IF EXISTS cycling.cyclist_category;

CREATE TABLE cycling.cyclist_category (
  category text,
  points int,
  id UUID,
  lastname text,
  PRIMARY KEY (category, points)
)
WITH CLUSTERING ORDER BY (points DESC);

source 'cyclist_category-table-data.cql';

// Other extaneous statements removed.