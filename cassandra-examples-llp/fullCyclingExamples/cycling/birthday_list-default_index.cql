CREATE KEYSPACE IF NOT EXISTS cycling WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };

SOURCE "birthday_list-table.cql";

// For different key-value pairs that you want specify a data types
// START-index-control-types
CREATE SEARCH INDEX ON cycling.birthday_list;
// END-index

// Return all fields that were indexed on a key
SELECT * FROM cycling.birthday_list WHERE solr_query = 'blist_age:*';
SELECT * FROM cycling.birthday_list WHERE solr_query = 'bday:*';

// Regular queries -- how do you query indexed maps?
SELECT * FROM cycling.birthday_list WHERE blist_['blist_age'] = '23';
SELECT * FROM cycling.birthday_list WHERE blist_['blist_nation'] = 'GERMANY';
SELECT * FROM cycling.birthday_list WHERE blist_['bday'] = '27/07/1992' ALLOW FILTERING;

// using search index
SELECT * FROM cycling.birthday_list WHERE solr_query = 'blist_age:23';
SELECT * FROM cycling.birthday_list WHERE solr_query = 'blist_nation:GERMANY';


