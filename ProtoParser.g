parser grammar ProtoParser;

options {
    output = AST;
    language = Java;
    tokenVocab = ProtoLexer;  // ProtoLexer.tokens
    ASTLabelType = CommonTree;
}

tokens {
  PROTO;
  OPTION_PREDEFINED;
  OPTION_CUSTOMIZED;
  OPTION_VALUE_ITEM;
  OPTION_VALUE_OBJECT;
  ENUM_FIELD;
  MESSAGE_FIELD;
}

// Predefines
all_identifier
  :  IDENTIFIER
  |  QUALIFIED_IDENTIFIER
  ;

all_value
  :  IDENTIFIER
  |  literal_value
  ;

literal_value
  :  INTEGER_LITERAL
  |  STRING_LITERAL
  |  BOOL_LITERAL
  |  FLOAT_LITERAL
  ;

proto_type
  :  PROTOBUF_TYPE_LITERAL
  |  all_identifier
  ;

// Proto ------------------------------
proto
  :  (package_def | import_def | option_line_def | enum_def | ext_def | message_def | service_def)* EOF  // Only one package define is allowed - will handle that in the compiler
     -> ^(PROTO package_def* import_def* option_line_def* enum_def* ext_def* message_def* service_def*)
  ;
// Proto ------------------------------

// Package ----------------------------
package_def
  :  PACKAGE_LITERAL package_name ITEM_TERMINATOR
     -> ^(PACKAGE_LITERAL package_name)
  ;

package_name : all_identifier ;
// Package ----------------------------

// Import -----------------------------
import_def
  :  IMPORT_LITERAL import_file_name ITEM_TERMINATOR
     -> ^(IMPORT_LITERAL import_file_name)
  ;

import_file_name : STRING_LITERAL ;
// Import -----------------------------

// Option in line----------------------
option_line_def
  :  OPTION_LITERAL option_name EQUALS option_all_value ITEM_TERMINATOR
     -> ^(OPTION_LITERAL option_name option_all_value)
  ;

option_field_def
  :  BRACKET_OPEN! option_field_item (COMMA! option_field_item)* BRACKET_CLOSE!
  ;

option_field_item
  :  option_name EQUALS option_all_value
     -> ^(OPTION_LITERAL option_name option_all_value)
  ;

option_all_value
  : all_value
  | option_value_object
  ;

option_value_object
  :  BLOCK_OPEN option_value_item* BLOCK_CLOSE
     -> ^(OPTION_VALUE_OBJECT option_value_item*)
  ;

option_value_item
  :  IDENTIFIER COLON option_all_value
     -> ^(OPTION_VALUE_ITEM IDENTIFIER option_all_value)
  ;

option_name
  :  IDENTIFIER
     -> ^(OPTION_PREDEFINED IDENTIFIER)
  |  PAREN_OPEN all_identifier PAREN_CLOSE FIELD_IDENTIFIER*
     -> ^(OPTION_CUSTOMIZED all_identifier FIELD_IDENTIFIER*)
  ;
// Option in line----------------------

// Enum -------------------------------
enum_def
  :  ENUM_LITERAL enum_name BLOCK_OPEN enum_content BLOCK_CLOSE
     -> ^(ENUM_LITERAL enum_name enum_content)
  ;

enum_name : IDENTIFIER ;

enum_content : (option_line_def | enum_item_def)* ;

enum_item_def
  :  IDENTIFIER EQUALS INTEGER_LITERAL option_field_def? ITEM_TERMINATOR
     -> ^(ENUM_FIELD IDENTIFIER INTEGER_LITERAL option_field_def?)
  ;
// Enum -------------------------------

// Message ----------------------------
message_def
  :  MESSAGE_LITERAL message_name BLOCK_OPEN message_content? BLOCK_CLOSE
     -> ^(MESSAGE_LITERAL message_name message_content?)
  ;

message_name : IDENTIFIER ;

message_content : (option_line_def | message_item_def | message_def | enum_def | message_ext_def)+ ;

message_item_def
  : PROTOBUF_SCOPE_LITERAL proto_type IDENTIFIER EQUALS INTEGER_LITERAL option_field_def? ITEM_TERMINATOR
     -> ^(MESSAGE_FIELD PROTOBUF_SCOPE_LITERAL proto_type IDENTIFIER INTEGER_LITERAL option_field_def?)
  ;

message_ext_def
  : EXTENSIONS_DEF_LITERAL INTEGER_LITERAL EXTENSIONS_TO_LITERAL (v=INTEGER_LITERAL | v=EXTENSIONS_MAX_LITERAL) ITEM_TERMINATOR
    -> ^(EXTENSIONS_DEF_LITERAL INTEGER_LITERAL $v)
  ;
// Message ----------------------------

// Extension --------------------------
ext_def
  :  EXTEND_LITERAL ext_name BLOCK_OPEN ext_content? BLOCK_CLOSE
     -> ^(EXTEND_LITERAL ext_name ext_content?)
  ;

ext_name : all_identifier ;

ext_content : (option_line_def | message_item_def | message_def | enum_def)+ ;
// Extension --------------------------

// Service ----------------------------
service_def
  :  SERVICE_LITERAL service_name BLOCK_OPEN service_content? BLOCK_CLOSE
     -> ^(SERVICE_LITERAL service_name service_content?)
  ;

service_name : IDENTIFIER ;

service_content : (option_line_def | rpc_def )+ ;

rpc_def
  :  RPC_LITERAL rpc_name PAREN_OPEN req_name PAREN_CLOSE RETURNS_LITERAL PAREN_OPEN resp_name PAREN_CLOSE (BLOCK_OPEN option_line_def* BLOCK_CLOSE ITEM_TERMINATOR? | ITEM_TERMINATOR)
     -> ^(RPC_LITERAL rpc_name req_name resp_name option_line_def*)
  ;

rpc_name : IDENTIFIER ;
req_name : all_identifier ;
resp_name : all_identifier ;
// Service ----------------------------
