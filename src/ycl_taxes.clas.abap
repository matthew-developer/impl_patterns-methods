CLASS ycl_taxes DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  METHODS: constructor
            IMPORTING iv_employee_id TYPE i,
            calculate_taxes
                RETURNING VALUE(rv_taxes) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
  DATA: mv_employee_id TYPE i.
ENDCLASS.

CLASS ycl_taxes IMPLEMENTATION.

  METHOD constructor.
    mv_employee_id = iv_employee_id.
  ENDMETHOD.

  METHOD calculate_taxes.
  ENDMETHOD.

ENDCLASS.
