--bdd
USE [master]
GO

/****** Object:  Database [dcor]    Script Date: 12/8/2022 21:17:13 ******/
CREATE DATABASE [dcor]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dcor', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\dcor.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'dcor_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\dcor_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dcor].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [dcor] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [dcor] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [dcor] SET ANSI_PADDING OFF 
GO
--usuario y login
USE [master]
GO

/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [dcorPrueba]    Script Date: 12/8/2022 21:43:42 ******/
CREATE LOGIN [dcorPrueba] WITH PASSWORD=N'oiHuoA0nNwkvHr91XJpRBLjnY24j1I/xDC+V2Hz8ZpE=', DEFAULT_DATABASE=[dcor], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

ALTER LOGIN [dcorPrueba] DISABLE
GO
USE [dcor]
GO

/****** Object:  User [dcorPrueba]    Script Date: 12/8/2022 21:46:23 ******/
CREATE USER [dcorPrueba] FOR LOGIN [dcorPrueba] WITH DEFAULT_SCHEMA=[prueba]
GO

--schema
USE [dcor]
GO

/****** Object:  Schema [prueba]    Script Date: 12/8/2022 21:27:08 ******/
CREATE SCHEMA [prueba]
GO

--tablas
USE [dcor]
GO
IF OBJECT_ID(N'prueba.Movimiento', N'U') IS NOT NULL  
   DROP TABLE [prueba].[Movimiento]; 
GO
IF OBJECT_ID(N'prueba.Cuenta', N'U') IS NOT NULL  
   DROP TABLE [prueba].[Cuenta]; 
GO
IF OBJECT_ID(N'prueba.Persona', N'U') IS NOT NULL  
   DROP TABLE [prueba].[Persona]; 
GO



CREATE TABLE [prueba].[Persona] (
    id int NOT NULL PRIMARY KEY,
	discriminator varchar(10) NOT NULL,
    nombre varchar(255) NOT NULL,
    genero varchar(1) NOT NULL,
    edad int NOT NULL,
    identificacion varchar(13) NOT NULL,
	direccion varchar(255) NOT NULL,
    telefono varchar(10) NOT NULL,
	contrasena varchar(20) NULL,
	estado int NULL
   
);
GO

CREATE TABLE [prueba].Cuenta (
    id int NOT NULL PRIMARY KEY,
    numeroCuenta varchar(20) NOT NULL UNIQUE,
    tipoCuenta varchar(20) NOT NULL,
    saldoInicial decimal(15,4) NOT NULL,
	estado int NOT NULL,
	clienteId INT,
	FOREIGN KEY (clienteId) REFERENCES [prueba].Persona(id)
);
GO


CREATE TABLE [prueba].Movimiento (
    id int NOT NULL PRIMARY KEY,
    cuentaId int NOT NULL,
	fecha datetime NOT NULL,
    tipo varchar(10) NOT NULL,
    valor decimal(15,4) NOT NULL,
	saldo decimal(20,4) NOT NULL,
	FOREIGN KEY (cuentaId) REFERENCES [prueba].Cuenta(id)
);
GO

--vista
USE [dcor]
GO

/****** Object:  View [prueba].[ListadoMovimientos]    Script Date: 14/8/2022 16:15:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [prueba].[ListadoMovimientos]
AS
SELECT cl.id as ClienteId, CONVERT(varchar, m.fecha, 102) AS fecha, cl.nombre AS cliente, c.numeroCuenta, c.tipoCuenta AS tipo, c.saldoInicial, CASE c.estado WHEN 1 THEN 'True' ELSE 'False' END AS Estado, m.valor AS movimiento, m.saldo AS saldoDisponible
FROM   prueba.Movimiento AS m INNER JOIN
             prueba.Cuenta AS c ON c.id = m.cuentaId INNER JOIN
             prueba.Persona AS cl ON cl.id = c.clienteId
GO
--sp
USE [dcor]
GO

/****** Object:  StoredProcedure [prueba].[ListadoM]    Script Date: 14/8/2022 19:58:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [prueba].[ListadoM]
    -- Add the parameters for the stored procedure here
                @clienteID int,
                @fechaInicio datetime,
                @fechaFin datetime
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
	SELECT  CONVERT(varchar, m.fecha, 102) AS fecha, cl.nombre AS cliente, c.numeroCuenta, c.tipoCuenta AS tipo, c.saldoInicial, CASE c.estado WHEN 1 THEN 'True' ELSE 'False' END AS Estado, m.valor AS movimiento, m.saldo AS saldoDisponible
	FROM   prueba.Movimiento AS m INNER JOIN
             prueba.Cuenta AS c ON c.id = m.cuentaId INNER JOIN
             prueba.Persona AS cl ON cl.id = c.clienteId
    WHERE c.id=@clienteId
	and m.fecha between @fechaInicio and @fechaFin
END
GO
