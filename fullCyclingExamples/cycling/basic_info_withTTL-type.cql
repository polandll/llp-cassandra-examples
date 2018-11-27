//START-droptype
DROP TYPE IF EXISTS cycling.basic_info_expire;
//END-droptype

//START-basicinfoTTLexpiretype
CREATE TYPE cycling.basic_info_expire IF NOT EXISTS (
  birthday timestamp,
  nationality text,
  height text,
  weight text,
  next_race text
  ) ;
//END-basicinfoTTLexpiretype

// START-createtable
CREATE TABLE cycling.basic_info_TTL_expire (
  id UUID PRIMARY KEY,
  lastname text,
  basics basic_info_expire
  );
// END-createtable

// START-insertTTLexpiretype
INSERT INTO cycling.basic_info_TTL_expire (id, lastname, basics)
  VALUES (e7ae5cf3-d358-4d99-b900-85902fda9bb0, 'FRAME',
  { birthday:'1993-06-18',nationality:'New Zealand',weight:'175',height:'72',next_race:'Amgen Tour of California' }) 
  USING TIMESTAMP 100 AND TTL 10000;
// END-insertTTLexpiretype

// START-updateTTLexpiretype
UPDATE cycling.basic_info_TTL_expire 
  USING TTL 100 
  SET basics.next_race='Tour de France' 
  WHERE id = e7ae5cf3-d358-4d99-b900-85902fda9bb0;
// END-updateTTLexpiretype

// START-selectTTLexpiretype
SELECT * FROM cycling.basic_info_TTL_expire;
// END-selectTTLexpiretype

// START-selectWritetimeTTLexpiretype
SELECT WRITETIME(basics), TTL(basics) FROM cycling.basic_info_TTL_expire 
  WHERE id = e7ae5cf3-d358-4d99-b900-85902fda9bb0;
// END-selectWritetimeTTLexpiretype
