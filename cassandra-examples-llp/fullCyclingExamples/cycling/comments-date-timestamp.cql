SOURCE 'comments-table.cql'


// START-removedata
TRUNCATE cycling.comments;
// END-removedata


/* CURRENT DATE */

// START-now_date
INSERT INTO cycling.comments (
   id,
   created_at)
values (
     e7ae5cf3-d358-4d99-b900-85902fda9bb0,
     toTimeStamp(toDate(now())));
// END-now_date

// START-snow_date
SELECT created_at FROM cycling.comments
WHERE id = e7ae5cf3-d358-4d99-b900-85902fda9bb0
LIMIT 1;
// END-snow_date

// START-rnow_date
created_at
---------------------------------
2017-06-01 00:00:00.000000+0000

(1 rows)
// END-rnow_date


/* CURRENT TIMESTAMP */

// START-now_timestamp
INSERT INTO cycling.comments (
   id,
   created_at)
values (
     e7ae5cf3-d358-4d99-b900-85902fda9bb0,
     toTimeStamp(now()));
// END-now_timestamp

// START-snow_timestamp
SELECT created_at FROM cycling.comments
WHERE id = e7ae5cf3-d358-4d99-b900-85902fda9bb0
LIMIT 1;
// END-snow_timestamp

// START-rnow_timestamp
created_at
---------------------------------
2017-06-01 03:28:41.526000+0000

(1 rows)
// END-rnow_timestamp


/* DATE without time or zone */

// START-string_date_no_tz
INSERT INTO cycling.comments (
   id,
   created_at)
values (
 e7ae5cf3-d358-4d99-b900-85902fda9bb0,
 '2017-04-01');
// END-string_date_no_tz

// START-sstring_date_no_tz
SELECT created_at FROM cycling.comments
WHERE id = e7ae5cf3-d358-4d99-b900-85902fda9bb0 AND
created_at = '2017-04-01';
// END-sstring_date_no_tz

/* START-rstring_date_no_tz
created_at
---------------------------------
2017-04-01 00:00:00.000000+0000

(1 rows)
END-rstring_date_no_tz */


/* DATE WITH TIMEZONE */

// START-string_date_tz
INSERT INTO cycling.comments (
   id,
   created_at)
values (
 e7ae5cf3-d358-4d99-b900-85902fda9bb0,
 '2017-04-01+0000');
// END-string_date_tz

// START-sstring_date_tz
SELECT created_at FROM cycling.comments
WHERE id = e7ae5cf3-d358-4d99-b900-85902fda9bb0 AND
created_at = '2017-04-01+0000';
// END-sstring_datetz

/* START-rstring_date_tz
created_at
---------------------------------
2017-04-01 00:00:00.000000+0000

(1 rows)
END-rstring-date_tz */

/* FULL TIMESTAMP */

// START-string_ts
INSERT INTO cycling.comments (
   id,
   created_at)
values (
 e7ae5cf3-d358-4d99-b900-85902fda9bb0,
 '2017-04-01T11:21:59.001+0000');
// END-string_ts

// START-sstring_ts
SELECT created_at FROM cycling.comments
WHERE id = e7ae5cf3-d358-4d99-b900-85902fda9bb0 AND
created_at = '2017-04-01T11:21:59.001-0800';
// END-sstring_ts

/* START-rstring_ts
created_at
---------------------------------
2017-04-01 11:21:59.001000-0800
END-rstring_ts */
