SOURCE 'comments-table.cql';


// START-select-mostrecent
SELECT toDate(created_at) AS Date, comment, commenter FROM cycling.comments
PER PARTITION LIMIT 1;
// END-select-mostrecent

/* START-select-mostrecent-results
 date       | comment                                       | commenter
------------+-----------------------------------------------+-----------
2017-05-17 |                                     Nice race |      Alex
2017-05-17 | The gift certificate for winning was the best |       Amy
2017-05-17 |       Fastest womens time ever way to go amy! |  Maryanne
2017-05-17 |                                  Great course |   Michael
2017-05-17 |                  Can't wait for the next race | Katarzyna
2017-05-18 |                 Thanks for all your hard work |  Marianne
2017-05-18 |                                 A for effort! |     Paolo
2017-05-18 |            Closing ceremony was a little lame |  Rossella
2017-05-18 |                               Next time guys! |    Marcia
2017-05-18 |              So many great races thanks y'all |    Steven
2017-05-18 |                        Go team, you rocked it |      Anna
2017-05-18 |             Next year the tour of california! |   Melissa
2017-05-18 |                           Next year for sure! |      Vera

(13 rows)
END-select-mostrecent-results */
