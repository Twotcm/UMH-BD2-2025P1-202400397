CREATE DATABASE solicitudempleo;
USE solicitudempleo;

CREATE TABLE DatosPersonales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    apellido_paterno VARCHAR(50),
    apellido_materno VARCHAR(50),
    nombres VARCHAR(100),
    edad INT,
    domicilio VARCHAR(255),
    colonia VARCHAR(100),
    codigo_postal VARCHAR(10),
    telefono VARCHAR(20),
    movil VARCHAR(20),
    lugar_nacimiento VARCHAR(100),
    fecha_nacimiento DATE,
    nacionalidad VARCHAR(50),
    sexo ENUM('Masculino', 'Femenino'),
    vive_con ENUM('Padres', 'Familiares', 'Parientes', 'Amigos', 'Solo'),
    personas_dependientes VARCHAR(255),
    estado_civil ENUM('Soltero', 'Casado', 'Otro'),
    estatura DECIMAL(5,2),
    peso DECIMAL(5,2)
);

CREATE TABLE Documentacion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_persona INT,
    curp VARCHAR(18),
    cartilla_militar VARCHAR(20),
    pasaporte VARCHAR(20),
    licencia_manejo BOOLEAN,
    tipo_licencia VARCHAR(50),
    extranjero_documentacion BOOLEAN,
    FOREIGN KEY (id_persona) REFERENCES DatosPersonales(id)
);

CREATE TABLE HabitosPersonales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_persona INT,
    estado_salud ENUM('Buena', 'Regular', 'Mala'),
    enfermedad_cronica BOOLEAN,
    enfermedad_detalle VARCHAR(255),
    practica_deporte VARCHAR(255),
    pasatiempo VARCHAR(255),
    FOREIGN KEY (id_persona) REFERENCES DatosPersonales(id)
);

CREATE TABLE DatosFamiliares (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_persona INT,
    nombre VARCHAR(100),
    relacion ENUM('Padre', 'Madre', 'Esposo/a', 'Hijo/a'),
    vivo BOOLEAN,
    domicilio VARCHAR(255),
    ocupacion VARCHAR(100),
    FOREIGN KEY (id_persona) REFERENCES DatosPersonales(id)
);

CREATE TABLE Escolaridad (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_persona INT,
    nivel ENUM('Primaria', 'Secundaria', 'Preparatoria', 'Profesional', 'Comercial'),
    nombre_escuela VARCHAR(255),
    domicilio VARCHAR(255),
    fecha_inicio DATE,
    fecha_termino DATE,
    certificado VARCHAR(255),
    FOREIGN KEY (id_persona) REFERENCES DatosPersonales(id)
);

INSERT INTO DatosPersonales (
    apellido_paterno, apellido_materno, nombres, edad, domicilio, 
    colonia, codigo_postal, telefono, movil, lugar_nacimiento, 
    fecha_nacimiento, nacionalidad, sexo, vive_con, 
    personas_dependientes, estado_civil, estatura, peso
) 
VALUES (
    'Pinot', 'Varela', 'Brenda Yolanda', 20, 'Col. Hato', 
    'Centro', '11101', '331975454', '98986998', 'Honduras', 
    '2004-05-12', 'Hondureña', 'Femenino', 'solo', 
    'Ninguna', 'Soltero', 1.60, 80.5
);

INSERT INTO Documentacion (
    id_persona, curp, cartilla_militar, 
    pasaporte, licencia_manejo, tipo_licencia, extranjero_documentacion
)
VALUES (
    1, 'Ninguno', 'Ninguno', 'P1234545258', 1, 'Tipo A', 0
);

INSERT INTO HabitosPersonales (id_persona, estado_salud, 
enfermedad_cronica, enfermedad_detalle, practica_deporte, pasatiempo)
VALUES (1, 'Buena', FALSE, '', 'Cocinar', 'Escribir');

INSERT INTO DatosFamiliares (id_persona, nombre, relacion, vivo, domicilio, ocupacion)
VALUES (1, 'Fernando Varela', 'Padre', TRUE, 'Col. kennedy', 'Ingeniero');

INSERT INTO Escolaridad (id_persona, nivel, nombre_escuela, domicilio, fecha_inicio, fecha_termino, certificado)
VALUES (1, 'Profesional', 'Universidad Nacional Autonoma de Honduras', 
'Col. Hato', '2018-08-15', '2024-06-30', 'Título en Enfermeria');

CREATE TABLE LogsInserciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tipo_evento VARCHAR(50),
    data TEXT
);

DELIMITER //
CREATE PROCEDURE RegistrarDatosPersonales(
    IN p_apellido_paterno VARCHAR(50),
    IN p_apellido_materno VARCHAR(50),
    IN p_nombres VARCHAR(100),
    IN p_edad INT,
    IN p_domicilio VARCHAR(255),
    IN p_colonia VARCHAR(100),
    IN p_codigo_postal VARCHAR(10),
    IN p_telefono VARCHAR(20),
    IN p_movil VARCHAR(20),
    IN p_lugar_nacimiento VARCHAR(100),
    IN p_fecha_nacimiento DATE,
    IN p_nacionalidad VARCHAR(50),
    IN p_sexo ENUM('Masculino', 'Femenino'),
    IN p_vive_con ENUM('Padres', 'Familiares', 'Parientes', 'Amigos', 'Solo'),
    IN p_personas_dependientes VARCHAR(255),
    IN p_estado_civil ENUM('Soltero', 'Casado', 'Otro'),
    IN p_estatura DECIMAL(5,2),
    IN p_peso DECIMAL(5,2)
)
BEGIN
    INSERT INTO DatosPersonales (
        apellido_paterno, apellido_materno, nombres, edad, domicilio,
        colonia, codigo_postal, telefono, movil, lugar_nacimiento,
        fecha_nacimiento, nacionalidad, sexo, vive_con,
        personas_dependientes, estado_civil, estatura, peso
    ) VALUES (
        p_apellido_paterno, p_apellido_materno, p_nombres, p_edad, p_domicilio,
        p_colonia, p_codigo_postal, p_telefono, p_movil, p_lugar_nacimiento,
        p_fecha_nacimiento, p_nacionalidad, p_sexo, p_vive_con,
        p_personas_dependientes, p_estado_civil, p_estatura, p_peso
    );
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER After_Insert_DatosPersonales
AFTER INSERT ON DatosPersonales
FOR EACH ROW
BEGIN
    INSERT INTO LogsInserciones (tipo_evento, data)
    VALUES ('Inserción en DatosPersonales', 
            CONCAT('ID: ', NEW.id, ', Nombre: ', NEW.nombres, ' ', NEW.apellido_paterno, ' ', NEW.apellido_materno, 
                   ', Edad: ', NEW.edad, ', Nacionalidad: ', NEW.nacionalidad));
END //
DELIMITER ;

SHOW TABLES;

DESC DatosPersonales;
DESC LogsInserciones;

CALL RegistrarDatosPersonales(
    'Gómez', 'Pérez', 'Juan Carlos', 25, 'Col.Kennedy',
    'Centro', '11101', '99998877', '88887766', 'Tegucigalpa',
    '1999-04-15', 'Hondureña', 'Masculino', 'Padres',
    '1 hijo', 'Soltero', 1.75, 70.5
);

SELECT * FROM DatosPersonales;

SELECT * FROM LogsInserciones;

CALL RegistrarDatosPersonales(
    'López', 'Ramírez', 'María Fernanda', 30, 'Colonia el Mercadito',
    'Sur', '11002', '98765432', '76543210', 'San Pedro Sula',
    '1994-07-22', 'Hondureña', 'Femenino', 'Familiares',
    'Ninguna', 'Casado', 1.65, 60.0
);

SELECT * FROM LogsInserciones;

DELIMITER //
CREATE PROCEDURE ActualizarDatosPersonales(IN p_id INT, IN p_telefono VARCHAR(20), IN p_movil VARCHAR(20))
BEGIN
    UPDATE DatosPersonales SET telefono = p_telefono, movil = p_movil WHERE id = p_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ActualizarDocumentacion(IN p_id INT, IN p_curp VARCHAR(18), IN p_pasaporte VARCHAR(20))
BEGIN
    UPDATE Documentacion SET curp = p_curp, pasaporte = p_pasaporte WHERE id = p_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ActualizarEscolaridad(IN p_id INT, IN p_nivel ENUM('Primaria', 
'Secundaria', 'Preparatoria', 'Profesional', 'Comercial'))
BEGIN
    UPDATE Escolaridad SET nivel = p_nivel WHERE id = p_id;
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION ObtenerEdad(p_fecha_nacimiento DATE) RETURNS INT DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, p_fecha_nacimiento, CURDATE());
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION ObtenerNombreCompleto(p_id INT) RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
    DECLARE nombre_completo VARCHAR(255);
    SELECT CONCAT(nombres, ' ', apellido_paterno, ' ', apellido_materno) 
    INTO nombre_completo 
    FROM DatosPersonales 
    WHERE id = p_id;
    RETURN nombre_completo;
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION ContarFamiliares(p_id_persona INT) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total 
    FROM DatosFamiliares 
    WHERE id_persona = p_id_persona;
    RETURN total;
END //
DELIMITER ;