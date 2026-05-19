USE northwind;
/*EjerciciosOperadores Especiales de Filtro

Ciudades que empiezan con "A" o "B".
Por un extraño motivo, nuestro jefe quiere que le devolvamos una tabla con aquellas compañías que están afincadas en ciudades que empiezan por "A" o "B".
 Necesita que le devolvamos la ciudad, el nombre de la compañía y el nombre de contacto.*/
SELECT * FROM Customers;
SELECT City, CompanyName, ContactTitle
FROM Customers 
WHERE City REGEXP '^[a|b]'
ORDER BY City;

/*Número de pedidos que han hecho en las ciudades que empiezan con L.
En este caso, nuestro objetivo es devolver los mismos campos que en la query anterior el número de total de pedidos que han hecho todas las ciudades que empiezan por "L".*/
SELECT c.City, c.CompanyName, c.ContactTitle, COUNT(o.OrderID) 'total de pedidos'
FROM Customers c
JOIN Orders o
ON o.CustomerID=c.CustomerID
GROUP BY c.City, c.CompanyName, c.ContactTitle
HAVING c.City REGEXP '^[l]'
ORDER BY City;

/*Todos los clientes cuyo "country" no incluya "Sales".
Nuestro objetivo es extraer los clientes que no tengan el titulo de "Sales" en "ContactTitle" .
Extraer el nombre de contacto, su titulo de contacto y el nombre de la compañía.*/
SELECT c.ContactName,c.ContactTitle, c.CompanyName
FROM Customers c
WHERE c.ContactTitle REGEXP '^[^Sales]';

/*Todos los clientes que no tengan una "A" en segunda posición en su nombre.
Devolved unicamente el nombre de contacto.*/
SELECT c.ContactName,c.ContactTitle, c.CompanyName
FROM Customers c
WHERE c.ContactName REGEXP '^.[^Aa]';


/*Extraer toda la información sobre las compañías que tengamos en la bases de datos
Nuestros jefes nos han pedido que creemos una query que nos devuelva todos los clientes y proveedores que tenemos en la bases de datos.
Mostrad la ciudad a la que pertenecen, el nombre de la empresa y el nombre del contacto, además de la relación (Proveedor o Cliente). Pero importante! 
No debe haber duplicados en nuestra respuesta. La columna Relationship no existe y debe ser creada como columna temporal. 
Para ello añade el valor que le quieras dar al campo y utilizada como alias Relationship.
Nota: Deberás crear esta columna temporal en cada instrucción SELECT.*/
SELECT * FROM Customers;
SELECT * FROM Suppliers;

SELECT CAST(SupplierID AS CHAR(5)) ID, City, CompanyName, ContactName, 'Proveedor' as Relacion
FROM Suppliers
UNION
SELECT CAST(CustomerID AS CHAR(5)), City, CompanyName, ContactName, 'Cliente'
FROM Customers;

/*Extraer todas las categorías de la tabla categories que contengan en la descripción "sweet" o "Sweet".*/
SELECT * FROM Categories;
SELECT CategoryName,Description
WHERE Description regexp '[[:<:]]sweet[[:>:]]';
/*Extraed todos los nombres y apellidos de los clientes y empleados que tenemos en la bases de datos:
💡 Pista 💡 ¿Ambas tablas tienen las mismas columnas para nombre y apellido? Tendremos que combinar dos columnas usando concat para unir dos columnas. -->
*/