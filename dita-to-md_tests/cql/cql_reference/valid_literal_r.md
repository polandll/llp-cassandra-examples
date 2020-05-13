# Valid literals {#valid_literal_r .reference}

Values and definitions of valid literals.

Valid literal consist of these kinds of values:

-   blob

    hexadecimal defined as 0\[xX\]\(hex\)+

-   boolean

    true or false, case-insensitive, not enclosed in quotation marks

-   numeric constant

    A numeric constant can consist of integers 0-9 and a minus sign prefix. A numeric constant can also be float. A float can be a series of one or more decimal digits, followed by a period, ., and one or more decimal digits. There is no optional + sign. The forms .42 and 42 are unacceptable. You can use leading or trailing zeros before and after decimal points. For example, 0.42 and 42.0. A float constant, [expressed in E notation](exponential_notation_r.md), consists of the characters in this regular expression:

    ```
    '-'?[0-9]+('.'[0-9]*)?([eE][+-]?[0-9+])?
    ```

    NaN and Infinity are floats.

-   identifier

    Names of tables, columns, types, and other objects are identifiers. Since keyspace and table names are used in system file names, they must start with a letter or number and can only contain alphanumeric characters and underscores. All other identifiers, such as column and user-defined function names can contain any character. To specify an identifier that contains a special character enclose the name in quotes.

-   integer

    An optional minus sign, -, followed by one or more digits.

-   string literal

    Characters enclosed in single quotation marks. To use a single quotation mark itself in a string literal, escape it using a single quotation mark. For example, use ''to make dog possessive: dog''s.

-   uuid

    32 hex digits, 0-9 or a-f, which are case-insensitive, separated by dashes, -, after the 8th, 12th, 16th, and 20th digits. For example: 01234567-0123-0123-0123-0123456789ab

-   timeuuid

    Uses the time in 100 nanosecond intervals since 00:00:00.00 UTC \(60 bits\), a clock sequence number for prevention of duplicates \(14 bits\), plus the IEEE 801 MAC address \(48 bits\) to generate a unique identifier. For example: d2177dd0-eaa2-11de-a572-001b779c76e3

-   whitespace

    Separates terms and used inside string literals, but otherwise CQL ignores whitespace.


**Parent topic:** [CQL lexical structure](../../cql/cql_reference/cql_lexicon_c.md)

