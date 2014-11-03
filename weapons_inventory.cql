USE test;
CREATE TABLE inventory (
   item_id UUID,
   weapon_type text,
   cost float,
   damage points int,
   PRIMARY KEY ((weapon_type, damage_points), c ost)
);