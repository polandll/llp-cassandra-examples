ALTER TABLE sports_equipment ADD size text;

ALTER TABLE sports_equipment RENAME brand_name sponsor_name;

ALTER TABLE sports_equipment DROP brand_name;

ALTER TABLE sports_equipment ALTER id_node TYPE UUID;
