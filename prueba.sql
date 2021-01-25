--Creacion base de datos
CREATE DATABASE prueba;

--Entrar a base de datos
\c prueba

--Creacion de tablas
	--Tablas que almacenan informacion referente a los Productos
	CREATE TABLE categorias(
		id_categoria SERIAL PRIMARY KEY,
		nombre_categoria VARCHAR(20),
		descripcion_categoria VARCHAR(100)
	);
	CREATE TABLE precios(
		id_precio SERIAL PRIMARY KEY,
		precio_producto INT
	);
	CREATE TABLE productos(
		id_producto SERIAL PRIMARY KEY,
		id_categoria INT REFERENCES categorias(id_categoria),
		nombre_producto VARCHAR(20),
		descripcion_producto VARCHAR(100),
		precio_producto INT REFERENCES precios(id_precio)
	);

	--Tablas que almacena informacion referente a los clientes
	CREATE TABLE direccion(
		id_direccion SERIAL PRIMARY KEY,
		comuna VARCHAR(20),
		calle VARCHAR(20),
		numero_calle INT
	);
	CREATE TABLE cliente(
		id_cliente SERIAL PRIMARY KEY,
		nombre_cliente VARCHAR(20),
		apellido_cliente VARCHAR(20),
		rut VARCHAR(10),
		direccion INT REFERENCES direccion(id_direccion)
	);

	--Tablas que almacenan informacion respecto a la factura
	CREATE TABLE listado_productos(
		id_subtotal SERIAL PRIMARY KEY,
		producto1 INT REFERENCES productos(id_producto),
		precio1 INT REFERENCES precios(id_precio),
		cant1 INT,
		producto2 INT REFERENCES productos(id_producto),
		precio2 INT REFERENCES precios(id_precio),
		cant2 INT,
		producto3 INT REFERENCES productos(id_producto),
		precio3 INT REFERENCES precios(id_precio),
		cant3 INT,
		producto4 INT REFERENCES productos(id_producto),
		precio4 INT REFERENCES precios(id_precio),
		cant4 INT,
		valor_total INT
	);
	CREATE TABLE factura(
		id_factura SERIAL PRIMARY KEY,
		id_cliente INT REFERENCES cliente(id_cliente),
		fecha DATE,
		sub_total INT REFERENCES listado_productos(id_subtotal),
		iva INT,
		precio_total INT
	);

--Empiezo a poblar las tablas:

--Tablas Referente a los clientes:
	--direccion de clientes
	INSERT INTO direccion(comuna,calle,numero_calle) Values('Providencia','Av.bolivar', 123);
	INSERT INTO direccion(comuna,calle,numero_calle) Values('Maipu','Av.Bolivar', 321);
	INSERT INTO direccion(comuna,calle,numero_calle) Values('Huechuraba','C.tachira', 341);		
	INSERT INTO direccion(comuna,calle,numero_calle) Values('Ñuñoa','Av.Plaza', 521);
	INSERT INTO direccion(comuna,calle,numero_calle) Values('Vitacura','C.Andres Bello', 452);

	--Informacion de clientes:
	INSERT INTO cliente(nombre_cliente, apellido_cliente, rut, direccion) VALUES('Nahomi', 'Campos', '22456789-3', 1);
	INSERT INTO cliente(nombre_cliente, apellido_cliente, rut, direccion) VALUES('Debora', 'Martinez', '23465475-9', 2);
	INSERT INTO cliente(nombre_cliente, apellido_cliente, rut, direccion) VALUES('Julia', 'Suarez', '37816725-5', 3);
	INSERT INTO cliente(nombre_cliente, apellido_cliente, rut, direccion) VALUES('Sebastian', 'Saez', '36152818-4',4);
	INSERT INTO cliente(nombre_cliente, apellido_cliente, rut, direccion) VALUES('Marcos','Sanchez','18273928-2',5);

--Tablas Referente a los productos:
	--Categorias de los productos
	INSERT INTO categorias(nombre_categoria, descripcion_categoria) VALUES('Makeup Eyes', 'Todos los productos cuya aplicacion es en los ojos');
	INSERT INTO categorias(nombre_categoria, descripcion_categoria) VALUES('Makeup Labios', 'Todos los productos cuya aplicacion es en los labios');
	INSERT INTO categorias(nombre_categoria, descripcion_categoria) VALUES('Makeup Skin', 'Todos los productos cuya aplicacion es en la piel del rostro');

	--Precios de los productos
	INSERT INTO precios(precio_producto)
	VALUES(1200),(1300),(1400),(2200),(2400),(2500),(3500),(3600);

	--Insertar 8 productos
	INSERT INTO productos(id_categoria, nombre_producto, descripcion_producto, precio_producto)
	VALUES(1, 'Shiny Sparkle', 'Sombra de ojos con brillos', 1);
	INSERT INTO productos(id_categoria, nombre_producto, descripcion_producto, precio_producto)
	VALUES(1, 'Longer Black', 'Delineador de ojos negro 24Horas',2);
	INSERT INTO productos(id_categoria, nombre_producto, descripcion_producto, precio_producto)
	VALUES(1, 'Intense Blue', 'Sombra de ojos azul', 3);
	INSERT INTO productos(id_categoria, nombre_producto, descripcion_producto, precio_producto)
	VALUES(2, 'Red Tentation','Labial rojo terciopelo', 4);
	INSERT INTO productos(id_categoria, nombre_producto, descripcion_producto, precio_producto)
	VALUES(2, 'Purple Fix', 'Labial Morado de alta duracion', 5);
	INSERT INTO productos(id_categoria, nombre_producto, descripcion_producto, precio_producto)
	VALUES(2, 'Top Drama','Labial Matte color fucsia', 6);
	INSERT INTO productos(id_categoria, nombre_producto, descripcion_producto, precio_producto)
	VALUES(3, 'Aloha moha', 'Bronceador facial', 7);
	INSERT INTO productos(id_categoria, nombre_producto, descripcion_producto, precio_producto)
	VALUES(3, 'Peach Soft', 'Rubor color durazno', 8);

--Tablas referente a las Facturas
	--2 para el cliente 1, con 2 y 3 productos
		-- CLIENTE 1 FACTURA 1(2P)
			INSERT INTO listado_productos(producto1,precio1,cant1,producto2,precio2,cant2,producto3,precio3,cant3,producto4,precio4,cant4,valor_total)
				VALUES
				(1,1,1,2,2,1,null,null,null,null,null,null,2500);
			INSERT INTO factura(id_cliente,fecha,sub_total,iva,precio_total
				)
				VALUES
				(1,'2021/01/01', 1, 300, 2800);

		-- CLIENTE 1 FACTURA 2(3P)
			INSERT INTO listado_productos(producto1,precio1,cant1,producto2,precio2,cant2,producto3,precio3,cant3,producto4,precio4,cant4,valor_total)
				VALUES
				(8,8,2,5,5,1,null,null,null,null,null,null,9600);
			INSERT INTO factura(id_cliente,fecha,sub_total,iva,precio_total)
				VALUES
				(1,'2021/01/02', 2, 1152, 10752);


	--3 para el cliente 2, con 3, 2 y 3 productos
		--CLIENTE 2 FACTURA 1(3P)
			INSERT INTO listado_productos(producto1,precio1,cant1,producto2,precio2,cant2,producto3,precio3,cant3,producto4,precio4,cant4,valor_total)
				VALUES
				(3,3,1,6,6,1,2,2,1,null,null,null,5200);
			INSERT INTO factura(id_cliente,fecha,sub_total,iva,precio_total)
				VALUES
				(2,'2021/01/03', 3, 624, 5824);

		--CLIENTE 2 FACTURA 2(2P)
			INSERT INTO listado_productos(producto1,precio1,cant1,producto2,precio2,cant2,producto3,precio3,cant3,producto4,precio4,cant4,valor_total)
				VALUES
				(4,4,2,null,null,null,null,null,null,null,null,null,4400);
			INSERT INTO factura(id_cliente,fecha,sub_total,iva,precio_total)
				VALUES
				(2,'2021/01/04', 4, 528, 4928);

		--CLIENTE 2 FACTURA 3(3P)
			INSERT INTO listado_productos(producto1,precio1,cant1,producto2,precio2,cant2,producto3,precio3,cant3,producto4,precio4,cant4,valor_total)
				VALUES
				(8,8,1,6,6,1,1,1,1,null,null,null,7300);
			INSERT INTO factura(id_cliente,fecha,sub_total,iva,precio_total)
				VALUES
				(2,'2021/01/05', 5, 876, 8176);


	--1 para el cliente 3, con 1 producto
		--CLIENTE 3 FACTURA 1(1P)
			INSERT INTO listado_productos(producto1,precio1,cant1,producto2,precio2,cant2,producto3,precio3,cant3,producto4,precio4,cant4,valor_total)
				VALUES
				(7,7,1,null,null,null,null,null,null,null,null,null,3500);
			INSERT INTO factura(id_cliente,fecha,sub_total,iva,precio_total)
				VALUES
				(3,'2021/01/06', 6, 420, 3920);


	--4 para el cliente 4, con 2, 3, 4 y 1 producto
		--CLIENTE 4 FACTURA 1(2P)
			INSERT INTO listado_productos(producto1,precio1,cant1,producto2,precio2,cant2,producto3,precio3,cant3,producto4,precio4,cant4,valor_total)
				VALUES
				(1,1,1,4,4,1,null,null,null,null,null,null,3400);
			INSERT INTO factura(id_cliente,fecha,sub_total,iva,precio_total)
				VALUES
				(4,'2021/01/07', 7, 408, 3808);

		--CLIENTE 4 FACTURA 2(3P)
			INSERT INTO listado_productos(producto1,precio1,cant1,producto2,precio2,cant2,producto3,precio3,cant3,producto4,precio4,cant4,valor_total)
				VALUES
				(5,5,1,6,6,2,null,null,null,null,null,null,7400);
			INSERT INTO factura(id_cliente,fecha,sub_total,iva,precio_total)
				VALUES
				(4, '2021/01/08', 8, 888, 8288);

		--CLIENTE 4 FACTURA 3(4P)
			INSERT INTO listado_productos(producto1,precio1,cant1,producto2,precio2,cant2,producto3,precio3,cant3,producto4,precio4,cant4,valor_total)
				VALUES
				(3,3,1,4,4,1,6,6,1,2,2,1,7400);
			INSERT INTO factura(id_cliente,fecha,sub_total,iva,precio_total)
				VALUES
				(4,'2021/01/09',9,888,8288);

		--CLIENTE 4 FACTURA 4(1P)
			INSERT INTO listado_productos(producto1,precio1,cant1,producto2,precio2,cant2,producto3,precio3,cant3,producto4,precio4,cant4,valor_total)
				VALUES
				(7,7,1,null,null,null,null,null,null,null,null,null,3500);
			INSERT INTO factura(id_cliente,fecha,sub_total,iva,precio_total)
				VALUES
				(4,'2021/01/10',10,420,3920);

--CONSULTAS:
	--¿Que cliente realizó la compra más cara?
	SELECT cliente.nombre_cliente, factura.precio_total FROM cliente INNER JOIN factura ON cliente.id_cliente = factura.id_cliente WHERE factura.precio_total = (SELECT MAX(factura.precio_total) FROM factura);

	--¿Que cliente pagó sobre 100 de monto? (Lo modifique a 5000)
	SELECT cliente.nombre_cliente, factura.precio_total FROM cliente INNER JOIN factura ON cliente.id_cliente = factura.id_cliente WHERE factura.precio_total >= 5000;

	--¿Cuantos clientes han comprado el producto 6
	SELECT COUNT(id_factura) FROM factura INNER JOIN listado_productos ON factura.sub_total = listado_productos.id_subtotal WHERE producto1 = 6 OR producto2 = 6 OR producto3 = 6 OR producto4 = 6;