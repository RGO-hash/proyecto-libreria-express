-- =============================================
-- SCRIPT 1: CREACIÓN DE LA BASE DE DATOS
-- =============================================

-- Verificar si la base de datos existe y eliminarla
IF EXISTS(SELECT name FROM sys.databases WHERE name = 'LibreriaExpress')
BEGIN
    ALTER DATABASE LibreriaExpress SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE LibreriaExpress;
    PRINT '✅ Base de datos existente eliminada';
END
GO

-- Crear nueva base de datos
CREATE DATABASE LibreriaExpress;
GO

PRINT '🎉 Base de datos "LibreriaExpress" creada exitosamente';
GO

USE LibreriaExpress;
GO