CREATE DATABASE IF NOT EXISTS empresa_fixoSA;
USE empresa_fixoSA;

CREATE TABLE direccion (
    idDireccion INT(11) AUTO_INCREMENT PRIMARY KEY,
    Direccion VARCHAR(45),
    Ciudad VARCHAR(45),
    Condiminio VARCHAR(45)
);

INSERT INTO direccion (Direccion, Ciudad, Condiminio) VALUES 
('14 Avenida', 'Quiche', 'Encinales 1'),
('Avenida Principal', 'Jutiapa', 'Encinales 2'),
('Zona 16', 'Ciudad de Guatemala', 'Portogrande 2'),
('13 Avenida', 'Xela', 'La bodeguita'),
('Mixco Zona 7', 'Mixco', 'Las luces');

CREATE TABLE cliente (
    idCliente INT(11) AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(45),
    Apellido VARCHAR(45),
    Edad INT(11),
    Direccion_idDireccion INT(11),
    FOREIGN KEY (Direccion_idDireccion) REFERENCES direccion(idDireccion)
);

INSERT INTO cliente (Nombre, Apellido, Edad, Direccion_idDireccion) VALUES 
('Juliana', 'Gómez', 28, 1),
('Carlos', 'Ruiz', 32, 2),
('María', 'López', 25, 3),
('Juliana', 'Martínez', 30, 4),
('Pedro', 'Sánchez', 40, 5);

CREATE TABLE categoria (
    idCategoria INT(11) AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(45)
);

INSERT INTO categoria (Nombre) VALUES 
('Animación'),
('Acción'),
('Drama'),
('Ciencia Ficción'),
('Comedia');


CREATE TABLE peliculas (
    idPeliculas INT(11) AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(45),
    Duracion INT(11),
    Descripcion TEXT,
    Año INT(11),
    Categoria_idCategoria INT(11),
    FOREIGN KEY (Categoria_idCategoria) REFERENCES categoria(idCategoria)
);

INSERT INTO peliculas (Nombre, Duracion, Descripcion, Año, Categoria_idCategoria) VALUES 
('POKEMON1', 75, 'Primera película de Pokémon', 1998, 1),
('Ovnis en zacapa', 120, 'OVNIS son reportados en el noreste de Guatamela', 2015, 3),
('POKEMON1: Seguna parte', 80, 'Secuela de la película Pokémon', 1999, 1),
('Toy story 4', 95, 'Aventura de juguetes inanimados', 2019, 4),
('Son como niños', 90, 'Comedia divertida para la familia', 2010, 5);

CREATE TABLE inventario (
    idCopasPeliculas INT(11) AUTO_INCREMENT PRIMARY KEY,
    Peliculas_idPeliculas INT(11),
    Disponible TINYINT(1),
    FOREIGN KEY (Peliculas_idPeliculas) REFERENCES peliculas(idPeliculas)
);
INSERT INTO inventario (Peliculas_idPeliculas, Disponible) VALUES 
(1, 1),
(2, 1),
(3, 0),
(4, 1),
(5, 1),
(1, 0),
(2, 1);


CREATE TABLE renta (
    idRenta INT(11) AUTO_INCREMENT PRIMARY KEY,
    Fecha_Renta DATE,
    Fecha_Entrega DATE,
    Inventario_idCopasPeliculas INT(11),
    Cliente_idCliente INT(11),
    FOREIGN KEY (Inventario_idCopasPeliculas) REFERENCES inventario(idCopasPeliculas),
    FOREIGN KEY (Cliente_idCliente) REFERENCES cliente(idCliente)
);

INSERT INTO renta (Fecha_Renta, Fecha_Entrega, Inventario_idCopasPeliculas, Cliente_idCliente) VALUES 
('2025-01-15', '2025-01-20', 1, 1),
('2025-02-10', '2025-02-15', 2, 2),
('2025-03-05', '2025-03-10', 3, 3),
('2025-04-20', '2025-04-25', 4, 4),
('2025-05-15', '2025-05-20', 5, 5);


SELECT * FROM cliente WHERE Nombre = 'Juliana';
SELECT * FROM peliculas WHERE Nombre LIKE '%Juliana%';

DELETE FROM renta 
WHERE Inventario_idCopasPeliculas IN (
    SELECT idCopasPeliculas FROM inventario 
    WHERE Peliculas_idPeliculas IN (
        SELECT idPeliculas FROM peliculas WHERE Nombre LIKE '%POKEMON1%'
    )
);

DELETE FROM inventario 
WHERE Peliculas_idPeliculas IN (
    SELECT idPeliculas FROM peliculas WHERE Nombre LIKE 'POKEMON1%'
);

DELETE FROM peliculas WHERE Nombre LIKE '%POKEMON1%';

SELECT * FROM categoria ORDER BY Nombre ASC;
-- Para ordenar peliculas por años
SELECT * FROM peliculas ORDER BY Año DESC;

-- Para ejecutar ahi las tablas
SELECT * FROM direccion;
SELECT * FROM cliente;
SELECT * FROM categoria;
SELECT * FROM peliculas;
SELECT * FROM inventario;
SELECT * FROM renta;

