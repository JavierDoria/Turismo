CREATE DATABASE TurismoCasta
GO

USE TurismoCasta
GO

CREATE TABLE [dbo].[Turista](
	[Id_Turista] [int] IDENTITY NOT NULL,
	[Nombres] [varchar](40) NOT NULL,
	[Apellidos] [varchar](40) NOT NULL,
	[Nacionalidad] [char](1) NOT NULL,
	[PrecioBoleta] [int] NOT NULL,
	[Correlativo] [varchar](15) NOT NULL,
	[Fecha_Registro] [datetime] NOT NULL,
	[Fecha_Modificacion] [datetime] NULL,
	[Usuario_Registro] [varchar](40) NULL,
	[Usuario_Modificacion] [varchar](40) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Turista] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Turista] ADD  CONSTRAINT [DF_Turistas_FechaRegistro]  DEFAULT (getdate()) FOR [Fecha_Registro]
GO

ALTER TABLE [dbo].[Turista] ADD CONSTRAINT CK_Turista_Nacionalidad CHECK ([Nacionalidad] IN ('E', 'N', 'S'));
GO

CREATE TABLE Administrador(
	Id_Administrador int primary key identity,
	Dni varchar(8) unique,
	Password varchar(25)
)
go

insert into Administrador(Dni, Password) values
	(72557870, 'planetas159')
GO

-- =============================================Registrar
CREATE PROCEDURE sp_RegistrarTurista 
	@Nombres VARCHAR(40),
	@Apellidos VARCHAR(40),
	@Nacionalidad char(1),
	@PrecioBoleta int,
	@Correlativo varchar(15),
	@Usuario_Registro varchar(40)
AS
BEGIN

	DECLARE @xCantReg int;
	DECLARE @CorrelativoTxt VARCHAR(20);

	select @xCantReg = count(*) from Turista
	SET @CorrelativoTxt = @Correlativo + RIGHT('0000000000' + CAST(@xCantReg + 1 AS VARCHAR), 10);

	insert into Turista (Nombres, Apellidos, Nacionalidad, PrecioBoleta, Correlativo, Fecha_Registro, Usuario_Registro) values 
	(@Nombres, @Apellidos, @Nacionalidad, @PrecioBoleta, @CorrelativoTxt, GETDATE(), @Usuario_Registro)
END
GO

-- =============================================Actualizar
CREATE PROCEDURE sp_Actualizar
    @Id_Turista INT,
    @Nombres NVARCHAR(40),
    @Apellidos NVARCHAR(40),
	@PrecioBoleta int,
    @Nacionalidad char(1),
	@Usuario_Modificacion varchar(40)
AS
BEGIN
    UPDATE Turista
    SET
        Nombres = @Nombres,
        Apellidos = @Apellidos,
		PrecioBoleta= @PrecioBoleta,
        Nacionalidad = @Nacionalidad,
        Fecha_Modificacion = GETDATE(),
        Usuario_Modificacion = @Usuario_Modificacion
    WHERE Id_Turista = @Id_Turista;
END;
GO
-- =============================================Listar
CREATE PROCEDURE sp_Listar
	@Fecha_Inicio DATETIME,
	@Fecha_Fin DATETIME,
	@Nacionalidad char(1)
AS
BEGIN
	SELECT Id_Turista, Nombres, Apellidos, Nacionalidad, PrecioBoleta,
	Correlativo, Fecha_Registro, Fecha_Modificacion, Usuario_Registro, Usuario_Modificacion	
	FROM Turista where (@Nacionalidad = '' or @Nacionalidad = Nacionalidad)
	and Fecha_Registro between @Fecha_Inicio and @Fecha_Fin;
END
GO

CREATE PROCEDURE [dbo].[sp_ObtenerUltimoRegistro]

AS
BEGIN
	select top 1 Id_Turista, Nombres, Apellidos, Nacionalidad, PrecioBoleta,
	Correlativo, Fecha_Registro, Fecha_Modificacion, Usuario_Registro, Usuario_Modificacion from Turista 
	where cast(Fecha_Registro as date) = cast(getdate() as date) 
	order by Id_Turista desc
END

exec sp_ObtenerUltimoRegistro