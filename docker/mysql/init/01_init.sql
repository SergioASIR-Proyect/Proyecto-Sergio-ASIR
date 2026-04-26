CREATE DATABASE IF NOT EXISTS sistema_seguridad;
USE sistema_seguridad;

CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS evento (
    id_evento INT AUTO_INCREMENT PRIMARY KEY,
    tipo_evento VARCHAR(50),
    fecha_hora DATETIME
);

CREATE TABLE IF NOT EXISTS grabaciones (
    id_grabacion INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    ruta VARCHAR(255),
    fecha_hora DATETIME,
    id_evento INT,
    FOREIGN KEY (id_evento) REFERENCES evento(id_evento)
);

CREATE TABLE IF NOT EXISTS log_estado (
    id_estado INT AUTO_INCREMENT PRIMARY KEY,
    estado_alarma INT,
    fecha_hora DATETIME,
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);
