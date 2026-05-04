USE tienda;
SELECT * FROM customers;
/*
Realiza una consulta SELECT que obtenga el número identificativo de cliente más bajo de la base de datos.
Selecciona el limite de crédito medio para los clientes de España.
Selecciona el numero de clientes en Francia.
Selecciona el máximo de crédito que tiene cualquiera de los clientes del empleado con número 1323.
¿Cuál es el número máximo de empleado de la tabla customers?
Realiza una consulta SELECT que seleccione el número de cada empleado de ventas, así como el numero de clientes distintos que tiene cada uno.
Selecciona el número de cada empleado de ventas que tenga más de 7 clientes distintos.
*/
SELECT min(customer_number) 
FROM customers;

SELECT avg(credit_limit) 
FROM customers;

SELECT COUNT(DISTINCT(customer_number)) 
FROM customers 
WHERE country='France'; -- SELECT customer_number FROM customers WHERE country='France';

SELECT max(credit_limit) 
FROM customers 
WHERE sales_rep_employee_number = 1323;

SELECT max(sales_rep_employee_number) 
FROM customers;

SELECT DISTINCT sales_rep_employee_number, customer_number 
FROM customers 
WHERE sales_rep_employee_number IS NOT NULL;

SELECT sales_rep_employee_number 
FROM customers 
GROUP BY sales_rep_employee_number 
HAVING COUNT(DISTINCT customer_number >7);

/*BONUS:
Selecciona el número de cada empleado de ventas, así como el numero de clientes distintos que tiene cada uno.
Asigna una etiqueta de "AltoRendimiento" a aquellos empleadoscon mas de 7 clientes distintos.
PENDIENTE SEGUIR DESDE ACA!!!
Selecciona el número de clientes en cada país.
Selecciona aquellos países que tienen clientes de más de 3 ciudades diferentes.
*/
SELECT sales_rep_employee_number, COUNT(DISTINCT customer_number) AS cant_clientes 
FROM customers GROUP BY sales_rep_employee_number ORDER BY cant_clientes DESC; -- consulta de prueba

SELECT sales_rep_employee_number, 
CASE WHEN COUNT(DISTINCT customer_number) > 7 THEN 'AltoRendimiento' END AS 'Rendimiento'
FROM customers WHERE sales_rep_employee_number IS NOT NULL
GROUP BY sales_rep_employee_number;

SELECT country, COUNT(DISTINCT customer_number) AS clientes_por_pais 
FROM customers 
GROUP BY country 
ORDER BY clientes_por_pais DESC;

SELECT country 
FROM customers 
GROUP BY country 
HAVING COUNT(DISTINCT city) > 3;

SELECT country, city, customer_number
FROM customers
WHERE country IN (
    SELECT country
    FROM customers
    GROUP BY country
    HAVING COUNT(DISTINCT city) > 3
)
ORDER BY country, city, customer_number;	-- consulta de prueba




