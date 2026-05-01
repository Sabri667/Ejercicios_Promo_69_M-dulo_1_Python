/*Vamos a ver:
- Creación de esquemas: Esquema (colección de tablas)
- Creación de tablas
- Tipo de datos
- Restricciones
*/

    
/* 

Aquí también tenemos palabras clave como en Python y el nombre de tablas, columnas, etc., son algo así como nombres de variables.

Aquí las palabras clave se usan en MAYÚSCULAS y los nombres de tablas, esquemas y columnas en minúscula.

Algunas normas más:
- Se puede usar SQL en otros entornos y en otras herramientas, hasta en Python. Pero pueden variar detalles de la sintaxis
según donde se use.
- Aquí terminamos en ; y usamos identación por que quede más ordenado, aunque funcionará igual igual
- Palabras clave para crear esquema y tabla:
	CREATE SCHEMA
    CREATE TABLE
- Palabras clave para usar un esquema
    USE nombre_esquema
    

EJECUTAMOS ESTO: Lo seleciconamos y le damos al rayito. */

CREATE SCHEMA leccion_nueva;


/* 
Una vez que hemos creado el esquema, podremos empezar a crear tablas dentro de él.

EJEMPLO */

USE leccion_nueva;

"CREATE TABLE nombre_tabla (
	nombre_columna1 tipo_dato1 restriccion1,
    nombre_columna2 tipo_dato2 restriccion2,
    );"

CREATE TABLE clientas (
    id_clienta INT PRIMARY KEY,
    nombre_cliente VARCHAR(50) NOT NULL,
    email_cliente VARCHAR(100),
    fecha_registro DATE
);

/*TIPOS DE DATOS: Para asegurarnos de tener en nuestra tabla el tipo de dato que queremos

- NUMÉRICOS: 
		-SMALLINT: para números pequeños
        -INT: para números enteros de hasta 10 dígitos
        -BIGINT: Números más grandes
        -FLOAT: números con pocos decimales (6-7)
        -DOUBLE: números con muchos decimales
        -BOOL: 0 para False y 1 para True
	Los más usados son INT y FLOAT, dependiendo del tipo de dato.
    
    
- TEXTO: 
		-CHAR(tamaño): cadena de texto de tamaño FIJO, el número que le pasemos entre paréntesis va a ser JUSTO lo que ocupe
        -VARCHAR(tamaño): cadena de texto VARIABLE, el número de caracteres que le pasemos es el máximo que puede ocupar
        -ENUM(opciones): le pasamos las únicas opciones que puede haber en esa columna, si no es una de esas, nos dará error
        

- FECHA:
		-DATE: sigue el formato AAAA-MM-DD
		-TIME: sigue el formato HH:MM:SS
		-DATETIME combina ambos, la fecha va antes que la hora YYY-MM-DD HH:MM:SS
        -YEAR: guarda solo el año
    
    Veamos ejemplos*/
    
    CREATE TABLE productos (
    id_producto INT,
    nombre VARCHAR(100),
    color ENUM('rojo','amarillo','azul'),
    precio FLOAT,
    stock INT
);

/* ¿Qué pensáis de esta tabla? ¿Qué cosas mejoraríais?*/
    
    CREATE TABLE personas (
		dni CHAR(9),
        nombre VARCHAR(30),
        apellidos VARCHAR(80),
        edad INT,
        direccion VARCHAR(200),
        ciudad VARCHAR(50),
        sexo CHAR(1)
	 );
        


/*¿Y sobre las restricciones? 
RESTRICCIONES COLUMNAS:

- NOT NULL --> Este dato no puede ser nulo. Por ejemplo, una Primary Key no debe ser nula
- PRIMARY KEY --> Columna de referencia, va a ser única y no nula. Hay dor formas de hacerlo, lo vemos abajo.
- UNIQUE--> Cada valor debe ser único, pero puede haber nulos.
- CONSTRAINT y CHECK --> sirve para establecer una regla. Le damos un nombre a la restricción y luego la coprobamos
- DEFAULT--> Si no introducimos ningún dato, por defecto pone el dato que le pasemos al crear la tabla
- AUTO_INCREMENT --> Se va generando un numero de 1 en adelante
- FOREIGN KEY (columna) REFERENCES tabla(columna)
- ENUM, solo aceptará las opciones que le pasemos entre paréntesis

*/

  CREATE TABLE personas(
		id INT NOT NULL,
        nombre VARCHAR(30),
        apellido VARCHAR(30),
        edad INT,
        ciudad VARCHAR(20) DEFAULT 'Madrid'
	);
     
CREATE TABLE adalaber(
	dni CHAR(9) PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(60) NOT NULL,
    ciudad VARCHAR(30) DEFAULT 'Sin datos',
    direccion VARCHAR(100),
    correo VARCHAR(30) UNIQUE,
    telefono INT,
    curso VARCHAR(30) NOT NULL,
    conocimientos_previos ENUM('Sin', 'Poco', 'Mucho'),
    permiso_redes_sociales BOOL DEFAULT FALSE,
    fecha_registro DATE NOT NULL
    );
    
    
CREATE TABLE productos (
	id_producto INT AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    color ENUM('rojo', 'azul', 'amarillo'),
    precio FLOAT NOT NULL,
    CONSTRAINT precio_positivo CHECK (precio>0),
    categoria INT NOT NULL,
    PRIMARY KEY (id_producto),
    FOREIGN KEY (categoria) REFERENCES categorias(id_categoria)
    );

CREATE TABLE categorias (
	id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30),
    descripcion VARCHAR(30)

);

-- Pero también se puede usar sin el constraint
CREATE TABLE usuarios (
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    edad INT,
    CHECK (edad >= 18)
);

CREATE TABLE calificaciones (
    id INT PRIMARY KEY,
    nota INT,
    CHECK (nota BETWEEN 0 AND 100)
);
    
    
/* VAMOS A CREAR AHORA JUNTAS UNA TABLAS. POR EJEMPLO, UNA TABLA DE PELÍCULAS DE UN VIDEOCLUB */

CREATE TABLE peliculas (
	id_pelicula INT PRIMARY KEY AUTO_INCREMENT,
    nombre_pelicula VARCHAR (100) NOT NULL,
    duracion INT NOT NULL,
    año YEAR NOT NULL,
    generos ENUM ("Terror", "Accion", "Comedia", "Romance", "Ciencia Ficción") NOT NULL,
    director VARCHAR(30)
);


    
    
    
    
    
    
    
 
    
    
    /* 
	Hay veces que vamos a querer que al borrar una entrada en una tabla, se borre en otra o que se modifique.
    ¿Cómo hacemos eso? 

    
    - DELETE --> REFERENCES... ON DELETE CASCADE
    - UPDATE ---> REFERENCES... ON UPDATE CASCADE
    
    */
    
    CREATE TABLE notas_alumnas (
		id_notas INT NOT NULL AUTO_INCREMENT,
        id_alumna INT NOT NULL,
        nota FLOAT NOT NULL,
        PRIMARY KEY (id_notas),
        FOREIGN KEY (id_alumna) REFERENCES alumna(id_alumna)
        ON DELETE CASCADE
        ON UPDATE CASCADE
	);
    
    CREATE TABLE alumna (
		id_alumna INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(40) NOT NULL,
        edad INT
	);
    
    
/* 
-ERRORES QUE PUEDEN PASAR:
Si ya existe una tabla... ¿Cómo solucionarlo para que de warning, pero no dar error?*/ 


CREATE TABLE IF NOT EXISTS nombre_tabla;


/*
BORRAR TABLA*/ 

DROP TABLE IF EXISTS nombre_tabla;

-- o simplemente

DROP TABLE nombre_tabla;


-- CREAR UNA TABLA BASADA EN UNA TABLA

CREATE TABLE tabla2 AS
SELECT columna1,
	columna2,
    columna3
FROM tabla1; 


-- Ya iremos viendo cómo introducir y consultar los datos. Esto sería una consulta sencilla.
/* 



USE nombre_esquema;

SELECT nombre_columna
FROM nombre_tabla;



*/

USE sakila;
SELECT actor_id
FROM actor;

/*O más fácil y corto:

SELECT nombre_columna
FROM nombre_esquema.nombre_tabla */

SELECT first_name
FROM sakila.actor;

SELECT title,
film_id,
release_year
FROM film;

/* Por último...
Si hacemos la estructura de la BBDD en el diagrama, también se puede exportar el código para utilizarlo
Vayamos al diagrama...*/ 