-- usando la base de datos
USE solicitudempleo;

-- creando la tabla de logs
CREATE TABLE LogsInserciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tipo_evento VARCHAR(50),
    data TEXT
);

-- Este es el procedimiento almacenado para registrar un nuevo
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

-- Este es el trigger para registrar insercciones en la tabla de logs
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

-- verificamos si la tabla se creo de manera correcta
SHOW TABLES;

DESC DatosPersonales;
DESC LogsInserciones;

-- llamando el procedimiento para insertar un registro nuevo
CALL RegistrarDatosPersonales(
    'Gómez', 'Pérez', 'Juan Carlos', 25, 'Col.Kennedy',
    'Centro', '11101', '99998877', '88887766', 'Tegucigalpa',
    '1999-04-15', 'Hondureña', 'Masculino', 'Padres',
    '1 hijo', 'Soltero', 1.75, 70.5
);

-- verificamos el nuevo registro que acabamos de crear 
SELECT * FROM DatosPersonales;

-- vemos si existe un registro 
SELECT * FROM LogsInserciones;

-- registramos un nuevo registro
CALL RegistrarDatosPersonales(
    'López', 'Ramírez', 'María Fernanda', 30, 'Colonia el Mercadito',
    'Sur', '11002', '98765432', '76543210', 'San Pedro Sula',
    '1994-07-22', 'Hondureña', 'Femenino', 'Familiares',
    'Ninguna', 'Casado', 1.65, 60.0
);

-- revisamos el logs para verificar si existe un nuevo registro
SELECT * FROM LogsInserciones;