-- =============================================
-- SCRIPT 2: CREACIÓN DE TABLAS
-- =============================================

USE LibreriaExpress;
GO

PRINT 'Creando tablas...';

-- Tabla CATEGORIA
CREATE TABLE CATEGORIA (
    id_categoria INT IDENTITY(1,1) PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200),
    estado BIT DEFAULT 1,
    fecha_creacion DATETIME DEFAULT GETDATE()
);
PRINT '✅ Tabla CATEGORIA creada';

-- Tabla PROVEEDOR
CREATE TABLE PROVEEDOR (
    id_proveedor INT IDENTITY(1,1) PRIMARY KEY,
    nombre_empresa VARCHAR(100) NOT NULL,
    contacto VARCHAR(100),
    telefono VARCHAR(15),
    email VARCHAR(100),
    direccion VARCHAR(200),
    ruc VARCHAR(20) UNIQUE,
    estado BIT DEFAULT 1,
    fecha_creacion DATETIME DEFAULT GETDATE()
);
PRINT '✅ Tabla PROVEEDOR creada';

-- Tabla PRODUCTO
CREATE TABLE PRODUCTO (
    id_producto INT IDENTITY(1,1) PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    descripcion VARCHAR(200),
    precio_compra DECIMAL(10,2) NOT NULL CHECK (precio_compra >= 0),
    precio_venta DECIMAL(10,2) NOT NULL CHECK (precio_venta >= 0),
    stock_actual INT DEFAULT 0 CHECK (stock_actual >= 0),
    stock_minimo INT DEFAULT 5 CHECK (stock_minimo >= 0),
    id_categoria INT NOT NULL,
    id_proveedor INT NOT NULL,
    fecha_creacion DATETIME DEFAULT GETDATE(),
    fecha_actualizacion DATETIME DEFAULT GETDATE(),
    estado BIT DEFAULT 1,
    FOREIGN KEY (id_categoria) REFERENCES CATEGORIA(id_categoria),
    FOREIGN KEY (id_proveedor) REFERENCES PROVEEDOR(id_proveedor)
);
PRINT '✅ Tabla PRODUCTO creada';

-- Tabla CLIENTE
CREATE TABLE CLIENTE (
    id_cliente INT IDENTITY(1,1) PRIMARY KEY,
    nombre_completo VARCHAR(100) NOT NULL,
    tipo_documento VARCHAR(10) DEFAULT 'DNI',
    numero_documento VARCHAR(20) UNIQUE,
    telefono VARCHAR(15),
    email VARCHAR(100),
    direccion VARCHAR(200),
    tipo_cliente VARCHAR(20) DEFAULT 'Regular',
    fecha_registro DATETIME DEFAULT GETDATE(),
    estado BIT DEFAULT 1
);
PRINT '✅ Tabla CLIENTE creada';

-- Tabla EMPLEADO
CREATE TABLE EMPLEADO (
    id_empleado INT IDENTITY(1,1) PRIMARY KEY,
    nombre_completo VARCHAR(100) NOT NULL,
    cargo VARCHAR(50) DEFAULT 'Vendedor',
    telefono VARCHAR(15),
    email VARCHAR(100),
    fecha_contratacion DATE,
    salario DECIMAL(10,2) CHECK (salario >= 0),
    comision_porcentaje DECIMAL(5,2) DEFAULT 0.05,
    estado BIT DEFAULT 1
);
PRINT '✅ Tabla EMPLEADO creada';

-- Tabla VENTA
CREATE TABLE VENTA (
    id_venta INT IDENTITY(1,1) PRIMARY KEY,
    numero_factura VARCHAR(20) UNIQUE NOT NULL,
    fecha_venta DATETIME DEFAULT GETDATE(),
    subtotal DECIMAL(10,2) DEFAULT 0 CHECK (subtotal >= 0),
    igv DECIMAL(10,2) DEFAULT 0 CHECK (igv >= 0),
    total DECIMAL(10,2) DEFAULT 0 CHECK (total >= 0),
    estado_venta VARCHAR(20) DEFAULT 'Completada',
    id_cliente INT NOT NULL,
    id_empleado INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES EMPLEADO(id_empleado)
);
PRINT '✅ Tabla VENTA creada';

-- Tabla DETALLE_VENTA
CREATE TABLE DETALLE_VENTA (
    id_detalle INT IDENTITY(1,1) PRIMARY KEY,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10,2) NOT NULL CHECK (precio_unitario >= 0),
    descuento DECIMAL(10,2) DEFAULT 0 CHECK (descuento >= 0),
    subtotal_detalle DECIMAL(10,2) DEFAULT 0 CHECK (subtotal_detalle >= 0),
    FOREIGN KEY (id_venta) REFERENCES VENTA(id_venta) ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES PRODUCTO(id_producto)
);
PRINT '✅ Tabla DETALLE_VENTA creada';

-- Tabla COMPRA
CREATE TABLE COMPRA (
    id_compra INT IDENTITY(1,1) PRIMARY KEY,
    numero_compra VARCHAR(20) UNIQUE NOT NULL,
    fecha_compra DATETIME DEFAULT GETDATE(),
    total_compra DECIMAL(10,2) DEFAULT 0 CHECK (total_compra >= 0),
    id_proveedor INT NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES PROVEEDOR(id_proveedor)
);
PRINT '✅ Tabla COMPRA creada';

-- Tabla DETALLE_COMPRA
CREATE TABLE DETALLE_COMPRA (
    id_detalle_compra INT IDENTITY(1,1) PRIMARY KEY,
    id_compra INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_compra_unitario DECIMAL(10,2) NOT NULL CHECK (precio_compra_unitario >= 0),
    subtotal_compra DECIMAL(10,2) DEFAULT 0 CHECK (subtotal_compra >= 0),
    FOREIGN KEY (id_compra) REFERENCES COMPRA(id_compra) ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES PRODUCTO(id_producto)
);
PRINT '✅ Tabla DETALLE_COMPRA creada';

PRINT '🎉 Todas las tablas creadas exitosamente';
GO