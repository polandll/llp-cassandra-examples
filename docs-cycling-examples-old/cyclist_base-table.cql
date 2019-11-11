// This is not actually a part of the cycling database so

CREATE TABLE IF NOT EXISTS cycling.cyclist_base (
  cid UUID PRIMARY KEY,
  name text,
  age int,
  birthday date,
  country text
);

source 'cyclist_base-table-data.cql';

ALTER TABLE cycling.cyclist_base
WITH comment = 'basic cyclist information';

ALTER TABLE cycling.cyclist_base
WITH speculative_retry = '95percentile';

ALTER TABLE cycling.cyclist_base
WITH speculative_retry = '10ms';