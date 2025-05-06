CLASS zcl_delete_work_order DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  METHODS validate_work_order IMPORTING iv_order_id TYPE zde_work_order_id_ga
   RETURNING VALUE(rv_work_order_check) TYPE i.
  METHODS validate_work_order_hist IMPORTING iv_order_id TYPE zde_work_order_id_ga
   RETURNING VALUE(rv_work_order_hist_check) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_delete_work_order IMPLEMENTATION.
    METHOD if_oo_adt_classrun~main.

        DATA: instancia_clase TYPE REF TO zcl_modify_work_order,
              lv_work_order_id TYPE zde_work_order_id_ga VALUE '65432'.

        instancia_clase = NEW #( ).
        IF instancia_clase->validate_work_order( lv_work_order_id ) EQ 1 AND validate_work_order_hist( lv_work_order_id ) EQ 1.
            DELETE FROM ztworkorder_ga WHERE work_order_id EQ @lv_work_order_id.
            out->write( 'Orden borrada exitosamente' ).
        ELSE.
            out->write( 'La orden no es valida para ser borrada' ).
        ENDIF.

    ENDMETHOD.
    METHOD validate_work_order_hist.

        SELECT SINGLE FROM ztwork_ord_h_ga
               FIELDS work_order_id
               WHERE work_order_id EQ @iv_order_id
               INTO @DATA(lv_hist_check).

        IF sy-subrc EQ 0.
            rv_work_order_hist_check = 0.
        ELSE.
            rv_work_order_hist_check = 1.
        ENDIF.

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
