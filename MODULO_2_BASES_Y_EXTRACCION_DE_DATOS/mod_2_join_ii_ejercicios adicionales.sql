USE northwind;
/* 🟡 Ejercicios Intermedios

### 1. Productos sin pedidos
**Objetivo:** Listar todos los productos que nunca han sido pedidos.  
**Campos a mostrar:** `ProductID`, `ProductName`, `SupplierID`.  
**Ayuda:** `LEFT JOIN` entre `Products` y `OrderDetails` + verificar `NULL`. */

SELECT p.ProductID, p.ProductName, p.SupplierID
FROM Products p
LEFT JOIN orderdetails o
ON o.ProductID=p.ProductID
WHERE o.OrderID IS NULL;

/*### 2. Empleados con más de 10 pedidos en 1997
**Objetivo:** Mostrar `EmployeeID`, `FirstName`, `LastName` y la cantidad total de pedidos gestionados durante el año 1997.  
**Filtro:** Solo empleados con más de 10 pedidos en ese año.  
**Ayuda:** `COUNT` y `GROUP BY` + `HAVING`.*/

SELECT e.EmployeeID, e.FirstName, e.LastName, Count(o.OrderID) AS total_pedidos_gestionados_1997
FROM Employees e
LEFT JOIN Orders o 
ON e.EmployeeID=o.EmployeeID
AND OrderDate BETWEEN '1997-01-01'AND'1997-12-31'
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING COUNT(o.OrderID) >10;

/*### 3. Cliente con el mayor gasto total
**Objetivo:** Encontrar el cliente que ha gastado más dinero en toda la historia (suma de `UnitPrice * Quantity * (1 - Discount)`).  
**Mostrar:** `CustomerID`, `CompanyName`, `TotalGastado`.  
**Ayuda:** Unir `Customers`, `Orders`, `OrderDetails`; usar `SUM` y `ORDER BY LIMIT 1`.*/

SELECT c.CustomerID, c.CompanyName, SUM(od.UnitPrice*od.Quantity*(1-od.Discount)) 'TotalGastado'
FROM Customers c
JOIN Orders o
ON c.CustomerID=o.CustomerID
JOIN orderdetails od
ON o.OrderID=od.OrderID
GROUP BY c.CustomerID, c.CompanyName
ORDER BY TotalGastado DESC
LIMIT 1;

/*### 4. Productos que han sido pedidos por más de 5 clientes distintos
**Objetivo:** Listar `ProductID`, `ProductName` y la cantidad de clientes diferentes que lo compraron.  
**Filtro:** Solo productos con más de 5 clientes distintos.  
**Ayuda:** `COUNT(DISTINCT Customers.CustomerID)` y unir varias tablas.*/

SELECT p.ProductID, p.ProductName, COUNT(DISTINCT o.CustomerID) 'TotalClientes'
FROM Products p
LEFT JOIN orderdetails od
ON p.ProductID=od.ProductID
LEFT JOIN Orders o
ON od.OrderID=o.OrderID
GROUP BY p.ProductID, p.ProductName
HAVING TotalClientes >5
ORDER BY TotalClientes DESC;

/*### 5. Comparativa de ventas por categoría entre 1996 y 1997
**Objetivo:** Mostrar `CategoryName`, `TotalVentas1996`, `TotalVentas1997`, y la diferencia porcentual.  
**Ayuda:** Dos subconsultas o uso de `SUM(CASE WHEN YEAR(...) = ... THEN ... END)`.*/

SELECT c.CategoryName,
	   (CASE WHEN oo.OrderDate BETWEEN '1996-01-01'AND'1996-12-31' 
		THEN ROUND(SUM(o.UnitPrice*o.Quantity*(1-o.Discount)),2) END) AS TotalVentas1996,
	   (CASE WHEN oo.OrderDate BETWEEN '1997-01-01' AND'1997-12-31' 
		THEN ROUND(SUM(o.UnitPrice*o.Quantity*(1-o.Discount)),2) END) AS TotalVentas1997
FROM Categories c
LEFT JOIN Products p
ON c.CategoryID=p.CategoryID
LEFT JOIN orderdetails o
ON p.ProductID = o.ProductID
LEFT JOIN Orders oo
ON o.OrderID = oo.OrderID
GROUP BY c.CategoryName;


/*## 📌 Ejercicio 6 – Clasificar empleados por antigüedad

**Contexto:**  
Tabla `Employees` (EmployeeID, FirstName, LastName, HireDate)  
Tabla `Orders` (OrderID, EmployeeID, OrderDate)

**Enunciado:**  
Obtén por cada empleado: su nombre completo (Nombre Apellido), la cantidad total de pedidos que gestionó y una columna llamada `antiguedad` que clasifique:
- `'Junior'` si tiene menos de 5 años de antigüedad (desde su contratación hasta hoy o hasta el último pedido) --se toma 1998-05-06
- `'Senior'` si tiene entre 5 y 10 años
- `'Experto'` si tiene más de 10 años

**Ayuda:**  
Usa `TIMESTAMPDIFF(YEAR, HireDate, CURDATE())` y un `CASE` en el `SELECT`.  
Necesitas `LEFT JOIN` entre Employees y Orders, luego `GROUP BY` empleado y contar pedidos.
---*/
SELECT * FROM Employees;
SELECT * FROM Orders;
SELECT CONCAT(e.FirstName,' ',e.LastName) 'Nombre y Apellidos', COUNT(o.OrderID)'Cantidad de Pedidos',
(CASE 
WHEN TIMESTAMPDIFF(YEAR, e.HireDate, '1998-05-06') > 10 THEN 'Experto' 	-- curdate() formula correcta pero no habria distintas categorias
WHEN TIMESTAMPDIFF(YEAR, e.HireDate, '1998-05-06') BETWEEN 5 AND 10 THEN 'Senior' 
ELSE 'Junior' 
END) 
'Antiguedad'
FROM Employees e
LEFT JOIN Orders o
ON e.EmployeeID=o.EmployeeID
GROUP BY e.EmployeeID
ORDER BY 2 DESC;
SELECT * FROM Employees;
/*## 📌 Ejercicio 7 – Productos sin ventas en 1997 pero sí en 1996

**Contexto:**  
Tablas: `Products`, `OrderDetails`, `Orders`

**Enunciado:**  
Lista los productos (ProductName) que **no** tuvieron ninguna venta (cantidad > 0) durante el año 1997, pero **sí** tuvieron al menos una venta en 1996.  
Muestra también las unidades totales vendidas en 1996.

**Ayuda:**  
Haz dos agregaciones condicionales con `CASE` dentro de `SUM` o usa subconsultas.  
Filtra fechas con `YEAR(OrderDate)`.  
Recuerda `LEFT JOIN` para mantener productos sin ventas en 1997.

---

## 📌 Ejercicio 8 – Categorías con rango de precios según su producto más caro

**Contexto:**  
`Categories`, `Products`

**Enunciado:**  
Para cada categoría, muestra:
- Nombre de la categoría
- Precio máximo de sus productos (UnitPrice)
- Una columna `rango_precio` usando `CASE`:
  - `'Económica'` si el precio máximo es < 20
  - `'Media'` si está entre 20 y 50
  - `'Alta'` si es > 50

Además, incluye la cantidad de productos que tiene la categoría.

**Ayuda:**  
`LEFT JOIN` y `GROUP BY CategoryID`.  
El `CASE` se aplica sobre `MAX(UnitPrice)`.

---

## 📌 Ejercicio 9 – Comparativa de ventas por trimestre entre dos años

**Contexto:**  
`Orders` y `OrderDetails`

**Enunciado:**  
Obtén una tabla que muestre, para el año **1996** y **1997**, el total vendido (UnitPrice * Quantity * (1-Discount)) **por trimestre** (1, 2, 3, 4).  
El resultado debe tener 4 filas (una por trimestre) y las columnas:
- `trimestre`
- `ventas_1996`
- `ventas_1997`

**Ayuda:**  
Extrae el trimestre con `QUARTER(OrderDate)`.  
Usa `SUM(CASE WHEN YEAR(...)=1996 THEN ... ELSE 0 END)` para cada año.  
Agrupa por trimestre.

---

## 📌 Ejercicio 10 – Clientes con pedidos "grandes" y "pequeños"

**Contexto:**  
`Customers`, `Orders`, `OrderDetails`

**Enunciado:**  
Para cada cliente (CustomerID, CompanyName), calcula:
- Cantidad total de pedidos realizados
- Cantidad de pedidos cuyo monto total (suma de los detalles) sea **mayor a 1000** → llamarlos `'Grande'`
- Cantidad de pedidos con monto **<= 1000** → `'Pequeño'`

Muestra solo los clientes que tengan al menos 5 pedidos en total, ordenados de mayor a menor cantidad de pedidos grandes.

**Ayuda:**  
Necesitas primero calcular el monto por pedido (con `SUM` y `GROUP BY OrderID` en una subconsulta o CTE), luego unir con Customers y aplicar `CASE` para contar según rango.  
Otra forma: con `CASE` dentro de `COUNT` y usar `HAVING` para filtrar.

---
*/


/*## 🔴 Ejercicios Avanzados

### 11. Ranking de empleados por ventas (con función ventana)
**Objetivo:** Mostrar `EmployeeID`, `FirstName`, `LastName`, `TotalVentas` y un ranking (`RANK()`) ordenado por ventas de mayor a menor.  
**Ayuda:** Ventana `RANK() OVER (ORDER BY SUM(...) DESC)`.



### 12. Pedidos cuyo valor total supera el promedio de todos los pedidos
**Objetivo:** Listar `OrderID`, `CustomerID`, `FechaPedido`, `TotalPedido`.  
**Filtro:** Solo pedidos cuyo `TotalPedido` sea mayor al promedio de todos los pedidos.  
**Ayuda:** Subconsulta en `WHERE` o `HAVING`.



### 13. Empleados que ganan más que el promedio de su ciudad
**Objetivo:** Mostrar `EmployeeID`, `FirstName`, `LastName`, `City`, `Salary` y `PromedioCiudad`.  
**Filtro:** Solo empleados con salario superior al promedio de su propia ciudad.  
**Ayuda:** Subconsulta correlacionada o `JOIN` con una subconsulta agrupada por ciudad.



### 14. Productos que nunca se vendieron junto con otro producto específico
**Objetivo:** Dado un `ProductID` (ej. 7 = “Uncle Bob's Organic Dried Pears”), encontrar todos los productos que **nunca** aparecieron en el mismo pedido que él.  
**Ayuda:** Usar `NOT EXISTS` o `EXCEPT` / `NOT IN` con pares de productos.



### 15. Vista de resumen mensual (pivot de ventas por categoría)
**Objetivo:** Construir una consulta que muestre, para cada mes del año 1997, las ventas totales de cada categoría en columnas separadas.  
**Formato esperado:**  
| Mes | Bebidas | Condimentos | Confites | Lácteos | … |  
**Ayuda:** `SUM(CASE WHEN Categories.CategoryName = 'Bebidas' THEN ... END)` + agrupación por mes.

---
*/