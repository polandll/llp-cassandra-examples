// START-droptable
DROP TABLE IF EXISTS cycling.cyclist_stats;
// END-droptable

source 'basic_info-type.cql';

// START-createtable
CREATE TABLE cycling.cyclist_stats ( 
   id UUID PRIMARY KEY, 
   lastname text, 
   basics basic_info);
// END-createtable


INSERT INTO cycling.cyclist_stats (id, lastname, basics) VALUES (e7ae5cf3-d358-4d99-b900-85902fda9bb0, 'FRAME', { birthday:'1993-06-18',nationality:'New Zealand',weight:null,height:null });
INSERT INTO cycling.cyclist_stats (id, lastname, basics) VALUES (6cbc55e9-1943-47dc-91f2-f8f9e95992eb, 'VIGANO', { birthday:'1984-06-12',nationality:'Italy',weight:'67 kg',height:'1.82 m' });
INSERT INTO cycling.cyclist_stats (id, lastname, basics) VALUES (220844bf-4860-49d6-9a4b-6b5d3a79cbfb, 'TIRALONGO', { birthday:'1977-07-08',nationality:'Italy',weight:'63 kg',height:'1.78 m' });

// START-update
UPDATE cycling.cyclist_stats 
SET basics.birthday = '2000-12-12' 
WHERE id = 220844bf-4860-49d6-9a4b-6b5d3a79cbfb;
// END-update