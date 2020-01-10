CLASS ycl_state DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  METHODS: constructor
                IMPORTING iv_date TYPE d
                          iv_support_capacity TYPE i,
           set_support_capacity
                IMPORTING iv_support_capacity TYPE i,
           set_width
                IMPORTING iv_width TYPE i,
           set_width_2
                IMPORTING iv_width TYPE i,
           update_area.

  PROTECTED SECTION.
  PRIVATE SECTION.
    "variable state
    DATA: mv_date TYPE d,
          mv_support_capacity TYPE i,

          mv_area   TYPE i,
          mv_height TYPE i,
          mv_width TYPE  i.




ENDCLASS.



CLASS ycl_state IMPLEMENTATION.

  METHOD constructor. "set common state through constructor
    me->mv_date = iv_date.  " direct access
    me->mv_support_capacity = iv_support_capacity. " direct access
  ENDMETHOD.



  METHOD set_support_capacity. "don`t set the common state with accessors methods due to communacation problem.
    me->mv_support_capacity = iv_support_capacity. " direct access
  ENDMETHOD.

  METHOD set_width. "indirect access for coupled data.
    me->mv_width = iv_width.
    mv_area = me->mv_width * mv_height.
  ENDMETHOD.

  METHOD set_width_2. "indirect access for less coupled data, through a listener/updater.
    me->mv_width = iv_width. "Thema besprechen mit DRY auf Daten, wenn es sich um couple data handelt.
    update_area( ).
  ENDMETHOD.

  METHOD update_area.
    mv_area = mv_width * mv_height. "direct access
  ENDMETHOD.

ENDCLASS.
