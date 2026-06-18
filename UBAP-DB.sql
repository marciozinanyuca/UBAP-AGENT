CREATE TABLE sedes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE especialidades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT
);

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL, -- Hashes generados por BCrypt
    rol VARCHAR(30) NOT NULL,        -- ADMIN_SEDE, DOCTOR, PACIENTE
    telefono VARCHAR(20)
);

CREATE TABLE medicos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL UNIQUE,
    cmp VARCHAR(20) NOT NULL UNIQUE,
    especialidad_id INT NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_medico_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    CONSTRAINT fk_medico_especialidad FOREIGN KEY (especialidad_id) REFERENCES especialidades(id)
);

-- Tabla intermedia (Relación Muchos a Muchos)
CREATE TABLE medicos_sedes (
    medico_id INT NOT NULL,
    sede_id INT NOT NULL,
    PRIMARY KEY (medico_id, sede_id),
    CONSTRAINT fk_pivot_medico FOREIGN KEY (medico_id) REFERENCES medicos(id) ON DELETE CASCADE,
    CONSTRAINT fk_pivot_sede FOREIGN KEY (sede_id) REFERENCES sedes(id) ON DELETE CASCADE
);

-- ===============================================================================
-- 3. INSERCIÓN DE DATOS DE EJEMPLO (DML)
-- ===============================================================================

-- Sedes Iniciales
INSERT INTO sedes (id, nombre, direccion, telefono, activo) VALUES
(1, 'Sede Miraflores', 'Av. Larco 1234, Miraflores, Lima', '01-234-5678', TRUE),
(2, 'Sede San Isidro', 'Av. Javier Prado Este 456, San Isidro, Lima', '01-345-6789', TRUE),
(3, 'Sede Surco', 'Av. Caminos del Inca 789, Surco, Lima', '01-456-7890', TRUE);

-- Ajustar el contador AUTO_INCREMENT en MySQL para los siguientes registros
ALTER TABLE sedes AUTO_INCREMENT = 4;

-- Especialidades Médicas
INSERT INTO especialidades (id, nombre, descripcion) VALUES
(1, 'Cardiologia', 'Especialidad del corazon y sistema cardiovascular'),
(2, 'Pediatria', 'Atencion medica para ninos y adolescentes'),
(3, 'Neurologia', 'Especialidad del sistema nervioso'),
(4, 'Traumatologia', 'Especialidad de huesos, musculos y articulaciones');

ALTER TABLE especialidades AUTO_INCREMENT = 5;

-- Usuarios (Administrador, Médicos y Paciente)
INSERT INTO usuarios (id, nombre, email, password, rol, telefono) VALUES
(1, 'Administrador MediRed', 'admin@mediared.pe', '$2a$12$R9h/lSpxS/H2GvX7U.zGDeBwR2D03mBskQkP80oFjBPyxI8eC75.q', 'ADMIN_SEDE', '999000001'), 
(2, 'Carlos Garcia', 'dr.garcia@mediared.pe', '$2a$12$Z0HwGgO3P9ZtY0Rdx56eOeNve0g1XbB9gP.o5q2Zt4R09g8Ua5V0G', 'DOCTOR', '999000002'),     
(3, 'Maria Lopez', 'dr.lopez@mediared.pe', '$2a$12$Z0HwGgO3P9ZtY0Rdx56eOeNve0g1XbB9gP.o5q2Zt4R09g8Ua5V0G', 'DOCTOR', '999000003'),      
(4, 'Juan Perez', 'paciente@mediared.pe', '$2a$12$lK6vR8I4SgB2wD0eR9vTNuFvWxYmBvK6O9oXvY2tZ3R9g7Ua8V0G', 'PACIENTE', '999000004');    

ALTER TABLE usuarios AUTO_INCREMENT = 5;

-- Entidades de Médicos
INSERT INTO medicos (id, usuario_id, cmp, especialidad_id, activo) VALUES
(1, 2, 'CMP-12345', 1, TRUE), 
(2, 3, 'CMP-67890', 2, TRUE); 

ALTER TABLE medicos AUTO_INCREMENT = 3;

-- Relaciones Multi-sede
INSERT INTO medicos_sedes (medico_id, sede_id) VALUES
(1, 1), 
(1, 2), 
(2, 1);