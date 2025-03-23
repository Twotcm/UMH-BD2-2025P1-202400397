CREATE DATABASE solicitudempleo;
USE solicitudempleo;

CREATE TABLE Datospersonales (
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