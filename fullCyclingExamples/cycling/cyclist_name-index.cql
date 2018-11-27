SOURCE 'cycling.cyclist_name-table.cql';

// START-prefix
CREATE CUSTOM INDEX fn_prefix 
   ON cycling.comments (commenter) 
   USING 'org.apache.cassandra.index.sasi.SASIIndex';
// END-prefix

// START-contains 
CREATE CUSTOM INDEX fn_contains 
   ON cycling.comments (comment) 
   USING 'org.apache.cassandra.index.sasi.SASIIndex'
   WITH OPTIONS = { 'mode': 'CONTAINS' };
// END-contains

// START-sparse
CREATE CUSTOM INDEX fn_sparse 
   ON cycling.comments (record_id) 
   USING 'org.apache.cassandra.index.sasi.SASIIndex'
   WITH OPTIONS = { 'mode': 'SPARSE' };
// END-sparse

// START-case
CREATE CUSTOM INDEX  fn_notcasesensitive 
ON cycling.comments (comment) 
USING 'org.apache.cassandra.index.sasi.SASIIndex'
WITH OPTIONS = { 
   'analyzer_class': 'org.apache.cassandra.index.sasi.analyzer.NonTokenizingAnalyzer',
   'case_sensitive': 'false'};
// END-case

// START-stdanalyzer
CREATE CUSTOM INDEX stdanalyzer_idx 
   ON cycling.comments (comment) 
   USING 'org.apache.cassandra.index.sasi.SASIIndex' 
   WITH OPTIONS = { 'mode': 'CONTAINS',
                    'analyzer_class': 'org.apache.cassandra.index.sasi.analyzer.StandardAnalyzer',
                    'analyzed': 'true',
                    'tokenization_skip_stop_words': 'and, the, or',
                    'tokenization_enable_stemming': 'true',
                    'tokenization_normalize_lowercase': 'true',
                    'tokenization_locale': 'en' }
;
// END-stdanalyzer

// START-dprefix
DROP INDEX fn_prefix;
// END-dprefix