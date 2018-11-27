
// START-keyspace
CREATE KEYSPACE user_info
  WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };
// END-keyspace

// START-table
CREATE TABLE user_info.users (
  id text PRIMARY KEY,
  name text,
  email text,
  skype text,
  irc text,
  twitter text
) ;
// END-table

// START-data
INSERT INTO user_info.users (id, name, email, skype, irc, twitter) VALUES
  ('user1', 'john smith', 'jsmith@abc.com', 'johnsmith', 'smitty', '@johnsmith');

INSERT INTO user_info.users (id, name, email, skype, irc, twitter) VALUES
  ('user2', 'elizabeth doe', 'lizzy@swbell.net', 'roadwarriorliz', 'elizdoe',  '@edoe576');

INSERT INTO user_info.users (id, name, email, skype, irc, twitter) VALUES
  ('user3', 'dan graham', 'etnaboy1@aol.com', 'danielgra', 'dgraham', '@dannyboy');

INSERT INTO user_info.users (id, name, email, skype, irc, twitter) VALUES
  ('user4', 'john smith', 'jonsmit@fyc.com', 'johnsmith', 'jsmith345', '@johnrsmith');

INSERT INTO user_info.users (id, name, email, skype, irc, twitter) VALUES
  ('user5', 'john smith', 'jds@adeck.net', 'jdsmith', 'jdansmith',  '@smithjd999');

INSERT INTO user_info.users (id, name, email, skype, irc, twitter) VALUES
  ('user6', 'dan graham', 'hacker@legalb.com', 'dangrah', 'dgraham', '@graham222');
// END-data

// START-index
CREATE SEARCH INDEX ON user_info.users;
// END-index

// START-field
ALTER SEARCH INDEX SCHEMA ON user_info.users 
ADD fields.field[ @name='all', 
                  @type='StrField', 
                  @multiValued='true'];
// END-field

// START-copyfield
ALTER SEARCH INDEX SCHEMA ON user_info.users 
   ADD copyField[@source='id', @dest='all'];
ALTER SEARCH INDEX SCHEMA ON user_info.users 
   ADD copyField[@source='name', @dest='all'];
ALTER SEARCH INDEX SCHEMA ON user_info.users 
  ADD copyField[@source='email', @dest='all'];
ALTER SEARCH INDEX SCHEMA ON user_info.users 
  ADD copyField[@source='skype', @dest='all'];
ALTER SEARCH INDEX SCHEMA ON user_info.users 
  ADD copyField[@source='irc', @dest='all'];
ALTER SEARCH INDEX SCHEMA ON user_info.users 
  ADD copyField[@source='twitter', @dest='all'];
// END-copyfield

// START-docvalues  
ALTER SEARCH INDEX SCHEMA ON user_info.users
  SET fields.field[@name='name']@docValues='true';
// END-docvalues

// START-config
ALTER SEARCH INDEX CONFIG ON user_info.users 
SET defaultQueryField = 'all';
// END-config

// START-reload
RELOAD SEARCH INDEX ON user_info.users;
// END-reload

// START-rebuild
REBUILD SEARCH INDEX ON user_info.users;
// END-rebuild

// START-simple
SELECT * FROM user_info.users WHERE solr_query = 'all:smitty';
// END-simple

// START-facet
SELECT name FROM user_info.users 
   WHERE solr_query= '{"q":"*","facet":{"field":"name","mincount":"1"}}';
// END-facet