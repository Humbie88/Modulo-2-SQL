--Pasos a seguir

--a) Crear la base de datos con el archivo create_restaurant_db.sql

-- Este paso se realizó en la tutoría y se encuentra en el archivo: "ejercicio caso practico"

--b) Explorar la tabla “menu_items” para conocer los productos del menú.

select * from menu_items;

	--1.- Realizar consultas para contestar las siguientes preguntas:
	
		-- Encontrar el número de artículos en el menú.

select distinct item_name
from menu_items;	

select count (distinct item_name)
from menu_items;
			
		--¿Cuál es el artículo menos caro y el más caro en el menú?

SELECT item_name, price
FROM menu_items
WHERE price = (SELECT MIN(price) FROM menu_items)

SELECT item_name, price
FROM menu_items
WHERE price = (SELECT Max(price) FROM menu_items)

		
		--¿Cuántos platos americanos hay en el menú?

SELECT COUNT(*) as platos_americanos
FROM menu_items
WHERE category LIKE '%American%';
			
		--¿Cuál es el precio promedio de los platos?

select round(avg(price),2) 
from menu_items;
			
--c) Explorar la tabla “order_details” para conocer los datos que han sido recolectados. 

select * from order_details;

	--1.- Realizar consultas para contestar las siguientes preguntas:
	
		--¿Cuántos pedidos únicos se realizaron en total?

select count(distinct order_id) as pedidos_unicos
from order_details;
		
		--¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?


select order_id, count(item_id) as total_pedidos
from order_details
group by order_id
order by total_pedidos desc
limit 5;


		--¿Cuándo se realizó el primer pedido y el último pedido?

select  min(order_date)
from order_details;

select  max(order_date)
from order_details;

select order_date, order_id
from order_details
order by order_date asc
Limit 1;

select order_date, order_id
from order_details
order by order_date desc
Limit 1;

		--¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?

select count(distinct(order_id)) 
from order_details
where order_date between '2023-01-01'and '2023-01-05'
		
--d) Usar ambas tablas para conocer la reacción de los clientes respecto al menú.

	/*1.- Realizar un left join entre order_details y menu_items con el
	identificador item_id(tabla order_details) y menu_item_id(tabla menu_items).*/

select * from menu_items;

select * from order_details;

select m.menu_item_id, m.item_name, m.category, m.price, o.order_details_id, o.order_id, o.order_date, o.order_time, o.item_id
from menu_items as m
left join order_details as o
on m.menu_item_id = o.item_id

	
		/*e) Una vez que hayas explorado los datos en las tablas correspondientes y 
		respondido las preguntas planteadas, realiza un análisis adicional utilizando 
		este join entre las tablas.
		
		El objetivo es identificar 5 puntos clave que puedan ser de utilidad para los 	
		dueños del restaurante en el lanzamiento de su nuevo menú.
		
		Para ello, crea tus propias consultas y utiliza los resultados obtenidos para 
		llegar a estas conclusiones.*/


								--	PUNTOS CLAVE 

/*

1.- La hamburguesa es el artículo más vendido, por lo cual se debe de impulsar la 
venta de otros productos mediante promociones o combos que incluyan a la hamburguesa.

2.- Los Chicken Tacos son el artículo menos vendido, por lo que se debería considerar
retirar esta opción del menú. 

3.- El Korean Beef Bowl es el artículo que más dinero entregó al restaurante. Sería conveniente,
validar el porcentage de ganancia que entrega.

4.- Los chicken tacos coinciden tambien en ser el artículo que menos dinero genera.
	Validar el porcentaje de ganancia que entrega y compararlo con el porcentaje del
	Korean Beef Bowl para obtener una perspectiva de las ganancias reales de los productos.
	Confirmamos que es un producto que se debería retirar del menú, sin embargo, 
	deberiamos considerar cual es la estratégia de negocio del restaurante y por que tenemos
	una amplia variadad de platillos.

5.- A pesar de que la hamburguesa es el artículo más vendido, la categoría de comida 
	americana es la menos vendida, sería conveniente evaluar si se deberían retirar del 
	menú algunos platillos.


	
	




*/ 

		

--1.- ¿Cuál es el artículo que más se ordenó?

select m.item_name, count(o.item_id) as ordenes_totales
from menu_items as m
left join order_details as o
on m.menu_item_id = o.item_id
group by m.item_name
order by ordenes_totales desc
limit 1;
			
--2.- ¿Cuál es el artículo que menos se ordenó?

select m.item_name, count(o.item_id) as ordenes_totales
from menu_items as m
left join order_details as o
on m.menu_item_id = o.item_id
group by m.item_name
order by ordenes_totales asc
limit 1;
			
--3.- ¿Cuál es el artículo que obtuvo mayor ingreso de ventas?

select m.item_name, sum(m.price) as ingreso_ventas
from menu_items as m
left join order_details as o
on m.menu_item_id = o.item_id
group by m.item_name
order by ingreso_ventas desc
limit 1;


--4.- ¿Cuál es el artículo que obtuvo menor ingreso de ventas?

select m.item_name, sum(m.price) as ingreso_ventas
from menu_items as m
left join order_details as o
on m.menu_item_id = o.item_id
group by m.item_name
order by ingreso_ventas asc
limit 1;
			
--5.- ¿Qué categoría generó menor ingreso de ventas?

select m.category, sum(m.price) as ventas_categoria
from menu_items as m
left join order_details as o
on m.menu_item_id = o.item_id
group by m.category
order by ventas_categoria asc
limit 3;
	