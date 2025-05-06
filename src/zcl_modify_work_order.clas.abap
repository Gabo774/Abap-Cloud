CLASS zcl_modify_work_order DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  METHODS validate_work_order IMPORTING iv_order_id TYPE zde_work_order_id_ga
   RETURNING VALUE(rv_work_order_check) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_modify_work_order IMPLEMENTATION.
    METHOD if_oo_adt_classrun~main.

        DATA: ls_modify_order TYPE ztworkorder_ga.

        ls_modify_order-work_order_id = '65432'.
        ls_modify_order-priority = 'A'.
        ls_modify_order-status = 'PE'.
        ls_modify_order-creation_date = '20250101'.
        ls_modify_order-customer_id = '12345'.
        ls_modify_order-technician_id = '12346'.
        ls_modify_order-description = 'Hola Mundo'.

        "DATA lv_validated TYPE i VALUE validate_work_order.

        IF validate_work_order( ls_modify_order-work_order_id ) EQ 1.
            MODIFY ztworkorder_ga FROM @ls_modify_order.
        ELSE.
            out->write( 'La orden no es valida' ).
        ENDIF.

        SELECT FROM ztworkorder_ga
               FIELDS *
               INTO TABLE @DATA(lt_show_order).

        out->write( data = lt_show_order name = 'Ordenes' ).

    ENDMETHOD.

    METHOD validate_work_order.

        SELECT SINGLE FROM ztworkorder_ga
               FIELDS work_order_id, status
               WHERE work_order_id EQ @iv_order_id
               INTO @DATA(lv_check_order).

        IF sy-subrc EQ 0.
            IF lv_check_order-status EQ 'PE'.
                rv_work_order_check = 1.
            ELSE.
                rv_work_order_check = 0.
            ENDIF.
        ENDIF.

    ENDMETHOD.

ENDCLASS.
