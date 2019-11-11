SOURCE "birthday_list-table.cql";

// START-index
CREATE SEARCH INDEX ON cycling.birthday_list WITH COLUMNS blist_ {excluded:true};
// END-index

// Add types
ALTER SEARCH INDEX SCHEMA ON cycling.birthday_list ADD types.fieldType[@class='org.apache.solr.schema.TrieIntField', @name='TrieIntField'];

// Control the data types of map fields by name
ALTER SEARCH INDEX SCHEMA ON cycling.birthday_list ADD fields.field[@indexed='true', @multiValued='false', @name='blist_age', @type='TrieIntField'];
ALTER SEARCH INDEX SCHEMA ON cycling.birthday_list ADD fields.field[@name='blist_nation', @indexed='true', @multiValued='false', @type='StrField'];

// Make the pending schema active and rebuild the index
RELOAD SEARCH INDEX ON cycling.birthday_list;
REBUILD SEARCH INDEX ON cycling.birthday_list;

// Regular queries -- how do you query indexed maps?
SELECT * FROM cycling.birthday_list WHERE blist_['blist_age'] = '23';
SELECT * FROM cycling.birthday_list WHERE blist_['blist_nation'] = 'GERMANY';

// using search index
SELECT * FROM cycling.birthday_list WHERE solr_query = 'blist_age:23';
SELECT * FROM cycling.birthday_list WHERE solr_query = 'blist_nation:GERMANY';