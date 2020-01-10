CLASS ycl_bonus DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  METHODS:  constructor
                IMPORTING iv_employee_id TYPE i,
            get_bonus
            RETURNING VALUE(rv_bonus) TYPE i,
           calculate_bonus
            IMPORTING iv_id TYPE i OPTIONAL
                      iv_name TYPE string optional
            RETURNING VALUE(rv_bonus) TYPE i,
           calculate_bonus_based_on_id
            IMPORTING iv_id TYPE i
            RETURNING VALUE(rv_bonus) TYPE i,
            calculate_bonus_based_on_name
            IMPORTING iv_name TYPE string
            RETURNING VALUE(rv_bonus) TYPE i,
            calculate_bonus_for_employee
            IMPORTING iv_employee TYPE REF TO ycl_employee
            RETURNING VALUE(rv_bonus) TYPE i,
            calculate_bonus2
            RETURNING VALUE(rv_bonus) TYPE i,
            calculate_bonus3.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_bonus IMPLEMENTATION.

  METHOD get_bonus.
  ENDMETHOD.

  METHOD calculate_bonus.
  ENDMETHOD.

  METHOD calculate_bonus_based_on_id.
  ENDMETHOD.

  METHOD calculate_bonus_based_on_name.
  ENDMETHOD.

  METHOD calculate_bonus_for_employee.
  ENDMETHOD.

  METHOD calculate_bonus2.
  ENDMETHOD.

  METHOD calculate_bonus3.
  ENDMETHOD.

  METHOD constructor.
  ENDMETHOD.

ENDCLASS.
