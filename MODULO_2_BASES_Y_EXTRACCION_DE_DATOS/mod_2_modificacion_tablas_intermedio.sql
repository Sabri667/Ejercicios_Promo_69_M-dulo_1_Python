USE tienda_zapatillas;
/*Tabla Zapatillas:
Se nos ha olvidado introducir la marca y la talla de las zapatillas que tenemos en nuestra bases de datos. Por lo tanto, debemos incluir:
marca: es una cadena de caracteres de longitud máxima de 45 caracteres, no nula.
talla: es un entero, no nulo.
Tabla Empleados
salario: es un entero, no nulo. Pero puede que el salario de nuestros empleados tenga decimales, por lo que le cambiaremos el tipo a decimal.
Tabla Clientes
pais: la hemos incluido en la tabla pero nuestro negocio solo distribuye a España, por lo que es una columna que no hará falta. La eliminaremos.
Tabla Facturas:
total: madre mía!!! Se nos ha olvidado incluir el total de la cada factura generada😨!Creemos esa columna con un tipo de datos decimal.*/
ALTER TABLE zapatillas 
ADD COLUMN marca VARCHAR(45) NOT NULL,
ADD talla INT NOT NULL;
ALTER TABLE empleados
MODIFY salario FLOAT NOT NULL;
ALTER TABLE clientes
DROP COLUMN pais;
ALTER TABLE facturas
ADD COLUMN total FLOAT NOT NULL DEFAULT 0;

SELECT* FROM facturas;

/* Lo primero que vamos a hacer es insertar datos en nuestra bases de datos con los siguientes datos:

Tabla zapatillas

id_zapatilla	modelo	color	marca	talla
1	XQYUN	Negro	Nike	42
2	UOPMN	Rosas	Nike	39
3	OPNYT	Verdes	Adidas	35 */

INSERT INTO zapatillas (modelo,color,marca,talla)
VALUES ('XQYUN','Negro', 'Nike',42),('UOPMN','Rosas','Nike',39),('OPNYT','Verdes','Adidas',35);

/*Tabla empleados

id_empleado	nombre	tienda	salario	fecha_incorporacion
1	Laura	Alcobendas	25.987	03/09/2010
2	Maria	Sevilla		11/04/2001
3	Ester	Oviedo	30.165,98	29/11/2000*/
INSERT INTO empleados (nombre,tienda,salario,fecha_incorporacion)
VALUES ('Laura','Alcobendas', 25.987,'2010-09-03'),('Maria','Sevilla',0,'2001-04-11'),('Ester','Oviedo',30165.98,'2000-11-29');

/*Tabla clientes

id_cliente	nombre	numero_telefono	email	direccion	ciudad	provincia	codigo_postal
1	Monica	1234567289	monica@email.com	Calle Felicidad	Móstoles	Madrid	28176
2	Lorena	289345678	lorena@email.com	Calle Alegria	Barcelona	Barcelona	12346
3	Carmen	298463759	carmen@email.com	Calle del Color	Vigo	Pontevedra	23456*/
INSERT INTO clientes (nombre,numero_telefono,email,direccion,ciudad,provincia,codigo_postal)
VALUES ('Monica',1234567289, 'monica@email.com','Calle Felicidad', 'Móstoles','Madrid',28176),('Lorena',289345678,'lorena@email.com','Calle Alegria',
'Barcelona','Barcelona',12346),('Carmen', 298463759,'carmen@email.com','Calle del Color','Vigo','Pontevedra',23456);

/*Tabla facturas

id_factura	numero_factura	fecha	id_zapatilla	id_empleado	id_cliente	total
1	123	11/12/2001	1	2	1	54,98
2	1234	23/05/2005	1	1	3	89,91
3	12345	18/09/2015	2	3	3	76,23*/
DESCRIBE facturas;
ALTER TABLE facturas
DROP INDEX id_zapatilla;

INSERT INTO facturas (numero_factura,fecha,id_zapatilla,id_empleado, id_cliente, total)
VALUES (123,'2001-12-11',1,2,1,54.98), (1234,'2005-05-23',3,1,3,89.91), (12345,'2015-09-18',2,3,3,76.23) ;

/*De nuevo nos hemos dado cuenta que hay algunos errores en la inserción de datos. En este ejercicios los actualizaremos para que nuestra bases de datos este perfecta.
Tabla zapatillas: En nuestra tienda no vendemos zapatillas Rosas... ¿Cómo es posible que tengamos zapatillas de color rosa? 🤔 En realidad esas zapatillas son amarillas.
Tabla empleados: Laura se ha cambiado de ciudad y ya no vive en Alcobendas, se fue cerquita del mar, ahora vive en A Coruña.
Tabla clientes: El número de teléfono de Monica esta mal!!! Metimos un dígito de más. En realidad su número es: 123456728
Tabla facturas: El total de la factura de la zapatilla cuyo id es 2 es incorrecto. En realidad es: 89,91.*/

USE tienda_zapatillas;
SELECT * FROM zapatillas;
UPDATE zapatillas
SET color = "Amarillas"
WHERE color = "Rosas";
UPDATE empleados
SET tienda = "A Coruña"
WHERE nombre = "Laura";
SELECT * FROM empleados;
UPDATE facturas
SET total = 89.91
WHERE id_zapatillA = 2;
SELECT * FROM facturas;