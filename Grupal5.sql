-- Crear base de datos
CREATE SCHEMA  timebd;

-- Crear un usuario con todos los privilegios para trabajar con la base de datos recién creada.
CREATE USER 'adminBD'@'localhost' IDENTIFIED BY 'admin123';

-- Le otorgamos todos los privilegios al usuario recién creado
GRANT ALL PRIVILEGES ON timebd.* TO 'adminBD'@'localhost';

USE timebd; -- Indicamos que trabajaremos en la base de datos 'timebd'

-- Crear tabla usuarios y en un redmi explicaremos cada tipo de dato utilizado al crear la tabla
CREATE TABLE usuarios (
	id_usuario INT NOT NULL PRIMARY KEY,  		-- Cómo es un id usamos INT ya que sólo se ingresará números
	nombre varchar(20) NOT NULL, 				-- Al ingresar letras lo dejamos cómo VARCHAR y le dimos un máximo de 20 caracteres
	apellido VARCHAR(20) NOT NULL,				-- Igual que en el caso de nombre
	clave VARCHAR(8) NOT NULL,					-- Cómo en las contraseñas se ingresan números, caracteres y letras, dejamos un VARCHAR con un máximo de 8 
	zona_horaria VARCHAR(10) DEFAULT 'UTC-3',	-- La zona horaria es un VARCHAR porque recibe lectras, guón y número, los cuales se crearán automáticamente por defecto 
	genero VARCHAR(10) NOT NULL,				-- El género son letras con un máximo de 10
	telefono VARCHAR(9) NOT NULL				-- El teléfono es VARCHAR porque en caso de ser necesario se aumenta la cantidad del límite caracteres y podría recibir el +569
);

-- Creamos tabla ingreso_usuarios y en un redmi explicaremos cada tipo de dato utilizado al crear la tabla
CREATE TABLE ingreso_usuarios (
	id_ingreso INT NOT NULL PRIMARY KEY,						-- Cómo es un id usamos INT ya que sólo se ingresará números
	id_usuario INT NOT NULL,									-- Cómo es un id usamos INT ya que sólo se ingresará números
	fecha_hora_ingreso DATETIME DEFAULT CURRENT_TIMESTAMP,		-- Para agregar la fecha elegimos DATE y se agregará por defaul la fecha actual
	FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario)	-- Llave foránea genera una relacion con la tabla usuarios a traves de su id
);

-- Modifico el UTC por defecto.Desde UTC-3 a UTC-2.
ALTER TABLE usuarios
MODIFY zona_horaria VARCHAR(10) DEFAULT 'UTC-2';				-- Se modifica la columna 'zona_horaria', pero la justificación sigue siendo la misma que al crear la tabla


-- Ingresar 8 registros
INSERT INTO usuarios (id_usuario, nombre, apellido, clave, zona_horaria, genero, telefono)
VALUES 
(1, 'Juan', 'Pérez', '12345678', 'UTC-2', 'Masculino', '987654321'),
(2, 'Maria', 'González', 'abcd1234', 'UTC-2', 'Femenino', '908765678'),
(3, 'Pedro', 'López', 'abc12345', 'UTC-2', 'Masculino', '956789123'),
(4, 'Ana', 'Martinez', 'ab123456', 'UTC-2', 'Femenino', '987654555'),
(5, 'Jorge', 'Garcia', 'a1234567', 'UTC-2', 'Masculino', '923456789'),
(6, 'Lucia', 'Rodriguez', 'abcde123', 'UTC-2', 'Femenino', '956789876'),
(7, 'Diego', 'Hernandez', 'abcdef12', 'UTC-2', 'Masculino', '98756785'),
(8, 'Laura', 'Diaz', 'abcdefg1', 'UTC-2', 'Femenino', '993456789');


-- Ingresar 8 registros
INSERT INTO ingreso_usuarios (id_ingreso, id_usuario)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8);

-- Creen una nueva tabla llamada Contactos (id_contacto, id_usuario, numero de telefono, correo electronico).

CREATE TABLE contactos (
    id_contacto INT NOT NULL PRIMARY KEY,						--  Cómo es un id usamos INT ya que sólo se ingresará números
    id_usuario INT NOT NULL,									--  Cómo es un id usamos INT ya que sólo se ingresará números
    numero_telefono VARCHAR(9) NOT NULL,						-- El teléfono es VARCHAR porque en caso de ser necesario se aumenta la cantidad del límite caracteres y podría recibir el +569
    correo_electronico VARCHAR(50) NOT NULL,					-- El correo electónico puede recibir letras, números y caracteres especiales, por lo tanto le dejamos un VARCHAR	
    FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario)	-- Se crea una relacion con la tabla usuarios
);

INSERT INTO contactos (id_contacto, id_usuario, numero_telefono, correo_electronico)
VALUES 
(1, 1,'987654321','j.perez@gmail.com' ),
(2, 2, '908765678', 'mary@gmail.com'),
(3, 3, '956789123', 'pedrolopez@gmail.com'),
(4, 4, '987654555', 'anitam@gmail.com'),
(5, 5, '923456789', 'jgarcia@gmail.com'),
(6, 6, '956789876', 'lucia2000@gmail.com'),
(7, 7, '98756785', 'dh@gmail.com'),
(8, 8, '993456789', 'lali@gmail.com');

SELECT * FROM usuarios;

/*Modifique la columna teléfono de contacto, para crear un vínculo entre la tabla Usuarios y la
tabla Contactos.*/

ALTER TABLE usuarios
DROP COLUMN telefono;

ALTER TABLE usuarios ADD COLUMN id_contacto INT NULL;		-- La misma justificación dada por los id anteriores
ALTER TABLE usuarios ADD FOREIGN KEY (id_contacto) REFERENCES contactos(id_contacto);


