CLASS zcl_work_order_crud_test_ga DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  METHODS create_work_order IMPORTING iv_order_id TYPE zde_work_order_id_ga
   RETURNING VALUE(rv_insert_work_order) TYPE ztworkorder_ga.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_work_order_crud_test_ga IMPLEMENTATION.
    METHOD if_oo_adt_classrun~main.

        "CREATE
        DATA: lv_work_order_id TYPE zde_work_order_id_ga VALUE '65445'.
        DATA(ls_order_insert) = create_work_order( lv_work_order_id )."Inicia la estructura y crea una orden
        INSERT ztworkorder_ga FROM @ls_order_insert. "inserta la orden creada en la tabla

        "READ
        DATA: instancia_read TYPE REF TO zcl_work_order_crud_handler_ga.
        instancia_read = NEW #( ). "Crea una referencia a la clase crudhandler y la instancia para llamar a sus metodos

        out->write( Data = instancia_read->fetch_work_order( lv_work_order_id ) name = 'Read Orden' ).

        "UPDATE

        DATA: ls_modify TYPE ztworkorder_ga, "Crea una estructura para modificar los datos de tabla
              instancia_modify TYPE REF TO zcl_modify_work_order.
        instancia_modify = NEW #( ). "Crea una referencia a la clase de modify_work_order y la instancia para acceder a sus metodos de validacion

        ls_modify-work_order_id = '65445'.
        ls_modify-priority = 'A'.
        ls_modify-status = 'PE'.
        ls_modify-creation_date = '20250101'.
        ls_modify-customer_id = '12345'.
        ls_modify-technician_id = '12346'.
        ls_modify-description = 'Hola Mundo'.

        IF instancia_modify->validate_work_order( ls_modify-work_order_id ) EQ 1. "verifica que la orden sea valida para modificar
            MODIFY ztworkorder_ga FROM @ls_modify. "Modifica la orden
            out->write( Data = instancia_read->fetch_work_order( ls_modify-work_order_id ) name = 'Orden modificada' ). "Da por consola la orden modificada
        ELSE.
            out->write( 'La orden no es valida' ). "En caso de que no sea valida la orde, se muestra este mensaje
        ENDIF.

        "DELETE
        DATA: ls_delete TYPE ztworkorder_ga,
              instancia_delete TYPE REF TO zcl_delete_work_order.
        instancia_delete = NEW #( )."Crea e instancia una referencia a la clase de selete_work_order para acceder a su metodo de validar historiales

        IF instancia_modify->validate_work_order( lv_work_order_id ) EQ 1 AND instancia_delete->validate_work_order_hist( lv_work_order_id ) EQ 1.
            DELETE FROM ztworkorder_ga WHERE work_order_id EQ @lv_work_order_id."Una vez validado que la orden exista y no tenga historial de cambios, se elimina y manda un mensaje de confirmacion
            out->write( 'Orden borrada exitosamente' ).
        ELSE.
            out->write( 'La orden no es valida para ser borrada' )."En caso de que la orden no sea valida, se muestra este mensaje
        ENDIF.

    ENDMETHOD.

  METHOD create_work_order.

    rv_insert_work_order-work_order_id = '65445'.
    rv_insert_work_order-priority = 'A'.
    rv_insert_work_order-status = 'PE'.
    rv_insert_work_order-creation_date = '20250101'.
    rv_insert_work_order-customer_id = '12345'.
    rv_insert_work_order-technician_id = '12346'.

  ENDMETHOD.

ENDCLASS.
