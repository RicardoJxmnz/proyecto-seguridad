CREATE DATABASE Escuela

USE Escuela

CREATE TABLE Carreras 
(
	Id_Carrera TINYINT IDENTITY,
	Nombre VARCHAR(50) NOT NULL,
	CONSTRAINT pk_Carreras PRIMARY KEY (Id_Carrera)
);

CREATE TABLE Personas 
(
	Id_Persona INT IDENTITY,
	Nombre VARCHAR(20) NOT NULL,
	APaterno VARCHAR(20) NOT NULL,
	AMaterno VARCHAR(20) NOT NULL,
	Fecha_Nacimiento DATE NOT NULL,
	Sexo VARCHAR(1) NOT NULL,
	Imagen VARBINARY(MAX) NOT NULL,
    Embedding VARBINARY(MAX) NOT NULL,
	Activo BIT NOT NULL,
	CONSTRAINT pk_Personas PRIMARY KEY (Id_Persona),
	CONSTRAINT ck_Sexo CHECK (Sexo IN ('H','M'))
);

CREATE TABLE Maestros 
(
	Id_Maestro INT IDENTITY,
	Id_Persona INT NOT NULL,
	Titulo VARCHAR(50) NOT NULL,
	CONSTRAINT pk_Maestros PRIMARY KEY (Id_Maestro),
	CONSTRAINT fk_Maestro_Persona FOREIGN KEY (Id_Persona) 
	REFERENCES Personas(Id_Persona) ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE Alumnos 
(
	Matricula VARCHAR(8),
	Id_Persona INT NOT NULL,
	Grado TINYINT NOT NULL,
	Grupo VARCHAR(1) NOT NULL,
	Id_Carrera TINYINT NOT NULL, 
	CONSTRAINT pk_Alumnos PRIMARY KEY (Matricula),
	CONSTRAINT fk_Alumno_Persona FOREIGN KEY (Id_Persona) 
	REFERENCES Personas(Id_Persona) ON UPDATE CASCADE ON DELETE NO ACTION,
	CONSTRAINT fk_Alumno_Carrera FOREIGN KEY (Id_Carrera) 
	REFERENCES Carreras(Id_Carrera) ON UPDATE CASCADE ON DELETE NO ACTION
);


CREATE TABLE Materias 
(
	Id_Materia VARCHAR(4),
	Nombre VARCHAR(50) NOT NULL,
	Hora_Inicio TIME NOT NULL,
	Hora_Fin TIME NOT NULL,
	Id_Maestro INT,
	CONSTRAINT pk_Materias PRIMARY KEY (Id_Materia),
	CONSTRAINT fk_Materia_Maestro FOREIGN KEY (Id_Maestro) 
	REFERENCES Personas(Id_Persona) ON UPDATE CASCADE ON DELETE NO ACTION
);


CREATE TABLE Alumnos_Materias 
(
	Id_Materia VARCHAR(4),
	Matricula VARCHAR(8),
	CONSTRAINT pk_Alumnos_Materias PRIMARY KEY (Id_Materia, Matricula),
	CONSTRAINT fk_AluMat_Materia FOREIGN KEY (Id_Materia) 
	REFERENCES Materias(Id_Materia) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT fk_AluMat_Alumno FOREIGN KEY (Matricula) 
	REFERENCES Alumnos(Matricula) ON UPDATE NO ACTION ON DELETE NO ACTION
);