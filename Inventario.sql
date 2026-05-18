-- ================================
-- CREACIÓN DE TABLAS
-- ================================

-- Tabla de Usuarios
CREATE TABLE Usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    contrasena VARCHAR(100) NOT NULL,
    rol VARCHAR(50) NOT NULL
);

-- Tabla de Categorías
CREATE TABLE Categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255)
);

-- Tabla de Proveedores
CREATE TABLE Proveedor (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    contacto VARCHAR(100)
);

-- Tabla de Productos
CREATE TABLE Producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    stock_actual INT NOT NULL,
    id_categoria INT,
    id_proveedor INT,
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria),
    FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor)
);

-- Tabla de Movimientos
CREATE TABLE Movimiento (
    id_movimiento INT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('entrada','salida') NOT NULL,
    fecha DATE NOT NULL,
    cantidad INT NOT NULL,
    id_producto INT,
    id_usuario INT,
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- Tabla de Reportes
CREATE TABLE Reporte (
    id_reporte INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL,
    fecha DATE NOT NULL,
    contenido TEXT
);

-- Tabla de Alertas de Stock
CREATE TABLE AlertaStock (
    id_alerta INT AUTO_INCREMENT PRIMARY KEY,
    nivel_minimo INT NOT NULL,
    fecha_generada DATE NOT NULL,
    id_producto INT,
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- ================================
-- CONSULTAS DE EJEMPLO
-- ================================

-- Insertar un nuevo usuario
INSERT INTO Usuario (nombre, contrasena, rol)
VALUES ('Juan Pérez', '1234segura', 'Administrador');

-- Insertar un nuevo proveedor
INSERT INTO Proveedor (nombre, contacto)
VALUES ('Proveedor Minero SA', 'proveedor@minero.com');

-- Insertar un nuevo producto
INSERT INTO Producto (nombre, stock_actual, id_categoria, id_proveedor)
VALUES ('Martillo Neumático', 10, 1, 1);

-- Registrar una entrada de producto
INSERT INTO Movimiento (tipo, fecha, cantidad, id_producto, id_usuario)
VALUES ('entrada', CURDATE(), 5, 1, 1);

-- Registrar una salida de producto
INSERT INTO Movimiento (tipo, fecha, cantidad, id_producto, id_usuario)
VALUES ('salida', CURDATE(), 2, 1, 2);

-- Consultar todos los productos
SELECT * FROM Producto;

-- Consultar stock actual de un producto específico
SELECT nombre, stock_actual
FROM Producto
WHERE id_producto = 1;

-- Consultar historial de movimientos de un producto
SELECT M.id_movimiento, M.tipo, M.fecha, M.cantidad, U.nombre AS usuario
FROM Movimiento M
JOIN Usuario U ON M.id_usuario = U.id_usuario
WHERE M.id_producto = 1;

-- Eliminar un producto
DELETE FROM Producto
WHERE id_producto = 3;

-- Reporte de productos con stock crítico
SELECT P.nombre, P.stock_actual, A.nivel_minimo
FROM Producto P
JOIN AlertaStock A ON P.id_producto = A.id_producto
WHERE P.stock_actual < A.nivel_minimo;

-- Reporte de movimientos diarios
SELECT M.tipo, M.fecha, M.cantidad, P.nombre AS producto, U.nombre AS usuario
FROM Movimiento M
JOIN Producto P ON M.id_producto = P.id_producto
JOIN Usuario U ON M.id_usuario = U.id_usuario
WHERE M.fecha = CURDATE();

-- Reporte de productos faltantes
SELECT nombre
FROM Producto
WHERE stock_actual = 0;
