CLASS ycl_method DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  METHODS: calculate_salary
            IMPORTING iv_id TYPE i.

  PRIVATE SECTION.
  DATA: mv_salary TYPE i,
        mo_salary TYPE REF TO ycl_salary.
  METHODS: calculate_bonus
            IMPORTING iv_id TYPE i,
           calculate_taxes
            IMPORTING iv_id TYPE i,
           calculate_expenses
            IMPORTING iv_id TYPE i OPTIONAL
                      iv_name TYPE string OPTIONAL,
           "TO-DO: make the return parameter more abstract
           compute_expenses
            IMPORTING iv_expenses TYPE i.
ENDCLASS.

CLASS ycl_method IMPLEMENTATION.

  METHOD calculate_salary.
    calculate_bonus( iv_id ).
    calculate_taxes( iv_id ).
    mv_salary = mv_salary + 120.

    calculate_expenses(  ).

    mv_salary = mo_salary->calculate_salary( iv_id ).
  ENDMETHOD.

  METHOD calculate_bonus.
  ENDMETHOD.

  METHOD calculate_taxes.
  ENDMETHOD.

  METHOD calculate_expenses.
  ENDMETHOD.

  METHOD compute_expenses.
  ENDMETHOD.

ENDCLASS.
