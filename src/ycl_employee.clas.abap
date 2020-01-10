CLASS ycl_employee DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS: constructor
                IMPORTING iv_name TYPE string
                          iv_id   TYPE i
                          io_salary TYPE REF TO ycl_salary,
             calculate_salary
                RETURNING VALUE(rv_salary) TYPE i,
             add_bonus_card
                IMPORTING iv_id TYPE i.


  PROTECTED SECTION.
  PRIVATE SECTION.
  DATA: mv_name TYPE string,
        mv_id   TYPE i,
        mo_salary TYPE REF TO ycl_salary,
        mv_bonus_card_id TYPE i.
  METHODS: set_bonus_card_id
                IMPORTING iv_bonus_card_id TYPE i,
           updateBonusWithAdditionalCard.

ENDCLASS.



CLASS ycl_employee IMPLEMENTATION.

  METHOD constructor.
    mv_name  = iv_name.
    mv_id    = iv_id.
    mo_salary = io_salary.
  ENDMETHOD.

  METHOD calculate_salary.
    rv_salary = mo_salary->calculate_salary( mv_id ).
  ENDMETHOD.

  METHOD add_bonus_card.
    set_bonus_card_id( iv_id ).
  ENDMETHOD.

  METHOD set_bonus_card_id.
    mv_bonus_card_id = iv_bonus_card_id.
    updateBonusWithAdditionalCard( ).
  ENDMETHOD.

  METHOD updatebonuswithadditionalcard.
    mo_salary->add_bonus_card( mv_bonus_card_id ).
  ENDMETHOD.

ENDCLASS.
