COPY test.catfood (item_id, brand, flavor, can_price) FROM 'catfood_entries.csv' WITH HEADER=True AND DELIMITER='|';
COPY test.catfood2 (item_id, brand, flavor, can_price) FROM 'catfood_entries.csv' WITH HEADER=True AND DELIMITER='|';
