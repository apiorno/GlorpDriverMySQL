Connection with mutistatement disabled
- should return query statement error when multiple statements are sent in a query

Connection with multistatement enabled
- should return an error if the first statement causes an error
- should return okay or result sets for consecutive successful statements, followed by an error if an error occurs at a statement and no response for the rest of the statements after the one that caused error
- should return okay or result sets for all statements if there is no error
