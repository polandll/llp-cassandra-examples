# CQL code comments {#cqlRefComment .concept}

Add comments to CQL code.

Use the following notation to include comments in CQL code:

-   For a single line or end of line put a double hyphen before the text, this comments out the rest of the line:

    ```
    select * from cycling.route; -- End of line comment
    ```

-   For a single line or end of line put a double forward slash before the text, this comments out the rest of the line:

    ```
    select * from cycling.route; // End of line comment
    ```

-   For a block of comments put a forward slash asterisk at the beginning of the comment and then asterisk forward slash at the end.

    ```
    /* This is the first line of 
       of a comment that spans multiple
      lines */
    select * from cycling.route;
    ```


**Parent topic:** [CQL lexical structure](../../cql/cql_reference/cql_lexicon_c.md)

