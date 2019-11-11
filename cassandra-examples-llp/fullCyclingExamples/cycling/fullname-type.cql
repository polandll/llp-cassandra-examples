source '0_create_keyspace.cql';

// Store fist and last in the same column using a custom type

// START-fullname
CREATE TYPE cycling.fullname (
  firstname text,
  lastname text );
// END-fullname

// START-alt
ALTER TYPE cycling.fullname 
   ADD middlename text;
// END-alt

// START-rename
ALTER TYPE cycling.fullname 
  RENAME middlename TO middle 
  AND lastname TO last 
  AND firstname TO first;
// END-rename


ALTER TYPE cycling.fullname 
  RENAME middle to middlename 
  AND last to lastname 
  AND first TO firstname;
