USE test; 

CREATE TABLE sports_equipment (
	name text,
	cost float,
	brand_name text,
	id_code text,
	PRIMARY KEY(name, id_code)
);

CREATE INDEX equip_by_brand_name ON sports_equipment (brand_name);

COPY sports_equipment
	(name, cost, brand_name, id_code)
FROM 'sports_equipment_entries.csv'
WITH HEADER = 'true' AND DELIMITER = '|';
