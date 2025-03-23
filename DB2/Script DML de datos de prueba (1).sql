USE solicitudempleo;

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
'Col. Hato', '2018-08-15', '2024-06-30', 'Título en Enfermeria');
