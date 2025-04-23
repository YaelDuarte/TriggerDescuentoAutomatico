CREATE DATABASE VentasConDes;
USE VentasConDes;

CREATE TABLE clientes(
	idCliente INT PRIMARY KEY,
    nombre VARCHAR(100),
    descuentos_activos BOOLEAN DEFAULT FALSE,
    descuento_hasta DATE DEFAULT NULL
);

CREATE TABLE ventas (
	idVentas INT PRIMARY KEY auto_increment,
    idCliente INT,
    fecha_de_venta DATE,
    precio DECIMAL (10,2),
    precio_final DECIMAL (10,2),
    FOREIGN KEY (idCliente) REFERENCES clientes(idCliente)
);

INSERT INTO clientes (idCliente, nombre) VALUES
(1, 'Ana Pérez'),
(2, 'Carlos Gómez'),
(3, 'Lucía Torres');

-- Ventas para cliente 1 (8 ventas en abril)
INSERT INTO ventas (idCliente, fecha_de_venta, precio, precio_final) VALUES
(1, '2025-04-01', 100.00, 100.00),
(1, '2025-04-02', 80.00, 80.00),
(1, '2025-04-03', 50.00, 50.00),
(1, '2025-04-04', 30.00, 30.00),
(1, '2025-04-05', 120.00, 120.00),
(1, '2025-04-06', 90.00, 90.00),
(1, '2025-04-07', 70.00, 70.00),
(1, '2025-04-08', 60.00, 60.00);

INSERT INTO ventas (idCliente, fecha_de_venta, precio, precio_final) VALUES
(1, '2025-04-11', 65.00, 65.00),
(1, '2025-04-11', 120.00, 120.00);

INSERT INTO ventas (idCliente, fecha_de_venta, precio, precio_final) VALUES
(1, '2025-04-17', 950.00, 950.00),
(1, '2025-04-17', 133.14, 133.14);

INSERT INTO ventas (idCliente, fecha_de_venta, precio, precio_final) VALUES
(3, '2025-04-18', 900.00, 900.00),
(3, '2025-04-18', 111.11, 111.11);

INSERT INTO ventas (idCliente, fecha_de_venta, precio, precio_final) VALUES
(3, '2025-04-18', 100.00, 100.00),
(3, '2025-04-18', 231.11, 231.11),
(3, '2025-04-18', 800.10, 800.10),
(3, '2025-04-18', 900.00, 900.00),
(3, '2025-04-18', 900.00, 900.00),
(3, '2025-04-18', 56.11, 56.11),
(3, '2025-04-18', 231.41, 231.41),
(3, '2025-04-18', 100.11, 100.11),
(3, '2025-04-18', 1234.57, 1234.57);

-- Cliente 2 justo en la novena y décima compra, la 10 debería activar descuento
INSERT INTO ventas (idCliente, fecha_de_venta, precio, precio_final) VALUES
(2, '2025-04-01', 50.00, 50.00),
(2, '2025-04-02', 50.00, 50.00),
(2, '2025-04-03', 50.00, 50.00),
(2, '2025-04-04', 50.00, 50.00),
(2, '2025-04-05', 50.00, 50.00),
(2, '2025-04-06', 50.00, 50.00),
(2, '2025-04-07', 50.00, 50.00),
(2, '2025-04-08', 50.00, 50.00),
(2, '2025-04-09', 50.00, 50.00),
(2, '2025-04-10', 50.00, 50.00); -- Esta debería activar descuento

INSERT INTO ventas (idCliente, fecha_de_venta, precio, precio_final) VALUES
(2, '2025-04-15', 150.00, 150.00),
(2, '2025-04-15', 254.00, 254.00);

-- Cliente nuevo (no existe en tabla clientes aún, para probar trigger de creación)
INSERT INTO ventas (idCliente, fecha_de_venta, precio, precio_final) VALUES
(4, '2025-04-11', 60.00, 60.00);

ALTER TABLE clientes ADD ventas_mes_actual INT DEFAULT 0;
