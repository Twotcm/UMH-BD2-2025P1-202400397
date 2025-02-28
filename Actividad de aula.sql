DELIMITER //
DROP PROCEDURE sp_new_currency_case;

DELIMITER //
CREATE procedure sp_new_currency_case( 
     in P_currency_name varchar(45), 
     in P_currency_symbol varchar(45), 
     in P_exchange_rate decimal(15,2), 
     in P_country varchar(45),
     in P_iso_code varchar(45),
)
     
BEGIN
  /* Declaracion de variables */
    DECLARE _currency_name     varchar(45) default null;
    DECLARE _currency_symbol   varchar (45);
	DECLARE V_exchange_rate    decimal (15,2);
	Declare _country           varchar (45);
    declare v_iso_code         varchar (45);

    set V_currency_name = P_currency_name
    set _currency_name = P_currency_name;
	set _currency_symbol = P_currency_symbol;
    set V_exchange_rate = P_exchange_rate;
    set _country = P_country;
    set v_iso_code = p_iso_code;
    /* Case statement */
    CASE
        WHEN p_currency_name like '%dolar%' THEN set v_currency_symbol = "$";
        WHEN p_currency_name like '%peso%' THEN set v_currency_symbol = "P";
        WHEN p_currency_name like '%yen%' THEN set v_currency_symbol = "¥";
        WHEN p_currency_name like '%euro%' THEN set v_currency_symbol = "€";
        ELSE set _currency_symbol = P_currency_symbol;
	 END CASE;
     INSERT INTO currencies ( currency_name, currency_symbol, exchange_rate, country, ISO_CODE )
     VALUES (v_currency_name, _currency_symbol, V_exchange_rate, V_country, V_iso_code);
     commit;
END

CALL db_demo.sp_new_currency_case(
    "sol peruano", "s.", 0, "PERU" , "PEN"
);
select * from db_demo.currencies WHERE currency_name LIKE '%euro%"