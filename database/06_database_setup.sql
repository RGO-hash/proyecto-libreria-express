-- =============================================
-- SCRIPT 6: CONFIGURACIÓN Y VERIFICACIÓN FINAL
-- =============================================

USE LibreriaExpress;
GO

PRINT 'Realizando configuración final y verificación...';

-- Verificar que todas las tablas se crearon correctamente
PRINT '=== VERIFICACIÓN DE TABLAS ===';
SELECT 
    TABLE_NAME as Tabla,
    (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = t.TABLE_NAME) as Columnas
FROM INFORMATION_SCHEMA.TABLES t
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;

-- Verificar conteo de registros
PRINT '=== VERIFICACIÓN DE DATOS ===';
SELECT 
    'CATEGORIA' as Tabla, COUNT(*) as Registros FROM CATEGORIA
UNION ALL SELECT 'PROVEEDOR', COUNT(*) FROM PROVEEDOR
UNION ALL SELECT 'PRODUCTO', COUNT(*) FROM PRODUCTO
UNION ALL SELECT 'CLIENTE', COUNT(*) FROM CLIENTE
UNION ALL SELECT 'EMPLEADO', COUNT(*) FROM EMPLEADO
UNION ALL SELECT 'VENTA', COUNT(*) FROM VENTA
UNION ALL SELECT 'DETALLE_VENTA', COUNT(*) FROM DETALLE_VENTA
UNION ALL SELECT 'COMPRA', COUNT(*) FROM COMPRA
UNION ALL SELECT 'DETALLE_COMPRA', COUNT(*) FROM DETALLE_COMPRA;

-- Verificar procedimientos almacenados
PRINT '=== VERIFICACIÓN DE PROCEDIMIENTOS ===';
SELECT name as Procedimiento, type_desc as Tipo
FROM sys.procedures
ORDER BY name;

-- Verificar vistas
PRINT '=== VERIFICACIÓN DE VISTAS ===';
SELECT name as Vista, type_desc as Tipo
FROM sys.views
ORDER BY name;

-- Verificar triggers
PRINT '=== VERIFICACIÓN DE TRIGGERS ===';
SELECT name as Trigger, OBJECT_NAME(parent_id) as Tabla_Padre
FROM sys.triggers
WHERE is_ms_shipped = 0
ORDER BY name;

-- Ejecutar algunas consultas de prueba
PRINT '=== PRUEBAS DE FUNCIONALIDAD ===';

PRINT '1. Productos con stock bajo:';
EXEC sp_ProductosStockBajo;

PRINT '2. Estadísticas del dashboard:';
SELECT * FROM vw_EstadisticasDashboard;

PRINT '3. Top 5 productos más vendidos:';
EXEC sp_TopProductosMasVendidos @top_n = 5;

PRINT '4. Ventas del último mes:';
EXEC sp_ReporteVentasPorPeriodo 
    @fecha_inicio = DATEADD(MONTH, -1, GETDATE()),
    @fecha_fin = GETDATE();

PRINT '=== CONFIGURACIÓN FINALIZADA ===';
PRINT '🎉 Base de datos "LibreriaExpress" configurada y lista para usar!';
PRINT '📊 Estadísticas:';
PRINT '   - ' + CAST((SELECT COUNT(*) FROM PRODUCTO) AS VARCHAR) + ' productos cargados';
PRINT '   - ' + CAST((SELECT COUNT(*) FROM CLIENTE) AS VARCHAR) + ' clientes registrados';
PRINT '   - ' + CAST((SELECT COUNT(*) FROM VENTA) AS VARCHAR) + ' ventas realizadas';
PRINT '   - ' + CAST((SELECT COUNT(*) FROM sys.procedures) AS VARCHAR) + ' procedimientos creados';
PRINT '   - ' + CAST((SELECT COUNT(*) FROM sys.views) AS VARCHAR) + ' vistas creadas';
GO