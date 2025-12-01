# 📚 Proyecto Final: Sistema de Gestión para Librería Express

## 📋 Descripción
Sistema completo de gestión comercial para una librería, desarrollado como proyecto final de la materia **Base de Datos I**.

## 🏗️ Estructura del Proyecto

proyecto-libreria-express/
├── database/ # Base de datos SQL Server
│ ├── 01_database_creation.sql
│ ├── 02_tables_creation.sql
│ ├── 03_sample_data.sql
│ ├── 04_stored_procedures.sql
│ ├── 05_web_queries.sql
│ └── 06_database_setup.sql
├── web-app/ # Página web de demostración
│ ├── index.html
│ ├── style.css
│ ├── script.js
│ ├── data/
│ │ └── productos.json
│ └── README.md
└── README.md (este archivo)


## 🚀 Cómo Ejecutar

### **Parte 1: Base de Datos (SQL Server)**
1. Abrir **SQL Server Management Studio**
2. Ejecutar los scripts en orden numérico:
   ```sql
   -- Ejecutar en este orden:
   01_database_creation.sql
   02_tables_creation.sql
   03_sample_data.sql
   04_stored_procedures.sql
   05_web_queries.sql
   06_database_setup.sql