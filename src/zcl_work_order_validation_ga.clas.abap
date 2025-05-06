CLASS zcl_work_order_validation_ga DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  METHODS validate_customer
   IMPORTING iv_customer_id TYPE zde_customer_id
   RETURNING VALUE(rv_validated) TYPE i.

  METHODS validate_tech
   IMPORTING iv_tech_id TYPE zde_technician_id
   RETURNING VALUE(rv_validated) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_work_order_validation_ga IMPLEMENTATION.
    METHOD if_oo_adt_classrun~main.

        DATA: ls_order TYPE ztworkorder_ga.

        DELETE FROM ztworkorder_ga.

        ls_order-work_order_id = '65432'.
        ls_order-priority = 'A'.
        ls_order-status = 'PE'.
        ls_order-creation_date = '20250101'.
        ls_order-customer_id = '12345'.
        ls_order-technician_id = '12346'.

        IF validate_tech( ls_order-technician_id ) EQ 1 AND validate_customer( ls_order-technician_id ) EQ 1.
            IF ls_order-priority EQ 'A' OR ls_order-priority EQ 'B'.
                MODIFY ztworkorder_ga FROM @ls_order.
            ELSE.
                out->write( 'Prioridad no valida' ).
            ENDIF.
        ELSE.
            out->Write( 'El cliente o tecnico no existe' ).
        ENDIF.

        SELECT FROM ztworkorder_ga
               FIELDS *
               INTO TABLE @DATA(lt_show_order).

        out->write( data = lt_show_order name = 'Ordenes' ).

    ENDMETHOD.

    METHOD validate_customer.

        SELECT SINGLE FROM ztcustomers_ga
               FIELDS customer_id
               WHERE customer_id = @iv_customer_id
               INTO @DATA(lv_customer_id_check).

        IF sy-subrc = 0 AND lv_customer_id_check = iv_customer_id.
            rv_validated = 1.
        ELSE.
            rv_validated = 0.
        ENDIF.

    ENDMETHOD.

    METHOD validate_tech.

        SELECT SINGLE FROM zttechnician_ga
         FIELDS technician_id
         WHERE technician_id = @iv_tech_id
         INTO @DATA(lv_tech_id_check).

        IF sy-subrc = 0 AND lv_tech_id_check = iv_tech_id.
            rv_validated = 1.
        ELSE.
            rv_validated = 0.
        ENDIF.

    ENDMETHOD.

ENDCLASS.
