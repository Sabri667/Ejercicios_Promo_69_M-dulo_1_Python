CREATE SCHEMA mod_2_ejercicio_creacion_tablas_inicial;
USE mod_2_ejercicio_creacion_tablas_inicial;
/*Ejercicio 1*/

-- =============================================
-- SCHEMA PRINCIPAL
-- =============================================
CREATE SCHEMA mod_2_ejercicio_creacion_tablas_inicial;
USE mod_2_ejercicio_creacion_tablas_inicial;

/* Ejercicio 1 */
CREATE TABLE empleadas(
    id_empleada INT AUTO_INCREMENT PRIMARY KEY,  
    salario INT NOT NULL,
    nombre VARCHAR(60) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    pais VARCHAR(50) NOT NULL 
);

/* Ejercicio 2 */
CREATE TABLE personas (
    id INT NOT NULL,
    apellido VARCHAR(255) NOT NULL,
    nombre VARCHAR(255),
    edad INT,
    ciudad varchar(255) DEFAULT 'Madrid'
);

CREATE TABLE personas2 (
    id INT NOT NULL,
    apellido VARCHAR(255) NOT NULL,
    nombre VARCHAR(255),
    edad INT,
    ciudad varchar(255) DEFAULT 'Madrid',
    CONSTRAINT mayor_edad CHECK (edad >= 18)    
);

/* Ejercicio 3 */
CREATE TABLE empleadas_proyectos (
    id_empleada INT NOT NULL, 
    id_proyecto INT AUTO_INCREMENT PRIMARY KEY,
    FOREIGN KEY (id_empleada) REFERENCES empleadas(id_empleada)
        ON DELETE CASCADE
);

/* =============================================
   Ejercicio 4 - Nuevo schema Tienda
   ============================================= */
CREATE SCHEMA creacion_tienda2;
USE creacion_tienda2;

CREATE TABLE customers(
    id_customers INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    pais VARCHAR(60) NOT NULL,
    ciudad VARCHAR(60) NOT NULL,
    direccion VARCHAR(120) NOT NULL,
    cp INT(6) DEFAULT NULL,          
    mail VARCHAR(70) NOT NULL,
    cumpleaños DATE,
    telefono VARCHAR(20),            
    creditLimit decimal(10,2) DEFAULT NULL
);

/* BONUS: Ejercicio 5 */
CREATE TABLE employees(
    id_employee INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(100) NOT NULL, 
    salario FLOAT NOT NULL,
    pais VARCHAR(60) NOT NULL      
);

/* BONUS: Ejercicio 6 */
CREATE TABLE customers2 (
    id_customer INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    pais VARCHAR(60) NOT NULL,
    ciudad VARCHAR(60) NOT NULL,
    direccion VARCHAR(120) NOT NULL,
    cp INT(6) DEFAULT NULL,
    mail VARCHAR(70) NOT NULL,
    cumpleaños DATE,
    telefono VARCHAR(20),             
    creditLimit decimal(10,2) DEFAULT NULL,
    CONSTRAINT credito_positivo CHECK(creditLimit >= 0)   
);
