USE master
GO
IF DB_ID('DbDentalSuite') IS NOT NULL
	DROP DATABASE DbDentalSuite
GO

CREATE DATABASE DbDentalSuite
ON PRIMARY
(
	NAME = 'DbDentalSuite_data',
	FILENAME = 'C:\db\DbDentalSuite_data.mdf'
)
LOG ON
(
	NAME = 'DbDentalSuite_log',
	FILENAME = 'C:\db\DbDentalSuite_log.ldf'
)
GO

USE DbDentalSuite
GO

/********* CREACION DE TABLAS  *******/

CREATE TABLE dbo.Tb_Ubigeo(
	Cod_Departamento char(2) NOT NULL,
	Cod_Provincia char(2) NOT NULL,
	Cod_Distrito char(2) NOT NULL,
	Descripcion varchar(40) NOT NULL
)
GO

CREATE TABLE dbo.Tb_Tipo_Documento(
	Cod_Tipo_Documento CHAR(5) PRIMARY KEY CLUSTERED NOT NULL,
	Descripcion_Larga VARCHAR(50) NOT NULL,
	Descripcion_Corta VARCHAR(15) NOT NULL,
	Estado BIT NOT NULL DEFAULT 1
)
GO

CREATE TABLE dbo.Tb_Horario(
	Cod_Horario INT PRIMARY KEY CLUSTERED NOT NULL,
	Dia varchar(10) NOT NULL DEFAULT (GETUTCDATE()-'05:00:00'),
	Hora_Inicio TIME(0) NOT NULL,
	Hora_Fin TIME(0) NOT NULL
)
GO

CREATE TABLE dbo.Tb_Usuario(
	Cod_Usuario CHAR(4) PRIMARY KEY NONCLUSTERED NOT NULL,
	Nombres VARCHAR(30) NOT NULL,
	Apellidos VARCHAR(30) NOT NULL,
	Contrasena VARBINARY(20) NOT NULL DEFAULT hashbytes('sha1','12345'),
	Estado BIT NOT NULL DEFAULT 1
) 
GO

CREATE TABLE dbo.Tb_Especialidad(
	Cod_Especialidad INT PRIMARY KEY CLUSTERED NOT NULL,
	Nombre VARCHAR(50) NOT NULL,
	Descripcion VARCHAR(150) NOT NULL DEFAULT 'Sin Descripci�n',
	Estado BIT NOT NULL DEFAULT 1
)
GO

CREATE TABLE dbo.Tb_Paciente(
	Cod_Paciente CHAR(10) PRIMARY KEY CLUSTERED NOT NULL,
	Nombres VARCHAR(40) NOT NULL,
	Ape_Paterno VARCHAR(20) NOT NULL,
	Ape_Materno VARCHAR(20) NOT NULL,
	Sexo CHAR(1) NOT NULL CHECK (Sexo LIKE 'M' OR Sexo LIKE 'F'),
	Cod_Tipo_Documento CHAR(5) REFERENCES dbo.Tb_Tipo_Documento(Cod_Tipo_Documento) NOT NULL,
	Num_Documento VARCHAR(15) NOT NULL CHECK (Num_Documento LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' OR
												Num_Documento LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' OR
												Num_Documento LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' OR
												Num_Documento LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	Correo VARCHAR(40) NOT NULL CHECK (Correo LIKE '%@%.%'),
	Direccion VARCHAR(80) NOT NULL,
	Cod_Departamento CHAR(6) NOT NULL,
	Cod_Provincia CHAR(6) NOT NULL,
	Cod_Distrito CHAR(6) NOT NULL,
	Contrasena VARBINARY(20) NOT NULL DEFAULT hashbytes('sha1','12345')
)
GO

CREATE TABLE dbo.Tb_Odontologo(
	Cod_Odontologo CHAR(10) PRIMARY KEY CLUSTERED NOT NULL,
	Nombres VARCHAR(40) NOT NULL,
	Ape_Paterno VARCHAR(20) NOT NULL,
	Ape_Materno VARCHAR(20) NOT NULL,
	Sexo CHAR(1) NOT NULL CHECK (Sexo LIKE 'M' OR Sexo LIKE 'F'),
	Cod_Tipo_Documento CHAR(5) REFERENCES dbo.Tb_Tipo_Documento(Cod_Tipo_Documento) NOT NULL,
	Num_Documento VARCHAR(15) NOT NULL CHECK (Num_Documento LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' OR
												Num_Documento LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' OR
												Num_Documento LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' OR
												Num_Documento LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	Correo VARCHAR(40) NOT NULL CHECK (Correo LIKE '%@%.%'),
	Direccion VARCHAR(80) NOT NULL,
	Cod_Departamento CHAR(6) NOT NULL,
	Cod_Provincia CHAR(6) NOT NULL,
	Cod_Distrito CHAR(6) NOT NULL,
	Contrasena VARBINARY(20) NOT NULL DEFAULT HASHBYTES('sha1','12345'),
	COP VARCHAR(20) NOT NULL,
	Estado BIT NOT NULL DEFAULT 1
)
GO

CREATE TABLE dbo.Tb_Horario_Odontologo(
	Cod_Horario_Odontologo INT PRIMARY KEY CLUSTERED NOT NULL,
	Cod_Odontologo CHAR(10) REFERENCES dbo.Tb_Odontologo(Cod_Odontologo) NOT NULL,
	Cod_Horario INT REFERENCES dbo.Tb_Horario(Cod_Horario) NOT NULL,
	Fecha_Registro DATETIME NOT NULL DEFAULT (GETUTCDATE()-'05:00:00'),
	Estado BIT NOT NULL DEFAULT 1
)
GO

CREATE TABLE dbo.Tb_Reserva_Cita(
	Cod_Reserva_Cita INT PRIMARY KEY CLUSTERED NOT NULL,
	Fecha_Reserva DATETIME NOT NULL,
	Cod_Especialidad INT REFERENCES dbo.Tb_Especialidad(Cod_Especialidad) NOT NULL,
	Cod_Paciente CHAR(10) REFERENCES dbo.Tb_Paciente(Cod_Paciente) NOT NULL,
	Cod_Horario_Odontologo INT REFERENCES dbo.Tb_Horario_Odontologo(Cod_Horario_Odontologo) NOT NULL,
	Estado BIT NOT NULL DEFAULT 1
)
GO

/***** USP LISTAR *****/

CREATE PROCEDURE dbo.USP_Listar_Especialidad
AS
	SET NOCOUNT ON;

	SELECT	te.Cod_Especialidad, te.Nombre, te.Descripcion
	FROM	dbo.Tb_Especialidad te
	WHERE	te.Estado = 1
GO

CREATE PROCEDURE dbo.USP_Listar_Horario
AS
	SET NOCOUNT ON;

	SELECT	th.Cod_Horario, th.Dia, th.Hora_Inicio, th.Hora_Fin 
	FROM	dbo.Tb_Horario th
GO

CREATE PROCEDURE dbo.USP_Listar_Horario_Odontologo
AS
	SET NOCOUNT ON;

	SELECT	tho.Cod_Horario_Odontologo, [to].Nombres+', '+[to].Ape_Paterno+' '+[to].Ape_Materno Odontologo, 
			th.Dia,th.Hora_Inicio, th.Hora_Fin, tho.Fecha_Registro
	FROM	dbo.Tb_Horario_Odontologo tho INNER JOIN
			dbo.Tb_Odontologo [to]	ON	[to].Cod_Odontologo = tho.Cod_Odontologo INNER JOIN
			dbo.Tb_Horario th ON th.Cod_Horario = tho.Cod_Horario
	WHERE	tho.Estado = 1
GO

CREATE PROCEDURE dbo.USP_Listar_Odontologo
AS
	SET NOCOUNT ON;

	SELECT	[to].Cod_Odontologo, [to].Nombres,[to].Ape_Paterno,[to].Ape_Materno, [to].Sexo, ttd.Descripcion_Corta,
			[to].Num_Documento, [to].Correo, [to].Direccion, [to].Cod_Departamento, [to].Cod_Provincia, 
			[to].Cod_Distrito, [to].COP
	FROM	dbo.Tb_Odontologo [to] INNER JOIN
			dbo.Tb_Tipo_Documento ttd ON ttd.Cod_Tipo_Documento = [to].Cod_Tipo_Documento
	WHERE	[to].ESTADO = 1
GO

CREATE PROCEDURE dbo.USP_Listar_Paciente
AS
	SET NOCOUNT ON;

	SELECT	tp.Cod_Paciente, tp.Nombres,tp.Ape_Paterno,tp.Ape_Materno , tp.Sexo,tp.Cod_Tipo_Documento,
			tp.Num_Documento, tp.Correo, tp.Direccion, tp.Cod_Departamento, 
			tp.Cod_Provincia, tp.Cod_Distrito
	FROM	dbo.Tb_Paciente tp INNER JOIN
			dbo.Tb_Tipo_Documento ttd ON ttd.Cod_Tipo_Documento = tp.Cod_Tipo_Documento
GO

CREATE PROCEDURE dbo.USP_Listar_Reserva_Cita
AS
	SET NOCOUNT ON;

	SELECT	trc.Cod_Reserva_Cita, trc.Fecha_Reserva, te.Nombre Especialidad, tp.Nombres+', '+tp.Ape_Paterno+' '+tp.Ape_Materno Paciente, 
			[to].Nombres+', '+[to].Ape_Paterno+' '+[to].Ape_Materno Odontologo,th.Dia,th.Hora_Inicio, th.Hora_Fin
	FROM	dbo.Tb_Reserva_Cita trc INNER JOIN
			dbo.Tb_Especialidad te ON te.Cod_Especialidad = trc.Cod_Especialidad INNER JOIN
			dbo.Tb_Paciente tp ON tp.Cod_Paciente = trc.Cod_Paciente INNER JOIN
			dbo.Tb_Horario_Odontologo tho ON tho.Cod_Horario_Odontologo = trc.Cod_Horario_Odontologo INNER JOIN
			dbo.Tb_Odontologo [to] ON [to].Cod_Odontologo = tho.Cod_Odontologo INNER JOIN
			dbo.Tb_Horario th ON th.Cod_Horario = tho.Cod_Horario
	WHERE	trc.Estado = 1
GO

CREATE PROCEDURE dbo.USP_Listar_Usuario
AS
	SET NOCOUNT ON;

	SELECT	tu.Cod_Usuario, tu.Nombres+', '+tu.Apellidos Usuario
	FROM	dbo.Tb_Usuario tu
	WHERE	tu.Estado = 1
GO

CREATE PROCEDURE dbo.USP_Listar_Tipo_Documento
AS
	SET NOCOUNT ON;

	SELECT	ttd.Cod_Tipo_Documento,ttd.Descripcion_Larga,ttd.Descripcion_Corta
	FROM	dbo.Tb_Tipo_Documento ttd
	WHERE ttd.Estado = 1
GO

create procedure USP_listar_provincias
@Cod_Departamento CHAR(2)
AS
select	Cod_Provincia,Descripcion from Tb_Ubigeo
where	Cod_Departamento=@Cod_Departamento
		and Cod_Provincia<>'00'
		and Cod_Distrito='00'
GO

create procedure USP_listar_distritos
@Cod_Departamento CHAR(2),@Cod_Provincia CHAR(2)
AS
select	Cod_Distrito,Descripcion from Tb_Ubigeo
where	Cod_Departamento=@Cod_Departamento
		and Cod_Provincia=@Cod_Provincia
		and Cod_Distrito<>'00'
go

CREATE PROCEDURE USP_listar_departamentos
AS
	SELECT tu.Cod_Departamento, tu.Descripcion
	FROM	dbo.Tb_Ubigeo tu
	WHERE tu.Cod_Provincia ='00'
			AND tu.Cod_Distrito ='00'
GO

/***** USP INSERTAR *****/

CREATE PROCEDURE dbo.USP_Insertar_Especialidad
	@Nombre VARCHAR(50),
	@Descripcion VARCHAR(150)
AS
	DECLARE @Cod INT = (SELECT ISNULL(MAX(te.Cod_Especialidad),0) FROM dbo.Tb_Especialidad te)
	SET @Cod = @Cod+1

	INSERT INTO dbo.Tb_Especialidad(Cod_Especialidad,Nombre,Descripcion)
	VALUES(@Cod,@Nombre,@Descripcion)
GO

CREATE PROCEDURE dbo.USP_Insertar_Horario
	@Dia DATE,
	@Hora_Inicio TIME(0),
	@Hora_Fin TIME(0)
AS
	DECLARE @Cod INT = (SELECT ISNULL(MAX(te.Cod_Especialidad),0) FROM dbo.Tb_Especialidad te)
	SET @Cod = @Cod+1

	INSERT INTO dbo.Tb_Horario(Cod_Horario, Dia, Hora_Inicio, Hora_Fin)
	VALUES(@Cod,@Dia,@Hora_Inicio,@Hora_Fin)
GO

CREATE PROCEDURE dbo.USP_Insertar_Horario_Odontologico
	@Cod_Odontologo VARCHAR(10),
	@Cod_Horario INT
AS
	DECLARE @Cod INT = (SELECT ISNULL(MAX(tho.Cod_Horario_Odontologo),0) FROM dbo.Tb_Horario_Odontologo tho)
	SET @Cod = @Cod+1

	INSERT INTO dbo.Tb_Horario_Odontologo(Cod_Horario_Odontologo, Cod_Odontologo, Cod_Horario, Fecha_Registro)
	VALUES(@Cod,@Cod_Odontologo,@Cod_Horario,GETUTCDATE()-'05:00:00')
GO

CREATE PROCEDURE dbo.USP_Insertar_Odontologo
	@Nombres VARCHAR(40),
	@Ape_Paterno VARCHAR(20),
	@Ape_Materno VARCHAR(20),
	@Sexo CHAR(1),
	@Cod_Tipo_Documento CHAR(5),
	@Num_Documento VARCHAR(15),
	@Correo VARCHAR(40),
	@Direccion VARCHAR(80),
	@Cod_Departamento CHAR(6),
	@Cod_Provincia CHAR(6),
	@Cod_Distrito CHAR(6),
	@Contrasena VARCHAR(20),
	@COP varchar(20)
AS
	DECLARE @vcod CHAR(10)
	DECLARE @vcont INT
	SET @vcont=(SELECT COUNT([to].Cod_Odontologo) FROM dbo.Tb_Odontologo [to])
	IF @vcont=0 
		BEGIN
		   SET @vcod ='O000000001'
		END
	ELSE
	BEGIN
		SET @vcod=(SELECT 'O' +Right(MAX (Right([to].Cod_Odontologo,9)+ 1000000001 ),9) 
		FROM dbo.Tb_Odontologo [to])
	END
	INSERT INTO Tb_Odontologo (Cod_Odontologo, Nombres, Ape_Paterno, Ape_Materno, Sexo, Cod_Tipo_Documento, 
								Num_Documento, Correo, Direccion, Cod_Departamento, Cod_Provincia, Cod_Distrito, 
								Contrasena, COP)
	VALUES(@vcod,@Nombres,@Ape_Paterno,@Ape_Materno,@Sexo,@Cod_Tipo_Documento,@Num_Documento,@Correo,
			@Direccion,@Cod_Departamento,@Cod_Provincia,@Cod_Distrito,HASHBYTES('sha1',@Contrasena),@COP)
GO

CREATE PROCEDURE dbo.USP_Insertar_Paciente
	@Nombres VARCHAR(40),
	@Ape_Paterno VARCHAR(20),
	@Ape_Materno VARCHAR(20),
	@Sexo CHAR(1),
	@Cod_Tipo_Documento CHAR(5),
	@Num_Documento VARCHAR(15),
	@Correo VARCHAR(40),
	@Direccion VARCHAR(80),
	@Cod_Departamento VARCHAR(6),
	@Cod_Provincia VARCHAR(6),
	@Cod_Distrito VARCHAR(6),
	@Contrasena VARCHAR(20)
AS
	DECLARE @vcod CHAR(10)
	DECLARE @vcont INT
	SET @vcont=(SELECT COUNT(tp.Cod_Paciente) FROM dbo.Tb_Paciente tp)
	IF @vcont=0 
		BEGIN
		   SET @vcod ='P000000001'
		END
	ELSE
	BEGIN
		SET @vcod=(SELECT 'P' +Right(MAX (Right(tp.Cod_Paciente,9)+ 1000000001 ),9) 
		FROM dbo.Tb_Paciente tp)
	END
	INSERT INTO Tb_Paciente	(Cod_Paciente, Nombres, Ape_Paterno, Ape_Materno, Sexo, Cod_Tipo_Documento, 
								Num_Documento, Correo, Direccion, Cod_Departamento, Cod_Provincia, Cod_Distrito, 
								Contrasena)
	VALUES(@vcod,@Nombres,@Ape_Paterno,@Ape_Materno,@Sexo,@Cod_Tipo_Documento,@Num_Documento,@Correo,
			@Direccion,@Cod_Departamento,@Cod_Provincia,@Cod_Distrito,HASHBYTES('sha1',@Contrasena))
GO

CREATE PROCEDURE dbo.USP_Insertar_Reserva_Cita
	@Fecha_Reserva DATETIME,
	@Cod_Especialidad INT,
	@Cod_Paciente CHAR(10),
	@Cod_Horario_Odontologo INT
AS
	DECLARE @Cod INT = (SELECT ISNULL(MAX(trc.Cod_Reserva_Cita),0) FROM dbo.Tb_Reserva_Cita trc)
	SET @Cod = @Cod+1

	INSERT INTO dbo.Tb_Reserva_Cita(Cod_Reserva_Cita, Fecha_Reserva, Cod_Especialidad, Cod_Paciente, Cod_Horario_Odontologo)
	VALUES(@Cod,@Fecha_Reserva,@Cod_especialidad,@COd_Paciente,@Cod_Horario_Odontologo)
GO

CREATE PROCEDURE dbo.USP_Insertar_Usuario
	@Nombres varchar(30),
	@Apellidos varchar(30)
AS
	DECLARE @vcod CHAR(4)
	DECLARE @vcont INT
	SET @vcont=(SELECT COUNT(tu.Cod_Usuario) FROM dbo.Tb_Usuario tu)
	IF @vcont=0 
		BEGIN
		   SET @vcod ='U001'
		END
	ELSE
	BEGIN
		SET @vcod=(SELECT 'U' +Right(MAX (Right(tu.Cod_Usuario,3)+ 1001 ),3) 
		FROM dbo.Tb_Usuario tu)
	END

	INSERT INTO dbo.Tb_Usuario(Cod_Usuario, Nombres, Apellidos, Contrasena)
	VALUES	(@vcod,@Nombres,@Apellidos,HASHBYTES('sha1','12345'))
GO

/***** USP MODIFICAR *****/

CREATE PROCEDURE dbo.USP_Modificar_Especialidad
	@Cod_Especialidad INT, 
	@Nombre VARCHAR(50), 
	@Descripcion VARCHAR(10)
AS
	UPDATE dbo.Tb_Especialidad
	SET
	    Nombre = @Nombre,
		Descripcion = @Descripcion
	WHERE	Cod_Especialidad = @Cod_Especialidad
GO

CREATE PROCEDURE dbo.USP_Modificar_Horario
	@Cod_Horario INT,
	@Dia DATE,
	@Hora_Inicio TIME(0),
	@Hora_Fin TIME(0)
AS
	UPDATE dbo.Tb_Horario
	SET
		Dia = @Dia,
		Hora_Inicio = @Hora_Inicio,
		Hora_Fin = @Hora_Fin
	WHERE Cod_Horario = @Cod_Horario
GO

CREATE PROCEDURE dbo.USP_Modificar_Horario_Odontologo
	@Cod_Horario_Odontologo INT,
	@Cod_Odontologo CHAR(10),
	@Cod_Horario INT
AS
	UPDATE dbo.Tb_Horario_Odontologo
	SET
		Cod_Odontologo = @Cod_Odontologo,
		Cod_Horario = @Cod_Horario,
		Fecha_Registro = GETUTCDATE()-'05:00:00'
	WHERE	Cod_Horario_Odontologo = @Cod_Horario_Odontologo
GO

CREATE PROCEDURE dbo.USP_Modificar_Odontologo
	@Cod_Odontologo CHAR(10), 
	@Nombres VARCHAR(40), 
	@Ape_Paterno VARCHAR(20), 
	@Ape_Materno VARCHAR(20), 
	@Sexo CHAR(1), 
	@Cod_Tipo_Documento CHAR(5), 
	@Num_Documento VARCHAR(15), 
	@Correo VARCHAR(40), 
	@Direccion VARCHAR(80), 
	@Cod_Departamento CHAR(6), 
	@Cod_Provincia CHAR(6), 
	@Cod_Distrito CHAR(6),
	@COP VARCHAR(20)
AS
	UPDATE	dbo.Tb_Odontologo
	SET
		Nombres = @Nombres,
		Ape_Paterno = @Ape_Paterno, 
		Ape_Materno = @Ape_Materno, 
		Sexo = @Sexo, 
		Cod_Tipo_Documento = @Cod_Tipo_Documento, 
		Num_Documento = @Num_Documento, 
		Correo = @Correo, 
		Direccion = @Direccion, 
		Cod_Departamento = @Cod_Departamento, 
		Cod_Provincia = @Cod_Provincia, 
		Cod_Distrito = @Cod_Distrito,
		COP = @COP
	WHERE	Cod_Odontologo = @Cod_Odontologo
GO

CREATE PROCEDURE dbo.USP_Modificar_Paciente
	@Cod_Paciente CHAR(10), 
	@Nombres VARCHAR(40), 
	@Ape_Paterno VARCHAR(20), 
	@Ape_Materno VARCHAR(20), 
	@Sexo CHAR(1), 
	@Cod_Tipo_Documento CHAR(5), 
	@Num_Documento VARCHAR(15), 
	@Correo VARCHAR(40), 
	@Direccion VARCHAR(80), 
	@Cod_Departamento CHAR(6), 
	@Cod_Provincia CHAR(6), 
	@Cod_Distrito CHAR(6)
AS
	UPDATE	dbo.Tb_Paciente
	SET
		Nombres = @Nombres,
		Ape_Paterno = @Ape_Paterno, 
		Ape_Materno = @Ape_Materno, 
		Sexo = @Sexo, 
		Cod_Tipo_Documento = @Cod_Tipo_Documento, 
		Num_Documento = @Num_Documento, 
		Correo = @Correo, 
		Direccion = @Direccion, 
		Cod_Departamento = @Cod_Departamento, 
		Cod_Provincia = @Cod_Provincia, 
		Cod_Distrito = @Cod_Distrito
	WHERE	Cod_Paciente = @Cod_Paciente
GO

CREATE PROCEDURE dbo.USP_Modificar_Reserva_Cita
	@Cod_Reserva_Cita INT,
	@Fecha_Reserva DATETIME,
	@Cod_Especialidad INT,
	@Cod_Paciente CHAR(10),
	@Cod_Horario_Odontologo INT
AS
	UPDATE dbo.Tb_Reserva_Cita
	SET
		Fecha_Reserva = @Fecha_Reserva, 
		Cod_Especialidad = @Cod_Especialidad, 
		Cod_Paciente = @Cod_Paciente, 
		Cod_Horario_Odontologo = @Cod_Horario_Odontologo
	WHERE	Cod_Reserva_Cita = @Cod_Reserva_Cita
GO

CREATE PROCEDURE dbo.USP_Modificar_Usuario
	@Cod_Usuario CHAR(4),
	@Nombres VARCHAR(30),
	@Apellidos VARCHAR(30),
	@Contrasena VARCHAR(20)
AS
	UPDATE	dbo.Tb_Usuario
	SET
		Nombres = @Nombres,
		Apellidos = @Apellidos,
		Contrasena = HASHBYTES('sha1',@Contrasena)
	WHERE	Cod_Usuario = @Cod_Usuario
GO

/***** USP ELIMINAR *****/

CREATE PROCEDURE dbo.USP_Eliminar_Usuario
	@Cod_Usuario char(4)
AS
	UPDATE dbo.Tb_Usuario
	SET
	    Estado = 0
	WHERE dbo.Tb_Usuario.Cod_Usuario = @Cod_Usuario
GO

CREATE PROCEDURE dbo.USP_Eliminar_Especialidad
	@Cod_Especialidad int
AS
	UPDATE dbo.Tb_Especialidad
	SET
	    Estado = 0
	WHERE Cod_Especialidad = @Cod_Especialidad
GO

CREATE procedure [dbo].[USP_Eliminar_Paciente]
@Cod_Paciente CHAR(10)
AS
	DELETE	FROM	Tb_Paciente
	WHERE Cod_Paciente=@Cod_Paciente
GO


CREATE procedure USP_Eliminar_Odontologo
@Cod_Odontologo CHAR(10)
AS
	UPDATE	dbo.Tb_Odontologo
	SET Estado = 0
	WHERE Cod_Odontologo=@Cod_Odontologo
GO

/***** USP BUSCAR *****/

CREATE PROCEDURE dbo.USP_Buscar_Especialidad
@Cod_Especialidad int
AS
	SELECT te.Cod_Especialidad, te.Nombre, te.Descripcion
	FROM dbo.Tb_Especialidad te
	WHERE te.Cod_Especialidad = @Cod_Especialidad AND te.Estado = 1
GO

CREATE PROCEDURE dbo.USP_Buscar_Usuario
@Cod_Usuario char(4)
AS
	SELECT tu.Cod_Usuario, tu.Nombres, tu.Apellidos
	FROM dbo.Tb_Usuario tu
	WHERE tu.Cod_Usuario = @Cod_Usuario AND tu.Estado = 1
GO

CREATE PROCEDURE dbo.USP_Obtener_Usuario
@Nombre varchar(30),
@Apellido varchar(30)
AS
	SELECT tu.Cod_Usuario,tu.Nombres, tu.Apellidos
	FROM dbo.Tb_Usuario tu
	WHERE	tu.Nombres = @Nombre AND tu.Apellidos = @Apellido AND tu.Estado	=1
GO

create procedure USP_Buscar_Paciente 
@Cod_Paciente CHAR(10)
AS
	SELECT	tp.Cod_Paciente, tp.Nombres,tp.Ape_Paterno,tp.Ape_Materno Paciente, tp.Sexo, 
			ttd.Descripcion_Corta, tp.Num_Documento, tp.Correo, tp.Direccion, tp.Cod_Departamento, 
			tp.Cod_Provincia, tp.Cod_Distrito, tp.Contrasena
	FROM	dbo.Tb_Paciente tp INNER JOIN
			dbo.Tb_Tipo_Documento ttd ON ttd.Cod_Tipo_Documento = tp.Cod_Tipo_Documento
	WHERE
			tp.Cod_Paciente=@Cod_Paciente
GO

create procedure USP_obtener_codigo_TipDocumento
@Desc_Corta varchar(15)
as
select Cod_Tipo_Documento from tb_tipo_Documento
where Descripcion_Corta=@Desc_Corta AND Estado = 1
go

create procedure USP_Buscar_Odontologo
@Cod_Odontologo CHAR(10)
AS
	SELECT	tp.Cod_Odontologo, tp.Nombres,tp.Ape_Paterno,tp.Ape_Materno Paciente, tp.Sexo, 
			ttd.Descripcion_Corta, tp.Num_Documento, tp.Correo, tp.Direccion, tp.Cod_Departamento, 
			tp.Cod_Provincia, tp.Cod_Distrito, tp.COP
	FROM	dbo.Tb_Odontologo tp INNER JOIN
			dbo.Tb_Tipo_Documento ttd ON ttd.Cod_Tipo_Documento = tp.Cod_Tipo_Documento
	WHERE
			tp.Cod_Odontologo=@Cod_Odontologo
GO

/***** VALIDAR *****/
CREATE PROCEDURE USP_ValidarUsuario
 @Usuario varchar(40),
 @Contrasena varchar(40)
AS
	IF EXISTS(SELECT 1 FROM dbo.Tb_Usuario tu WHERE tu.Cod_Usuario = @Usuario AND Contrasena = HASHBYTES('sha1',@Contrasena))
	BEGIN
		SELECT tu.Nombres Nombre,tu.Apellidos Apellido,'Usuario' TipoUsuario FROM dbo.Tb_Usuario tu
		WHERE tu.Cod_Usuario = @Usuario AND Contrasena = HASHBYTES('sha1',@Contrasena)
		RETURN;
	IF EXISTS(SELECT 1 FROM dbo.Tb_Paciente tp WHERE tp.Correo = @Usuario AND tp.Contrasena = HASHBYTES('sha1',@Contrasena))
	BEGIN
		SELECT tp.Nombres Nombre, tp.Ape_Paterno+' '+tp.Ape_Materno Apellido, 'Paciente' TipoUsuario FROM dbo.Tb_Paciente tp
		WHERE tp.Correo = @Usuario AND tp.Contrasena = HASHBYTES('sha1',@Contrasena)
		RETURN;
	END
	
	IF EXISTS(SELECT 1 FROM dbo.Tb_Odontologo tod where tod.Correo = @Usuario and tod.Contrasena = HASHBYTES('sha1',@Contrasena))
	BEGIN
		SELECT tod.Nombres Nombre, tod.Ape_Paterno+' '+tod.Ape_Materno Apellido, 'Odontologo' TipoUsuario FROM Tb_Odontologo tod
		where tod.Correo = @Usuario and tod.Contrasena = HASHBYTES('sha1',@Contrasena)
		RETURN;
	END
END	
GO

/***** USP CITAS **/

create procedure USP_Insertar_Cita
@fecha DATE,
@codEsp int,
@codPac int,
@codHorOdo int
as
	declare @cod int=(select isnull(max(Cod_Reserva_Cita),0) from dbo.Tb_Reserva_Cita)
	set @cod=@cod+1;

	insert into dbo.Tb_Reserva_Cita (Cod_Reserva_Cita,Fecha_Reserva,Cod_Especialidad,Cod_Paciente
	,Cod_Horario_Odontologo)
	values (@cod,@fecha,@codEsp,@codPac,@codHorOdo)
GO

Create Procedure USP_Listar_Especialidad_cbo
As
	set nocount on;

	select Cod_Especialidad,Descripcion
	from Tb_Especialidad
	where Estado=1
GO

create procedure USP_Listar_Odontologo_cbo
AS
	set nocount on;
	select Cod_Odontologo, Nombres + ' ' + Ape_Paterno + ' '+ Ape_Materno 
	from Tb_Odontologo
	where Estado=1
GO


create procedure USP_Listar_Horario_Odontologo_Cbo
@cod_odonto as char(10)
As
	select ho.Cod_Horario_Odontologo, cast(h.Dia as varchar) + ' ' + cast(h.Hora_Inicio as varchar) +' - ' + cast(h.Hora_Fin as varchar) 
	from Tb_Horario_Odontologo ho 
	inner join Tb_Horario h on ho.Cod_Horario=h.Cod_Horario
	where 
	ho.Cod_Odontologo=@cod_odonto
Go

exec USP_Insertar_Horario_Odontologico 'O000000001', 1



/***** TRIGGER *****/

CREATE TRIGGER dbo.TR_Eliminar_Especialidad
ON dbo.Tb_Especialidad INSTEAD OF DELETE
AS
	RAISERROR('No se puede eliminar la Especialidad',16,1);
GO

CREATE TRIGGER dbo.TR_Eliminar_Horario
ON dbo.Tb_Horario INSTEAD OF DELETE
AS
	RAISERROR('No se puede eliminar el Horario',16,1);
GO

CREATE TRIGGER dbo.TR_Eliminar_Horario_Odontologo
ON dbo.Tb_Horario_Odontologo INSTEAD OF DELETE
AS
	RAISERROR('No se puede eliminar el Horario del Odontologo',16,1);
GO

CREATE TRIGGER dbo.TR_Eliminar_Odontologo
ON dbo.Tb_Odontologo INSTEAD OF DELETE
AS
	RAISERROR('No se puede eliminar el Odontologo',16,1);
GO

CREATE TRIGGER dbo.TR_Eliminar_Paciente
ON dbo.Tb_Paciente INSTEAD OF DELETE
AS
	RAISERROR('No se puede eliminar el Paciente',16,1);
GO

CREATE TRIGGER dbo.TR_Eliminar_Reserva_Cita
ON dbo.Tb_Reserva_Cita INSTEAD OF DELETE
AS
	RAISERROR('No se puede eliminar la Reserva de Cita',16,1);
GO

CREATE TRIGGER dbo.TR_Eliminar_Tipo_Documento
ON dbo.Tb_Tipo_Documento INSTEAD OF DELETE
AS
	RAISERROR('No se puede eliminar el Tipo de Documento',16,1);
GO

CREATE TRIGGER dbo.TR_Eliminar_Usuario
ON dbo.Tb_Usuario INSTEAD OF DELETE
AS
	RAISERROR('No se puede eliminar el Usuario',16,1);
GO

CREATE TRIGGER dbo.TR_Eliminar_Tb_Ubigeo
ON dbo.Tb_Ubigeo  INSTEAD OF DELETE
AS
	RAISERROR('No se puede eliminar el Tb_Ubigeo',16,1);
GO

/***** INSERTANDO DATOS *****/

 INSERT INTO Tb_Ubigeo VALUES('01', '00', '00', 'AMAZONAS'),
 ('01', '01', '00', 'CHACHAPOYAS'),
 ('01', '01', '01', 'CHACHAPOYAS'),
 ('01', '01', '02', 'ASUNCION'),
 ('01', '01', '03', 'BALSAS'),
 ('01', '01', '04', 'CHETO'),
 ('01', '01', '05', 'CHILIQUIN'),
 ('01', '01', '06', 'CHUQUIBAMBA'),
 ('01', '01', '07', 'GRANADA'),
 ('01', '01', '08', 'HUANCAS'),
 ('01', '01', '09', 'LA JALCA'),
 ('01', '01', '10', 'LEIMEBAMBA'),
 ('01', '01', '11', 'LEVANTO'),
 ('01', '01', '12', 'MAGDALENA'),
 ('01', '01', '13', 'MARISCAL CASTILLA'),
 ('01', '01', '14', 'MOLINOPAMPA'),
 ('01', '01', '15', 'MONTEVIDEO'),
 ('01', '01', '16', 'OLLEROS'),
 ('01', '01', '17', 'QUINJALCA'),
 ('01', '01', '18', 'SAN FRANCISCO DE DAGUAS'),
 ('01', '01', '19', 'SAN ISIDRO DE MAINO'),
 ('01', '01', '20', 'SOLOCO'),
 ('01', '01', '21', 'SONCHE'),
 ('01', '02', '00', 'BAGUA'),
 ('01', '02', '01', 'BAGUA'),
 ('01', '02', '02', 'ARAMANGO'),
 ('01', '02', '03', 'COPALLIN'),
 ('01', '02', '04', 'EL PARCO'),
 ('01', '02', '05', 'IMAZA'),
 ('01', '02', '06', 'LA PECA'),
 ('01', '03', '00', 'BONGARA'),
 ('01', '03', '01', 'JUMBILLA'),
 ('01', '03', '02', 'CHISQUILLA'),
 ('01', '03', '03', 'CHURUJA'),
 ('01', '03', '04', 'COROSHA'),
 ('01', '03', '05', 'CUISPES'),
 ('01', '03', '06', 'FLORIDA'),
 ('01', '03', '07', 'JAZAN'),
 ('01', '03', '08', 'RECTA'),
 ('01', '03', '09', 'SAN CARLOS'),
 ('01', '03', '10', 'SHIPASBAMBA'),
 ('01', '03', '11', 'VALERA'),
 ('01', '03', '12', 'YAMBRASBAMBA'),
 ('01', '04', '00', 'CONDORCANQUI'),
 ('01', '04', '01', 'NIEVA'),
 ('01', '04', '02', 'EL CENEPA'),
 ('01', '04', '03', 'RIO SANTIAGO'),
 ('01', '05', '00', 'LUYA'),
 ('01', '05', '01', 'LAMUD'),
 ('01', '05', '02', 'CAMPORREDONDO'),
 ('01', '05', '03', 'COCABAMBA'),
 ('01', '05', '04', 'COLCAMAR'),
 ('01', '05', '05', 'CONILA'),
 ('01', '05', '06', 'INGUILPATA'),
 ('01', '05', '07', 'LONGUITA'),
 ('01', '05', '08', 'LONYA CHICO'),
 ('01', '05', '09', 'LUYA'),
 ('01', '05', '10', 'LUYA VIEJO'),
 ('01', '05', '11', 'MARIA'),
 ('01', '05', '12', 'OCALLI'),
 ('01', '05', '13', 'OCUMAL'),
 ('01', '05', '14', 'PISUQUIA'),
 ('01', '05', '15', 'PROVIDENCIA'),
 ('01', '05', '16', 'SAN CRISTOBAL'),
 ('01', '05', '17', 'SAN FRANCISCO DEL YESO'),
 ('01', '05', '18', 'SAN JERONIMO'),
 ('01', '05', '19', 'SAN JUAN DE LOPECANCHA'),
 ('01', '05', '20', 'SANTA CATALINA'),
 ('01', '05', '21', 'SANTO TOMAS'),
 ('01', '05', '22', 'TINGO'),
 ('01', '05', '23', 'TRITA'),
 ('01', '06', '00', 'RODRIGUEZ DE MENDOZA'),
 ('01', '06', '01', 'SAN NICOLAS'),
 ('01', '06', '02', 'CHIRIMOTO'),
 ('01', '06', '03', 'COCHAMAL'),
 ('01', '06', '04', 'HUAMBO'),
 ('01', '06', '05', 'LIMABAMBA'),
 ('01', '06', '06', 'LONGAR'),
 ('01', '06', '07', 'MARISCAL BENAVIDES'),
 ('01', '06', '08', 'MILPUC'),
 ('01', '06', '09', 'OMIA'),
 ('01', '06', '10', 'SANTA ROSA'),
 ('01', '06', '11', 'TOTORA'),
 ('01', '06', '12', 'VISTA ALEGRE'),
 ('01', '07', '00', 'UTCUBAMBA'),
 ('01', '07', '01', 'BAGUA GRANDE'),
 ('01', '07', '02', 'CAJARURO'),
 ('01', '07', '03', 'CUMBA'),
 ('01', '07', '04', 'EL MILAGRO'),
 ('01', '07', '05', 'JAMALCA'),
 ('01', '07', '06', 'LONYA GRANDE'),
 ('01', '07', '07', 'YAMON'),
 ('02', '00', '00', 'ANCASH'),
 ('02', '01', '00', 'HUARAZ'),
 ('02', '01', '01', 'HUARAZ'),
 ('02', '01', '02', 'COCHABAMBA'),
 ('02', '01', '03', 'COLCABAMBA'),
 ('02', '01', '04', 'HUANCHAY'),
 ('02', '01', '05', 'INDEPENDENCIA'),
 ('02', '01', '06', 'JANGAS'),
 ('02', '01', '07', 'LA LIBERTAD'),
 ('02', '01', '08', 'OLLEROS'),
 ('02', '01', '09', 'PAMPAS'),
 ('02', '01', '10', 'PARIACOTO'),
 ('02', '01', '11', 'PIRA'),
 ('02', '01', '12', 'TARICA'),
 ('02', '02', '00', 'AIJA'),
 ('02', '02', '01', 'AIJA'),
 ('02', '02', '02', 'CORIS'),
 ('02', '02', '03', 'HUACLLAN'),
 ('02', '02', '04', 'LA MERCED'),
 ('02', '02', '05', 'SUCCHA'),
 ('02', '03', '00', 'ANTONIO RAYMONDI'),
 ('02', '03', '01', 'LLAMELLIN'),
 ('02', '03', '02', 'ACZO'),
 ('02', '03', '03', 'CHACCHO'),
 ('02', '03', '04', 'CHINGAS'),
 ('02', '03', '05', 'MIRGAS'),
 ('02', '03', '06', 'SAN JUAN DE RONTOY'),
 ('02', '04', '00', 'ASUNCION'),
 ('02', '04', '01', 'CHACAS'),
 ('02', '04', '02', 'ACOCHACA'),
 ('02', '05', '00', 'BOLOGNESI'),
 ('02', '05', '01', 'CHIQUIAN'),
 ('02', '05', '02', 'ABELARDO PARDO LEZAMETA'),
 ('02', '05', '03', 'ANTONIO RAYMONDI'),
 ('02', '05', '04', 'AQUIA'),
 ('02', '05', '05', 'CAJACAY'),
 ('02', '05', '06', 'CANIS'),
 ('02', '05', '07', 'COLQUIOC'),
 ('02', '05', '08', 'HUALLANCA'),
 ('02', '05', '09', 'HUASTA'),
 ('02', '05', '10', 'HUAYLLACAYAN'),
 ('02', '05', '11', 'LA PRIMAVERA'),
 ('02', '05', '12', 'MANGAS'),
 ('02', '05', '13', 'PACLLON'),
 ('02', '05', '14', 'SAN MIGUEL DE CORPANQUI'),
 ('02', '05', '15', 'TICLLOS'),
 ('02', '06', '00', 'CARHUAZ'),
 ('02', '06', '01', 'CARHUAZ'),
 ('02', '06', '02', 'ACOPAMPA'),
 ('02', '06', '03', 'AMASHCA'),
 ('02', '06', '04', 'ANTA'),
 ('02', '06', '05', 'ATAQUERO'),
 ('02', '06', '06', 'MARCARA'),
 ('02', '06', '07', 'PARIAHUANCA'),
 ('02', '06', '08', 'SAN MIGUEL DE ACO'),
 ('02', '06', '09', 'SHILLA'),
 ('02', '06', '10', 'TINCO'),
 ('02', '06', '11', 'YUNGAR'),
 ('02', '07', '00', 'CARLOS FERMIN FITZCARRALD'),
 ('02', '07', '01', 'SAN LUIS'),
 ('02', '07', '02', 'SAN NICOLAS'),
 ('02', '07', '03', 'YAUYA'),
 ('02', '08', '00', 'CASMA'),
 ('02', '08', '01', 'CASMA'),
 ('02', '08', '02', 'BUENA VISTA ALTA'),
 ('02', '08', '03', 'COMANDANTE NOEL'),
 ('02', '08', '04', 'YAUTAN'),
 ('02', '09', '00', 'CORONGO'),
 ('02', '09', '01', 'CORONGO'),
 ('02', '09', '02', 'ACO'),
 ('02', '09', '03', 'BAMBAS'),
 ('02', '09', '04', 'CUSCA'),
 ('02', '09', '05', 'LA PAMPA'),
 ('02', '09', '06', 'YANAC'),
 ('02', '09', '07', 'YUPAN'),
 ('02', '10', '00', 'HUARI'),
 ('02', '10', '01', 'HUARI'),
 ('02', '10', '02', 'ANRA'),
 ('02', '10', '03', 'CAJAY'),
 ('02', '10', '04', 'CHAVIN DE HUANTAR'),
 ('02', '10', '05', 'HUACACHI'),
 ('02', '10', '06', 'HUACCHIS'),
 ('02', '10', '07', 'HUACHIS'),
 ('02', '10', '08', 'HUANTAR'),
 ('02', '10', '09', 'MASIN'),
 ('02', '10', '10', 'PAUCAS'),
 ('02', '10', '11', 'PONTO'),
 ('02', '10', '12', 'RAHUAPAMPA'),
 ('02', '10', '13', 'RAPAYAN'),
 ('02', '10', '14', 'SAN MARCOS'),
 ('02', '10', '15', 'SAN PEDRO DE CHANA'),
 ('02', '10', '16', 'UCO'),
 ('02', '11', '00', 'HUARMEY'),
 ('02', '11', '01', 'HUARMEY'),
 ('02', '11', '02', 'COCHAPETI'),
 ('02', '11', '03', 'CULEBRAS'),
 ('02', '11', '04', 'HUAYAN'),
 ('02', '11', '05', 'MALVAS'),
 ('02', '12', '00', 'HUAYLAS'),
 ('02', '12', '01', 'CARAZ'),
 ('02', '12', '02', 'HUALLANCA'),
 ('02', '12', '03', 'HUATA'),
 ('02', '12', '04', 'HUAYLAS'),
 ('02', '12', '05', 'MATO'),
 ('02', '12', '06', 'PAMPAROMAS'),
 ('02', '12', '07', 'PUEBLO LIBRE'),
 ('02', '12', '08', 'SANTA CRUZ'),
 ('02', '12', '09', 'SANTO TORIBIO'),
 ('02', '12', '10', 'YURACMARCA'),
 ('02', '13', '00', 'MARISCAL LUZURIAGA'),
 ('02', '13', '01', 'PISCOBAMBA'),
 ('02', '13', '02', 'CASCA'),
 ('02', '13', '03', 'ELEAZAR GUZMAN BARRON'),
 ('02', '13', '04', 'FIDEL OLIVAS ESCUDERO'),
 ('02', '13', '05', 'LLAMA'),
 ('02', '13', '06', 'LLUMPA'),
 ('02', '13', '07', 'LUCMA'),
 ('02', '13', '08', 'MUSGA'),
 ('02', '14', '00', 'OCROS'),
 ('02', '14', '01', 'OCROS'),
 ('02', '14', '02', 'ACAS'),
 ('02', '14', '03', 'CAJAMARQUILLA'),
 ('02', '14', '04', 'CARHUAPAMPA'),
 ('02', '14', '05', 'COCHAS'),
 ('02', '14', '06', 'CONGAS'),
 ('02', '14', '07', 'LLIPA'),
 ('02', '14', '08', 'SAN CRISTOBAL DE RAJAN'),
 ('02', '14', '09', 'SAN PEDRO'),
 ('02', '14', '10', 'SANTIAGO DE CHILCAS'),
 ('02', '15', '00', 'PALLASCA'),
 ('02', '15', '01', 'CABANA'),
 ('02', '15', '02', 'BOLOGNESI'),
 ('02', '15', '03', 'CONCHUCOS'),
 ('02', '15', '04', 'HUACASCHUQUE'),
 ('02', '15', '05', 'HUANDOVAL'),
 ('02', '15', '06', 'LACABAMBA'),
 ('02', '15', '07', 'LLAPO'),
 ('02', '15', '08', 'PALLASCA'),
 ('02', '15', '09', 'PAMPAS'),
 ('02', '15', '10', 'SANTA ROSA'),
 ('02', '15', '11', 'TAUCA'),
 ('02', '16', '00', 'POMABAMBA'),
 ('02', '16', '01', 'POMABAMBA'),
 ('02', '16', '02', 'HUAYLLAN'),
 ('02', '16', '03', 'PAROBAMBA'),
 ('02', '16', '04', 'QUINUABAMBA'),
 ('02', '17', '00', 'RECUAY'),
 ('02', '17', '01', 'RECUAY'),
 ('02', '17', '02', 'CATAC'),
 ('02', '17', '03', 'COTAPARACO'),
 ('02', '17', '04', 'HUAYLLAPAMPA'),
 ('02', '17', '05', 'LLACLLIN'),
 ('02', '17', '06', 'MARCA'),
 ('02', '17', '07', 'PAMPAS CHICO'),
 ('02', '17', '08', 'PARARIN'),
 ('02', '17', '09', 'TAPACOCHA'),
 ('02', '17', '10', 'TICAPAMPA'),
 ('02', '18', '00', 'SANTA'),
 ('02', '18', '01', 'CHIMBOTE'),
 ('02', '18', '02', 'CACERES DEL PERU'),
 ('02', '18', '03', 'COISHCO'),
 ('02', '18', '04', 'MACATE'),
 ('02', '18', '05', 'MORO'),
 ('02', '18', '06', 'NEPE�A'),
 ('02', '18', '07', 'SAMANCO'),
 ('02', '18', '08', 'SANTA'),
 ('02', '18', '09', 'NUEVO CHIMBOTE'),
 ('02', '19', '00', 'SIHUAS'),
 ('02', '19', '01', 'SIHUAS'),
 ('02', '19', '02', 'ACOBAMBA'),
 ('02', '19', '03', 'ALFONSO UGARTE'),
 ('02', '19', '04', 'CASHAPAMPA'),
 ('02', '19', '05', 'CHINGALPO'),
 ('02', '19', '06', 'HUAYLLABAMBA'),
 ('02', '19', '07', 'QUICHES'),
 ('02', '19', '08', 'RAGASH'),
 ('02', '19', '09', 'SAN JUAN'),
 ('02', '19', '10', 'SICSIBAMBA'),
 ('02', '20', '00', 'YUNGAY'),
 ('02', '20', '01', 'YUNGAY'),
 ('02', '20', '02', 'CASCAPARA'),
 ('02', '20', '03', 'MANCOS'),
 ('02', '20', '04', 'MATACOTO'),
 ('02', '20', '05', 'QUILLO'),
 ('02', '20', '06', 'RANRAHIRCA'),
 ('02', '20', '07', 'SHUPLUY'),
 ('02', '20', '08', 'YANAMA'),
 ('03', '00', '00', 'APURIMAC'),
 ('03', '01', '00', 'ABANCAY'),
 ('03', '01', '01', 'ABANCAY'),
 ('03', '01', '02', 'CHACOCHE'),
 ('03', '01', '03', 'CIRCA'),
 ('03', '01', '04', 'CURAHUASI'),
 ('03', '01', '05', 'HUANIPACA'),
 ('03', '01', '06', 'LAMBRAMA'),
 ('03', '01', '07', 'PICHIRHUA'),
 ('03', '01', '08', 'SAN PEDRO DE CACHORA'),
 ('03', '01', '09', 'TAMBURCO'),
 ('03', '02', '00', 'ANDAHUAYLAS'),
 ('03', '02', '01', 'ANDAHUAYLAS'),
 ('03', '02', '02', 'ANDARAPA'),
 ('03', '02', '03', 'CHIARA'),
 ('03', '02', '04', 'HUANCARAMA'),
 ('03', '02', '05', 'HUANCARAY'),
 ('03', '02', '06', 'HUAYANA'),
 ('03', '02', '07', 'KISHUARA'),
 ('03', '02', '08', 'PACOBAMBA'),
 ('03', '02', '09', 'PACUCHA'),
 ('03', '02', '10', 'PAMPACHIRI'),
 ('03', '02', '11', 'POMACOCHA'),
 ('03', '02', '12', 'SAN ANTONIO DE CACHI'),
 ('03', '02', '13', 'SAN JERONIMO'),
 ('03', '02', '14', 'SAN MIGUEL DE CHACCRAMPA'),
 ('03', '02', '15', 'SANTA MARIA DE CHICMO'),
 ('03', '02', '16', 'TALAVERA'),
 ('03', '02', '17', 'TUMAY HUARACA'),
 ('03', '02', '18', 'TURPO'),
 ('03', '02', '19', 'KAQUIABAMBA'),
 ('03', '03', '00', 'ANTABAMBA'),
 ('03', '03', '01', 'ANTABAMBA'),
 ('03', '03', '02', 'EL ORO'),
 ('03', '03', '03', 'HUAQUIRCA'),
 ('03', '03', '04', 'JUAN ESPINOZA MEDRANO'),
 ('03', '03', '05', 'OROPESA'),
 ('03', '03', '06', 'PACHACONAS'),
 ('03', '03', '07', 'SABAINO'),
 ('03', '04', '00', 'AYMARAES'),
 ('03', '04', '01', 'CHALHUANCA'),
 ('03', '04', '02', 'CAPAYA'),
 ('03', '04', '03', 'CARAYBAMBA'),
 ('03', '04', '04', 'CHAPIMARCA'),
 ('03', '04', '05', 'COLCABAMBA'),
 ('03', '04', '06', 'COTARUSE'),
 ('03', '04', '07', 'HUAYLLO'),
 ('03', '04', '08', 'JUSTO APU SAHUARAURA'),
 ('03', '04', '09', 'LUCRE'),
 ('03', '04', '10', 'POCOHUANCA'),
 ('03', '04', '11', 'SAN JUAN DE CHAC�A'),
 ('03', '04', '12', 'SA�AYCA'),
 ('03', '04', '13', 'SORAYA'),
 ('03', '04', '14', 'TAPAIRIHUA'),
 ('03', '04', '15', 'TINTAY'),
 ('03', '04', '16', 'TORAYA'),
 ('03', '04', '17', 'YANACA'),
 ('03', '05', '00', 'COTABAMBAS'),
 ('03', '05', '01', 'TAMBOBAMBA'),
 ('03', '05', '02', 'COTABAMBAS'),
 ('03', '05', '03', 'COYLLURQUI'),
 ('03', '05', '04', 'HAQUIRA'),
 ('03', '05', '05', 'MARA'),
 ('03', '05', '06', 'CHALLHUAHUACHO'),
 ('03', '06', '00', 'CHINCHEROS'),
 ('03', '06', '01', 'CHINCHEROS'),
 ('03', '06', '02', 'ANCO-HUALLO'),
 ('03', '06', '03', 'COCHARCAS'),
 ('03', '06', '04', 'HUACCANA'),
 ('03', '06', '05', 'OCOBAMBA'),
 ('03', '06', '06', 'ONGOY'),
 ('03', '06', '07', 'URANMARCA'),
 ('03', '06', '08', 'RANRACANCHA'),
 ('03', '07', '00', 'GRAU'),
 ('03', '07', '01', 'CHUQUIBAMBILLA'),
 ('03', '07', '02', 'CURPAHUASI'),
 ('03', '07', '03', 'GAMARRA'),
 ('03', '07', '04', 'HUAYLLATI'),
 ('03', '07', '05', 'MAMARA'),
 ('03', '07', '06', 'MICAELA BASTIDAS'),
 ('03', '07', '07', 'PATAYPAMPA'),
 ('03', '07', '08', 'PROGRESO'),
 ('03', '07', '09', 'SAN ANTONIO'),
 ('03', '07', '10', 'SANTA ROSA'),
 ('03', '07', '11', 'TURPAY'),
 ('03', '07', '12', 'VILCABAMBA'),
 ('03', '07', '13', 'VIRUNDO'),
 ('03', '07', '14', 'CURASCO'),
 ('04', '00', '00', 'AREQUIPA'),
 ('04', '01', '00', 'AREQUIPA'),
 ('04', '01', '01', 'AREQUIPA'),
 ('04', '01', '02', 'ALTO SELVA ALEGRE'),
 ('04', '01', '03', 'CAYMA'),
 ('04', '01', '04', 'CERRO COLORADO'),
 ('04', '01', '05', 'CHARACATO'),
 ('04', '01', '06', 'CHIGUATA'),
 ('04', '01', '07', 'JACOBO HUNTER'),
 ('04', '01', '08', 'LA JOYA'),
 ('04', '01', '09', 'MARIANO MELGAR'),
 ('04', '01', '10', 'MIRAFLORES'),
 ('04', '01', '11', 'MOLLEBAYA'),
 ('04', '01', '12', 'PAUCARPATA'),
 ('04', '01', '13', 'POCSI'),
 ('04', '01', '14', 'POLOBAYA'),
 ('04', '01', '15', 'QUEQUE�A'),
 ('04', '01', '16', 'SABANDIA'),
 ('04', '01', '17', 'SACHACA'),
 ('04', '01', '18', 'SAN JUAN DE SIGUAS'),
 ('04', '01', '19', 'SAN JUAN DE TARUCANI'),
 ('04', '01', '20', 'SANTA ISABEL DE SIGUAS'),
 ('04', '01', '21', 'SANTA RITA DE SIGUAS'),
 ('04', '01', '22', 'SOCABAYA'),
 ('04', '01', '23', 'TIABAYA'),
 ('04', '01', '24', 'UCHUMAYO'),
 ('04', '01', '25', 'VITOR'),
 ('04', '01', '26', 'YANAHUARA'),
 ('04', '01', '27', 'YARABAMBA'),
 ('04', '01', '28', 'YURA'),
 ('04', '01', '29', 'JOSE LUIS BUSTAMANTE Y RIVERO'),
 ('04', '02', '00', 'CAMANA'),
 ('04', '02', '01', 'CAMANA'),
 ('04', '02', '02', 'JOSE MARIA QUIMPER'),
 ('04', '02', '03', 'MARIANO NICOLAS VALCARCEL'),
 ('04', '02', '04', 'MARISCAL CACERES'),
 ('04', '02', '05', 'NICOLAS DE PIEROLA'),
 ('04', '02', '06', 'OCO�A'),
 ('04', '02', '07', 'QUILCA'),
 ('04', '02', '08', 'SAMUEL PASTOR'),
 ('04', '03', '00', 'CARAVELI'),
 ('04', '03', '01', 'CARAVELI'),
 ('04', '03', '02', 'ACARI'),
 ('04', '03', '03', 'ATICO'),
 ('04', '03', '04', 'ATIQUIPA'),
 ('04', '03', '05', 'BELLA UNION'),
 ('04', '03', '06', 'CAHUACHO'),
 ('04', '03', '07', 'CHALA'),
 ('04', '03', '08', 'CHAPARRA'),
 ('04', '03', '09', 'HUANUHUANU'),
 ('04', '03', '10', 'JAQUI'),
 ('04', '03', '11', 'LOMAS'),
 ('04', '03', '12', 'QUICACHA'),
 ('04', '03', '13', 'YAUCA'),
 ('04', '04', '00', 'CASTILLA'),
 ('04', '04', '01', 'APLAO'),
 ('04', '04', '02', 'ANDAGUA'),
 ('04', '04', '03', 'AYO'),
 ('04', '04', '04', 'CHACHAS'),
 ('04', '04', '05', 'CHILCAYMARCA'),
 ('04', '04', '06', 'CHOCO'),
 ('04', '04', '07', 'HUANCARQUI'),
 ('04', '04', '08', 'MACHAGUAY'),
 ('04', '04', '09', 'ORCOPAMPA'),
 ('04', '04', '10', 'PAMPACOLCA'),
 ('04', '04', '11', 'TIPAN'),
 ('04', '04', '12', 'U�ON'),
 ('04', '04', '13', 'URACA'),
 ('04', '04', '14', 'VIRACO'),
 ('04', '05', '00', 'CAYLLOMA'),
 ('04', '05', '01', 'CHIVAY'),
 ('04', '05', '02', 'ACHOMA'),
 ('04', '05', '03', 'CABANACONDE'),
 ('04', '05', '04', 'CALLALLI'),
 ('04', '05', '05', 'CAYLLOMA'),
 ('04', '05', '06', 'COPORAQUE'),
 ('04', '05', '07', 'HUAMBO'),
 ('04', '05', '08', 'HUANCA'),
 ('04', '05', '09', 'ICHUPAMPA'),
 ('04', '05', '10', 'LARI'),
 ('04', '05', '11', 'LLUTA'),
 ('04', '05', '12', 'MACA'),
 ('04', '05', '13', 'MADRIGAL'),
 ('04', '05', '14', 'SAN ANTONIO DE CHUCA'),
 ('04', '05', '15', 'SIBAYO'),
 ('04', '05', '16', 'TAPAY'),
 ('04', '05', '17', 'TISCO'),
 ('04', '05', '18', 'TUTI'),
 ('04', '05', '19', 'YANQUE'),
 ('04', '05', '20', 'MAJES'),
 ('04', '06', '00', 'CONDESUYOS'),
 ('04', '06', '01', 'CHUQUIBAMBA'),
 ('04', '06', '02', 'ANDARAY'),
 ('04', '06', '03', 'CAYARANI'),
 ('04', '06', '04', 'CHICHAS'),
 ('04', '06', '05', 'IRAY'),
 ('04', '06', '06', 'RIO GRANDE'),
 ('04', '06', '07', 'SALAMANCA'),
 ('04', '06', '08', 'YANAQUIHUA'),
 ('04', '07', '00', 'ISLAY'),
 ('04', '07', '01', 'MOLLENDO'),
 ('04', '07', '02', 'COCACHACRA'),
 ('04', '07', '03', 'DEAN VALDIVIA'),
 ('04', '07', '04', 'ISLAY'),
 ('04', '07', '05', 'MEJIA'),
 ('04', '07', '06', 'PUNTA DE BOMBON'),
 ('04', '08', '00', 'LA UNION'),
 ('04', '08', '01', 'COTAHUASI'),
 ('04', '08', '02', 'ALCA'),
 ('04', '08', '03', 'CHARCANA'),
 ('04', '08', '04', 'HUAYNACOTAS'),
 ('04', '08', '05', 'PAMPAMARCA'),
 ('04', '08', '06', 'PUYCA'),
 ('04', '08', '07', 'QUECHUALLA'),
 ('04', '08', '08', 'SAYLA'),
 ('04', '08', '09', 'TAURIA'),
 ('04', '08', '10', 'TOMEPAMPA'),
 ('04', '08', '11', 'TORO'),
 ('05', '00', '00', 'AYACUCHO'),
 ('05', '01', '00', 'HUAMANGA'),
 ('05', '01', '01', 'AYACUCHO'),
 ('05', '01', '02', 'ACOCRO'),
 ('05', '01', '03', 'ACOS VINCHOS'),
 ('05', '01', '04', 'CARMEN ALTO'),
 ('05', '01', '05', 'CHIARA'),
 ('05', '01', '06', 'OCROS'),
 ('05', '01', '07', 'PACAYCASA'),
 ('05', '01', '08', 'QUINUA'),
 ('05', '01', '09', 'SAN JOSE DE TICLLAS'),
 ('05', '01', '10', 'SAN JUAN BAUTISTA'),
 ('05', '01', '11', 'SANTIAGO DE PISCHA'),
 ('05', '01', '12', 'SOCOS'),
 ('05', '01', '13', 'TAMBILLO'),
 ('05', '01', '14', 'VINCHOS'),
 ('05', '01', '15', 'JESUS NAZARENO'),
 ('05', '02', '00', 'CANGALLO'),
 ('05', '02', '01', 'CANGALLO'),
 ('05', '02', '02', 'CHUSCHI'),
 ('05', '02', '03', 'LOS MOROCHUCOS'),
 ('05', '02', '04', 'MARIA PARADO DE BELLIDO'),
 ('05', '02', '05', 'PARAS'),
 ('05', '02', '06', 'TOTOS'),
 ('05', '03', '00', 'HUANCA SANCOS'),
 ('05', '03', '01', 'SANCOS'),
 ('05', '03', '02', 'CARAPO'),
 ('05', '03', '03', 'SACSAMARCA'),
 ('05', '03', '04', 'SANTIAGO DE LUCANAMARCA'),
 ('05', '04', '00', 'HUANTA'),
 ('05', '04', '01', 'HUANTA'),
 ('05', '04', '02', 'AYAHUANCO'),
 ('05', '04', '03', 'HUAMANGUILLA'),
 ('05', '04', '04', 'IGUAIN'),
 ('05', '04', '05', 'LURICOCHA'),
 ('05', '04', '06', 'SANTILLANA'),
 ('05', '04', '07', 'SIVIA'),
 ('05', '04', '08', 'LLOCHEGUA'),
 ('05', '05', '00', 'LA MAR'),
 ('05', '05', '01', 'SAN MIGUEL'),
 ('05', '05', '02', 'ANCO'),
 ('05', '05', '03', 'AYNA'),
 ('05', '05', '04', 'CHILCAS'),
 ('05', '05', '05', 'CHUNGUI'),
 ('05', '05', '06', 'LUIS CARRANZA'),
 ('05', '05', '07', 'SANTA ROSA'),
 ('05', '05', '08', 'TAMBO'),
 ('05', '06', '00', 'LUCANAS'),
 ('05', '06', '01', 'PUQUIO'),
 ('05', '06', '02', 'AUCARA'),
 ('05', '06', '03', 'CABANA'),
 ('05', '06', '04', 'CARMEN SALCEDO'),
 ('05', '06', '05', 'CHAVI�A'),
 ('05', '06', '06', 'CHIPAO'),
 ('05', '06', '07', 'HUAC-HUAS'),
 ('05', '06', '08', 'LARAMATE'),
 ('05', '06', '09', 'LEONCIO PRADO'),
 ('05', '06', '10', 'LLAUTA'),
 ('05', '06', '11', 'LUCANAS'),
 ('05', '06', '12', 'OCA�A'),
 ('05', '06', '13', 'OTOCA'),
 ('05', '06', '14', 'SAISA'),
 ('05', '06', '15', 'SAN CRISTOBAL'),
 ('05', '06', '16', 'SAN JUAN'),
 ('05', '06', '17', 'SAN PEDRO'),
 ('05', '06', '18', 'SAN PEDRO DE PALCO'),
 ('05', '06', '19', 'SANCOS'),
 ('05', '06', '20', 'SANTA ANA DE HUAYCAHUACHO'),
 ('05', '06', '21', 'SANTA LUCIA'),
 ('05', '07', '00', 'PARINACOCHAS'),
 ('05', '07', '01', 'CORACORA'),
 ('05', '07', '02', 'CHUMPI'),
 ('05', '07', '03', 'CORONEL CASTA�EDA'),
 ('05', '07', '04', 'PACAPAUSA'),
 ('05', '07', '05', 'PULLO'),
 ('05', '07', '06', 'PUYUSCA'),
 ('05', '07', '07', 'SAN FRANCISCO DE RAVACAYCO'),
 ('05', '07', '08', 'UPAHUACHO'),
 ('05', '08', '00', 'PAUCAR DEL SARA SARA'),
 ('05', '08', '01', 'PAUSA'),
 ('05', '08', '02', 'COLTA'),
 ('05', '08', '03', 'CORCULLA'),
 ('05', '08', '04', 'LAMPA'),
 ('05', '08', '05', 'MARCABAMBA'),
 ('05', '08', '06', 'OYOLO'),
 ('05', '08', '07', 'PARARCA'),
 ('05', '08', '08', 'SAN JAVIER DE ALPABAMBA'),
 ('05', '08', '09', 'SAN JOSE DE USHUA'),
 ('05', '08', '10', 'SARA SARA'),
 ('05', '09', '00', 'SUCRE'),
 ('05', '09', '01', 'QUEROBAMBA'),
 ('05', '09', '02', 'BELEN'),
 ('05', '09', '03', 'CHALCOS'),
 ('05', '09', '04', 'CHILCAYOC'),
 ('05', '09', '05', 'HUACA�A'),
 ('05', '09', '06', 'MORCOLLA'),
 ('05', '09', '07', 'PAICO'),
 ('05', '09', '08', 'SAN PEDRO DE LARCAY'),
 ('05', '09', '09', 'SAN SALVADOR DE QUIJE'),
 ('05', '09', '10', 'SANTIAGO DE PAUCARAY'),
 ('05', '09', '11', 'SORAS'),
 ('05', '10', '00', 'VICTOR FAJARDO'),
 ('05', '10', '01', 'HUANCAPI'),
 ('05', '10', '02', 'ALCAMENCA'),
 ('05', '10', '03', 'APONGO'),
 ('05', '10', '04', 'ASQUIPATA'),
 ('05', '10', '05', 'CANARIA'),
 ('05', '10', '06', 'CAYARA'),
 ('05', '10', '07', 'COLCA'),
 ('05', '10', '08', 'HUAMANQUIQUIA'),
 ('05', '10', '09', 'HUANCARAYLLA'),
 ('05', '10', '10', 'HUAYA'),
 ('05', '10', '11', 'SARHUA'),
 ('05', '10', '12', 'VILCANCHOS'),
 ('05', '11', '00', 'VILCAS HUAMAN'),
 ('05', '11', '01', 'VILCAS HUAMAN'),
 ('05', '11', '02', 'ACCOMARCA'),
 ('05', '11', '03', 'CARHUANCA'),
 ('05', '11', '04', 'CONCEPCION'),
 ('05', '11', '05', 'HUAMBALPA'),
 ('05', '11', '06', 'INDEPENDENCIA'),
 ('05', '11', '07', 'SAURAMA'),
 ('05', '11', '08', 'VISCHONGO'),
 ('06', '00', '00', 'CAJAMARCA'),
 ('06', '01', '00', 'CAJAMARCA'),
 ('06', '01', '01', 'CAJAMARCA'),
 ('06', '01', '02', 'ASUNCION'),
 ('06', '01', '03', 'CHETILLA'),
 ('06', '01', '04', 'COSPAN'),
 ('06', '01', '05', 'ENCA�ADA'),
 ('06', '01', '06', 'JESUS'),
 ('06', '01', '07', 'LLACANORA'),
 ('06', '01', '08', 'LOS BA�OS DEL INCA'),
 ('06', '01', '09', 'MAGDALENA'),
 ('06', '01', '10', 'MATARA'),
 ('06', '01', '11', 'NAMORA'),
 ('06', '01', '12', 'SAN JUAN'),
 ('06', '02', '00', 'CAJABAMBA'),
 ('06', '02', '01', 'CAJABAMBA'),
 ('06', '02', '02', 'CACHACHI'),
 ('06', '02', '03', 'CONDEBAMBA'),
 ('06', '02', '04', 'SITACOCHA'),
 ('06', '03', '00', 'CELENDIN'),
 ('06', '03', '01', 'CELENDIN'),
 ('06', '03', '02', 'CHUMUCH'),
 ('06', '03', '03', 'CORTEGANA'),
 ('06', '03', '04', 'HUASMIN'),
 ('06', '03', '05', 'JORGE CHAVEZ'),
 ('06', '03', '06', 'JOSE GALVEZ'),
 ('06', '03', '07', 'MIGUEL IGLESIAS'),
 ('06', '03', '08', 'OXAMARCA'),
 ('06', '03', '09', 'SOROCHUCO'),
 ('06', '03', '10', 'SUCRE'),
 ('06', '03', '11', 'UTCO'),
 ('06', '03', '12', 'LA LIBERTAD DE PALLAN'),
 ('06', '04', '00', 'CHOTA'),
 ('06', '04', '01', 'CHOTA'),
 ('06', '04', '02', 'ANGUIA'),
 ('06', '04', '03', 'CHADIN'),
 ('06', '04', '04', 'CHIGUIRIP'),
 ('06', '04', '05', 'CHIMBAN'),
 ('06', '04', '06', 'CHOROPAMPA'),
 ('06', '04', '07', 'COCHABAMBA'),
 ('06', '04', '08', 'CONCHAN'),
 ('06', '04', '09', 'HUAMBOS'),
 ('06', '04', '10', 'LAJAS'),
 ('06', '04', '11', 'LLAMA'),
 ('06', '04', '12', 'MIRACOSTA'),
 ('06', '04', '13', 'PACCHA'),
 ('06', '04', '14', 'PION'),
 ('06', '04', '15', 'QUEROCOTO'),
 ('06', '04', '16', 'SAN JUAN DE LICUPIS'),
 ('06', '04', '17', 'TACABAMBA'),
 ('06', '04', '18', 'TOCMOCHE'),
 ('06', '04', '19', 'CHALAMARCA'),
 ('06', '05', '00', 'CONTUMAZA'),
 ('06', '05', '01', 'CONTUMAZA'),
 ('06', '05', '02', 'CHILETE'),
 ('06', '05', '03', 'CUPISNIQUE'),
 ('06', '05', '04', 'GUZMANGO'),
 ('06', '05', '05', 'SAN BENITO'),
 ('06', '05', '06', 'SANTA CRUZ DE TOLED'),
 ('06', '05', '07', 'TANTARICA'),
 ('06', '05', '08', 'YONAN'),
 ('06', '06', '00', 'CUTERVO'),
 ('06', '06', '01', 'CUTERVO'),
 ('06', '06', '02', 'CALLAYUC'),
 ('06', '06', '03', 'CHOROS'),
 ('06', '06', '04', 'CUJILLO'),
 ('06', '06', '05', 'LA RAMADA'),
 ('06', '06', '06', 'PIMPINGOS'),
 ('06', '06', '07', 'QUEROCOTILLO'),
 ('06', '06', '08', 'SAN ANDRES DE CUTERVO'),
 ('06', '06', '09', 'SAN JUAN DE CUTERVO'),
 ('06', '06', '10', 'SAN LUIS DE LUCMA'),
 ('06', '06', '11', 'SANTA CRUZ'),
 ('06', '06', '12', 'SANTO DOMINGO DE LA CAPILLA'),
 ('06', '06', '13', 'SANTO TOMAS'),
 ('06', '06', '14', 'SOCOTA'),
 ('06', '06', '15', 'TORIBIO CASANOVA'),
 ('06', '07', '00', 'HUALGAYOC'),
 ('06', '07', '01', 'BAMBAMARCA'),
 ('06', '07', '02', 'CHUGUR'),
 ('06', '07', '03', 'HUALGAYOC'),
 ('06', '08', '00', 'JAEN'),
 ('06', '08', '01', 'JAEN'),
 ('06', '08', '02', 'BELLAVISTA'),
 ('06', '08', '03', 'CHONTALI'),
 ('06', '08', '04', 'COLASAY'),
 ('06', '08', '05', 'HUABAL'),
 ('06', '08', '06', 'LAS PIRIAS'),
 ('06', '08', '07', 'POMAHUACA'),
 ('06', '08', '08', 'PUCARA'),
 ('06', '08', '09', 'SALLIQUE'),
 ('06', '08', '10', 'SAN FELIPE'),
 ('06', '08', '11', 'SAN JOSE DEL ALTO'),
 ('06', '08', '12', 'SANTA ROSA'),
 ('06', '09', '00', 'SAN IGNACIO'),
 ('06', '09', '01', 'SAN IGNACIO'),
 ('06', '09', '02', 'CHIRINOS'),
 ('06', '09', '03', 'HUARANGO'),
 ('06', '09', '04', 'LA COIPA'),
 ('06', '09', '05', 'NAMBALLE'),
 ('06', '09', '06', 'SAN JOSE DE LOURDES'),
 ('06', '09', '07', 'TABACONAS'),
 ('06', '10', '00', 'SAN MARCOS'),
 ('06', '10', '01', 'PEDRO GALVEZ'),
 ('06', '10', '02', 'CHANCAY'),
 ('06', '10', '03', 'EDUARDO VILLANUEVA'),
 ('06', '10', '04', 'GREGORIO PITA'),
 ('06', '10', '05', 'ICHOCAN'),
 ('06', '10', '06', 'JOSE MANUEL QUIROZ'),
 ('06', '10', '07', 'JOSE SABOGAL'),
 ('06', '11', '00', 'SAN MIGUEL'),
 ('06', '11', '01', 'SAN MIGUEL'),
 ('06', '11', '02', 'BOLIVAR'),
 ('06', '11', '03', 'CALQUIS'),
 ('06', '11', '04', 'CATILLUC'),
 ('06', '11', '05', 'EL PRADO'),
 ('06', '11', '06', 'LA FLORIDA'),
 ('06', '11', '07', 'LLAPA'),
 ('06', '11', '08', 'NANCHOC'),
 ('06', '11', '09', 'NIEPOS'),
 ('06', '11', '10', 'SAN GREGORIO'),
 ('06', '11', '11', 'SAN SILVESTRE DE COCHAN'),
 ('06', '11', '12', 'TONGOD'),
 ('06', '11', '13', 'UNION AGUA BLANCA'),
 ('06', '12', '00', 'SAN PABLO'),
 ('06', '12', '01', 'SAN PABLO'),
 ('06', '12', '02', 'SAN BERNARDINO'),
 ('06', '12', '03', 'SAN LUIS'),
 ('06', '12', '04', 'TUMBADEN'),
 ('06', '13', '00', 'SANTA CRUZ'),
 ('06', '13', '01', 'SANTA CRUZ'),
 ('06', '13', '02', 'ANDABAMBA'),
 ('06', '13', '03', 'CATACHE'),
 ('06', '13', '04', 'CHANCAYBA�OS'),
 ('06', '13', '05', 'LA ESPERANZA'),
 ('06', '13', '06', 'NINABAMBA'),
 ('06', '13', '07', 'PULAN'),
 ('06', '13', '08', 'SAUCEPAMPA'),
 ('06', '13', '09', 'SEXI'),
 ('06', '13', '10', 'UTICYACU'),
 ('06', '13', '11', 'YAUYUCAN'),
 ('07', '00', '00', 'CALLAO'),
 ('07', '01', '00', 'CALLAO'),
 ('07', '01', '01', 'CALLAO'),
 ('07', '01', '02', 'BELLAVISTA'),
 ('07', '01', '03', 'CARMEN DE LA LEGUA REYNOSO'),
 ('07', '01', '04', 'LA PERLA'),
 ('07', '01', '05', 'LA PUNTA'),
 ('07', '01', '06', 'VENTANILLA'),
 ('08', '00', '00', 'CUSCO'),
 ('08', '01', '00', 'CUSCO'),
 ('08', '01', '01', 'CUSCO'),
 ('08', '01', '02', 'CCORCA'),
 ('08', '01', '03', 'POROY'),
 ('08', '01', '04', 'SAN JERONIMO'),
 ('08', '01', '05', 'SAN SEBASTIAN'),
 ('08', '01', '06', 'SANTIAGO'),
 ('08', '01', '07', 'SAYLLA'),
 ('08', '01', '08', 'WANCHAQ'),
 ('08', '02', '00', 'ACOMAYO'),
 ('08', '02', '01', 'ACOMAYO'),
 ('08', '02', '02', 'ACOPIA'),
 ('08', '02', '03', 'ACOS'),
 ('08', '02', '04', 'MOSOC LLACTA'),
 ('08', '02', '05', 'POMACANCHI'),
 ('08', '02', '06', 'RONDOCAN'),
 ('08', '02', '07', 'SANGARARA'),
 ('08', '03', '00', 'ANTA'),
 ('08', '03', '01', 'ANTA'),
 ('08', '03', '02', 'ANCAHUASI'),
 ('08', '03', '03', 'CACHIMAYO'),
 ('08', '03', '04', 'CHINCHAYPUJIO'),
 ('08', '03', '05', 'HUAROCONDO'),
 ('08', '03', '06', 'LIMATAMBO'),
 ('08', '03', '07', 'MOLLEPATA'),
 ('08', '03', '08', 'PUCYURA'),
 ('08', '03', '09', 'ZURITE'),
 ('08', '04', '00', 'CALCA'),
 ('08', '04', '01', 'CALCA'),
 ('08', '04', '02', 'COYA'),
 ('08', '04', '03', 'LAMAY'),
 ('08', '04', '04', 'LARES'),
 ('08', '04', '05', 'PISAC'),
 ('08', '04', '06', 'SAN SALVADOR'),
 ('08', '04', '07', 'TARAY'),
 ('08', '04', '08', 'YANATILE'),
 ('08', '05', '00', 'CANAS'),
 ('08', '05', '01', 'YANAOCA'),
 ('08', '05', '02', 'CHECCA'),
 ('08', '05', '03', 'KUNTURKANKI'),
 ('08', '05', '04', 'LANGUI'),
 ('08', '05', '05', 'LAYO'),
 ('08', '05', '06', 'PAMPAMARCA'),
 ('08', '05', '07', 'QUEHUE'),
 ('08', '05', '08', 'TUPAC AMARU'),
 ('08', '06', '00', 'CANCHIS'),
 ('08', '06', '01', 'SICUANI'),
 ('08', '06', '02', 'CHECACUPE'),
 ('08', '06', '03', 'COMBAPATA'),
 ('08', '06', '04', 'MARANGANI'),
 ('08', '06', '05', 'PITUMARCA'),
 ('08', '06', '06', 'SAN PABLO'),
 ('08', '06', '07', 'SAN PEDRO'),
 ('08', '06', '08', 'TINTA'),
 ('08', '07', '00', 'CHUMBIVILCAS'),
 ('08', '07', '01', 'SANTO TOMAS'),
 ('08', '07', '02', 'CAPACMARCA'),
 ('08', '07', '03', 'CHAMACA'),
 ('08', '07', '04', 'COLQUEMARCA'),
 ('08', '07', '05', 'LIVITACA'),
 ('08', '07', '06', 'LLUSCO'),
 ('08', '07', '07', 'QUI�OTA'),
 ('08', '07', '08', 'VELILLE'),
 ('08', '08', '00', 'ESPINAR'),
 ('08', '08', '01', 'ESPINAR'),
 ('08', '08', '02', 'CONDOROMA'),
 ('08', '08', '03', 'COPORAQUE'),
 ('08', '08', '04', 'OCORURO'),
 ('08', '08', '05', 'PALLPATA'),
 ('08', '08', '06', 'PICHIGUA'),
 ('08', '08', '07', 'SUYCKUTAMBO'),
 ('08', '08', '08', 'ALTO PICHIGUA'),
 ('08', '09', '00', 'LA CONVENCION'),
 ('08', '09', '01', 'SANTA ANA'),
 ('08', '09', '02', 'ECHARATE'),
 ('08', '09', '03', 'HUAYOPATA'),
 ('08', '09', '04', 'MARANURA'),
 ('08', '09', '05', 'OCOBAMBA'),
 ('08', '09', '06', 'QUELLOUNO'),
 ('08', '09', '07', 'KIMBIRI'),
 ('08', '09', '08', 'SANTA TERESA'),
 ('08', '09', '09', 'VILCABAMBA'),
 ('08', '09', '10', 'PICHARI'),
 ('08', '10', '00', 'PARURO'),
 ('08', '10', '01', 'PARURO'),
 ('08', '10', '02', 'ACCHA'),
 ('08', '10', '03', 'CCAPI'),
 ('08', '10', '04', 'COLCHA'),
 ('08', '10', '05', 'HUANOQUITE'),
 ('08', '10', '06', 'OMACHA'),
 ('08', '10', '07', 'PACCARITAMBO'),
 ('08', '10', '08', 'PILLPINTO'),
 ('08', '10', '09', 'YAURISQUE'),
 ('08', '11', '00', 'PAUCARTAMBO'),
 ('08', '11', '01', 'PAUCARTAMBO'),
 ('08', '11', '02', 'CAICAY'),
 ('08', '11', '03', 'CHALLABAMBA'),
 ('08', '11', '04', 'COLQUEPATA'),
 ('08', '11', '05', 'HUANCARANI'),
 ('08', '11', '06', 'KOS�IPATA'),
 ('08', '12', '00', 'QUISPICANCHI'),
 ('08', '12', '01', 'URCOS'),
 ('08', '12', '02', 'ANDAHUAYLILLAS'),
 ('08', '12', '03', 'CAMANTI'),
 ('08', '12', '04', 'CCARHUAYO'),
 ('08', '12', '05', 'CCATCA'),
 ('08', '12', '06', 'CUSIPATA'),
 ('08', '12', '07', 'HUARO'),
 ('08', '12', '08', 'LUCRE'),
 ('08', '12', '09', 'MARCAPATA'),
 ('08', '12', '10', 'OCONGATE'),
 ('08', '12', '11', 'OROPESA'),
 ('08', '12', '12', 'QUIQUIJANA'),
 ('08', '13', '00', 'URUBAMBA'),
 ('08', '13', '01', 'URUBAMBA'),
 ('08', '13', '02', 'CHINCHERO'),
 ('08', '13', '03', 'HUAYLLABAMBA'),
 ('08', '13', '04', 'MACHUPICCHU'),
 ('08', '13', '05', 'MARAS'),
 ('08', '13', '06', 'OLLANTAYTAMBO'),
 ('08', '13', '07', 'YUCAY'),
 ('09', '00', '00', 'HUANCAVELICA'),
 ('09', '01', '00', 'HUANCAVELICA'),
 ('09', '01', '01', 'HUANCAVELICA'),
 ('09', '01', '02', 'ACOBAMBILLA'),
 ('09', '01', '03', 'ACORIA'),
 ('09', '01', '04', 'CONAYCA'),
 ('09', '01', '05', 'CUENCA'),
 ('09', '01', '06', 'HUACHOCOLPA'),
 ('09', '01', '07', 'HUAYLLAHUARA'),
 ('09', '01', '08', 'IZCUCHACA'),
 ('09', '01', '09', 'LARIA'),
 ('09', '01', '10', 'MANTA'),
 ('09', '01', '11', 'MARISCAL CACERES'),
 ('09', '01', '12', 'MOYA'),
 ('09', '01', '13', 'NUEVO OCCORO'),
 ('09', '01', '14', 'PALCA'),
 ('09', '01', '15', 'PILCHACA'),
 ('09', '01', '16', 'VILCA'),
 ('09', '01', '17', 'YAULI'),
 ('09', '01', '18', 'ASCENSION'),
 ('09', '01', '19', 'HUANDO'),
 ('09', '02', '00', 'ACOBAMBA'),
 ('09', '02', '01', 'ACOBAMBA'),
 ('09', '02', '02', 'ANDABAMBA'),
 ('09', '02', '03', 'ANTA'),
 ('09', '02', '04', 'CAJA'),
 ('09', '02', '05', 'MARCAS'),
 ('09', '02', '06', 'PAUCARA'),
 ('09', '02', '07', 'POMACOCHA'),
 ('09', '02', '08', 'ROSARIO'),
 ('09', '03', '00', 'ANGARAES'),
 ('09', '03', '01', 'LIRCAY'),
 ('09', '03', '02', 'ANCHONGA'),
 ('09', '03', '03', 'CALLANMARCA'),
 ('09', '03', '04', 'CCOCHACCASA'),
 ('09', '03', '05', 'CHINCHO'),
 ('09', '03', '06', 'CONGALLA'),
 ('09', '03', '07', 'HUANCA-HUANCA'),
 ('09', '03', '08', 'HUAYLLAY GRANDE'),
 ('09', '03', '09', 'JULCAMARCA'),
 ('09', '03', '10', 'SAN ANTONIO DE ANTAPARCO'),
 ('09', '03', '11', 'SANTO TOMAS DE PATA'),
 ('09', '03', '12', 'SECCLLA'),
 ('09', '04', '00', 'CASTROVIRREYNA'),
 ('09', '04', '01', 'CASTROVIRREYNA'),
 ('09', '04', '02', 'ARMA'),
 ('09', '04', '03', 'AURAHUA'),
 ('09', '04', '04', 'CAPILLAS'),
 ('09', '04', '05', 'CHUPAMARCA'),
 ('09', '04', '06', 'COCAS'),
 ('09', '04', '07', 'HUACHOS'),
 ('09', '04', '08', 'HUAMATAMBO'),
 ('09', '04', '09', 'MOLLEPAMPA'),
 ('09', '04', '10', 'SAN JUAN'),
 ('09', '04', '11', 'SANTA ANA'),
 ('09', '04', '12', 'TANTARA'),
 ('09', '04', '13', 'TICRAPO'),
 ('09', '05', '00', 'CHURCAMPA'),
 ('09', '05', '01', 'CHURCAMPA'),
 ('09', '05', '02', 'ANCO'),
 ('09', '05', '03', 'CHINCHIHUASI'),
 ('09', '05', '04', 'EL CARMEN'),
 ('09', '05', '05', 'LA MERCED'),
 ('09', '05', '06', 'LOCROJA'),
 ('09', '05', '07', 'PAUCARBAMBA'),
 ('09', '05', '08', 'SAN MIGUEL DE MAYOCC'),
 ('09', '05', '09', 'SAN PEDRO DE CORIS'),
 ('09', '05', '10', 'PACHAMARCA'),
 ('09', '06', '00', 'HUAYTARA'),
 ('09', '06', '01', 'HUAYTARA'),
 ('09', '06', '02', 'AYAVI'),
 ('09', '06', '03', 'CORDOVA'),
 ('09', '06', '04', 'HUAYACUNDO ARMA'),
 ('09', '06', '05', 'LARAMARCA'),
 ('09', '06', '06', 'OCOYO'),
 ('09', '06', '07', 'PILPICHACA'),
 ('09', '06', '08', 'QUERCO'),
 ('09', '06', '09', 'QUITO-ARMA'),
 ('09', '06', '10', 'SAN ANTONIO DE CUSICANCHA'),
 ('09', '06', '11', 'SAN FRANCISCO DE SANGAYAICO'),
 ('09', '06', '12', 'SAN ISIDRO'),
 ('09', '06', '13', 'SANTIAGO DE CHOCORVOS'),
 ('09', '06', '14', 'SANTIAGO DE QUIRAHUARA'),
 ('09', '06', '15', 'SANTO DOMINGO DE CAPILLAS'),
 ('09', '06', '16', 'TAMBO'),
 ('09', '07', '00', 'TAYACAJA'),
 ('09', '07', '01', 'PAMPAS'),
 ('09', '07', '02', 'ACOSTAMBO'),
 ('09', '07', '03', 'ACRAQUIA'),
 ('09', '07', '04', 'AHUAYCHA'),
 ('09', '07', '05', 'COLCABAMBA'),
 ('09', '07', '06', 'DANIEL HERNANDEZ'),
 ('09', '07', '07', 'HUACHOCOLPA'),
 ('09', '07', '09', 'HUARIBAMBA'),
 ('09', '07', '10', '�AHUIMPUQUIO'),
 ('09', '07', '11', 'PAZOS'),
 ('09', '07', '13', 'QUISHUAR'),
 ('09', '07', '14', 'SALCABAMBA'),
 ('09', '07', '15', 'SALCAHUASI'),
 ('09', '07', '16', 'SAN MARCOS DE ROCCHAC'),
 ('09', '07', '17', 'SURCUBAMBA'),
 ('09', '07', '18', 'TINTAY PUNCU'),
 ('10', '00', '00', 'HUANUCO'),
 ('10', '01', '00', 'HUANUCO'),
 ('10', '01', '01', 'HUANUCO'),
 ('10', '01', '02', 'AMARILIS'),
 ('10', '01', '03', 'CHINCHAO'),
 ('10', '01', '04', 'CHURUBAMBA'),
 ('10', '01', '05', 'MARGOS'),
 ('10', '01', '06', 'QUISQUI'),
 ('10', '01', '07', 'SAN FRANCISCO DE CAYRAN'),
 ('10', '01', '08', 'SAN PEDRO DE CHAULAN'),
 ('10', '01', '09', 'SANTA MARIA DEL VALLE'),
 ('10', '01', '10', 'YARUMAYO'),
 ('10', '01', '11', 'PILLCO MARCA'),
 ('10', '02', '00', 'AMBO'),
 ('10', '02', '01', 'AMBO'),
 ('10', '02', '02', 'CAYNA'),
 ('10', '02', '03', 'COLPAS'),
 ('10', '02', '04', 'CONCHAMARCA'),
 ('10', '02', '05', 'HUACAR')
 INSERT INTO Tb_Ubigeo VALUES('10', '02', '06', 'SAN FRANCISCO'),
 ('10', '02', '07', 'SAN RAFAEL'),
 ('10', '02', '08', 'TOMAY KICHWA'),
 ('10', '03', '00', 'DOS DE MAYO'),
 ('10', '03', '01', 'LA UNION'),
 ('10', '03', '07', 'CHUQUIS'),
 ('10', '03', '11', 'MARIAS'),
 ('10', '03', '13', 'PACHAS'),
 ('10', '03', '16', 'QUIVILLA'),
 ('10', '03', '17', 'RIPAN'),
 ('10', '03', '21', 'SHUNQUI'),
 ('10', '03', '22', 'SILLAPATA'),
 ('10', '03', '23', 'YANAS'),
 ('10', '04', '00', 'HUACAYBAMBA'),
 ('10', '04', '01', 'HUACAYBAMBA'),
 ('10', '04', '02', 'CANCHABAMBA'),
 ('10', '04', '03', 'COCHABAMBA'),
 ('10', '04', '04', 'PINRA'),
 ('10', '05', '00', 'HUAMALIES'),
 ('10', '05', '01', 'LLATA'),
 ('10', '05', '02', 'ARANCAY'),
 ('10', '05', '03', 'CHAVIN DE PARIARCA'),
 ('10', '05', '04', 'JACAS GRANDE'),
 ('10', '05', '05', 'JIRCAN'),
 ('10', '05', '06', 'MIRAFLORES'),
 ('10', '05', '07', 'MONZON'),
 ('10', '05', '08', 'PUNCHAO'),
 ('10', '05', '09', 'PU�OS'),
 ('10', '05', '10', 'SINGA'),
 ('10', '05', '11', 'TANTAMAYO'),
 ('10', '06', '00', 'LEONCIO PRADO'),
 ('10', '06', '01', 'RUPA-RUPA'),
 ('10', '06', '02', 'DANIEL ALOMIAS ROBLES'),
 ('10', '06', '03', 'HERMILIO VALDIZAN'),
 ('10', '06', '04', 'JOSE CRESPO Y CASTILLO'),
 ('10', '06', '05', 'LUYANDO'),
 ('10', '06', '06', 'MARIANO DAMASO BERAUN'),
 ('10', '07', '00', 'MARA�ON'),
 ('10', '07', '01', 'HUACRACHUCO'),
 ('10', '07', '02', 'CHOLON'),
 ('10', '07', '03', 'SAN BUENAVENTURA'),
 ('10', '08', '00', 'PACHITEA'),
 ('10', '08', '01', 'PANAO'),
 ('10', '08', '02', 'CHAGLLA'),
 ('10', '08', '03', 'MOLINO'),
 ('10', '08', '04', 'UMARI'),
 ('10', '09', '00', 'PUERTO INCA'),
 ('10', '09', '01', 'PUERTO INCA'),
 ('10', '09', '02', 'CODO DEL POZUZO'),
 ('10', '09', '03', 'HONORIA'),
 ('10', '09', '04', 'TOURNAVISTA'),
 ('10', '09', '05', 'YUYAPICHIS'),
 ('10', '10', '00', 'LAURICOCHA'),
 ('10', '10', '01', 'JESUS'),
 ('10', '10', '02', 'BA�OS'),
 ('10', '10', '03', 'JIVIA'),
 ('10', '10', '04', 'QUEROPALCA'),
 ('10', '10', '05', 'RONDOS'),
 ('10', '10', '06', 'SAN FRANCISCO DE ASIS'),
 ('10', '10', '07', 'SAN MIGUEL DE CAURI'),
 ('10', '11', '00', 'YAROWILCA'),
 ('10', '11', '01', 'CHAVINILLO'),
 ('10', '11', '02', 'CAHUAC'),
 ('10', '11', '03', 'CHACABAMBA'),
 ('10', '11', '04', 'APARICIO POMARES'),
 ('10', '11', '05', 'JACAS CHICO'),
 ('10', '11', '06', 'OBAS'),
 ('10', '11', '07', 'PAMPAMARCA'),
 ('10', '11', '08', 'CHORAS'),
 ('11', '00', '00', 'ICA'),
 ('11', '01', '00', 'ICA'),
 ('11', '01', '01', 'ICA'),
 ('11', '01', '02', 'LA TINGUI�A'),
 ('11', '01', '03', 'LOS AQUIJES'),
 ('11', '01', '04', 'OCUCAJE'),
 ('11', '01', '05', 'PACHACUTEC'),
 ('11', '01', '06', 'PARCONA'),
 ('11', '01', '07', 'PUEBLO NUEVO'),
 ('11', '01', '08', 'SALAS'),
 ('11', '01', '09', 'SAN JOSE DE LOS MOLINOS'),
 ('11', '01', '10', 'SAN JUAN BAUTISTA'),
 ('11', '01', '11', 'SANTIAGO'),
 ('11', '01', '12', 'SUBTANJALLA'),
 ('11', '01', '13', 'TATE'),
 ('11', '01', '14', 'YAUCA DEL ROSARIO'),
 ('11', '02', '00', 'CHINCHA'),
 ('11', '02', '01', 'CHINCHA ALTA'),
 ('11', '02', '02', 'ALTO LARAN'),
 ('11', '02', '03', 'CHAVIN'),
 ('11', '02', '04', 'CHINCHA BAJA'),
 ('11', '02', '05', 'EL CARMEN'),
 ('11', '02', '06', 'GROCIO PRADO'),
 ('11', '02', '07', 'PUEBLO NUEVO'),
 ('11', '02', '08', 'SAN JUAN DE YANAC'),
 ('11', '02', '09', 'SAN PEDRO DE HUACARPANA'),
 ('11', '02', '10', 'SUNAMPE'),
 ('11', '02', '11', 'TAMBO DE MORA'),
 ('11', '03', '00', 'NAZCA'),
 ('11', '03', '01', 'NAZCA'),
 ('11', '03', '02', 'CHANGUILLO'),
 ('11', '03', '03', 'EL INGENIO'),
 ('11', '03', '04', 'MARCONA'),
 ('11', '03', '05', 'VISTA ALEGRE'),
 ('11', '04', '00', 'PALPA'),
 ('11', '04', '01', 'PALPA'),
 ('11', '04', '02', 'LLIPATA'),
 ('11', '04', '03', 'RIO GRANDE'),
 ('11', '04', '04', 'SANTA CRUZ'),
 ('11', '04', '05', 'TIBILLO'),
 ('11', '05', '00', 'PISCO'),
 ('11', '05', '01', 'PISCO'),
 ('11', '05', '02', 'HUANCANO'),
 ('11', '05', '03', 'HUMAY'),
 ('11', '05', '04', 'INDEPENDENCIA'),
 ('11', '05', '05', 'PARACAS'),
 ('11', '05', '06', 'SAN ANDRES'),
 ('11', '05', '07', 'SAN CLEMENTE'),
 ('11', '05', '08', 'TUPAC AMARU INCA'),
 ('12', '00', '00', 'JUNIN'),
 ('12', '01', '00', 'HUANCAYO'),
 ('12', '01', '01', 'HUANCAYO'),
 ('12', '01', '04', 'CARHUACALLANGA'),
 ('12', '01', '05', 'CHACAPAMPA'),
 ('12', '01', '06', 'CHICCHE'),
 ('12', '01', '07', 'CHILCA'),
 ('12', '01', '08', 'CHONGOS ALTO'),
 ('12', '01', '11', 'CHUPURO'),
 ('12', '01', '12', 'COLCA'),
 ('12', '01', '13', 'CULLHUAS'),
 ('12', '01', '14', 'EL TAMBO'),
 ('12', '01', '16', 'HUACRAPUQUIO'),
 ('12', '01', '17', 'HUALHUAS'),
 ('12', '01', '19', 'HUANCAN'),
 ('12', '01', '20', 'HUASICANCHA'),
 ('12', '01', '21', 'HUAYUCACHI'),
 ('12', '01', '22', 'INGENIO'),
 ('12', '01', '24', 'PARIAHUANCA'),
 ('12', '01', '25', 'PILCOMAYO'),
 ('12', '01', '26', 'PUCARA'),
 ('12', '01', '27', 'QUICHUAY'),
 ('12', '01', '28', 'QUILCAS'),
 ('12', '01', '29', 'SAN AGUSTIN'),
 ('12', '01', '30', 'SAN JERONIMO DE TUNAN'),
 ('12', '01', '32', 'SA�O'),
 ('12', '01', '33', 'SAPALLANGA'),
 ('12', '01', '34', 'SICAYA'),
 ('12', '01', '35', 'SANTO DOMINGO DE ACOBAMBA'),
 ('12', '01', '36', 'VIQUES'),
 ('12', '02', '00', 'CONCEPCION'),
 ('12', '02', '01', 'CONCEPCION'),
 ('12', '02', '02', 'ACO'),
 ('12', '02', '03', 'ANDAMARCA'),
 ('12', '02', '04', 'CHAMBARA'),
 ('12', '02', '05', 'COCHAS'),
 ('12', '02', '06', 'COMAS'),
 ('12', '02', '07', 'HEROINAS TOLEDO'),
 ('12', '02', '08', 'MANZANARES'),
 ('12', '02', '09', 'MARISCAL CASTILLA'),
 ('12', '02', '10', 'MATAHUASI'),
 ('12', '02', '11', 'MITO'),
 ('12', '02', '12', 'NUEVE DE JULIO'),
 ('12', '02', '13', 'ORCOTUNA'),
 ('12', '02', '14', 'SAN JOSE DE QUERO'),
 ('12', '02', '15', 'SANTA ROSA DE OCOPA'),
 ('12', '03', '00', 'CHANCHAMAYO'),
 ('12', '03', '01', 'CHANCHAMAYO'),
 ('12', '03', '02', 'PERENE'),
 ('12', '03', '03', 'PICHANAQUI'),
 ('12', '03', '04', 'SAN LUIS DE SHUARO'),
 ('12', '03', '05', 'SAN RAMON'),
 ('12', '03', '06', 'VITOC'),
 ('12', '04', '00', 'JAUJA'),
 ('12', '04', '01', 'JAUJA'),
 ('12', '04', '02', 'ACOLLA'),
 ('12', '04', '03', 'APATA'),
 ('12', '04', '04', 'ATAURA'),
 ('12', '04', '05', 'CANCHAYLLO'),
 ('12', '04', '06', 'CURICACA'),
 ('12', '04', '07', 'EL MANTARO'),
 ('12', '04', '08', 'HUAMALI'),
 ('12', '04', '09', 'HUARIPAMPA'),
 ('12', '04', '10', 'HUERTAS'),
 ('12', '04', '11', 'JANJAILLO'),
 ('12', '04', '12', 'JULCAN'),
 ('12', '04', '13', 'LEONOR ORDO�EZ'),
 ('12', '04', '14', 'LLOCLLAPAMPA'),
 ('12', '04', '15', 'MARCO'),
 ('12', '04', '16', 'MASMA'),
 ('12', '04', '17', 'MASMA CHICCHE'),
 ('12', '04', '18', 'MOLINOS'),
 ('12', '04', '19', 'MONOBAMBA'),
 ('12', '04', '20', 'MUQUI'),
 ('12', '04', '21', 'MUQUIYAUYO'),
 ('12', '04', '22', 'PACA'),
 ('12', '04', '23', 'PACCHA'),
 ('12', '04', '24', 'PANCAN'),
 ('12', '04', '25', 'PARCO'),
 ('12', '04', '26', 'POMACANCHA'),
 ('12', '04', '27', 'RICRAN'),
 ('12', '04', '28', 'SAN LORENZO'),
 ('12', '04', '29', 'SAN PEDRO DE CHUNAN'),
 ('12', '04', '30', 'SAUSA'),
 ('12', '04', '31', 'SINCOS'),
 ('12', '04', '32', 'TUNAN MARCA'),
 ('12', '04', '33', 'YAULI'),
 ('12', '04', '34', 'YAUYOS'),
 ('12', '05', '00', 'JUNIN'),
 ('12', '05', '01', 'JUNIN'),
 ('12', '05', '02', 'CARHUAMAYO'),
 ('12', '05', '03', 'ONDORES'),
 ('12', '05', '04', 'ULCUMAYO'),
 ('12', '06', '00', 'SATIPO'),
 ('12', '06', '01', 'SATIPO'),
 ('12', '06', '02', 'COVIRIALI'),
 ('12', '06', '03', 'LLAYLLA'),
 ('12', '06', '04', 'MAZAMARI'),
 ('12', '06', '05', 'PAMPA HERMOSA'),
 ('12', '06', '06', 'PANGOA'),
 ('12', '06', '07', 'RIO NEGRO'),
 ('12', '06', '08', 'RIO TAMBO'),
 ('12', '07', '00', 'TARMA'),
 ('12', '07', '01', 'TARMA'),
 ('12', '07', '02', 'ACOBAMBA'),
 ('12', '07', '03', 'HUARICOLCA'),
 ('12', '07', '04', 'HUASAHUASI'),
 ('12', '07', '05', 'LA UNION'),
 ('12', '07', '06', 'PALCA'),
 ('12', '07', '07', 'PALCAMAYO'),
 ('12', '07', '08', 'SAN PEDRO DE CAJAS'),
 ('12', '07', '09', 'TAPO'),
 ('12', '08', '00', 'YAULI'),
 ('12', '08', '01', 'LA OROYA'),
 ('12', '08', '02', 'CHACAPALPA'),
 ('12', '08', '03', 'HUAY-HUAY'),
 ('12', '08', '04', 'MARCAPOMACOCHA'),
 ('12', '08', '05', 'MOROCOCHA'),
 ('12', '08', '06', 'PACCHA'),
 ('12', '08', '07', 'SANTA BARBARA DE CARHUACAYAN'),
 ('12', '08', '08', 'SANTA ROSA DE SACCO'),
 ('12', '08', '09', 'SUITUCANCHA'),
 ('12', '08', '10', 'YAULI'),
 ('12', '09', '00', 'CHUPACA'),
 ('12', '09', '01', 'CHUPACA'),
 ('12', '09', '02', 'AHUAC'),
 ('12', '09', '03', 'CHONGOS BAJO'),
 ('12', '09', '04', 'HUACHAC'),
 ('12', '09', '05', 'HUAMANCACA CHICO'),
 ('12', '09', '06', 'SAN JUAN DE YSCOS'),
 ('12', '09', '07', 'SAN JUAN DE JARPA'),
 ('12', '09', '08', 'TRES DE DICIEMBRE'),
 ('12', '09', '09', 'YANACANCHA'),
 ('13', '00', '00', 'LA LIBERTAD'),
 ('13', '01', '00', 'TRUJILLO'),
 ('13', '01', '01', 'TRUJILLO'),
 ('13', '01', '02', 'EL PORVENIR'),
 ('13', '01', '03', 'FLORENCIA DE MORA'),
 ('13', '01', '04', 'HUANCHACO'),
 ('13', '01', '05', 'LA ESPERANZA'),
 ('13', '01', '06', 'LAREDO'),
 ('13', '01', '07', 'MOCHE'),
 ('13', '01', '08', 'POROTO'),
 ('13', '01', '09', 'SALAVERRY'),
 ('13', '01', '10', 'SIMBAL'),
 ('13', '01', '11', 'VICTOR LARCO HERRERA'),
 ('13', '02', '00', 'ASCOPE'),
 ('13', '02', '01', 'ASCOPE'),
 ('13', '02', '02', 'CHICAMA'),
 ('13', '02', '03', 'CHOCOPE'),
 ('13', '02', '04', 'MAGDALENA DE CAO'),
 ('13', '02', '05', 'PAIJAN'),
 ('13', '02', '06', 'RAZURI'),
 ('13', '02', '07', 'SANTIAGO DE CAO'),
 ('13', '02', '08', 'CASA GRANDE'),
 ('13', '03', '00', 'BOLIVAR'),
 ('13', '03', '01', 'BOLIVAR'),
 ('13', '03', '02', 'BAMBAMARCA'),
 ('13', '03', '03', 'CONDORMARCA'),
 ('13', '03', '04', 'LONGOTEA'),
 ('13', '03', '05', 'UCHUMARCA'),
 ('13', '03', '06', 'UCUNCHA'),
 ('13', '04', '00', 'CHEPEN'),
 ('13', '04', '01', 'CHEPEN'),
 ('13', '04', '02', 'PACANGA'),
 ('13', '04', '03', 'PUEBLO NUEVO'),
 ('13', '05', '00', 'JULCAN'),
 ('13', '05', '01', 'JULCAN'),
 ('13', '05', '02', 'CALAMARCA'),
 ('13', '05', '03', 'CARABAMBA'),
 ('13', '05', '04', 'HUASO'),
 ('13', '06', '00', 'OTUZCO'),
 ('13', '06', '01', 'OTUZCO'),
 ('13', '06', '02', 'AGALLPAMPA'),
 ('13', '06', '04', 'CHARAT'),
 ('13', '06', '05', 'HUARANCHAL'),
 ('13', '06', '06', 'LA CUESTA'),
 ('13', '06', '08', 'MACHE'),
 ('13', '06', '10', 'PARANDAY'),
 ('13', '06', '11', 'SALPO'),
 ('13', '06', '13', 'SINSICAP'),
 ('13', '06', '14', 'USQUIL'),
 ('13', '07', '00', 'PACASMAYO'),
 ('13', '07', '01', 'SAN PEDRO DE LLOC'),
 ('13', '07', '02', 'GUADALUPE'),
 ('13', '07', '03', 'JEQUETEPEQUE'),
 ('13', '07', '04', 'PACASMAYO'),
 ('13', '07', '05', 'SAN JOSE'),
 ('13', '08', '00', 'PATAZ'),
 ('13', '08', '01', 'TAYABAMBA'),
 ('13', '08', '02', 'BULDIBUYO'),
 ('13', '08', '03', 'CHILLIA'),
 ('13', '08', '04', 'HUANCASPATA'),
 ('13', '08', '05', 'HUAYLILLAS'),
 ('13', '08', '06', 'HUAYO'),
 ('13', '08', '07', 'ONGON'),
 ('13', '08', '08', 'PARCOY'),
 ('13', '08', '09', 'PATAZ'),
 ('13', '08', '10', 'PIAS'),
 ('13', '08', '11', 'SANTIAGO DE CHALLAS'),
 ('13', '08', '12', 'TAURIJA'),
 ('13', '08', '13', 'URPAY'),
 ('13', '09', '00', 'SANCHEZ CARRION'),
 ('13', '09', '01', 'HUAMACHUCO'),
 ('13', '09', '02', 'CHUGAY'),
 ('13', '09', '03', 'COCHORCO'),
 ('13', '09', '04', 'CURGOS'),
 ('13', '09', '05', 'MARCABAL'),
 ('13', '09', '06', 'SANAGORAN'),
 ('13', '09', '07', 'SARIN'),
 ('13', '09', '08', 'SARTIMBAMBA'),
 ('13', '10', '00', 'SANTIAGO DE CHUCO'),
 ('13', '10', '01', 'SANTIAGO DE CHUCO'),
 ('13', '10', '02', 'ANGASMARCA'),
 ('13', '10', '03', 'CACHICADAN'),
 ('13', '10', '04', 'MOLLEBAMBA'),
 ('13', '10', '05', 'MOLLEPATA'),
 ('13', '10', '06', 'QUIRUVILCA'),
 ('13', '10', '07', 'SANTA CRUZ DE CHUCA'),
 ('13', '10', '08', 'SITABAMBA'),
 ('13', '11', '00', 'GRAN CHIMU'),
 ('13', '11', '01', 'CASCAS'),
 ('13', '11', '02', 'LUCMA'),
 ('13', '11', '03', 'COMPIN'),
 ('13', '11', '04', 'SAYAPULLO'),
 ('13', '12', '00', 'VIRU'),
 ('13', '12', '01', 'VIRU'),
 ('13', '12', '02', 'CHAO'),
 ('13', '12', '03', 'GUADALUPITO'),
 ('14', '00', '00', 'LAMBAYEQUE'),
 ('14', '01', '00', 'CHICLAYO'),
 ('14', '01', '01', 'CHICLAYO'),
 ('14', '01', '02', 'CHONGOYAPE'),
 ('14', '01', '03', 'ETEN'),
 ('14', '01', '04', 'ETEN PUERTO'),
 ('14', '01', '05', 'JOSE LEONARDO ORTIZ'),
 ('14', '01', '06', 'LA VICTORIA'),
 ('14', '01', '07', 'LAGUNAS'),
 ('14', '01', '08', 'MONSEFU'),
 ('14', '01', '09', 'NUEVA ARICA'),
 ('14', '01', '10', 'OYOTUN'),
 ('14', '01', '11', 'PICSI'),
 ('14', '01', '12', 'PIMENTEL'),
 ('14', '01', '13', 'REQUE'),
 ('14', '01', '14', 'SANTA ROSA'),
 ('14', '01', '15', 'SA�A'),
 ('14', '01', '16', 'CAYALTI'),
 ('14', '01', '17', 'PATAPO'),
 ('14', '01', '18', 'POMALCA'),
 ('14', '01', '19', 'PUCALA'),
 ('14', '01', '20', 'TUMAN'),
 ('14', '02', '00', 'FERRE�AFE'),
 ('14', '02', '01', 'FERRE�AFE'),
 ('14', '02', '02', 'CA�ARIS'),
 ('14', '02', '03', 'INCAHUASI'),
 ('14', '02', '04', 'MANUEL ANTONIO MESONES MURO'),
 ('14', '02', '05', 'PITIPO'),
 ('14', '02', '06', 'PUEBLO NUEVO'),
 ('14', '03', '00', 'LAMBAYEQUE'),
 ('14', '03', '01', 'LAMBAYEQUE'),
 ('14', '03', '02', 'CHOCHOPE'),
 ('14', '03', '03', 'ILLIMO'),
 ('14', '03', '04', 'JAYANCA'),
 ('14', '03', '05', 'MOCHUMI'),
 ('14', '03', '06', 'MORROPE'),
 ('14', '03', '07', 'MOTUPE'),
 ('14', '03', '08', 'OLMOS'),
 ('14', '03', '09', 'PACORA'),
 ('14', '03', '10', 'SALAS'),
 ('14', '03', '11', 'SAN JOSE'),
 ('14', '03', '12', 'TUCUME'),
 ('15', '00', '00', 'LIMA'),
 ('15', '01', '00', 'LIMA'),
 ('15', '01', '01', 'LIMA'),
 ('15', '01', '02', 'ANCON'),
 ('15', '01', '03', 'ATE'),
 ('15', '01', '04', 'BARRANCO'),
 ('15', '01', '05', 'BRE�A'),
 ('15', '01', '06', 'CARABAYLLO'),
 ('15', '01', '07', 'CHACLACAYO'),
 ('15', '01', '08', 'CHORRILLOS'),
 ('15', '01', '09', 'CIENEGUILLA'),
 ('15', '01', '10', 'COMAS'),
 ('15', '01', '11', 'EL AGUSTINO'),
 ('15', '01', '12', 'INDEPENDENCIA'),
 ('15', '01', '13', 'JESUS MARIA'),
 ('15', '01', '14', 'LA MOLINA'),
 ('15', '01', '15', 'LA VICTORIA'),
 ('15', '01', '16', 'LINCE'),
 ('15', '01', '17', 'LOS OLIVOS'),
 ('15', '01', '18', 'LURIGANCHO'),
 ('15', '01', '19', 'LURIN'),
 ('15', '01', '20', 'MAGDALENA DEL MAR'),
 ('15', '01', '21', 'MAGDALENA VIEJA'),
 ('15', '01', '22', 'MIRAFLORES'),
 ('15', '01', '23', 'PACHACAMAC'),
 ('15', '01', '24', 'PUCUSANA'),
 ('15', '01', '25', 'PUENTE PIEDRA'),
 ('15', '01', '26', 'PUNTA HERMOSA'),
 ('15', '01', '27', 'PUNTA NEGRA'),
 ('15', '01', '28', 'RIMAC'),
 ('15', '01', '29', 'SAN BARTOLO'),
 ('15', '01', '30', 'SAN BORJA'),
 ('15', '01', '31', 'SAN ISIDRO'),
 ('15', '01', '32', 'SAN JUAN DE LURIGANCHO'),
 ('15', '01', '33', 'SAN JUAN DE MIRAFLORES'),
 ('15', '01', '34', 'SAN LUIS'),
 ('15', '01', '35', 'SAN MARTIN DE PORRES'),
 ('15', '01', '36', 'SAN MIGUEL'),
 ('15', '01', '37', 'SANTA ANITA'),
 ('15', '01', '38', 'SANTA MARIA DEL MAR'),
 ('15', '01', '39', 'SANTA ROSA'),
 ('15', '01', '40', 'SANTIAGO DE SURCO'),
 ('15', '01', '41', 'SURQUILLO'),
 ('15', '01', '42', 'VILLA EL SALVADOR'),
 ('15', '01', '43', 'VILLA MARIA DEL TRIUNFO'),
 ('15', '02', '00', 'BARRANCA'),
 ('15', '02', '01', 'BARRANCA'),
 ('15', '02', '02', 'PARAMONGA'),
 ('15', '02', '03', 'PATIVILCA'),
 ('15', '02', '04', 'SUPE'),
 ('15', '02', '05', 'SUPE PUERTO'),
 ('15', '03', '00', 'CAJATAMBO'),
 ('15', '03', '01', 'CAJATAMBO'),
 ('15', '03', '02', 'COPA'),
 ('15', '03', '03', 'GORGOR'),
 ('15', '03', '04', 'HUANCAPON'),
 ('15', '03', '05', 'MANAS'),
 ('15', '04', '00', 'CANTA'),
 ('15', '04', '01', 'CANTA'),
 ('15', '04', '02', 'ARAHUAY'),
 ('15', '04', '03', 'HUAMANTANGA'),
 ('15', '04', '04', 'HUAROS'),
 ('15', '04', '05', 'LACHAQUI'),
 ('15', '04', '06', 'SAN BUENAVENTURA'),
 ('15', '04', '07', 'SANTA ROSA DE QUIVES'),
 ('15', '05', '00', 'CA�ETE'),
 ('15', '05', '01', 'SAN VICENTE DE CA�ETE'),
 ('15', '05', '02', 'ASIA'),
 ('15', '05', '03', 'CALANGO'),
 ('15', '05', '04', 'CERRO AZUL'),
 ('15', '05', '05', 'CHILCA'),
 ('15', '05', '06', 'COAYLLO'),
 ('15', '05', '07', 'IMPERIAL'),
 ('15', '05', '08', 'LUNAHUANA'),
 ('15', '05', '09', 'MALA'),
 ('15', '05', '10', 'NUEVO IMPERIAL'),
 ('15', '05', '11', 'PACARAN'),
 ('15', '05', '12', 'QUILMANA'),
 ('15', '05', '13', 'SAN ANTONIO'),
 ('15', '05', '14', 'SAN LUIS'),
 ('15', '05', '15', 'SANTA CRUZ DE FLORES'),
 ('15', '05', '16', 'ZU�IGA'),
 ('15', '06', '00', 'HUARAL'),
 ('15', '06', '01', 'HUARAL'),
 ('15', '06', '02', 'ATAVILLOS ALTO'),
 ('15', '06', '03', 'ATAVILLOS BAJO'),
 ('15', '06', '04', 'AUCALLAMA'),
 ('15', '06', '05', 'CHANCAY'),
 ('15', '06', '06', 'IHUARI'),
 ('15', '06', '07', 'LAMPIAN'),
 ('15', '06', '08', 'PACARAOS'),
 ('15', '06', '09', 'SAN MIGUEL DE ACOS'),
 ('15', '06', '10', 'SANTA CRUZ DE ANDAMARCA'),
 ('15', '06', '11', 'SUMBILCA'),
 ('15', '06', '12', 'VEINTISIETE DE NOVIEMBRE'),
 ('15', '07', '00', 'HUAROCHIRI'),
 ('15', '07', '01', 'MATUCANA'),
 ('15', '07', '02', 'ANTIOQUIA'),
 ('15', '07', '03', 'CALLAHUANCA'),
 ('15', '07', '04', 'CARAMPOMA'),
 ('15', '07', '05', 'CHICLA'),
 ('15', '07', '06', 'CUENCA'),
 ('15', '07', '07', 'HUACHUPAMPA'),
 ('15', '07', '08', 'HUANZA'),
 ('15', '07', '09', 'HUAROCHIRI'),
 ('15', '07', '10', 'LAHUAYTAMBO'),
 ('15', '07', '11', 'LANGA'),
 ('15', '07', '12', 'LARAOS'),
 ('15', '07', '13', 'MARIATANA'),
 ('15', '07', '14', 'RICARDO PALMA'),
 ('15', '07', '15', 'SAN ANDRES DE TUPICOCHA'),
 ('15', '07', '16', 'SAN ANTONIO'),
 ('15', '07', '17', 'SAN BARTOLOME'),
 ('15', '07', '18', 'SAN DAMIAN'),
 ('15', '07', '19', 'SAN JUAN DE IRIS'),
 ('15', '07', '20', 'SAN JUAN DE TANTARANCHE'),
 ('15', '07', '21', 'SAN LORENZO DE QUINTI'),
 ('15', '07', '22', 'SAN MATEO'),
 ('15', '07', '23', 'SAN MATEO DE OTAO'),
 ('15', '07', '24', 'SAN PEDRO DE CASTA'),
 ('15', '07', '25', 'SAN PEDRO DE HUANCAYRE'),
 ('15', '07', '26', 'SANGALLAYA'),
 ('15', '07', '27', 'SANTA CRUZ DE COCACHACRA'),
 ('15', '07', '28', 'SANTA EULALIA'),
 ('15', '07', '29', 'SANTIAGO DE ANCHUCAYA'),
 ('15', '07', '30', 'SANTIAGO DE TUNA'),
 ('15', '07', '31', 'SANTO DOMINGO DE LOS OLLEROS'),
 ('15', '07', '32', 'SURCO'),
 ('15', '08', '00', 'HUAURA'),
 ('15', '08', '01', 'HUACHO'),
 ('15', '08', '02', 'AMBAR'),
 ('15', '08', '03', 'CALETA DE CARQUIN'),
 ('15', '08', '04', 'CHECRAS'),
 ('15', '08', '05', 'HUALMAY'),
 ('15', '08', '06', 'HUAURA'),
 ('15', '08', '07', 'LEONCIO PRADO'),
 ('15', '08', '08', 'PACCHO'),
 ('15', '08', '09', 'SANTA LEONOR'),
 ('15', '08', '10', 'SANTA MARIA'),
 ('15', '08', '11', 'SAYAN'),
 ('15', '08', '12', 'VEGUETA'),
 ('15', '09', '00', 'OYON'),
 ('15', '09', '01', 'OYON'),
 ('15', '09', '02', 'ANDAJES'),
 ('15', '09', '03', 'CAUJUL'),
 ('15', '09', '04', 'COCHAMARCA'),
 ('15', '09', '05', 'NAVAN'),
 ('15', '09', '06', 'PACHANGARA'),
 ('15', '10', '00', 'YAUYOS'),
 ('15', '10', '01', 'YAUYOS'),
 ('15', '10', '02', 'ALIS'),
 ('15', '10', '03', 'AYAUCA'),
 ('15', '10', '04', 'AYAVIRI'),
 ('15', '10', '05', 'AZANGARO'),
 ('15', '10', '06', 'CACRA'),
 ('15', '10', '07', 'CARANIA'),
 ('15', '10', '08', 'CATAHUASI'),
 ('15', '10', '09', 'CHOCOS'),
 ('15', '10', '10', 'COCHAS'),
 ('15', '10', '11', 'COLONIA'),
 ('15', '10', '12', 'HONGOS'),
 ('15', '10', '13', 'HUAMPARA'),
 ('15', '10', '14', 'HUANCAYA'),
 ('15', '10', '15', 'HUANGASCAR'),
 ('15', '10', '16', 'HUANTAN'),
 ('15', '10', '17', 'HUA�EC'),
 ('15', '10', '18', 'LARAOS'),
 ('15', '10', '19', 'LINCHA'),
 ('15', '10', '20', 'MADEAN'),
 ('15', '10', '21', 'MIRAFLORES'),
 ('15', '10', '22', 'OMAS'),
 ('15', '10', '23', 'PUTINZA'),
 ('15', '10', '24', 'QUINCHES'),
 ('15', '10', '25', 'QUINOCAY'),
 ('15', '10', '26', 'SAN JOAQUIN'),
 ('15', '10', '27', 'SAN PEDRO DE PILAS'),
 ('15', '10', '28', 'TANTA'),
 ('15', '10', '29', 'TAURIPAMPA'),
 ('15', '10', '30', 'TOMAS'),
 ('15', '10', '31', 'TUPE'),
 ('15', '10', '32', 'VI�AC'),
 ('15', '10', '33', 'VITIS'),
 ('16', '00', '00', 'LORETO'),
 ('16', '01', '00', 'MAYNAS'),
 ('16', '01', '01', 'IQUITOS'),
 ('16', '01', '02', 'ALTO NANAY'),
 ('16', '01', '03', 'FERNANDO LORES'),
 ('16', '01', '04', 'INDIANA'),
 ('16', '01', '05', 'LAS AMAZONAS'),
 ('16', '01', '06', 'MAZAN'),
 ('16', '01', '07', 'NAPO'),
 ('16', '01', '08', 'PUNCHANA'),
 ('16', '01', '09', 'PUTUMAYO'),
 ('16', '01', '10', 'TORRES CAUSANA'),
 ('16', '01', '12', 'BELEN'),
 ('16', '01', '13', 'SAN JUAN BAUTISTA'),
 ('16', '01', '14', 'TENIENTE MANUEL CLAVERO'),
 ('16', '02', '00', 'ALTO AMAZONAS'),
 ('16', '02', '01', 'YURIMAGUAS'),
 ('16', '02', '02', 'BALSAPUERTO'),
 ('16', '02', '05', 'JEBEROS'),
 ('16', '02', '06', 'LAGUNAS'),
 ('16', '02', '10', 'SANTA CRUZ'),
 ('16', '02', '11', 'TENIENTE CESAR LOPEZ ROJAS'),
 ('16', '03', '00', 'LORETO'),
 ('16', '03', '01', 'NAUTA'),
 ('16', '03', '02', 'PARINARI'),
 ('16', '03', '03', 'TIGRE'),
 ('16', '03', '04', 'TROMPETEROS'),
 ('16', '03', '05', 'URARINAS'),
 ('16', '04', '00', 'MARISCAL RAMON CASTILLA'),
 ('16', '04', '01', 'RAMON CASTILLA'),
 ('16', '04', '02', 'PEBAS'),
 ('16', '04', '03', 'YAVARI'),
 ('16', '04', '04', 'SAN PABLO'),
 ('16', '05', '00', 'REQUENA'),
 ('16', '05', '01', 'REQUENA'),
 ('16', '05', '02', 'ALTO TAPICHE'),
 ('16', '05', '03', 'CAPELO'),
 ('16', '05', '04', 'EMILIO SAN MARTIN'),
 ('16', '05', '05', 'MAQUIA'),
 ('16', '05', '06', 'PUINAHUA'),
 ('16', '05', '07', 'SAQUENA'),
 ('16', '05', '08', 'SOPLIN'),
 ('16', '05', '09', 'TAPICHE'),
 ('16', '05', '10', 'JENARO HERRERA'),
 ('16', '05', '11', 'YAQUERANA'),
 ('16', '06', '00', 'UCAYALI'),
 ('16', '06', '01', 'CONTAMANA'),
 ('16', '06', '02', 'INAHUAYA'),
 ('16', '06', '03', 'PADRE MARQUEZ'),
 ('16', '06', '04', 'PAMPA HERMOSA'),
 ('16', '06', '05', 'SARAYACU'),
 ('16', '06', '06', 'VARGAS GUERRA'),
 ('16', '07', '00', 'DATEM DEL MARA�ON'),
 ('16', '07', '01', 'BARRANCA'),
 ('16', '07', '02', 'CAHUAPANAS'),
 ('16', '07', '03', 'MANSERICHE'),
 ('16', '07', '04', 'MORONA'),
 ('16', '07', '05', 'PASTAZA'),
 ('16', '07', '06', 'ANDOAS'),
 ('17', '00', '00', 'MADRE DE DIOS'),
 ('17', '01', '00', 'TAMBOPATA'),
 ('17', '01', '01', 'TAMBOPATA'),
 ('17', '01', '02', 'INAMBARI'),
 ('17', '01', '03', 'LAS PIEDRAS'),
 ('17', '01', '04', 'LABERINTO'),
 ('17', '02', '00', 'MANU'),
 ('17', '02', '01', 'MANU'),
 ('17', '02', '02', 'FITZCARRALD'),
 ('17', '02', '03', 'MADRE DE DIOS'),
 ('17', '02', '04', 'HUEPETUHE'),
 ('17', '03', '00', 'TAHUAMANU'),
 ('17', '03', '01', 'I�APARI'),
 ('17', '03', '02', 'IBERIA'),
 ('17', '03', '03', 'TAHUAMANU'),
 ('18', '00', '00', 'MOQUEGUA'),
 ('18', '01', '00', 'MARISCAL NIETO'),
 ('18', '01', '01', 'MOQUEGUA'),
 ('18', '01', '02', 'CARUMAS'),
 ('18', '01', '03', 'CUCHUMBAYA'),
 ('18', '01', '04', 'SAMEGUA'),
 ('18', '01', '05', 'SAN CRISTOBAL'),
 ('18', '01', '06', 'TORATA'),
 ('18', '02', '00', 'GENERAL SANCHEZ CERRO'),
 ('18', '02', '01', 'OMATE'),
 ('18', '02', '02', 'CHOJATA'),
 ('18', '02', '03', 'COALAQUE'),
 ('18', '02', '04', 'ICHU�A'),
 ('18', '02', '05', 'LA CAPILLA'),
 ('18', '02', '06', 'LLOQUE'),
 ('18', '02', '07', 'MATALAQUE'),
 ('18', '02', '08', 'PUQUINA'),
 ('18', '02', '09', 'QUINISTAQUILLAS'),
 ('18', '02', '10', 'UBINAS'),
 ('18', '02', '11', 'YUNGA'),
 ('18', '03', '00', 'ILO'),
 ('18', '03', '01', 'ILO'),
 ('18', '03', '02', 'EL ALGARROBAL'),
 ('18', '03', '03', 'PACOCHA'),
 ('19', '00', '00', 'PASCO'),
 ('19', '01', '00', 'PASCO'),
 ('19', '01', '01', 'CHAUPIMARCA'),
 ('19', '01', '02', 'HUACHON'),
 ('19', '01', '03', 'HUARIACA'),
 ('19', '01', '04', 'HUAYLLAY'),
 ('19', '01', '05', 'NINACACA'),
 ('19', '01', '06', 'PALLANCHACRA'),
 ('19', '01', '07', 'PAUCARTAMBO'),
 ('19', '01', '08', 'SAN FRANCISCO DE ASIS DE YARUSYACAN'),
 ('19', '01', '09', 'SIMON BOLIVAR'),
 ('19', '01', '10', 'TICLACAYAN'),
 ('19', '01', '11', 'TINYAHUARCO'),
 ('19', '01', '12', 'VICCO'),
 ('19', '01', '13', 'YANACANCHA'),
 ('19', '02', '00', 'DANIEL ALCIDES CARRION'),
 ('19', '02', '01', 'YANAHUANCA'),
 ('19', '02', '02', 'CHACAYAN'),
 ('19', '02', '03', 'GOYLLARISQUIZGA'),
 ('19', '02', '04', 'PAUCAR'),
 ('19', '02', '05', 'SAN PEDRO DE PILLAO'),
 ('19', '02', '06', 'SANTA ANA DE TUSI'),
 ('19', '02', '07', 'TAPUC'),
 ('19', '02', '08', 'VILCABAMBA'),
 ('19', '03', '00', 'OXAPAMPA'),
 ('19', '03', '01', 'OXAPAMPA'),
 ('19', '03', '02', 'CHONTABAMBA'),
 ('19', '03', '03', 'HUANCABAMBA'),
 ('19', '03', '04', 'PALCAZU'),
 ('19', '03', '05', 'POZUZO'),
 ('19', '03', '06', 'PUERTO BERMUDEZ'),
 ('19', '03', '07', 'VILLA RICA'),
 ('20', '00', '00', 'PIURA'),
 ('20', '01', '00', 'PIURA'),
 ('20', '01', '01', 'PIURA'),
 ('20', '01', '04', 'CASTILLA'),
 ('20', '01', '05', 'CATACAOS'),
 ('20', '01', '07', 'CURA MORI'),
 ('20', '01', '08', 'EL TALLAN'),
 ('20', '01', '09', 'LA ARENA'),
 ('20', '01', '10', 'LA UNION'),
 ('20', '01', '11', 'LAS LOMAS'),
 ('20', '01', '14', 'TAMBO GRANDE'),
 ('20', '02', '00', 'AYABACA'),
 ('20', '02', '01', 'AYABACA'),
 ('20', '02', '02', 'FRIAS'),
 ('20', '02', '03', 'JILILI'),
 ('20', '02', '04', 'LAGUNAS'),
 ('20', '02', '05', 'MONTERO'),
 ('20', '02', '06', 'PACAIPAMPA'),
 ('20', '02', '07', 'PAIMAS'),
 ('20', '02', '08', 'SAPILLICA'),
 ('20', '02', '09', 'SICCHEZ'),
 ('20', '02', '10', 'SUYO'),
 ('20', '03', '00', 'HUANCABAMBA'),
 ('20', '03', '01', 'HUANCABAMBA'),
 ('20', '03', '02', 'CANCHAQUE'),
 ('20', '03', '03', 'EL CARMEN DE LA FRONTERA'),
 ('20', '03', '04', 'HUARMACA'),
 ('20', '03', '05', 'LALAQUIZ'),
 ('20', '03', '06', 'SAN MIGUEL DE EL FAIQUE'),
 ('20', '03', '07', 'SONDOR'),
 ('20', '03', '08', 'SONDORILLO'),
 ('20', '04', '00', 'MORROPON'),
 ('20', '04', '01', 'CHULUCANAS'),
 ('20', '04', '02', 'BUENOS AIRES'),
 ('20', '04', '03', 'CHALACO'),
 ('20', '04', '04', 'LA MATANZA'),
 ('20', '04', '05', 'MORROPON'),
 ('20', '04', '06', 'SALITRAL'),
 ('20', '04', '07', 'SAN JUAN DE BIGOTE'),
 ('20', '04', '08', 'SANTA CATALINA DE MOSSA'),
 ('20', '04', '09', 'SANTO DOMINGO'),
 ('20', '04', '10', 'YAMANGO'),
 ('20', '05', '00', 'PAITA'),
 ('20', '05', '01', 'PAITA'),
 ('20', '05', '02', 'AMOTAPE'),
 ('20', '05', '03', 'ARENAL'),
 ('20', '05', '04', 'COLAN'),
 ('20', '05', '05', 'LA HUACA'),
 ('20', '05', '06', 'TAMARINDO'),
 ('20', '05', '07', 'VICHAYAL'),
 ('20', '06', '00', 'SULLANA'),
 ('20', '06', '01', 'SULLANA'),
 ('20', '06', '02', 'BELLAVISTA'),
 ('20', '06', '03', 'IGNACIO ESCUDERO'),
 ('20', '06', '04', 'LANCONES'),
 ('20', '06', '05', 'MARCAVELICA'),
 ('20', '06', '06', 'MIGUEL CHECA'),
 ('20', '06', '07', 'QUERECOTILLO'),
 ('20', '06', '08', 'SALITRAL'),
 ('20', '07', '00', 'TALARA'),
 ('20', '07', '01', 'PARI�AS'),
 ('20', '07', '02', 'EL ALTO'),
 ('20', '07', '03', 'LA BREA'),
 ('20', '07', '04', 'LOBITOS'),
 ('20', '07', '05', 'LOS ORGANOS'),
 ('20', '07', '06', 'MANCORA'),
 ('20', '08', '00', 'SECHURA'),
 ('20', '08', '01', 'SECHURA'),
 ('20', '08', '02', 'BELLAVISTA DE LA UNION'),
 ('20', '08', '03', 'BERNAL'),
 ('20', '08', '04', 'CRISTO NOS VALGA'),
 ('20', '08', '05', 'VICE'),
 ('20', '08', '06', 'RINCONADA LLICUAR'),
 ('21', '00', '00', 'PUNO'),
 ('21', '01', '00', 'PUNO'),
 ('21', '01', '01', 'PUNO'),
 ('21', '01', '02', 'ACORA'),
 ('21', '01', '03', 'AMANTANI'),
 ('21', '01', '04', 'ATUNCOLLA'),
 ('21', '01', '05', 'CAPACHICA'),
 ('21', '01', '06', 'CHUCUITO'),
 ('21', '01', '07', 'COATA'),
 ('21', '01', '08', 'HUATA'),
 ('21', '01', '09', 'MA�AZO'),
 ('21', '01', '10', 'PAUCARCOLLA'),
 ('21', '01', '11', 'PICHACANI'),
 ('21', '01', '12', 'PLATERIA'),
 ('21', '01', '13', 'SAN ANTONIO'),
 ('21', '01', '14', 'TIQUILLACA'),
 ('21', '01', '15', 'VILQUE'),
 ('21', '02', '00', 'AZANGARO'),
 ('21', '02', '01', 'AZANGARO'),
 ('21', '02', '02', 'ACHAYA'),
 ('21', '02', '03', 'ARAPA'),
 ('21', '02', '04', 'ASILLO'),
 ('21', '02', '05', 'CAMINACA'),
 ('21', '02', '06', 'CHUPA'),
 ('21', '02', '07', 'JOSE DOMINGO CHOQUEHUANCA'),
 ('21', '02', '08', 'MU�ANI'),
 ('21', '02', '09', 'POTONI'),
 ('21', '02', '10', 'SAMAN'),
 ('21', '02', '11', 'SAN ANTON'),
 ('21', '02', '12', 'SAN JOSE'),
 ('21', '02', '13', 'SAN JUAN DE SALINAS'),
 ('21', '02', '14', 'SANTIAGO DE PUPUJA'),
 ('21', '02', '15', 'TIRAPATA'),
 ('21', '03', '00', 'CARABAYA'),
 ('21', '03', '01', 'MACUSANI'),
 ('21', '03', '02', 'AJOYANI'),
 ('21', '03', '03', 'AYAPATA'),
 ('21', '03', '04', 'COASA'),
 ('21', '03', '05', 'CORANI'),
 ('21', '03', '06', 'CRUCERO'),
 ('21', '03', '07', 'ITUATA'),
 ('21', '03', '08', 'OLLACHEA'),
 ('21', '03', '09', 'SAN GABAN'),
 ('21', '03', '10', 'USICAYOS'),
 ('21', '04', '00', 'CHUCUITO'),
 ('21', '04', '01', 'JULI'),
 ('21', '04', '02', 'DESAGUADERO'),
 ('21', '04', '03', 'HUACULLANI'),
 ('21', '04', '04', 'KELLUYO'),
 ('21', '04', '05', 'PISACOMA'),
 ('21', '04', '06', 'POMATA'),
 ('21', '04', '07', 'ZEPITA'),
 ('21', '05', '00', 'EL COLLAO'),
 ('21', '05', '01', 'ILAVE'),
 ('21', '05', '02', 'CAPAZO'),
 ('21', '05', '03', 'PILCUYO'),
 ('21', '05', '04', 'SANTA ROSA'),
 ('21', '05', '05', 'CONDURIRI'),
 ('21', '06', '00', 'HUANCANE'),
 ('21', '06', '01', 'HUANCANE'),
 ('21', '06', '02', 'COJATA'),
 ('21', '06', '03', 'HUATASANI'),
 ('21', '06', '04', 'INCHUPALLA'),
 ('21', '06', '05', 'PUSI'),
 ('21', '06', '06', 'ROSASPATA'),
 ('21', '06', '07', 'TARACO'),
 ('21', '06', '08', 'VILQUE CHICO'),
 ('21', '07', '00', 'LAMPA'),
 ('21', '07', '01', 'LAMPA'),
 ('21', '07', '02', 'CABANILLA'),
 ('21', '07', '03', 'CALAPUJA'),
 ('21', '07', '04', 'NICASIO'),
 ('21', '07', '05', 'OCUVIRI'),
 ('21', '07', '06', 'PALCA'),
 ('21', '07', '07', 'PARATIA'),
 ('21', '07', '08', 'PUCARA'),
 ('21', '07', '09', 'SANTA LUCIA'),
 ('21', '07', '10', 'VILAVILA'),
 ('21', '08', '00', 'MELGAR'),
 ('21', '08', '01', 'AYAVIRI'),
 ('21', '08', '02', 'ANTAUTA'),
 ('21', '08', '03', 'CUPI'),
 ('21', '08', '04', 'LLALLI'),
 ('21', '08', '05', 'MACARI'),
 ('21', '08', '06', 'NU�OA'),
 ('21', '08', '07', 'ORURILLO'),
 ('21', '08', '08', 'SANTA ROSA'),
 ('21', '08', '09', 'UMACHIRI'),
 ('21', '09', '00', 'MOHO'),
 ('21', '09', '01', 'MOHO'),
 ('21', '09', '02', 'CONIMA'),
 ('21', '09', '03', 'HUAYRAPATA'),
 ('21', '09', '04', 'TILALI'),
 ('21', '10', '00', 'SAN ANTONIO DE PUTINA'),
 ('21', '10', '01', 'PUTINA'),
 ('21', '10', '02', 'ANANEA'),
 ('21', '10', '03', 'PEDRO VILCA APAZA'),
 ('21', '10', '04', 'QUILCAPUNCU'),
 ('21', '10', '05', 'SINA'),
 ('21', '11', '00', 'SAN ROMAN'),
 ('21', '11', '01', 'JULIACA'),
 ('21', '11', '02', 'CABANA'),
 ('21', '11', '03', 'CABANILLAS'),
 ('21', '11', '04', 'CARACOTO'),
 ('21', '12', '00', 'SANDIA'),
 ('21', '12', '01', 'SANDIA'),
 ('21', '12', '02', 'CUYOCUYO'),
 ('21', '12', '03', 'LIMBANI'),
 ('21', '12', '04', 'PATAMBUCO'),
 ('21', '12', '05', 'PHARA'),
 ('21', '12', '06', 'QUIACA'),
 ('21', '12', '07', 'SAN JUAN DEL ORO'),
 ('21', '12', '08', 'YANAHUAYA'),
 ('21', '12', '09', 'ALTO INAMBARI'),
 ('21', '12', '10', 'SAN PEDRO DE PUTINA PUNCO'),
 ('21', '13', '00', 'YUNGUYO'),
 ('21', '13', '01', 'YUNGUYO'),
 ('21', '13', '02', 'ANAPIA'),
 ('21', '13', '03', 'COPANI'),
 ('21', '13', '04', 'CUTURAPI'),
 ('21', '13', '05', 'OLLARAYA'),
 ('21', '13', '06', 'TINICACHI'),
 ('21', '13', '07', 'UNICACHI'),
 ('22', '00', '00', 'SAN MARTIN'),
 ('22', '01', '00', 'MOYOBAMBA'),
 ('22', '01', '01', 'MOYOBAMBA'),
 ('22', '01', '02', 'CALZADA'),
 ('22', '01', '03', 'HABANA'),
 ('22', '01', '04', 'JEPELACIO'),
 ('22', '01', '05', 'SORITOR'),
 ('22', '01', '06', 'YANTALO'),
 ('22', '02', '00', 'BELLAVISTA'),
 ('22', '02', '01', 'BELLAVISTA'),
 ('22', '02', '02', 'ALTO BIAVO'),
 ('22', '02', '03', 'BAJO BIAVO'),
 ('22', '02', '04', 'HUALLAGA'),
 ('22', '02', '05', 'SAN PABLO'),
 ('22', '02', '06', 'SAN RAFAEL'),
 ('22', '03', '00', 'EL DORADO'),
 ('22', '03', '01', 'SAN JOSE DE SISA'),
 ('22', '03', '02', 'AGUA BLANCA'),
 ('22', '03', '03', 'SAN MARTIN'),
 ('22', '03', '04', 'SANTA ROSA'),
 ('22', '03', '05', 'SHATOJA'),
 ('22', '04', '00', 'HUALLAGA'),
 ('22', '04', '01', 'SAPOSOA'),
 ('22', '04', '02', 'ALTO SAPOSOA'),
 ('22', '04', '03', 'EL ESLABON'),
 ('22', '04', '04', 'PISCOYACU'),
 ('22', '04', '05', 'SACANCHE'),
 ('22', '04', '06', 'TINGO DE SAPOSOA'),
 ('22', '05', '00', 'LAMAS'),
 ('22', '05', '01', 'LAMAS'),
 ('22', '05', '02', 'ALONSO DE ALVARADO'),
 ('22', '05', '03', 'BARRANQUITA'),
 ('22', '05', '04', 'CAYNARACHI'),
 ('22', '05', '05', 'CU�UMBUQUI'),
 ('22', '05', '06', 'PINTO RECODO'),
 ('22', '05', '07', 'RUMISAPA'),
 ('22', '05', '08', 'SAN ROQUE DE CUMBAZA'),
 ('22', '05', '09', 'SHANAO'),
 ('22', '05', '10', 'TABALOSOS'),
 ('22', '05', '11', 'ZAPATERO'),
 ('22', '06', '00', 'MARISCAL CACERES'),
 ('22', '06', '01', 'JUANJUI'),
 ('22', '06', '02', 'CAMPANILLA'),
 ('22', '06', '03', 'HUICUNGO'),
 ('22', '06', '04', 'PACHIZA'),
 ('22', '06', '05', 'PAJARILLO'),
 ('22', '07', '00', 'PICOTA'),
 ('22', '07', '01', 'PICOTA'),
 ('22', '07', '02', 'BUENOS AIRES'),
 ('22', '07', '03', 'CASPISAPA'),
 ('22', '07', '04', 'PILLUANA'),
 ('22', '07', '05', 'PUCACACA'),
 ('22', '07', '06', 'SAN CRISTOBAL'),
 ('22', '07', '07', 'SAN HILARION'),
 ('22', '07', '08', 'SHAMBOYACU'),
 ('22', '07', '09', 'TINGO DE PONASA'),
 ('22', '07', '10', 'TRES UNIDOS'),
 ('22', '08', '00', 'RIOJA'),
 ('22', '08', '01', 'RIOJA'),
 ('22', '08', '02', 'AWAJUN'),
 ('22', '08', '03', 'ELIAS SOPLIN VARGAS'),
 ('22', '08', '04', 'NUEVA CAJAMARCA'),
 ('22', '08', '05', 'PARDO MIGUEL'),
 ('22', '08', '06', 'POSIC'),
 ('22', '08', '07', 'SAN FERNANDO'),
 ('22', '08', '08', 'YORONGOS'),
 ('22', '08', '09', 'YURACYACU'),
 ('22', '09', '00', 'SAN MARTIN'),
 ('22', '09', '01', 'TARAPOTO'),
 ('22', '09', '02', 'ALBERTO LEVEAU'),
 ('22', '09', '03', 'CACATACHI'),
 ('22', '09', '04', 'CHAZUTA'),
 ('22', '09', '05', 'CHIPURANA'),
 ('22', '09', '06', 'EL PORVENIR'),
 ('22', '09', '07', 'HUIMBAYOC'),
 ('22', '09', '08', 'JUAN GUERRA'),
 ('22', '09', '09', 'LA BANDA DE SHILCAYO'),
 ('22', '09', '10', 'MORALES'),
 ('22', '09', '11', 'PAPAPLAYA'),
 ('22', '09', '12', 'SAN ANTONIO'),
 ('22', '09', '13', 'SAUCE'),
 ('22', '09', '14', 'SHAPAJA'),
 ('22', '10', '00', 'TOCACHE'),
 ('22', '10', '01', 'TOCACHE'),
 ('22', '10', '02', 'NUEVO PROGRESO'),
 ('22', '10', '03', 'POLVORA'),
 ('22', '10', '04', 'SHUNTE'),
 ('22', '10', '05', 'UCHIZA'),
 ('23', '00', '00', 'TACNA'),
 ('23', '01', '00', 'TACNA'),
 ('23', '01', '01', 'TACNA'),
 ('23', '01', '02', 'ALTO DE LA ALIANZA'),
 ('23', '01', '03', 'CALANA'),
 ('23', '01', '04', 'CIUDAD NUEVA'),
 ('23', '01', '05', 'INCLAN'),
 ('23', '01', '06', 'PACHIA'),
 ('23', '01', '07', 'PALCA'),
 ('23', '01', '08', 'POCOLLAY'),
 ('23', '01', '09', 'SAMA'),
 ('23', '01', '10', 'CORONEL GREGORIO ALBARRACIN LANCHIPA'),
 ('23', '02', '00', 'CANDARAVE'),
 ('23', '02', '01', 'CANDARAVE'),
 ('23', '02', '02', 'CAIRANI')
 INSERT INTO Tb_Ubigeo VALUES('23', '02', '03', 'CAMILACA'),
 ('23', '02', '04', 'CURIBAYA'),
 ('23', '02', '05', 'HUANUARA'),
 ('23', '02', '06', 'QUILAHUANI'),
 ('23', '03', '00', 'JORGE BASADRE'),
 ('23', '03', '01', 'LOCUMBA'),
 ('23', '03', '02', 'ILABAYA'),
 ('23', '03', '03', 'ITE'),
 ('23', '04', '00', 'TARATA'),
 ('23', '04', '01', 'TARATA'),
 ('23', '04', '02', 'HEROES ALBARRACIN'),
 ('23', '04', '03', 'ESTIQUE'),
 ('23', '04', '04', 'ESTIQUE-PAMPA'),
 ('23', '04', '05', 'SITAJARA'),
 ('23', '04', '06', 'SUSAPAYA'),
 ('23', '04', '07', 'TARUCACHI'),
 ('23', '04', '08', 'TICACO'),
 ('24', '00', '00', 'TUMBES'),
 ('24', '01', '00', 'TUMBES'),
 ('24', '01', '01', 'TUMBES'),
 ('24', '01', '02', 'CORRALES'),
 ('24', '01', '03', 'LA CRUZ'),
 ('24', '01', '04', 'PAMPAS DE HOSPITAL'),
 ('24', '01', '05', 'SAN JACINTO'),
 ('24', '01', '06', 'SAN JUAN DE LA VIRGEN'),
 ('24', '02', '00', 'CONTRALMIRANTE VILLAR'),
 ('24', '02', '01', 'ZORRITOS'),
 ('24', '02', '02', 'CASITAS'),
 ('24', '02', '03', 'CANOAS DE PUNTA SAL'),
 ('24', '03', '00', 'ZARUMILLA'),
 ('24', '03', '01', 'ZARUMILLA'),
 ('24', '03', '02', 'AGUAS VERDES'),
 ('24', '03', '03', 'MATAPALO'),
 ('24', '03', '04', 'PAPAYAL'),
 ('25', '00', '00', 'UCAYALI'),
 ('25', '01', '00', 'CORONEL PORTILLO'),
 ('25', '01', '01', 'CALLERIA'),
 ('25', '01', '02', 'CAMPOVERDE'),
 ('25', '01', '03', 'IPARIA'),
 ('25', '01', '04', 'MASISEA'),
 ('25', '01', '05', 'YARINACOCHA'),
 ('25', '01', '06', 'NUEVA REQUENA'),
 ('25', '01', '07', 'MANANTAY'),
 ('25', '02', '00', 'ATALAYA'),
 ('25', '02', '01', 'RAYMONDI'),
 ('25', '02', '02', 'SEPAHUA'),
 ('25', '02', '03', 'TAHUANIA'),
 ('25', '02', '04', 'YURUA'),
 ('25', '03', '00', 'PADRE ABAD'),
 ('25', '03', '01', 'PADRE ABAD'),
 ('25', '03', '02', 'IRAZOLA'),
 ('25', '03', '03', 'CURIMANA'),
 ('25', '04', '00', 'PURUS'),
 ('25', '04', '01', 'PURUS')
 
GO
EXEC dbo.USP_Insertar_Especialidad
	@Nombre = 'Endodoncia',
	@Descripcion = 'Parte de la odontolog�a que estudia las enfermedades de la pulpa de los dientes y sus t�cnicas de curaci�n.'
GO
EXEC dbo.USP_Insertar_Especialidad
	@Nombre = 'Ortodoncia',
	@Descripcion = 'Tratamiento que consiste en corregir los defectos y las irregularidades de posici�n de los dientes.'
GO
EXEC dbo.USP_Insertar_Especialidad
	@Nombre = 'OdontoPediatria',
	@Descripcion = 'La odontopediatr�a es la rama de la odontolog�a encargada de tratar a los ni�os.'
GO

INSERT INTO dbo.Tb_Tipo_Documento (Cod_Tipo_Documento,Descripcion_Larga,Descripcion_Corta)
VALUES
('TD001','Documento Nacional de identidad','DNI'),
('TD002','Carnet de Extranjeria','CE'),
('TD003','Pasaporte','PS')
go

EXEC dbo.USP_Insertar_Odontologo
	@Nombres = 'Lucero Yuliet',
	@Ape_Paterno = 'Pacheco',
	@Ape_Materno = 'Ayala',
	@Sexo = 'F',
	@Cod_Tipo_Documento = 'TD001',
	@Num_Documento = '75830463',
	@Correo = 'lyuliet@gmail.com',
	@Direccion = 'Av.Ucayali 356',
	@Cod_Departamento = '15',
	@Cod_Provincia = '08',
	@Cod_Distrito = '01',
	@Contrasena = 'lpacheco11',
	@COP = '051721'
GO

EXEC dbo.USP_Insertar_Odontologo
	@Nombres = 'Carlos',
	@Ape_Paterno = 'Camara',
	@Ape_Materno = 'Santos',
	@Sexo = 'M',
	@Cod_Tipo_Documento = 'TD001',
	@Num_Documento = '75125620',
	@Correo = 'ccamara@aol.com',
	@Direccion = 'Av.Peru 3743',
	@Cod_Departamento = '15',
	@Cod_Provincia = '01',
	@Cod_Distrito = '35',
	@Contrasena = 'ccamara21',
	@COP = '874125'
GO

EXEC dbo.USP_Insertar_Odontologo
	@Nombres = 'Priscila',
	@Ape_Paterno = 'Lizana',
	@Ape_Materno = 'Vilchez',
	@Sexo = 'F',
	@Cod_Tipo_Documento = 'TD001',
	@Num_Documento = '48537116',
	@Correo = 'plizana@outlook.com',
	@Direccion = 'Jr.Cuzco 356',
	@Cod_Departamento = '15',
	@Cod_Provincia = '00',
	@Cod_Distrito = '01',
	@Contrasena = 'plizana52',
	@COP = '91436'
GO

EXEC dbo.USP_Insertar_Odontologo
	@Nombres = 'Aron',
	@Ape_Paterno = 'Zavala',
	@Ape_Materno = 'Aicama',
	@Sexo = 'M',
	@Cod_Tipo_Documento = 'TD001',
	@Num_Documento = '78150264',
	@Correo = 'azavala@gmail.com',
	@Direccion = 'Av.Piura 12',
	@Cod_Departamento = '11',
	@Cod_Provincia = '00',
	@Cod_Distrito = '01',
	@Contrasena = 'azavala98',
	@COP = '624837'
GO

INSERT INTO dbo.Tb_Paciente VALUES
('P000000001','Jos�','Romero','Soto','M','TD001','54623659','jrsoto@gmail.com','AV Meza 3125','16','05','01',DEFAULT),
('P000000002','Laura','Castillo','Verategi','F','TD001','79812963','verategilau@outlook.com','Calle Colmena 113','15','10','06',DEFAULT),
('P000000003','Victor','Contreras','Alcalde','M','TD001','01252389','vctorcon@outlook.com','Jr. Castilla 654','12','05','03',DEFAULT),
('P000000004','Alexandra','Vento','Hidalgo','F','TD001','65712273','alevento@outlook.com','Calle Mariategui 602','13','05','03',DEFAULT),
('P000000005','Daniel','Ardue','Pinto','M','TD001','85012346','dandue@outlook.com','Av Ica 3128','16','06','04',DEFAULT)
go

INSERT INTO dbo.Tb_Horario VALUES
(1,'Lunes','08:00:00','11:00:00'),
(2,'Lunes','15:30:00','18:30:00'),
(3,'Martes','08:00:00','11:00:00'),
(4,'Martes','16:30:00:00','19:00:00'),
(5,'Miercoles','08:00:00','11:00:00'),
(6,'Miercoles','16:00:00','19:30:00'),
(7,'Jueves','08:00:00','11:00:00'),
(8,'Jueves','15:00:00','18:00:00'),
(9,'Viernes','08:00:00','11:00:00'),
(10,'Viernes','17:00:00','20:00:00'),
(11,'Sabado','08:00:00','11:00:00'),
(12,'Sabado','17:30:00','20:30:00'),
(13,'Domingo','08:00:00','13:00:00')
GO

EXEC dbo.USP_Insertar_Usuario
	@Nombres = 'Carlos',
	@Apellidos = 'Barremechea'
GO

EXEC dbo.USP_Insertar_Usuario
	@Nombres = 'Carlos',
	@Apellidos = 'Casta�eda'
GO

EXEC dbo.USP_Insertar_Usuario
	@Nombres = 'Aldo',
	@Apellidos = 'Chumpitaz'
GO

EXEC dbo.USP_Insertar_Usuario
	@Nombres = 'Veronica',
	@Apellidos = 'Lernaque'
GO

