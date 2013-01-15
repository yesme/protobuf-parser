// Compatibility with Protocol Buffer defines
// https://developers.google.com/protocol-buffers/docs/proto
lexer grammar ProtoLexer;

@header {
    package dsl;
}

COMMENT
  :  '//' ~('\n' | '\r')* END_OF_LINE {skip();}
  |  '/*' (options {greedy=false;} : .)* '*/' {skip();}
  ;
fragment END_OF_LINE: '\n' | '\r' | '\r\n' {skip();};
WHITESPACE : ('\t' | ' ' | '\r' | '\n' | '\u000C')+ {skip();};

PACKAGE_LITERAL : 'package' ;
IMPORT_LITERAL : 'import' ;
OPTION_LITERAL : 'option' ;

ENUM_LITERAL : 'enum' ;
MESSAGE_LITERAL : 'message' ;
EXTEND_LITERAL : 'extend' ;
EXTENSIONS_DEF_LITERAL : 'extensions' ;
EXTENSIONS_TO_LITERAL : 'to' ;
EXTENSIONS_MAX_LITERAL : 'max' ;

//GROUP_LITERAL : 'group' ;  // deprecated
//OPTIONAL_DEFAULT_LITERAL : 'default' ;
//OPTIONAL_DEPRECATED_LITERAL : 'deprecated' ;
//REPEATED_PACKED_LITERAL : 'packed' ;

SERVICE_LITERAL : 'service' ;
RETURNS_LITERAL : 'returns' ;
RPC_LITERAL : 'rpc' ;

BLOCK_OPEN : '{' ;
BLOCK_CLOSE : '}' ;
PAREN_OPEN : '(' ;
PAREN_CLOSE : ')' ;
BRACKET_OPEN : '[' ;
BRACKET_CLOSE : ']' ;
EQUALS : '=' ;
COLON : ':' ;
COMMA : ',' ;
ITEM_TERMINATOR : ';' ;

// Protobuf Scope ---------------------
PROTOBUF_SCOPE_LITERAL
  :  REQUIRED_PROTOBUF_SCOPE_LITERAL
  |  OPTIONAL_PROTOBUF_SCOPE_LITERAL
  |  REPEATED_PROTOBUF_SCOPE_LITERAL
  ;

fragment REQUIRED_PROTOBUF_SCOPE_LITERAL : 'required' ;
fragment OPTIONAL_PROTOBUF_SCOPE_LITERAL : 'optional' ;
fragment REPEATED_PROTOBUF_SCOPE_LITERAL : 'repeated' ;
// Protobuf Scope ---------------------

// Protobuf Type ----------------------
PROTOBUF_TYPE_LITERAL
  :  DOUBLE_PROTOBUF_TYPE_LITERAL
  |  FLOAT_PROTOBUF_TYPE_LITERAL
  |  INT32_PROTOBUF_TYPE_LITERAL
  |  INT64_PROTOBUF_TYPE_LITERAL
  |  UINT32_PROTOBUF_TYPE_LITERAL
  |  UINT64_PROTOBUF_TYPE_LITERAL
  |  SINT32_PROTOBUF_TYPE_LITERAL
  |  SINT64_PROTOBUF_TYPE_LITERAL
  |  FIXED32_PROTOBUF_TYPE_LITERAL
  |  FIXED64_PROTOBUF_TYPE_LITERAL
  |  SFIXED32_PROTOBUF_TYPE_LITERAL
  |  SFIXED64_PROTOBUF_TYPE_LITERAL
  |  BOOL_PROTOBUF_TYPE_LITERAL
  |  STRING_PROTOBUF_TYPE_LITERAL
  |  BYTES_PROTOBUF_TYPE_LITERAL
  ;

fragment DOUBLE_PROTOBUF_TYPE_LITERAL : 'double' ;
fragment FLOAT_PROTOBUF_TYPE_LITERAL : 'float' ;
fragment INT32_PROTOBUF_TYPE_LITERAL : 'int32' ;
fragment INT64_PROTOBUF_TYPE_LITERAL : 'int64' ;
fragment UINT32_PROTOBUF_TYPE_LITERAL : 'uint32' ;
fragment UINT64_PROTOBUF_TYPE_LITERAL : 'uint64' ;
fragment SINT32_PROTOBUF_TYPE_LITERAL : 'sint32' ;
fragment SINT64_PROTOBUF_TYPE_LITERAL : 'sint64' ;
fragment FIXED32_PROTOBUF_TYPE_LITERAL : 'fixed32' ;
fragment FIXED64_PROTOBUF_TYPE_LITERAL : 'fixed64' ;
fragment SFIXED32_PROTOBUF_TYPE_LITERAL : 'sfixed32' ;
fragment SFIXED64_PROTOBUF_TYPE_LITERAL : 'sfixed64' ;
fragment BOOL_PROTOBUF_TYPE_LITERAL : 'bool' ;
fragment STRING_PROTOBUF_TYPE_LITERAL : 'string' ;
fragment BYTES_PROTOBUF_TYPE_LITERAL : 'bytes' ;
// Protobuf Type ----------------------

// Integer ----------------------------
INTEGER_LITERAL
  :  HEX_LITERAL
  |  OCTAL_LITERAL
  |  DECIMAL_LITERAL
  ;
fragment HEX_DIGIT : ('0'..'9'|'a'..'f'|'A'..'F') ;
fragment HEX_LITERAL : '-'? '0' ('x'|'X') HEX_DIGIT+ ;
fragment OCTAL_LITERAL : '-'? '0' ('0'..'7')+ ;
fragment DECIMAL_LITERAL : ('0' | '-'? '1'..'9' '0'..'9'*) ;
// Integer ----------------------------

// String -----------------------------
STRING_LITERAL
  :  '"' STRING_GUTS '"'
  ;
fragment STRING_GUTS : ( ESCAPE_SEQUENCE | ~('\\'|'"') )* ;

fragment ESCAPE_SEQUENCE
  :  '\\' ('b'|'t'|'n'|'f'|'r'|'\"'|'\''|'\\')
  |  OCTAL_ESCAPE
  |  UNICODE_ESCAPE
  ;

fragment OCTAL_ESCAPE
  :  '\\' ('0'..'3') ('0'..'7') ('0'..'7')
  |  '\\' ('0'..'7') ('0'..'7')
  |  '\\' ('0'..'7')
  ;

fragment UNICODE_ESCAPE
  :  '\\' 'u' HEX_DIGIT HEX_DIGIT HEX_DIGIT HEX_DIGIT
  ;
// String -----------------------------

// Bool -------------------------------
BOOL_LITERAL : 'true' | 'false';
// Bool -------------------------------

// Float-------------------------------
FLOAT_LITERAL
  :  '-'? ('0'..'9')+ '.' ('0'..'9')* EXPONENT?
  |  '-'? '.' ('0'..'9')+ EXPONENT?
  |  '-'? ('0'..'9')+ EXPONENT
  ;

fragment EXPONENT : ('e'|'E') ('+'|'-')? ('0'..'9')+ ;
// Float-------------------------------

IDENTIFIER : '_'* ('a'..'z' | 'A'..'Z' ) ('a'..'z' | 'A'..'Z' | '_' | '0'..'9')* ;
QUALIFIED_IDENTIFIER : IDENTIFIER ('.' IDENTIFIER)+ ;
FIELD_IDENTIFIER : '.' IDENTIFIER ;
