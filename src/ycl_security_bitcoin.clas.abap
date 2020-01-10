CLASS ycl_security_bitcoin DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  METHODS:  is_bitcoin_value_valid
                  IMPORTING iv_bitcoin_Value TYPE i
                  RETURNING VALUE(rv_result) TYPE abap_bool.

ENDCLASS.

CLASS ycl_security_bitcoin IMPLEMENTATION.

  METHOD is_bitcoin_value_valid.
  ENDMETHOD.

ENDCLASS.
