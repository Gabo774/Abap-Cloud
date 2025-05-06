CLASS zcl_fill_tables DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_fill_tables IMPLEMENTATION.
    METHOD if_oo_adt_classrun~main.

        DATA: ls_customer TYPE ztcustomers_ga,
              lt_customers TYPE TABLE OF ztcustomers_ga,
              ls_tech TYPE zttechnician_ga,
              lt_techs TYPE TABLE OF zttechnician_ga.

        ls_customer-customer_id = '12345'.
        ls_customer-name = 'Celina'.
        ls_customer-address = 'Esperanto 1419'.
        ls_customer-phone = '123-456-7890'.
        APPEND ls_customer TO lt_customers.

        ls_customer-customer_id = '12346'.
        ls_customer-name = 'Mateo'.
        ls_customer-address = 'Av. Siempreviva 742'.
        ls_customer-phone = '987-654-3210'.
        APPEND ls_customer TO lt_customers.

        ls_customer-customer_id = '12347'.
        ls_customer-name = 'Valentina'.
        ls_customer-address = 'Calle Falsa 123'.
        ls_customer-phone = '555-123-4567'.
        APPEND ls_customer TO lt_customers.

        ls_customer-customer_id = '12348'.
        ls_customer-name = 'Tomás'.
        ls_customer-address = 'Libertador 2020'.
        ls_customer-phone = '321-765-0987'.
        APPEND ls_customer TO lt_customers.

        INSERT ztcustomers_ga FROM TABLE @lt_customers.

        ls_tech-technician_id = '12345'.
        ls_tech-name = 'Gabriel'.
        ls_tech-specialty = 'Electricist'.
        APPEND ls_tech TO lt_techs.

        ls_tech-technician_id = '12346'.
        ls_tech-name = 'Lucía'.
        ls_tech-specialty = 'Plumber'.
        APPEND ls_tech TO lt_techs.

        ls_tech-technician_id = '12347'.
        ls_tech-name = 'Ramiro'.
        ls_tech-specialty = 'HVAC'.
        APPEND ls_tech TO lt_techs.

        ls_tech-technician_id = '12348'.
        ls_tech-name = 'Sofía'.
        ls_tech-specialty = 'Carpenter'.
        APPEND ls_tech TO lt_techs.

        INSERT zttechnician_ga FROM TABLE @lt_techs.


    ENDMETHOD.

ENDCLASS.
