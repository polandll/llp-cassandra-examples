DROP table if exists cycling.events;

CREATE TABLE cycling.events (
  year int,
  start_month int,
  start_day int,
  end_month int,
  end_day int,
  race text,
  discipline text,
  location text,
  uci_code text,
  PRIMARY KEY (
    (year, discipline), start_month, start_day, race
  )
);

source 'events-table-data.cql';

// Various queries removed.