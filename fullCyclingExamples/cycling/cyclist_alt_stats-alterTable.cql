// ALTER TABLE
// ADD COLUMN
SOURCE 'cyclist_alt_stats-table.cql';

ALTER TABLE cycling.cyclist_alt_stats ADD age int;

// ALTER TABLE WITH COLLECTION
SOURCE 'upcoming_calendar-table.cql';

// START-collection
ALTER TABLE cycling.upcoming_calendar ADD description map<text,text>;
// END-collection

SOURCE 'cycling.cyclist_alt_stats-table.cql';

// ALTER TABLE AND ALTER COLUMN TYPE

// ADDS COLUMN as varchar and then changes it to text

// START-textcolumn
ALTER TABLE cycling.cyclist_alt_stats ADD favorite_color varchar;
// END-textcolumn

// START-typechange
ALTER TABLE cycling.cyclist_alt_stats ALTER favorite_color TYPE text;
// END-typechange

// Change compression
SOURCE 'cycling_comments-table.cql';

// START-compression
ALTER TABLE cycling.cycling_comments
WITH compression = {
   'sstable_compression' : 'DeflateCompressor',
   'chunk_length_kb' : 64 };
// END-compression
