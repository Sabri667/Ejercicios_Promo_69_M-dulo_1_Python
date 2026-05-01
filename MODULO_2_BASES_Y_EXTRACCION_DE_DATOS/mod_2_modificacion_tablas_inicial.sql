CREATE SCHEMA mod_2_modificacion_tablas_inicial;
USE mod_2_modificacion_tablas_inicial;
CREATE TABLE tabla_1 (
	a INT,
    b CHAR(10)
    );
/* 
Renombra la tabla tabla_1 a tabla_2.
Cambia la columna a de tipo INTEGER a tipo TINYINT NOT NULL (manteniendo el mismo nombre para la columna).
Cambia la columna b de tipo CHAR de 10 caracteres a CHAR de 20 caracteres. Además, renombra la columna como c.
Añade una nueva columna llamada d de tipo TIMESTAMP.
Elimina la columna c que definiste en el ejercicio 3.
Crea una tabla llamada tabla_3 idéntica a la tabla tabla_2 (de manera automática, no definiéndola columna a columna).
Elimina la tabla original tabla_2 y en otra sentencia renombra la tabla tabla_3 como tabla_1.
*/
RENAME TABLE tabla_1 TO tabla_2;
ALTER TABLE tabla_2 MODIFY COLUMN a TINYINT NOT NULL;
ALTER TABLE tabla_2 CHANGE b c CHAR(20) NULL;
ALTER TABLE tabla_2 ADD COLUMN d TIMESTAMP;
ALTER TABLE tabla_2 DROP COLUMN c;
CREATE TABLE tabla_3 LIKE tabla_2;
DROP TABLE tabla_2;
RENAME TABLE tabla_3 TO tabla_1;

/* Ejercicio 8 */
/*Para los siguientes ejercicios vamos a usar las tablas ya creadas llamadas customers (clientes/as) y employees, 
que están en la base de datos tienda (que se cargo al inicio de este modulo).*/

USE creacion_tienda2;
/*CREATE TABLE IF NOT EXISTS customers_mod SELECT * FROM customers2;*/  -- comando indicado por ejercio, pero que no copia propiedad de PRIMARY KEY ni AUTO_INCREMENT.
CREATE TABLE IF NOT EXISTS customers_mod2 LIKE customers2;
INSERT creacion_tienda2.customers_mod2 (nombre,apellido,pais,ciudad,direccion,cp,mail,cumpleaños,telefono,creditLimit) 
VALUES ( "Julia", "Rodriguez", "España", "Madrid", "Calle False 123",28000, "julia@prueba.com", "1989/11/03", 0156984755, 20000000);
SELECT * FROM creacion_tienda2.customers_mod2;
DELETE FROM customers_mod2 WHERE id_customer=2;
SELECT * FROM creacion_tienda2.customers_mod2;
ALTER TABLE customers_mod2 MODIFY mail VARCHAR(120) NOT NULL UNIQUE;  -- no va a permitr cargar dos veces el registro
INSERT creacion_tienda2.customers_mod2 (nombre,apellido,pais,ciudad,direccion,cp,mail,cumpleaños,telefono,creditLimit) 
VALUES ( "Julia", "Rodriguez", "España", "Madrid", "Calle False 123",28000, "julia@prueba.com", "1989/11/03", 0156984755, 20000000);
INSERT creacion_tienda2.customers_mod2 (nombre,apellido,pais,ciudad,direccion,cp,mail,cumpleaños,telefono,creditLimit) 
VALUES ( "Juan", "Perez", "España", "Barcelona", "Avenida Goal 453", NULL, "juan25@prueba.com", "1950/12/22", 35789984755, 4652897), 
( "Veronica", "Perez", "España", "Barcelona", "Avenida Goal 453", NULL, "verolita@prueba.com", "1965/09/12", 5464784755, 50004697) ;
SELECT * FROM customers_mod2;
INSERT creacion_tienda2.customers_mod2 (nombre,apellido,pais,ciudad,direccion,cp,mail,cumpleaños,telefono,creditLimit) 
VALUES ( "Magali", "Suarez", "Italia", "Milan", "Av. Cervantes 6", NULL, "maga1425@prueba.com", NULL, NULL, 4652897), 
( "Luis", "Bunge", "Suiza", "Bern", "Avenida Argentina 1253", NULL, "luis233@prueba.com", "2000/06/13", NULL, 50004697),
( "Paula", "Bunge", "Suiza", "Bern", "Avenida Argentina 1253", NULL, "paus12sa@prueba.com", "2002/01/05", NULL, 50004697),
( "Diego", "Torres", "España", "Madrid", "Calle Gratarola 53",28000, "dieguis@prueba.com", "1989/10/25", 65487755, 20000000),
( "Justina", "Marquez", "Portugal", "Oslo", "Puntial False 45 C",28000, "justina@prueba.com", "1989/11/03", 65498725, 20000000) ;

UPDATE creacion_tienda2.customers_mod2 
SET cp = 01546, telefono = 1231231231
WHERE apellido = "Bunge"; -- debe modificar a 2 usuarios.

CREATE TABLE creacion_tienda2.costumer_delete LIKE customers_mod2;
INSERT INTO costumer_delete SELECT * FROM customers_mod2;

SELECT * FROM creacion_tienda2.costumer_delete;

UPDATE costumer_delete
SET nombre="Vamos",apellido="a",pais="arruinar",ciudad="la" ,direccion="base de datos!!";
SELECT * FROM creacion_tienda2.costumer_delete;

CREATE TABLE IF NOT EXISTS costumers_delete
SELECT * FROM
    customers_mod2;

UPDATE costumer_delete
SET creditLimit=1560000.59
LIMIT 4;

SELECT * FROM creacion_tienda2.costumer_delete;
DROP TABLE creacion_tienda2.costumer_delete;
SELECT * FROM creacion_tienda2.customers_delete;
SELECT * FROM creacion_tienda2.costumers_delete;
SELECT * FROM creacion_tienda2.costumer_delete;
USE creacion_tienda2;
DELETE FROM creacion_tienda2.costumers_delete; /*BORRA DATOS*/
SELECT * FROM creacion_tienda2.costumers_delete;
DROP TABLE creacion_tienda2.costumers_delete; /*ELIMINA TABLA*/
SELECT * FROM creacion_tienda2.customers_delete;


/*
Realiza una inserción de datos sobre la tabla customers introduciendo la siguiente información.

customernumber: 343
customername: Adalab
contactlastname: Rodriguez
contactfirstname: Julia
phone: 672986373
addressline1: Calle Falsa 123
addressline2: Puerta 42
city: Madrid
state: España
postalcode:28000
country: España
salesrepemployeeNumber: 15
creditlimit: 20000000
Realiza una inserción de datos sobre la tabla customers introduciendo la siguiente información. Fíjate que ahora no tenemos toda la información.

customernumber: 344
customername: La pegatina After
contactlastname: Santiago
contactfirsnName: Maricarmen
phone: 00000000
addressline1: Travesía del rave
addressline2: NULL
city: Palma de Mallorca
state: NULL
postalcode:07005
country: España
salesrepemployeenumber: 10
creditlimit: 45673453
Introduce ahora 5 filas nuevas con la información que consideres relevante para los campos disponibles en una misma instrucción. Se recuerda que el Indice(=la clave primaria), no es necesaria especificarla. En 3 de las nuevas filas debes dejar vacío el campo 'contactFirstName'

Actualiza ahora los datos faltantes correspondientes al CustomerName 'La pegatina After' con la siguiente información.

addressline1: Polígono Industrial de Son Castelló
addressline2: Nave 92
city: Palma de Mallorca
state: España
postalcode:28123
country: España
salesrepemployeenumber: 25
creditlimit: 5000000
Vamos ahora a romper a propósito la tabla con la que estamos trabajando, para ello primero vamos a realizar una copia de la misma antes de ejecutar lo siguiente. Con el nombre customers_destroy.

Para ello hacemos uso de la herramienta de exportación de datos de MySQL, como se explicaba en las guías del módulo 0 para la exportación y la importación de datos.
Una vez creada la copia y guardada a buen recaudo, vamos a actualizar algunos de los cambios sin especificar la condición del WHERE. Para ello modifica el campo los siguientes campos de

addressline1: Vamos
addressline2: a
postalcode: fastidiar
country: la tabla :)
Tras esto restaura la tabla que has trasteado con la copia que te has creado previamente.
Actualiza ahora los datos de la tabla customers_mod, para que las 10 primeras empresas sean gestionadas por la representante de ventas numero 2. El resto de empresas no deben ser modificadas.
Queremos ahora eliminar de los datos de la tabla aquellos registros que contengan un 'null' en el campo 'ContactFirstName'.
Ejecuta la instrucción de DELETE para la tabla customers_mod olvidando el WHERE como condición. Y observa lo que ha ocurrido.






