-- =============================================
-- SCRIPT 4: PROCEDIMIENTOS ALMACENADOS Y TRIGGERS
-- =============================================

USE LibreriaExpress;
GO

PRINT 'Creando procedimientos almacenados y triggers...';

-- Procedimiento para calcular totales de venta
CREATE PROCEDURE sp_CalcularTotalesVenta
    @id_venta INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @subtotal DECIMAL(10,2), @igv DECIMAL(10,2), @total DECIMAL(10,2);
    
    -- Calcular subtotal sumando todos los detalles
    SELECT @subtotal = ISNULL(SUM(subtotal_detalle), 0)
    FROM DETALLE_VENTA
    WHERE id_venta = @id_venta;
    
    -- Calcular IGV (18%)
    SET @igv = @subtotal * 0.18;
    
    -- Calcular total
    SET @total = @subtotal + @igv;
    
    -- Actualizar la venta
    UPDATE VENTA
    SET subtotal = @subtotal, 
        igv = @igv, 
        total = @total
    WHERE id_venta = @id_venta;
    
    PRINT 'Totales calculados para venta ID: ' + CAST(@id_venta AS VARCHAR);
END;
GO
PRINT '✅ sp_CalcularTotalesVenta creado';

-- Procedimiento para productos con stock bajo
CREATE PROCEDURE sp_ProductosStockBajo
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        p.id_producto,
        p.nombre_producto,
        p.stock_actual,
        p.stock_minimo,
        c.nombre_categoria,
        pr.nombre_empresa as proveedor,
        CASE 
            WHEN p.stock_actual = 0 THEN 'SIN STOCK'
            WHEN p.stock_actual <= p.stock_minimo THEN 'STOCK BAJO'
            ELSE 'STOCK OK'
        END as estado_stock
    FROM PRODUCTO p
    INNER JOIN CATEGORIA c ON p.id_categoria = c.id_categoria
    INNER JOIN PROVEEDOR pr ON p.id_proveedor = pr.id_proveedor
    WHERE p.stock_actual <= p.stock_minimo
    AND p.estado = 1
    ORDER BY p.stock_actual ASC;
END;
GO
PRINT '✅ sp_ProductosStockBajo creado';

-- Procedimiento para reporte de ventas por período
CREATE PROCEDURE sp_ReporteVentasPorPeriodo
    @fecha_inicio DATE,
    @fecha_fin DATE
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        v.numero_factura,
        v.fecha_venta,
        c.nombre_completo as cliente,
        c.tipo_cliente,
        e.nombre_completo as empleado,
        v.subtotal,
        v.igv,
        v.total
    FROM VENTA v
    INNER JOIN CLIENTE c ON v.id_cliente = c.id_cliente
    INNER JOIN EMPLEADO e ON v.id_empleado = e.id_empleado
    WHERE CAST(v.fecha_venta AS DATE) BETWEEN @fecha_inicio AND @fecha_fin
    ORDER BY v.fecha_venta DESC;
END;
GO
PRINT '✅ sp_ReporteVentasPorPeriodo creado';

-- Procedimiento para top productos más vendidos
CREATE PROCEDURE sp_TopProductosMasVendidos
    @top_n INT = 10,
    @fecha_inicio DATE = NULL,
    @fecha_fin DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    IF @fecha_inicio IS NULL SET @fecha_inicio = DATEADD(MONTH, -1, GETDATE());
    IF @fecha_fin IS NULL SET @fecha_fin = GETDATE();
    
    SELECT TOP (@top_n)
        p.nombre_producto,
        c.nombre_categoria,
        SUM(dv.cantidad) as total_vendido,
        SUM(dv.subtotal_detalle) as ingresos_totales,
        AVG(dv.precio_unitario) as precio_promedio
    FROM DETALLE_VENTA dv
    INNER JOIN PRODUCTO p ON dv.id_producto = p.id_producto
    INNER JOIN CATEGORIA c ON p.id_categoria = c.id_categoria
    INNER JOIN VENTA v ON dv.id_venta = v.id_venta
    WHERE CAST(v.fecha_venta AS DATE) BETWEEN @fecha_inicio AND @fecha_fin
    GROUP BY p.nombre_producto, c.nombre_categoria
    ORDER BY total_vendido DESC;
END;
GO
PRINT '✅ sp_TopProductosMasVendidos creado';

-- TRIGGERS

-- Trigger para actualizar stock después de una venta
CREATE TRIGGER tr_ActualizarStockVenta
ON DETALLE_VENTA
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE p
    SET p.stock_actual = p.stock_actual - i.cantidad,
        p.fecha_actualizacion = GETDATE()
    FROM PRODUCTO p
    INNER JOIN inserted i ON p.id_producto = i.id_producto;
    
    PRINT 'Stock actualizado después de venta';
END;
GO
PRINT '✅ tr_ActualizarStockVenta creado';

-- Trigger para actualizar stock después de una compra
CREATE TRIGGER tr_ActualizarStockCompra
ON DETALLE_COMPRA
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE p
    SET p.stock_actual = p.stock_actual + i.cantidad,
        p.fecha_actualizacion = GETDATE()
    FROM PRODUCTO p
    INNER JOIN inserted i ON p.id_producto = i.id_producto;
    
    PRINT 'Stock actualizado después de compra';
END;
GO
PRINT '✅ tr_ActualizarStockCompra creado';

-- Trigger para validar stock antes de una venta
CREATE TRIGGER tr_ValidarStockVenta
ON DETALLE_VENTA
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Verificar stock suficiente para todos los productos en la inserción
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN PRODUCTO p ON i.id_producto = p.id_producto
        WHERE p.stock_actual < i.cantidad
    )
    BEGIN
        RAISERROR('Stock insuficiente para uno o más productos', 16, 1);
        RETURN;
    END;
    
    -- Si todo está bien, realizar la inserción
    INSERT INTO DETALLE_VENTA (id_venta, id_producto, cantidad, precio_unitario, descuento, subtotal_detalle)
    SELECT id_venta, id_producto, cantidad, precio_unitario, descuento, subtotal_detalle
    FROM inserted;
    
    PRINT 'Venta validada e insertada correctamente';
END;
GO
PRINT '✅ tr_ValidarStockVenta creado';

PRINT '🎉 Todos los procedimientos y triggers creados exitosamente';
GO