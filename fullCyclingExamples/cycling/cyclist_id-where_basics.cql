SOURCE 'cyclist_id-table.cql';

// START-basicwhere
SELECT firstname AS 'First', lastname AS 'Last' FROM cycling.cyclist_id WHERE
lastname = 'COSTA' AND firstname = 'Adrien';
// END-basicwhere

// START-in_where
SELECT firstname AS 'First', lastname AS 'Last' FROM cycling.cyclist_id WHERE
lastname in ('COSTA','WELTEN');
// END-select_in_where
