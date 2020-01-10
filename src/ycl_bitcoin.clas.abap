CLASS ycl_bitcoin DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  METHODS:
          constructor
            IMPORTING io_salary TYPE REF TO ycl_salary OPTIONAL,
          provide_value
             RETURNING VALUE(rv_value) TYPE i.
  PRIVATE SECTION.
ENDCLASS.

CLASS ycl_bitcoin IMPLEMENTATION.

  METHOD constructor.
  ENDMETHOD.

  METHOD provide_value.
  ENDMETHOD.

ENDCLASS.
