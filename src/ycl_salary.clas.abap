CLASS ycl_salary DEFINITION
  PUBLIC
  FINAL.

  PUBLIC SECTION.
    METHODS:
            constructor
                IMPORTING io_bonus   TYPE REF TO ycl_bonus
                          io_taxes   TYPE REF TO ycl_taxes,
            calculate_salary
                IMPORTING iv_id TYPE i
                RETURNING VALUE(rv_salary) TYPE i,
            add_bonus_card
                IMPORTING iv_bonus_card_id TYPE i,
            convert_to_bitcoin
                RETURNING VALUE(ro_bitcoin) TYPE REF TO ycl_bitcoin.

   CLASS-METHODS: create
                        IMPORTING iv_employee_id TYPE i
                        RETURNING VALUE(ro_salary) TYPE REF TO ycl_salary,
                   retriveBitcoinValuesFromStock
                        RETURNING VALUE(rv_value) TYPE i,
                   add_bitcoin_value
                        IMPORTING iv_bitcoin_value TYPE i.

  PRIVATE SECTION.
  DATA: mo_bitcoin TYPE REF TO ycl_bitcoin,
        mo_bonus   TYPE REF TO ycl_bonus,
        mo_taxes   TYPE REF TO ycl_taxes.

  METHODS: calculate_bonus
                IMPORTING iv_id TYPE i
                RETURNING VALUE(rv_bonus) TYPE i,
           calculate_taxes
                IMPORTING iv_id TYPE i
                RETURNING VALUE(rv_bonus) TYPE i,
           taxes_object_exist
                RETURNING VALUE(rv_value) TYPE abap_bool,
           calculate_taxes_for_employee
                RETURNING VALUE(rv_taxes) TYPE i,
           create_taxes_object
                IMPORTING iv_id TYPE i.

  CLASS-DATA: mv_bitcoin_value TYPE i.

ENDCLASS.

CLASS ycl_salary IMPLEMENTATION.

  METHOD constructor.

  ENDMETHOD.

  METHOD calculate_salary.
    rv_salary =  calculate_bonus( iv_id ) + calculate_taxes( iv_id ).
  ENDMETHOD.

  METHOD convert_to_bitcoin.
    ro_bitcoin = new ycl_bitcoin( me ).
  ENDMETHOD.

  METHOD add_bonus_card.
  ENDMETHOD.

  METHOD create.
    ro_salary = new ycl_salary( io_bonus = new ycl_bonus( iv_employee_id )
                                io_taxes = new ycl_taxes( iv_employee_id ) ).

    DATA(lv_bitcoin_value) = retriveBitcoinValuesFromStock(  ).

    IF new ycl_security_bitcoin(  )->is_bitcoin_value_valid( lv_bitcoin_value ).
        add_bitcoin_value( lv_bitcoin_value ).
    ENDIF.
  ENDMETHOD.

  METHOD retriveBitcoinValuesFromStock.
      rv_value = new ycl_bitcoin(  )->provide_value( ).
  ENDMETHOD.

  METHOD add_bitcoin_value.
    mv_bitcoin_value = iv_bitcoin_value.
  ENDMETHOD.

  METHOD calculate_bonus.
    IF mo_bonus IS NOT INITIAL.
        rv_bonus = mo_bonus->calculate_bonus_based_on_id( iv_id ).
    ELSE.
       mo_bonus = new ycl_bonus( iv_id ).
       rv_bonus = mo_bonus->calculate_bonus2(  ).
    ENDIF.
  ENDMETHOD.

  METHOD calculate_taxes.
    IF taxes_object_exist(  ).
        calculate_taxes_for_employee(  ).
    ELSE.
       create_taxes_object( iv_id ).
       calculate_taxes_for_employee(  ).
    ENDIF.
  ENDMETHOD.

  METHOD taxes_object_exist.
    rv_value = boolc( mo_taxes IS NOT INITIAL ).
  ENDMETHOD.

  METHOD calculate_taxes_for_employee.
    rv_taxes =  mo_taxes->calculate_taxes(  ).
  ENDMETHOD.

  METHOD create_taxes_object.
     mo_taxes = new ycl_taxes( iv_id ).
  ENDMETHOD.
ENDCLASS.
