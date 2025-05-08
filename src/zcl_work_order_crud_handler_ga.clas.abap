CLASS zcl_work_order_crud_handler_ga DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  METHODS fetch_work_order IMPORTING iv_order_id TYPE zde_work_order_id_ga
   RETURNING VALUE(rv_work_order) TYPE ztworkorder_ga.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_work_order_crud_handler_ga IMPLEMENTATION.

    METHOD if_oo_adt_classrun~main.

        "CREATE
        out->write( 'CREATE' ).
        DATA: ls_insert TYPE ztworkorder_ga,
              instancia_insert TYPE REF TO zcl_work_order_validation_ga.

        instancia_insert = NEW #( ).

        ls_insert-work_order_id = '65444'.
        ls_insert-priority = 'B'.
        ls_insert-status = 'PE'.
        ls_insert-creation_date = '20250101'.
        ls_insert-customer_id = '12345'.
        ls_insert-technician_id = '12346'.

        IF instancia_insert->validate_tech( ls_insert-technician_id ) EQ 1 AND instancia_insert->validate_customer( ls_insert-technician_id ) EQ 1.
            IF ls_insert-priority EQ 'A' OR ls_insert-priority EQ 'B'.
                INSERT ztworkorder_ga FROM @ls_insert.
            ELSE.
                out->write( 'Prioridad no valida' ).
            ENDIF.
        ELSE.
            out->Write( 'El cliente o tecnico no existe' ).
        ENDIF.

        "READ
        out->write( 'READ' ).

        IF sy-subrc EQ 0.
            out->write( Data = fetch_work_order( ls_insert-work_order_id ) name = 'Orden' ).
        ELSE.
            out->write( 'Orden no encontrada' ).
        ENDIF.

        "UPDATE
        out->write( 'UPDATE' ).
        DATA: ls_modify TYPE ztworkorder_ga,
              instancia_modify TYPE REF TO zcl_modify_work_order.

        instancia_modify = NEW #( ).

        ls_modify-work_order_id = '65444'.
        ls_modify-priority = 'A'.
        ls_modify-status = 'PE'.
        ls_modify-creation_date = '20250101'.
        ls_modify-customer_id = '12345'.
        ls_modify-technician_id = '12346'.
        ls_modify-description = 'Hola Mundo'.

        IF instancia_modify->validate_work_order( ls_modify-work_order_id ) EQ 1.
            MODIFY ztworkorder_ga FROM @ls_modify.
            out->write( Data = fetch_work_order( ls_modify-work_order_id ) name = 'Orden modificada' ).
        ELSE.
            out->write( 'La orden no es valida' ).
        ENDIF.

        "DELETE
        out->write( 'DELETE' ).
        DATA: ls_delete TYPE ztworkorder_ga,
              instancia_delete TYPE REF TO zcl_delete_work_order,
              lv_work_order_id TYPE zde_work_order_id_ga VALUE '65444'.

        instancia_delete = NEW #( ).

        IF instancia_modify->validate_work_order( lv_work_order_id ) EQ 1 AND instancia_delete->validate_work_order_hist( lv_work_order_id ) EQ 1.
            DELETE FROM ztworkorder_ga WHERE work_order_id EQ @lv_work_order_id.
            out->write( 'Orden borrada exitosamente' ).
        ELSE.
            out->write( 'La orden no es valida para ser borrada' ).
        ENDIF.

    ENDMETHOD.
    METHOD fetch_work_order.

        SELECT SINGLE FROM ztworkorder_ga
               FIELDS *
               WHERE work_order_id = @iv_order_id
               INTO @rv_work_order.

    ENDMETHOD.

ENDCLASS.
