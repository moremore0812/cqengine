grammar CQEngineSQL;
import SQLite;

start : K_SELECT STAR K_FROM indexedCollection whereClause? EOF ;

indexedCollection : IDENTIFIER ;
whereClause : ( K_WHERE query ) ;

query : logicalQuery | simpleQuery ;

logicalQuery : andQuery | orQuery | notQuery ;

andQuery : OPEN_PAR query K_AND query (K_AND query)* CLOSE_PAR ;
orQuery : OPEN_PAR query K_OR query (K_OR query)* CLOSE_PAR ;
notQuery : K_NOT query ;

simpleQuery : equalQuery
            | notEqualQuery
            | lessThanOrEqualToQuery
            | lessThanQuery
            | greaterThanOrEqualToQuery
            | greaterThanQuery
            | betweenQuery
            | notBetweenQuery
            | inQuery
            | notInQuery
            | startsWithQuery
            | endsWithQuery
            | containsQuery
            | hasQuery
            | notHasQuery
            | OPEN_PAR simpleQuery CLOSE_PAR
            ;

equalQuery : attributeName ASSIGN queryParameter ;
notEqualQuery : attributeName NOT_EQ2 queryParameter ;
lessThanOrEqualToQuery : attributeName LT_EQ queryParameter ;
lessThanQuery : attributeName LT queryParameter ;
greaterThanOrEqualToQuery : attributeName GT_EQ queryParameter ;
greaterThanQuery : attributeName GT queryParameter ;
betweenQuery : attributeName K_BETWEEN queryParameter K_AND queryParameter ;
notBetweenQuery : attributeName K_NOT K_BETWEEN queryParameter K_AND queryParameter ;
inQuery : attributeName K_IN OPEN_PAR queryParameter (',' queryParameter)* CLOSE_PAR ;
notInQuery : attributeName K_NOT K_IN OPEN_PAR queryParameter (',' queryParameter)* CLOSE_PAR ;
startsWithQuery : attributeName K_LIKE queryParameterTrailingPercent ;
endsWithQuery : attributeName K_LIKE queryParameterLeadingPercent ;
containsQuery : attributeName K_LIKE queryParameterLeadingAndTrailingPercent ;
hasQuery : attributeName K_IS K_NOT K_NULL ;
notHasQuery : attributeName K_IS K_NULL ;

attributeName : IDENTIFIER | STRING_LITERAL ;

queryParameterTrailingPercent : STRING_LITERAL_WITH_TRAILING_PERCENT ;
queryParameterLeadingPercent : STRING_LITERAL_WITH_LEADING_PERCENT ;
queryParameterLeadingAndTrailingPercent : STRING_LITERAL_WITH_LEADING_AND_TRAILING_PERCENT ;
queryParameter : NUMERIC_LITERAL | STRING_LITERAL ;

STRING_LITERAL_WITH_TRAILING_PERCENT : '\'' ( ~[%'] | '\'\'' )* '%\'' ;
STRING_LITERAL_WITH_LEADING_PERCENT : '\'%' ( ~[%'] | '\'\'' )* '\'' ;
STRING_LITERAL_WITH_LEADING_AND_TRAILING_PERCENT : '\'%' ( ~[%'] | '\'\'' )* '%\'' ;

