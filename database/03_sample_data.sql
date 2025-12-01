-- =============================================
-- SCRIPT 3: DATOS DE EJEMPLO
-- =============================================

USE LibreriaExpress;
GO

PRINT 'Insertando datos de ejemplo...';

-- Insertar Categorías
INSERT INTO CATEGORIA (nombre_categoria, descripcion) VALUES
('Literatura', 'Novelas, cuentos, poesía y obras literarias clásicas y contemporáneas'),
('Educación', 'Libros educativos, textos académicos y material de estudio'),
('Infantil', 'Libros para niños, cuentos ilustrados y literatura juvenil'),
('Tecnología', 'Libros de programación, TI, ciencia y desarrollo profesional'),
('Oficina', 'Materiales de oficina, papelería y útiles escolares'),
('Arte', 'Libros de arte, diseño, fotografía y arquitectura'),
('Cocina', 'Libros de recetas, gastronomía y técnicas culinarias'),
('Autoayuda', 'Desarrollo personal, superación y bienestar');
PRINT '✅ Categorías insertadas';

-- Insertar Proveedores
INSERT INTO PROVEEDOR (nombre_empresa, contacto, telefono, email, direccion, ruc) VALUES
('Editorial Penguin Random House', 'Ana García López', '987654321', 'ventas@penguin.com', 'Av. Libros 123, Lima', '20123456789'),
('Librería Nacional S.A.', 'Carlos López Mendoza', '987654322', 'pedidos@lnacional.com', 'Jr. Lectura 456, Lima', '20123456790'),
('Distribuidora ABC Internacional', 'María Torres Silva', '987654323', 'info@distribuidoraabc.com', 'Av. Distribución 789, Arequipa', '20123456791'),
('Papelería Moderna EIRL', 'Roberto Silva Castro', '987654324', 'contacto@pmoderna.com', 'Calle Papel 321, Trujillo', '20123456792'),
('Editorial Planeta Perú', 'Lucía Fernández Díaz', '987654325', 'editorial@planeta.pe', 'Av. Cultura 654, Lima', '20123456793'),
('Importadora BookWorld', 'Jorge Martínez Rojas', '987654326', 'import@bookworld.com', 'Jr. Internacional 987, Callao', '20123456794');
PRINT '✅ Proveedores insertados';

-- Insertar Productos
INSERT INTO PRODUCTO (nombre_producto, descripcion, precio_compra, precio_venta, stock_actual, stock_minimo, id_categoria, id_proveedor) VALUES
('Cien años de soledad', 'Novela clásica de Gabriel García Márquez, edición especial', 25.00, 35.00, 50, 10, 1, 1),
('El principito', 'Libro infantil clásico de Antoine de Saint-Exupéry, tapa dura', 15.00, 22.00, 30, 5, 3, 1),
('SQL Server Guía Completa 2023', 'Manual actualizado de base de datos SQL Server', 40.00, 55.00, 20, 3, 4, 2),
('Cuaderno Universitario Rayado', 'Cuaderno profesional 100 hojas, pasta dura', 3.00, 5.00, 100, 20, 5, 4),
('Lapicero Azul Pilot', 'Paquete de 10 unidades, punta fina', 2.50, 4.00, 200, 30, 5, 4),
('Física Universitaria Vol. 1', 'Libro de texto para cursos de física básica', 35.00, 48.00, 15, 5, 2, 3),
('El arte de la guerra', 'Estrategias militares aplicadas a los negocios', 18.00, 25.00, 40, 8, 8, 5),
('Harry Potter y la piedra filosofal', 'Primer libro de la saga, edición ilustrada', 30.00, 42.00, 25, 5, 3, 1),
('Python para Principiantes', 'Guía completa de programación en Python', 28.00, 38.00, 18, 4, 4, 2),
('Recetas Peruanas Tradicionales', 'Libro de cocina con 100 recetas peruanas', 22.00, 32.00, 35, 10, 7, 6),
('Calculadora Científica Casio', 'Calculadora fx-991ES para estudiantes', 45.00, 65.00, 12, 3, 5, 4),
('Los miserables', 'Novela clásica de Victor Hugo, edición completa', 32.00, 45.00, 22, 6, 1, 5);
PRINT '✅ Productos insertados';

-- Insertar Clientes
INSERT INTO CLIENTE (nombre_completo, tipo_documento, numero_documento, telefono, email, direccion, tipo_cliente) VALUES
('María Elena Paredes Torres', 'DNI', '12345678', '999888777', 'maria.paredes@email.com', 'Av. Siempre Viva 123, Lima', 'Frecuente'),
('Juan Carlos Mendoza Ruiz', 'DNI', '87654321', '999888776', 'juan.mendoza@email.com', 'Jr. Los Olivos 456, Lima', 'Premium'),
('Lucía Fernanda Ramos Díaz', 'DNI', '11223344', '999888775', 'lucia.ramos@email.com', 'Av. Argentina 789, Callao', 'Regular'),
('Roberto Silva Santos', 'DNI', '44332211', '999888774', 'roberto.silva@email.com', 'Calle Lima 321, Miraflores', 'Frecuente'),
('Ana Patricia Gómez Castro', 'DNI', '55667788', '999888773', 'ana.gomez@email.com', 'Urb. San Felipe 654, Jesús María', 'Premium'),
('Carlos Alfredo Villanueva', 'DNI', '99887766', '999888772', 'carlos.villanueva@email.com', 'Av. La Marina 987, San Miguel', 'Regular');
PRINT '✅ Clientes insertados';

-- Insertar Empleados
INSERT INTO EMPLEADO (nombre_completo, cargo, telefono, email, fecha_contratacion, salario, comision_porcentaje) VALUES
('Ana Patricia Gómez López', 'Gerente', '988777666', 'ana.gomez@libreriaexpress.com', '2022-01-15', 3500.00, 0.03),
('Carlos Alfredo Ruiz Mendoza', 'Vendedor Senior', '988777665', 'carlos.ruiz@libreriaexpress.com', '2023-03-20', 1800.00, 0.05),
('Sofía Alejandra Castro Rojas', 'Vendedor', '988777664', 'sofia.castro@libreriaexpress.com', '2023-06-10', 1500.00, 0.05),
('Miguel Ángel Torres Díaz', 'Almacenero', '988777663', 'miguel.torres@libreriaexpress.com', '2022-11-05', 1600.00, 0.02),
('Laura Cecilia Ramos Silva', 'Cajero', '988777662', 'laura.ramos@libreriaexpress.com', '2023-08-15', 1400.00, 0.04);
PRINT '✅ Empleados insertados';

-- Insertar Ventas
INSERT INTO VENTA (numero_factura, id_cliente, id_empleado, subtotal, igv, total) VALUES
('F001-0001', 1, 2, 90.00, 16.20, 106.20),
('F001-0002', 2, 3, 59.00, 10.62, 69.62),
('F001-0003', 3, 2, 56.00, 10.08, 66.08),
('F001-0004', 4, 3, 125.00, 22.50, 147.50),
('F001-0005', 5, 2, 38.00, 6.84, 44.84);
PRINT '✅ Ventas insertadas';

-- Insertar Detalles de Venta
INSERT INTO DETALLE_VENTA (id_venta, id_producto, cantidad, precio_unitario, descuento, subtotal_detalle) VALUES
(1, 1, 1, 35.00, 0, 35.00),
(1, 3, 1, 55.00, 0, 55.00),
(2, 2, 2, 22.00, 0, 44.00),
(2, 4, 3, 5.00, 0, 15.00),
(3, 5, 2, 4.00, 0, 8.00),
(3, 6, 1, 48.00, 0, 48.00),
(4, 7, 2, 25.00, 0, 50.00),
(4, 8, 1, 42.00, 0, 42.00),
(4, 9, 1, 38.00, 5.00, 33.00),
(5, 10, 1, 32.00, 0, 32.00),
(5, 11, 1, 65.00, 59.00, 6.00);
PRINT '✅ Detalles de venta insertados';

-- Insertar Compras
INSERT INTO COMPRA (numero_compra, id_proveedor, total_compra) VALUES
('C001-0001', 1, 725.00),
('C001-0002', 4, 400.00),
('C001-0003', 2, 560.00),
('C001-0004', 5, 320.00);
PRINT '✅ Compras insertadas';

-- Insertar Detalles de Compra
INSERT INTO DETALLE_COMPRA (id_compra, id_producto, cantidad, precio_compra_unitario, subtotal_compra) VALUES
(1, 1, 20, 25.00, 500.00),
(1, 2, 15, 15.00, 225.00),
(2, 4, 50, 3.00, 150.00),
(2, 5, 100, 2.50, 250.00),
(3, 3, 10, 40.00, 400.00),
(3, 6, 8, 35.00, 280.00),
(4, 7, 10, 18.00, 180.00),
(4, 8, 5, 30.00, 150.00);
PRINT '✅ Detalles de compra insertados';

PRINT '🎉 Todos los datos de ejemplo insertados exitosamente';
GO