use solicitudempleo;

DELIMITER //
CREATE PROCEDURE ActualizarDatosPersonales(IN p_id INT, IN p_telefono VARCHAR(20), IN p_movil VARCHAR(20))
BEGIN
    UPDATE DatosPersonales SET telefono = p_telefono, movil = p_movil WHERE id = p_id;
END //

CREATE PROCEDURE ActualizarDocumentacion(IN p_id INT, IN p_curp VARCHAR(18), IN p_pasaporte VARCHAR(20))
BEGIN
    UPDATE Documentacion SET curp = p_curp, pasaporte = p_pasaporte WHERE id = p_id;
END //

CREATE PROCEDURE ActualizarEscolaridad(IN p_id INT, IN p_nivel ENUM('Primaria', 
'Secundaria', 'Preparatoria', 'Profesional', 'Comercial'))
BEGIN
    UPDATE Escolaridad SET nivel = p_nivel WHERE id = p_id;
END //
DELIMITER ;