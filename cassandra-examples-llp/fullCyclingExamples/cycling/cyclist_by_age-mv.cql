// Source keyspace, tables, and insert data
SOURCE '0_create_keyspace.cql';
SOURCE 'cyclist_base-table.cql';
SOURCE 'cyclist_base_ext-table.cql';

// START-dropmv
DROP MATERIALIZED VIEW IF EXISTS cycling.cyclist_by_age;
// END-dropmv

//START-dropOtherMVs
DROP MATERIALIZED VIEW IF EXISTS cycling.cyclist_by_birthday_and_age;
DROP MATERIALIZED VIEW IF EXISTS cycling.cyclist_by_country_and_birthday;
DROP MATERIALIZED VIEW IF EXISTS cycling.cyclist_by_birthday_and_age19;
DROP MATERIALIZED VIEW IF EXISTS cycling.cyclist_by_age_birthday_cid;
//END-dropOtherMVs


// ORIGINAL MV
// START-age
CREATE MATERIALIZED VIEW cycling.cyclist_by_age 
   AS SELECT age, cid, birthday, country, name FROM cycling.cyclist_base 
WHERE age IS NOT NULL AND cid IS NOT NULL
PRIMARY KEY (age, cid)
WITH CLUSTERING ORDER BY (cid ASC)
     AND caching = { 'keys' : 'ALL', 'rows_per_partition' : '100' }
     AND comment = 'Based on table cyclist';
 // END-age

// ADD 2 non-PK columns
// START-MVtwoNonPKcols
CREATE MATERIALIZED VIEW cycling.cyclist_by_birthday_and_age
    AS SELECT age, cid, birthday, country, name FROM cycling.cyclist_base
    WHERE age IS NOT NULL AND birthday IS NOT NULL AND cid IS NOT NULL
    PRIMARY KEY (cid, birthday, age);
// END-MVtwoNonPKcols

// ADD 2 non-PK columns and specify one in the WHERE phrase
// START-MVtwoNonPKcolsWhereCountry
CREATE MATERIALIZED VIEW cycling.cyclist_by_country_and_birthday
    AS SELECT age, cid, birthday, country, name FROM cycling.cyclist_base
    WHERE birthday IS NOT NULL AND cid IS NOT NULL AND country='Australia'
    PRIMARY KEY (cid, country, birthday);
// END-MVtwoNonPKcolsWhereCountry

// ADD 2 non-PK columns and specify one in the WHERE phrase
// START-MVtwoNonPKcolsWhereAge
CREATE MATERIALIZED VIEW cycling.cyclist_by_birthday_and_age19
    AS SELECT age, cid, birthday, country, name FROM cycling.cyclist_base
    WHERE birthday IS NOT NULL AND cid IS NOT NULL AND age=19
    PRIMARY KEY (cid, birthday, age);
// END-MVtwoNonPKcolsWhereAge

// ADD multiple PK columns, but MV has different order for values
// START-MVmultPKcols
CREATE MATERIALIZED VIEW cycling.cyclist_by_age_birthday_cid
    AS SELECT age, cid, birthday, country, name FROM cycling.cyclist_base_ext
    WHERE age IS NOT NULL AND birthday IS NOT NULL AND cid IS NOT NULL
    PRIMARY KEY (age, birthday, cid);
// END-MVmultPKcols

// add a comment to describe the table
// START-comment
ALTER MATERIALIZED VIEW cycling.cyclist_by_age 
WITH comment = 'A most excellent and useful view'
AND bloom_filter_fp_chance = 0.02;
// END-comment

// alter example
// START-compression
ALTER MATERIALIZED VIEW cycling.cyclist_by_age 
WITH compression = { 
   'sstable_compression' : 'DeflateCompressor', 
   'chunk_length_kb' : 64 }
AND compaction = {
   'class': 'SizeTieredCompactionStrategy', 
   'max_threshold': 64};
// END-compression   

// alter example
// START-cache
ALTER MATERIALIZED VIEW cycling.cyclist_by_age 
WITH caching = { 
   'keys' : 'NONE', 
   'rows_per_partition' : '15' };
// END-cache

// START-test
INSERT INTO cycling.cyclist_base (cid,name,age,birthday,country) 
VALUES ( 
         d1aad83b-be60-47a4-bd6e-069b8da0d97b,
         'Johannes HEIDER', 
         27, 
         '1987-09-04',
         'Germany');
// END-test

// Add some data to cyclist_base
// START-cyclist_baseData
INSERT INTO cycling.cyclist_base (cid,name,age,birthday,country)
    VALUES (
        d1aad83b-be60-47a4-bd6e-069b8da0d97b,
        'Johannes HEIDER',
        27,
        '1987-09-04',
        'Germany');

INSERT INTO cycling.cyclist_base (cid,name,age,birthday,country)
    VALUES (
        1c526849-d3a2-42a3-bcf9-7903c80b3d16,
        'Kanden GROVES',
        19,
        '1998-12-23',
        'Australia');

INSERT INTO cycling.cyclist_base (cid,name,age,birthday,country)
    VALUES (
          96c4c40d-58c8-4710-b73f-681e9b1f70ae,
        'Benjamin DYBALL',
        29,
        '1989-04-20',
        'Australia');

INSERT INTO cycling.cyclist_base (cid,name,age,birthday,country)
    VALUES (
        410919ef-bd1b-4efa-8256-b0fd8ab67029,
        'Iskandarbek SHODIEV',
        19,
        '1999-01-04',
        'Uzbekistan');
// END-cyclist_baseData

// Add some data to cyclist_base_ext
// START-cyclist_base_extData
INSERT INTO cycling.cyclist_base_ext (cid,name,age,birthday,country)
    VALUES (
        d1aad83b-be60-47a4-bd6e-069b8da0d97b,
        'Johannes HEIDER',
        27,
        '1987-09-04',
        'Germany');

INSERT INTO cycling.cyclist_base_ext (cid,name,age,birthday,country)
    VALUES (
        1c526849-d3a2-42a3-bcf9-7903c80b3d16,
        'Kanden GROVES',
        19,
        '1998-12-23',
        'Australia');

INSERT INTO cycling.cyclist_base_ext (cid,name,age,birthday,country)
    VALUES (
          96c4c40d-58c8-4710-b73f-681e9b1f70ae,
        'Benjamin DYBALL',
        29,
        '1989-04-20',
        'Australia');

INSERT INTO cycling.cyclist_base_ext (cid,name,age,birthday,country)
    VALUES (
        410919ef-bd1b-4efa-8256-b0fd8ab67029,
        'Iskandarbek SHODIEV',
        19,
        '1999-01-04',
        'Uzbekistan');
// END-cyclist_base_extData

// SELECTS
// START-selectMVage
SELECT * FROM cycling.cyclist_by_age;
// END-selectMVage

// START-selectMVBdayAge
SELECT * FROM cycling.cyclist_by_birthday_and_age;
// END-selectMVBdayAge

// START-selectMVCountryBday
SELECT * FROM cycling.cyclist_by_country_and_birthday;
// END-selectMVCountryBday

// START-selectMVBdayAge19
SELECT * FROM cycling.cyclist_by_birthday_and_age19;
// END-selectMVBdayAge19

// START-MVAge19BdayCID
SELECT * FROM cycling.cyclist_by_age_birthday_cid WHERE age=19;
// END-MVAge19BdayCID

// START-MVAge19Bday19981223CID
SELECT * FROM cyclist_by_age_birthday_cid WHERE age=19 AND birthday='1998-12-23';
// END-MVAge19Bday19981223CID

// THIS ONE WILL ERROR OUT
// START-MVAgeBday19981223CID
 SELECT * FROM cyclist_by_age_birthday_cid WHERE birthday='1998-12-23';
// END-MVAgeBday19981223CID

