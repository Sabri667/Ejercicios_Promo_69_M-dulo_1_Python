USE tienda;
/*Ejercicios Subconsultas
La tabla customers tiene las siguientes columnas:

customer_number: el número identificativo de las clientas/es. Es un número entero y sirve de clave primaria.
customer_name: el nombre de las empresas en las que trabajan las/los clientas/es. Es una cadena de texto.
contact_last_name: El apellido de la persona de contacto en la empresa cliente. Es una cadena de texto.
contact_first_name: El nombre de la persona de contacto en la empresa cliente. Es una cadena de texto.
phone: El teléfono de la persona de contacto en la empresa cliente. Es una cadena de texto (ya que hay espacios).
address_line1: La dirección (calle, número, etc.) de la empresa cliente. Es una cadena de texto.
address_line2: La dirección de la empresa cliente (si se necesita mas espacio). Es una cadena de texto. Muchas veces está vacía.
city: La ciudad de la empresa cliente. Es una cadena de texto.
state: El estado en el que se encuentra la empresa cliente. Válido para los Estados Unidos. Es una cadena de texto.
postal_code: El código postal. Es una cadena de texto (ya que puede haber espacios).
country: El país de la empresa cliente. Es una cadena de texto.
sales_rep_employee_number: El número identificador de la empleada o empleado que lleva a esa empresa cliente. Es un número entero.
credit_limit: El límite de crédito que tiene la empresa cliente. Es un número decimal.

La tabla Employees tiene las siguientes columnas:

employee_number: el número identificativo de las empleadas/os. Es un número entero y sirve de clave primaria.
last_name: el apellido de las empleadas. Es una cadena de texto.
first_name: el nombre de las empleadas. Es una cadena de texto.
extension: su extensión telefónica. Es una cadena de texto.
email: el correo electrónico de la empleada. Es una cadena de texto.
office_code: El código de la oficina de la empleada. Es una cadena de texto.
reports_to: el número identificativo de la empleada a la que reporta (su supervisora). Es un número entero y clave foránea (relacionada con employeeNumber).
job_title: el nombre del puesto de trabajo que desempeña. Es una cadena de texto.

La tabla Offices tiene las siguientes columnas:

office_code: El código de la oficina. Es un número entero y sirve de clave primaria.
city: nombre de la ciudad donde se encuentra la oficina. Es una cadena de texto.
phone: Teléfono de la oficina. Es una cadena de texto.
address_line1: La dirección de la oficina. Es una cadena de texto.
address_line2: La dirección secundaria de la oficina, por si hubiera algún carácter que no cupiera en la columna de la primera dirección. Es una cadena de texto.
state: El estado en que se encuentra dicha oficina (Para el caso de EEUU o países que agreguen otros países). Es una cadena de texto.
country: país en el cual se encuentra la oficina. Es una cadena de texto.
postal_code: El código postal de la oficina. Es una cadena de texto.
territory: Designación geográfica del territorio donde se encuentra dicha oficina. Es una cadena de texto.
*/

/*Calcula el numero de clientes por cada ciudad.*/
SELECT city 'Ciudad',COUNT(customer_number) 'Total de clientes por ciudad'
FROM customers
GROUP BY city;

/*Usando la consulta anterior como subconsulta, selecciona la ciudad con el mayor numero de clientes.*/
SELECT city, COUNT(customer_number) 'Total de clientes por ciudad'
FROM customers
GROUP BY city
HAVING COUNT(customer_number) = (
SELECT MAX(total) FROM (
						SELECT city 'Ciudad',COUNT(customer_number) 'total'FROM customers GROUP BY city
) AS subconsulta
);

/*Por último, usa todas las consultas anteriores para seleccionar el customerNumber, nombre y apellido de las clientas asignadas a la ciudad con mayor 
numero de clientas.*/

SELECT customerNumber, first_name,last_name
FROM customers
GROUP BY city
HAVING COUNT(customer_number) = (
SELECT MAX(total) FROM (
						SELECT city 'Ciudad',COUNT(customer_number) 'total'FROM customers GROUP BY city
) AS subconsulta
);

/*Queremos ver ahora que empleados tienen algún contrato asignado con alguno de los clientes existentes. Para ello selecciona 
employeeNumber como 'Número empleado', firstName como 'nombre Empleado' y lastName como 'Apellido Empleado'

Queremos ver ahora en cuantas ciudades en las cuales tenemos clientes, no también una oficina de nuestra empresa para ello: Selecciona aquellas
 ciudades como 'ciudad' y los nombres de las empresas como 'nombre de la empresa ' de la tabla customers, 
sin repeticiones, que no tengan una oficina en dicha ciudad de la tabla offices.*/