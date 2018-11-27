source 'cyclist_expenses-table.cql';

// START-restrictrows
RESTRICT ROWS ON cycling.cyclist_expenses USING cyclist_name ;
// END-restrictrows

// START-describe
DESC cycling.cyclist_expenses;
// END-describe

// START-primarykey
SELECT DISTINCT cyclist_name FROM cycling.cyclist_expenses ;
// END-primarykey

// START-danfilter
GRANT SELECT 
ON 'Paolo TIRALONGO' ROWS IN cycling.cyclist_expenses 
TO dantest1;
// END-danfilter

// START-janefilter
GRANT SELECT 
ON 'Vera ADRIAN' ROWS IN cycling.cyclist_expenses 
TO jane;
//END-janefilter

// START-danverify
LIST ALL PERMISSIONS OF dantest1;
// END-danverify

// START-janeverify
LIST ALL PERMISSIONS OF jane;
// END-janeverify

// START-danlogin
LOGIN dantest1 'password'
// END-danlogin

// START-danquery
SELECT * FROM cycling.cyclist_expenses ;
// END-danquery

// START-janelogin
LOGIN jane 'password'
// END-janelogin

// START-janequery
SELECT * FROM cycling.cyclist_expenses ;
// END-janequery

