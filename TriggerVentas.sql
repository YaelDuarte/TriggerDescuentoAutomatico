DELIMITER $$

CREATE TRIGGER crear_cliente_si_no_existe
AFTER INSERT ON ventas
FOR EACH ROW
BEGIN
    DECLARE cliente_count INT;

    SELECT COUNT(*) INTO cliente_count
    FROM clientes
    WHERE idCliente = NEW.idCliente;

    IF cliente_count = 0 THEN
        INSERT INTO clientes (idCliente, nombre)
        VALUES (NEW.idCliente, CONCAT('Cliente_', NEW.idCliente));
    END IF;
END$$

DELIMITER ;



DELIMITER $$

CREATE TRIGGER aplicar_descuento
BEFORE INSERT ON ventas
FOR EACH ROW
BEGIN
    DECLARE descuento_activo BOOLEAN DEFAULT FALSE;
    DECLARE fecha_limite DATE;
    DECLARE ventas_actual INT;
    DECLARE mes_actual INT;
    

    -- Traemos los datos actuales del cliente
    SELECT descuentos_activos, descuento_hasta,
           ventas_mes_actual,  mes_ventas_actual
    INTO descuento_activo, fecha_limite,
         ventas_actual, mes_actual
    FROM clientes
    WHERE idCliente = NEW.idCliente;

    -- Aplicamos descuento si está activo y vigente
    IF descuento_activo = TRUE AND fecha_limite >= CURDATE() THEN
        SET NEW.precio_final = NEW.precio * 0.15;
    ELSE
        SET NEW.precio_final = NEW.precio;

        -- Si llegó a 10, activamos descuento
        IF ventas_actual = 10 THEN
            UPDATE clientes
            SET descuentos_activos = TRUE,
                descuento_hasta = DATE_ADD(CURDATE(), INTERVAL 1 MONTH),
                ventas_mes_actual = ventas_actual,
                mes_ventas_actual = mes_actual
            WHERE idCliente = NEW.idCliente;

            SET NEW.precio_final = NEW.precio * 0.85;
        ELSE
            -- Solo actualizamos el conteo si aún no hay descuento
            UPDATE clientes
            SET ventas_mes_actual = ventas_actual,
                mes_ventas_actual = mes_actual
            WHERE idCliente = NEW.idCliente;
        END IF;
    END IF;
END$$

DELIMITER ;

