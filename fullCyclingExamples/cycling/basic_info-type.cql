source '0_create_keyspace.cql';

//START-droptype
DROP TYPE IF EXISTS cycling.basic_info;
//END-droptype

//START-basicinfotype
CREATE TYPE cycling.basic_info ( 
    birthday timestamp, 
    nationality text, 
    height text,
    weight text
     );
 //END-basicinfotype

DESC TYPE cycling.basic_info;