SOURCE '0_create_keyspace.cql';

DROP TABLE IF EXISTS cycling.comments;

CREATE TABLE cycling.comments (
  record_id timeuuid,
  id uuid,
  commenter text,
  comment text,
  created_at timestamp,
  PRIMARY KEY (id, created_at))
WITH CLUSTERING ORDER BY (created_at DESC);

source 'comments-table-data.cql';

ALTER TABLE cycling.comments 
WITH compression = { 
   'sstable_compression' : 'DeflateCompressor', 
   'chunk_length_kb' : 64 };

ALTER TABLE cycling.comments 
   WITH caching = {
    'keys': 'NONE', 
    'rows_per_partition': 10 };

ALTER TABLE cycling.comments 
WITH COMPACTION = {
   'class': 'SizeTieredCompactionStrategy', 
   'enabled': 'false' };

ALTER TABLE cycling.comments 
WITH COMPACTION = {
   'class': 'SizeTieredCompactionStrategy', 
   'enabled': 'true' };