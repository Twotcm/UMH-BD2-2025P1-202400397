USE solicitudempleo;

DELIMITER //

CREATE FUNCTION ObtenerEdad(p_fecha_nacimiento DATE) RETURNS INT DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, p_fecha_nacimiento, CURDATE());
END //

CREATE FUNCTION ObtenerNombreCompleto(p_id INT) RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
    DECLARE nombre_completo VARCHAR(255);
    SELECT CONCAT(nombres, ' ', apellido_paterno, ' ', apellido_materno) 
    INTO nombre_completo 
    FROM DatosPersonales 
    WHERE id = p_id;
    RETURN nombre_completo;
END //

CREATE FUNCTION ContarFamiliares(p_id_persona INT) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total 
    FROM DatosFamiliares 
    WHERE id_persona = p_id_persona;
    RETURN total;
END //

DELIMITER ;