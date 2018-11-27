SOURCE 'cyclist_expenses.cql';
EXPAND ON

// START-query
SELECT cyclist_name, expense_id,
        amount, WRITETIME(amount),
        description, WRITETIME(description),
        paid,WRITETIME(paid)
   FROM cycling.cyclist_expenses
WHERE cyclist_name = 'Vera ADRIAN';
//END-query