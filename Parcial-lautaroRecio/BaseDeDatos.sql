
IF DB_ID('TiendaVideojuegos') IS NULL
    CREATE DATABASE TiendaVideojuegos;
GO

USE TiendaVideojuegos;
GO

IF OBJECT_ID('productos') IS NOT NULL DROP TABLE productos;
IF OBJECT_ID('categorias') IS NOT NULL DROP TABLE categorias;
GO

-- Tabla 2: categorias
CREATE TABLE categorias (
    idCategoria INT IDENTITY(1,1) PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL
);
GO

-- Tabla 1: productos
CREATE TABLE productos (
    idProducto  INT IDENTITY(1,1) PRIMARY KEY,
    nombre      VARCHAR(50) NOT NULL,
    precio      DECIMAL(10,2) NOT NULL,
    idCategoria INT NOT NULL,
    CONSTRAINT FK_productos_categorias
        FOREIGN KEY (idCategoria) REFERENCES categorias(idCategoria)
);
GO

-- Datos de prueba
INSERT INTO categorias (descripcion) VALUES
    ('Accion'),
    ('Deportes'),
    ('Aventura'),
    ('Terror'),
    ('Carreras');

INSERT INTO productos (nombre, precio, idCategoria) VALUES
    ('Resident Evil 4', 49999.00, 4),
    ('God of War Ragnarok', 39999.00, 3),
    ('FIFA 26', 45000.00, 2),
    ('Forza Horizon', 35000.00, 5),
    ('Call Of Duty Black Ops 2', 25000.00, 1),
    ('Silent Hill', 30000.00, 4),
    ('NBA 2K26', 25000.00, 2);
GO

SELECT p.idProducto, p.nombre, p.precio, c.descripcion AS categoria
FROM productos AS p
JOIN categorias AS c ON c.idCategoria = p.idCategoria;
GO
