USE [TurismoCasta]
GO

/****** Object:  Table [dbo].[Turista]    Script Date: 26/03/2026 18:54:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Turista](
	[Id_Turista] [int] IDENTITY(1,1) NOT NULL,
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

ALTER TABLE [dbo].[Turista]  WITH CHECK ADD CHECK  (([Nacionalidad]='E' OR [Nacionalidad]='N'))
GO


