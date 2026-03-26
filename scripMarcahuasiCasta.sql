-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
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
select * from turista

CREATE PROCEDURE [dbo].[sp_ObtenerUltimoRegistro]

AS
BEGIN
	select top 1 Id_Turista, Nombres, Apellidos, Nacionalidad, PrecioBoleta,
	Correlativo, Fecha_Registro, Fecha_Modificacion, Usuario_Registro, Usuario_Modificacion from Turista 
	where cast(Fecha_Registro as date) = cast(getdate() as date) 
	order by Id_Turista desc
END