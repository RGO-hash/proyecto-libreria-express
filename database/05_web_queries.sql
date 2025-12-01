-- =============================================
-- SCRIPT 5: CONSULTAS PARA LA APLICACIÓN WEB
-- =============================================

USE LibreriaExpress;
GO

PRINT 'Creando consultas para la aplicación web...';

-- Vista para productos disponibles en la web
CREATE VIEW vw_ProductosWeb AS
SELECT 
    p.id_producto,
    p.nombre_producto,
    p.descripcion,
    p.precio_venta as precio,
    p.stock_actual,
    p.stock_minimo,
    c.nombre_categoria,
    c.id_categoria,
    pr.nombre_empresa as proveedor,
    CASE 
        WHEN p.stock_actual = 0 THEN 'Agotado'
        WHEN p.stock_actual <= p.stock_minimo THEN 'Stock Bajo'
        ELSE 'Disponible'
    END as estado_disponibilidad,
    p.fecha_creacion
FROM PRODUCTO p
INNER JOIN CATEGORIA c ON p.id_categoria = c.id_categoria
INNER JOIN PROVEEDOR pr ON p.id_proveedor = pr.id_proveedor
WHERE p.estado = 1;
GO
PRINT '✅ Vista vw_ProductosWeb creada';

-- Vista para estadísticas del dashboard
CREATE VIEW vw_EstadisticasDashboard AS
SELECT 
    -- Totales generales
    (SELECT COUNT(*) FROM PRODUCTO WHERE estado = 1) as total_productos,
    (SELECT COUNT(*) FROM CLIENTE WHERE estado = 1) as total_clientes,
    (SELECT COUNT(*) FROM VENTA WHERE MONTH(fecha_venta) = MONTH(GETDATE())) as ventas_mes_actual,
    (SELECT ISNULL(SUM(total), 0) FROM VENTA WHERE MONTH(fecha_venta) = MONTH(GETDATE())) as ingresos_mes_actual,
    
    -- Productos con stock bajo
    (SELECT COUNT(*) FROM PRODUCTO WHERE stock_actual <= stock_minimo AND estado = 1) as productos_stock_bajo,
    
    -- Clientes por tipo
    (SELECT COUNT(*) FROM CLIENTE WHERE tipo_cliente = 'Premium' AND estado = 1) as clientes_premium,
    (SELECT COUNT(*) FROM CLIENTE WHERE tipo_cliente = 'Frecuente' AND estado = 1) as clientes_frecuentes,
    
    -- Ventas del día
    (SELECT ISNULL(SUM(total), 0) FROM VENTA WHERE CAST(fecha_venta AS DATE) = CAST(GETDATE() AS DATE)) as ventas_hoy;
GO
PRINT '✅ Vista vw_EstadisticasDashboard creada';

-- Consultas específicas para la API

-- 1. Obtener todos los productos para catálogo
SELECT * FROM vw_ProductosWeb ORDER BY nombre_producto;

-- 2. Obtener productos por categoría
SELECT * FROM vw_ProductosWeb WHERE id_categoria = 1 ORDER BY precio;

-- 3. Obtener categorías activas
SELECT id_categoria, nombre_categoria, descripcion 
FROM CATEGORIA 
WHERE estado = 1 
ORDER BY nombre_categoria;

-- 4. Productos con stock bajo (alerta)
SELECT nombre_producto, stock_actual, stock_minimo, estado_disponibilidad
FROM vw_ProductosWeb
WHERE estado_disponibilidad IN ('Stock Bajo', 'Agotado')
ORDER BY stock_actual ASC;

-- 5. Estadísticas para el dashboard
SELECT * FROM vw_EstadisticasDashboard;

-- 6. Top 5 productos más vendidos (último mes)
SELECT TOP 5
    p.nombre_producto,
    c.nombre_categoria,
    SUM(dv.cantidad) as total_vendido,
    SUM(dv.subtotal_detalle) as ingresos_totales
FROM DETALLE_VENTA dv
INNER JOIN PRODUCTO p ON dv.id_producto = p.id_producto
INNER JOIN CATEGORIA c ON p.id_categoria = c.id_categoria
INNER JOIN VENTA v ON dv.id_venta = v.id_venta
WHERE v.fecha_venta >= DATEADD(MONTH, -1, GETDATE())
GROUP BY p.nombre_producto, c.nombre_categoria
ORDER BY total_vendido DESC;

-- 7. Ventas recientes (últimas 10)
SELECT TOP 10
    v.numero_factura,
    v.fecha_venta,
    c.nombre_completo as cliente,
    e.nombre_completo as empleado,
    v.total
FROM VENTA v
INNER JOIN CLIENTE c ON v.id_cliente = c.id_cliente
INNER JOIN EMPLEADO e ON v.id_empleado = e.id_empleado
ORDER BY v.fecha_venta DESC;

-- 8. Productos por proveedor
SELECT 
    pr.nombre_empresa as proveedor,
    COUNT(p.id_producto) as cantidad_productos,
    SUM(p.stock_actual) as stock_total
FROM PROVEEDOR pr
LEFT JOIN PRODUCTO p ON pr.id_proveedor = p.id_proveedor AND p.estado = 1
WHERE pr.estado = 1
GROUP BY pr.nombre_empresa
ORDER BY cantidad_productos DESC;

PRINT '🎉 Consultas para la aplicación web creadas exitosamente';
GO