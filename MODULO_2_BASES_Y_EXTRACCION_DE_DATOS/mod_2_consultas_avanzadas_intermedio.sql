USE tienda;
SELECT * FROM products;quantity_in_stockquantity_in_stock
/*Productos más baratos y caros de nuestra la bases de datos:
Desde la división de productos nos piden conocer el precio de los productos que tienen el precio más alto y más bajo. Dales el alias lowestPrice y highestPrice.*/

SELECT product_name, msrp	-- consulta de prueba
FROM products
ORDER BY msrp ASC
LIMIT 1;

SELECT product_name, msrp		-- consulta de prueba
FROM products
ORDER BY msrp DESC
LIMIT 1;

SELECT product_name, msrp,
    CASE 
        WHEN msrp = (SELECT MIN(msrp) FROM products) THEN 'lowestPrice'
        WHEN msrp = (SELECT MAX(msrp) FROM products) THEN 'highestPrice'
        END AS Min_Max_Price
FROM products
WHERE msrp IN ((SELECT MIN(msrp) FROM products), (SELECT MAX(msrp) FROM products))
ORDER BY msrp;

/*ALTERNATIVA CON UNIÓN
(SELECT product_name, msrp, 'lowestPrice' AS Min_Max_Price
 FROM products
 ORDER BY msrp ASC LIMIT 1)
UNION
(SELECT product_name, msrp, 'highestPrice' AS Min_Max_Price
 FROM products
 ORDER BY msrp DESC LIMIT 1);
 */

/*Conociendo el numero de productos y su precio medio:
Adicionalmente nos piden que diseñemos otra consulta para conocer el número de productos y el precio medio de todos ellos (en general, no por cada producto).*/
SELECT COUNT(*) AS Q_products, AVG(msrp) AS avgPrice
FROM products;

/*Sacad la máxima y mínima carga de los pedidos de UK:
Nuestro siguiente encargo consiste en preparar una consulta que devuelva la máxima y mínima cantidad de carga para un pedido (freight) enviado 
a Reino Unido (United Kingdom).*/
SELECT * FROM customers;
/*1.Identificar tablas:
maximo y minimo quantites
'customers': customer_number, country
'orders': order_number, status, customer_number
'order_details': order_number, quantities
2. Pasos de consulta:
	a.id de UK
    b.id de order
    c.status de order
    d.cantidad de order
*/
SELECT DISTINCT country FROM customers; -- UK 
SELECT customer_number FROM customers WHERE country = 'UK'; -- 187/201/240/324/489
SELECT order_number,status,customer_number FROM orders WHERE customer_number in (SELECT customer_number FROM customers WHERE country = 'UK'); -- consulta de prueba
SELECT order_number FROM orders WHERE customer_number in (SELECT customer_number FROM customers WHERE country = 'UK');
SELECT COUNT(DISTINCT(order_number)) FROM order_details;	-- consulta de prueba 326 ordenes // +2900 registros
SELECT * FROM orders;

SELECT order_number, min(quantity_ordered) AS Q_min, max(quantity_ordered) AS Q_max
FROM order_details
GROUP BY order_number;	-- consulta con máximos y mínimos por orden, sin filtrar país de cliente

SELECT DISTINCT order_number, min(quantity_ordered) AS Q_min, max(quantity_ordered) AS Q_max
FROM order_details
WHERE order_number IN (SELECT order_number FROM orders WHERE customer_number IN(SELECT customer_number FROM customers WHERE country = 'UK'))
GROUP BY order_number;

/*Qué productos se venden por encima del precio medio:
Después de analizar los resultados de alguna de nuestras consultas anteriores, desde el departamento de Ventas quieren conocer qué productos 
en concreto se venden por encima del precio medio para todos los productos de la empresa, ya que sospechan que dicho número es demasiado elevado.
También quieren que ordenemos los resultados por su precio de mayor a menor.*/
 
SELECT COUNT(*) FROM products;	-- 110 productos
SELECT AVG(msrp) AS avgPrice FROM products;	-- 100.438727

SELECT product_code,product_name,msrp 
FROM products 
WHERE msrp > (SELECT AVG(msrp) FROM products) 
ORDER BY msrp DESC;