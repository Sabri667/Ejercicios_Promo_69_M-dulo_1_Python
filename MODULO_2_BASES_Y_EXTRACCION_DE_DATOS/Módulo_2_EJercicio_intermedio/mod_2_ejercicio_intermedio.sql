/*Ejercicio 1: Creación de Esquema y Tablas*/
CREATE SCHEMA videoclub;

USE videoclub;

CREATE TABLE generos(
id_genero INT AUTO_INCREMENT PRIMARY KEY,
nombre_genero VARCHAR(80) NOT NULL,
descripcion VARCHAR(200)
);

CREATE TABLE peliculas (
id_pelicula INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR (120) NOT NULL,
duracion INT CHECK (duracion >=0), 
direccion VARCHAR(150) NOT NULL DEFAULT 'desconocido',
id_genero INT NOT NULL,
fecha_estreno DATE,
FOREIGN KEY (id_genero) REFERENCES generos(id_genero)
);

CREATE TABLE clientes (
id_cliente INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR (120) NOT NULL,
apellido VARCHAR(180) NOT NULL,
direccion VARCHAR(120) NOT NULL,
telefono VARCHAR (60) NOT NULL,
email VARCHAR(120),
fecha_registro DATE
);

CREATE TABLE alquileres (
id_alquiler INT AUTO_INCREMENT PRIMARY KEY,
id_cliente INT NOT NULL,
id_pelicula INT NOT NULL,
fecha_alquiler DATE NOT NULL,
fecha_devolucion DATE NOT NULL, 	-- consultar porque al asignar NULL completa '0000-00-00' y lo trae bajo consulta NULL
estado VARCHAR(15) CHECK (estado IN ('Pendiente', 'Devuelto')),
FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente) ON DELETE CASCADE,
FOREIGN KEY (id_pelicula) REFERENCES peliculas (id_pelicula) ON DELETE CASCADE -- No eliminar pelicula sin consultar devoluciones pendientes//VER opciones.
);

/*Ejercicio 2: Modificación de tablas*/
-- Modificación de 'email' en tabla 'clientes': más caracteres y NOT NULL.
ALTER TABLE clientes
MODIFY email VARCHAR (150) NOT NULL;
-- Modificación de 'estado' en tabla 'alquileres': por defecto 'pendiente.
ALTER TABLE alquileres
MODIFY estado ENUM('Pendiente', 'Devuelto') DEFAULT 'Pendiente';

/* Inicialmente escribí esta instrucción pero puede no funcionar para versiones anteriores como la mía.
ALTER TABLE alquileres
MODIFY estado VARCHAR(15) CHECK (estado IN ('Pendiente', 'Devuelto')) DEFAULT 'Pendiente'; */

/*Ejercicio 3: Carga de datos*/

INSERT generos(nombre_genero,descripcion)VALUES ('Acción','Películas de emoción y aventuras'),
('Comedia', 'Películas para reir y disfrutar'), ('Drama', 'Películas emocionales y profundas'),
('Ciencia Ficción', 'Películas con elementos futuristas o tecnológicos');

INSERT peliculas(nombre,duracion,direccion, id_genero, fecha_estreno)
VALUES ('Misión Resccate',130,'Ridley Scott',4,'2015-10-02'),
('La Gran Aventura',120,'Chris Colombus',1,'2001-06-22'),
('Reir o Llorar',95,'John Smith',2,'2020-11-12'),
('Crisis Total',110,'Jane Doe',3,'2019-005-15');

INSERT clientes(nombre,apellido,direccion,telefono,email,fecha_registro)
VALUES('Carlos','García','Av.Principal 123','555-1234','carlos@example.com','2023-01-15'),
('Lucía','Pérez', 'Calle Secundaria 45', '555-5678','lucia@example.com','2023-02-20'),
('Miguel','López', 'Av. Tercera 789', '555-9876', 'miguel@example,com', '2023-03-10');

INSERT alquileres(id_cliente,id_pelicula,fecha_alquiler,fecha_devolucion, estado) 
VALUES(1,1,'2025-01-01', NULL, 'Pendiente'),(2,2,'2025-01-03','2025-01-07', 'Devuelto'),
(3,4,'2025-01-05',NULL,'Pendiente');

-- Se modifica fecha_devolucion para permitir nulos y se ejecuta nuevamente la carga de datos en alquileres.
ALTER TABLE alquileres MODIFY fecha_devolucion DATE;

/*Ejercicio 4: Modificaciones y consultas*/
SELECT * FROM videoclub.clientes;

/*Modificación de email: carlos_garcia@example.com*/
UPDATE clientes
SET email = 'carlos_garcia@example.com'
WHERE id_cliente=1;

SELECT email FROM clientes;

/*ELiminar cliente Lucía*/

DELETE FROM clientes WHERE nombre = 'Lucía' AND apellido = 'Pérez';

/*Cambiar nombre de columna en tabla generos*/
ALTER TABLE generos CHANGE nombre_genero genero VARCHAR(80) NOT NULL;
/*Para nuevas versiones: ALTER TABLE generos RENAME COLUMN nombre_genero TO genero;*/

/*Consultas*/
SELECT * FROM peliculas;
SELECT nombre,duracion FROM peliculas;
SELECT * FROM peliculas WHERE id_genero=4;
SELECT * FROM clientes WHERE nombre='Carlos';
SELECT * FROM peliculas ORDER BY fecha_estreno ASC;
SELECT * FROM peliculas ORDER BY fecha_estreno DESC;
SELECT * FROM clientes ORDER BY fecha_registro ASC;
SELECT * FROM clientes ORDER BY fecha_registro DESC;
SELECT * FROM peliculas LIMIT 2; 
SELECT nombre,duracion FROM peliculas WHERE duracion IN (90,120); -- alternativa BETWEEN 90 AND 120 
SELECT * FROM peliculas WHERE duracion>100 OR  id_genero=1;
SELECT * FROM alquileres WHERE fecha_devolucion IS NOT NULL;
SELECT DISTINCT genero FROM generos; 

select * from clientes;























