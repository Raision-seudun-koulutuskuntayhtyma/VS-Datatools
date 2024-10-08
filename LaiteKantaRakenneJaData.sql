﻿USE [master]
GO
/****** Object:  Database [Laite]    Script Date: 3.9.2024 8.38.41 ******/
CREATE DATABASE [Laite]
 CONTAINMENT = NONE
 ON  PRIMARY 
 -- Tarkista aina omasta koneestasi SQL Server:n asennuspolku, muokkaa tarvittaessa FILENAME-parametrin arvoa
( NAME = N'Laite', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Laite.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
 -- Tarkista aina omasta koneestasi SQL Server:n asennuspolku, muokkaa tarvittaessa FILENAME-parametrin arvoa
( NAME = N'Laite_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Laite_log.ldf' , SIZE = 1792KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Laite] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Laite].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Laite] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Laite] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Laite] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Laite] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Laite] SET ARITHABORT OFF 
GO
ALTER DATABASE [Laite] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Laite] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Laite] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Laite] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Laite] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Laite] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Laite] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Laite] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Laite] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Laite] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Laite] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Laite] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Laite] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Laite] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Laite] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Laite] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Laite] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Laite] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Laite] SET  MULTI_USER 
GO
ALTER DATABASE [Laite] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Laite] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Laite] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Laite] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Laite] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Laite] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Laite] SET QUERY_STORE = ON
GO
ALTER DATABASE [Laite] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Laite]
GO
/****** Object:  Table [dbo].[Lainaaja]    Script Date: 3.9.2024 8.38.42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lainaaja](
	[LainaajaID] [varchar](50) NOT NULL,
	[Etunimi] [varchar](30) NOT NULL,
	[Sukunimi] [varchar](50) NOT NULL,
	[Ryhma] [varchar](50) NOT NULL,
	[Puhelin] [varchar](20) NULL,
	[Sahkoposti] [varchar](30) NULL,
 CONSTRAINT [Lainaaja_pk] PRIMARY KEY CLUSTERED 
(
	[LainaajaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[LainaajaLista]    Script Date: 3.9.2024 8.38.42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[LainaajaLista]
AS
SELECT        TOP (100) PERCENT LainaajaID, Sukunimi + ' ' + Etunimi AS Kokonimi
FROM            dbo.Lainaaja
GO
/****** Object:  Table [dbo].[Laite]    Script Date: 3.9.2024 8.38.42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Laite](
	[LaiteID] [int] IDENTITY(1,1) NOT NULL,
	[Laitetyyppi] [varchar](30) NOT NULL,
	[Nimi] [varchar](50) NOT NULL,
	[Lisatieto] [varchar](250) NULL,
 CONSTRAINT [Laite_pk] PRIMARY KEY CLUSTERED 
(
	[LaiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lainaus]    Script Date: 3.9.2024 8.38.42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lainaus](
	[LainausID] [int] IDENTITY(1,1) NOT NULL,
	[LaiteID] [int] NOT NULL,
	[LainaajaID] [varchar](50) NOT NULL,
	[Lainauspaiva] [datetime] NOT NULL,
	[Palautuaspaiva] [datetime] NULL,
 CONSTRAINT [Lainaus_pk] PRIMARY KEY CLUSTERED 
(
	[LainausID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[LainassaOlevatLaitteet]    Script Date: 3.9.2024 8.38.42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[LainassaOlevatLaitteet]
AS
SELECT        dbo.Laite.Laitetyyppi, dbo.Laite.Nimi, dbo.Lainaus.Lainauspaiva, dbo.Lainaaja.Sukunimi, dbo.Lainaaja.Etunimi, dbo.Lainaaja.Ryhma, dbo.Lainaus.Palautuaspaiva
FROM            dbo.Lainaus INNER JOIN
                         dbo.Laite ON dbo.Lainaus.LaiteID = dbo.Laite.LaiteID INNER JOIN
                         dbo.Lainaaja ON dbo.Lainaus.LainaajaID = dbo.Lainaaja.LainaajaID
WHERE        (dbo.Lainaus.Palautuaspaiva IS NULL)
GO
/****** Object:  Table [dbo].[Varaus]    Script Date: 3.9.2024 8.38.42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Varaus](
	[VarausID] [int] IDENTITY(1,1) NOT NULL,
	[LainaajaID] [varchar](50) NOT NULL,
	[LaiteID] [int] NOT NULL,
	[Alkaa] [datetime] NOT NULL,
	[Paattyy] [datetime] NOT NULL,
 CONSTRAINT [Varaus_pk] PRIMARY KEY CLUSTERED 
(
	[VarausID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[KaikkiVaraukset]    Script Date: 3.9.2024 8.38.42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[KaikkiVaraukset]
AS
SELECT        dbo.Laite.Laitetyyppi, dbo.Laite.Nimi, dbo.Varaus.Alkaa, dbo.Varaus.Paattyy, dbo.Lainaaja.Sukunimi, dbo.Lainaaja.Etunimi, dbo.Lainaaja.Ryhma
FROM            dbo.Lainaaja INNER JOIN
                         dbo.Varaus ON dbo.Lainaaja.LainaajaID = dbo.Varaus.LainaajaID INNER JOIN
                         dbo.Laite ON dbo.Varaus.LaiteID = dbo.Laite.LaiteID
GO
/****** Object:  View [dbo].[AktiivisetVaraukset]    Script Date: 3.9.2024 8.38.42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AktiivisetVaraukset]
AS
SELECT        Laitetyyppi, Nimi, Alkaa, Paattyy, Sukunimi, Etunimi, Ryhma
FROM            dbo.KaikkiVaraukset
WHERE        (Paattyy >= GETDATE())
GO
/****** Object:  View [dbo].[IDListaLainassa]    Script Date: 3.9.2024 8.38.42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[IDListaLainassa]
AS
SELECT        LaiteID
FROM            dbo.Lainaus
WHERE        (Palautuaspaiva IS NULL)
GO
/****** Object:  View [dbo].[IDListaVarausTanaan]    Script Date: 3.9.2024 8.38.42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[IDListaVarausTanaan]
AS
SELECT        LaiteID
FROM            dbo.Varaus
WHERE        (Paattyy >= GETDATE()) AND (Alkaa <= GETDATE())
GO
/****** Object:  View [dbo].[IDListaEiVapaaTanaan]    Script Date: 3.9.2024 8.38.42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[IDListaEiVapaaTanaan]
AS
SELECT        dbo.IDListaLainassa.LaiteID
FROM            dbo.IDListaLainassa 
                       UNION
SELECT dbo.IDListaVarausTanaan.LaiteID
FROM dbo.IDListaVarausTanaan
GO
/****** Object:  View [dbo].[IDListaVapaatLaitteetTanaan]    Script Date: 3.9.2024 8.38.42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[IDListaVapaatLaitteetTanaan]
AS
SELECT        dbo.Laite.LaiteID
FROM            dbo.Laite
EXCEPT
SELECT dbo.IDListaEiVapaaTanaan.LaiteID
FROM dbo.IDListaEiVapaaTanaan
GO
/****** Object:  View [dbo].[LaiteValintaVapaaTanaan]    Script Date: 3.9.2024 8.38.42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[LaiteValintaVapaaTanaan]
AS
SELECT        dbo.Laite.LaiteID, dbo.Laite.Laitetyyppi, dbo.Laite.Nimi, dbo.Laite.Lisatieto
FROM            dbo.Laite INNER JOIN
                         dbo.IDListaVapaatLaitteetTanaan ON dbo.Laite.LaiteID = dbo.IDListaVapaatLaitteetTanaan.LaiteID
GO
/****** Object:  Table [dbo].[Laitetyyppi]    Script Date: 3.9.2024 8.38.42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Laitetyyppi](
	[Laitetyyppi] [varchar](30) NOT NULL,
	[Lisatieto] [varchar](250) NOT NULL,
 CONSTRAINT [Laitetyyppi_pk] PRIMARY KEY CLUSTERED 
(
	[Laitetyyppi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Lainaaja] ([LainaajaID], [Etunimi], [Sukunimi], [Ryhma], [Puhelin], [Sahkoposti]) VALUES (N'12345', N'Teppo', N'Testi', N'Tivi20Oa', N'0400 432 267', N'12345@edu.raseko.fi')
INSERT [dbo].[Lainaaja] ([LainaajaID], [Etunimi], [Sukunimi], [Ryhma], [Puhelin], [Sahkoposti]) VALUES (N'12346', N'Tiina', N'Testi', N'Tivi20Oa', N'050 123 4568', N'12346@edu.raseko.fi')
INSERT [dbo].[Lainaaja] ([LainaajaID], [Etunimi], [Sukunimi], [Ryhma], [Puhelin], [Sahkoposti]) VALUES (N'456654', N'Jakke', N'Jäynä', N'TiVi24A', N'044777666', N'456654@edu.raseko.fi')
INSERT [dbo].[Lainaaja] ([LainaajaID], [Etunimi], [Sukunimi], [Ryhma], [Puhelin], [Sahkoposti]) VALUES (N'olli.ope@raseko.fi', N'Olli', N'Ope', N'Tieto- ja viestintätekniikka', N'044 705 7433', N'olli.ope@raseko.fi')
GO
SET IDENTITY_INSERT [dbo].[Lainaus] ON 

INSERT [dbo].[Lainaus] ([LainausID], [LaiteID], [LainaajaID], [Lainauspaiva], [Palautuaspaiva]) VALUES (2, 1, N'12345', CAST(N'2024-08-20T00:00:00.000' AS DateTime), CAST(N'2024-08-21T00:00:00.000' AS DateTime))
INSERT [dbo].[Lainaus] ([LainausID], [LaiteID], [LainaajaID], [Lainauspaiva], [Palautuaspaiva]) VALUES (3, 2, N'12345', CAST(N'2024-08-20T00:00:00.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Lainaus] OFF
GO
SET IDENTITY_INSERT [dbo].[Laite] ON 

INSERT [dbo].[Laite] ([LaiteID], [Laitetyyppi], [Nimi], [Lisatieto]) VALUES (1, N'Audiotallennin', N'Zoom Q9', N'Audiotallennin-videokamera, tuotta vain laajakuvaa, hyvä ääni')
INSERT [dbo].[Laite] ([LaiteID], [Laitetyyppi], [Nimi], [Lisatieto]) VALUES (2, N'Mikrofoni', N'Rode NT1-USB', N'Hyvälaatuinen kondensaattorimikrofoni USB-lähtö ja 3,5 mm kuulokeliitäntä')
INSERT [dbo].[Laite] ([LaiteID], [Laitetyyppi], [Nimi], [Lisatieto]) VALUES (3, N'Audiotallennin', N'Zoom HN1', N'MicroSD-korttia käyttävä 24 bit tallennin AAA paristot')
INSERT [dbo].[Laite] ([LaiteID], [Laitetyyppi], [Nimi], [Lisatieto]) VALUES (4, N'Mikrofoni', N'Shure SM5', NULL)
INSERT [dbo].[Laite] ([LaiteID], [Laitetyyppi], [Nimi], [Lisatieto]) VALUES (5, N'Kamera', N'Sony 4K', N'4k Videokamera 50 x zoom')
SET IDENTITY_INSERT [dbo].[Laite] OFF
GO
INSERT [dbo].[Laitetyyppi] ([Laitetyyppi], [Lisatieto]) VALUES (N'Audiotallennin', N'Äänen nauhoittamiseen tarkoitetut laiteet, myös Zoom-vido/äänitalllentimet')
INSERT [dbo].[Laitetyyppi] ([Laitetyyppi], [Lisatieto]) VALUES (N'Kamera', N'Tavalliset kamerat, esim. järjestelmäkamerat ja muut ei-videokamerat')
INSERT [dbo].[Laitetyyppi] ([Laitetyyppi], [Lisatieto]) VALUES (N'Mikrofoni', N'Erilaiset mikrofonit, joissa ei ole omaa tallenninta')
INSERT [dbo].[Laitetyyppi] ([Laitetyyppi], [Lisatieto]) VALUES (N'Videokamera', N'Varsinaiset videokamerat, Zoom-laitteet kirjataan Audio tallentimiin')
GO
SET IDENTITY_INSERT [dbo].[Varaus] ON 

INSERT [dbo].[Varaus] ([VarausID], [LainaajaID], [LaiteID], [Alkaa], [Paattyy]) VALUES (1, N'456654', 1, CAST(N'2024-08-26T00:00:00.000' AS DateTime), CAST(N'2024-08-29T00:00:00.000' AS DateTime))
INSERT [dbo].[Varaus] ([VarausID], [LainaajaID], [LaiteID], [Alkaa], [Paattyy]) VALUES (2, N'olli.ope@raseko.fi', 4, CAST(N'2024-08-30T00:00:00.000' AS DateTime), CAST(N'2024-08-30T00:00:00.000' AS DateTime))
INSERT [dbo].[Varaus] ([VarausID], [LainaajaID], [LaiteID], [Alkaa], [Paattyy]) VALUES (3, N'12345', 3, CAST(N'2024-08-19T00:00:00.000' AS DateTime), CAST(N'2024-08-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Varaus] ([VarausID], [LainaajaID], [LaiteID], [Alkaa], [Paattyy]) VALUES (4, N'12346', 5, CAST(N'2024-08-22T00:00:00.000' AS DateTime), CAST(N'2024-08-23T00:00:00.000' AS DateTime))
INSERT [dbo].[Varaus] ([VarausID], [LainaajaID], [LaiteID], [Alkaa], [Paattyy]) VALUES (5, N'12345', 2, CAST(N'2024-08-20T00:00:00.000' AS DateTime), CAST(N'2024-08-23T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Varaus] OFF
GO
ALTER TABLE [dbo].[Lainaus]  WITH CHECK ADD  CONSTRAINT [Lainaaja_Lainaus_fk] FOREIGN KEY([LainaajaID])
REFERENCES [dbo].[Lainaaja] ([LainaajaID])
GO
ALTER TABLE [dbo].[Lainaus] CHECK CONSTRAINT [Lainaaja_Lainaus_fk]
GO
ALTER TABLE [dbo].[Lainaus]  WITH CHECK ADD  CONSTRAINT [Laite_Lainaus_fk] FOREIGN KEY([LaiteID])
REFERENCES [dbo].[Laite] ([LaiteID])
GO
ALTER TABLE [dbo].[Lainaus] CHECK CONSTRAINT [Laite_Lainaus_fk]
GO
ALTER TABLE [dbo].[Laite]  WITH CHECK ADD  CONSTRAINT [Laitetyyppi_Laite_fk] FOREIGN KEY([Laitetyyppi])
REFERENCES [dbo].[Laitetyyppi] ([Laitetyyppi])
GO
ALTER TABLE [dbo].[Laite] CHECK CONSTRAINT [Laitetyyppi_Laite_fk]
GO
ALTER TABLE [dbo].[Varaus]  WITH CHECK ADD  CONSTRAINT [Lainaaja_Varaus_fk] FOREIGN KEY([LainaajaID])
REFERENCES [dbo].[Lainaaja] ([LainaajaID])
GO
ALTER TABLE [dbo].[Varaus] CHECK CONSTRAINT [Lainaaja_Varaus_fk]
GO
ALTER TABLE [dbo].[Varaus]  WITH CHECK ADD  CONSTRAINT [Laite_Varaus_fk] FOREIGN KEY([LaiteID])
REFERENCES [dbo].[Laite] ([LaiteID])
GO
ALTER TABLE [dbo].[Varaus] CHECK CONSTRAINT [Laite_Varaus_fk]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "KaikkiVaraukset"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 211
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3045
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AktiivisetVaraukset'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AktiivisetVaraukset'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "IDListaLainassa"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 85
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "IDListaVarausTanaan"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 85
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'IDListaEiVapaaTanaan'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'IDListaEiVapaaTanaan'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Lainaus"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 174
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 1665
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'IDListaLainassa'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'IDListaLainassa'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Laite"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "IDListaEiVapaaTanaan"
            Begin Extent = 
               Top = 2
               Left = 328
               Bottom = 81
               Right = 591
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'IDListaVapaatLaitteetTanaan'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'IDListaVapaatLaitteetTanaan'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Varaus"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 176
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'IDListaVarausTanaan'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'IDListaVarausTanaan'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -96
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Lainaaja"
            Begin Extent = 
               Top = 92
               Left = 208
               Bottom = 276
               Right = 378
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Laite"
            Begin Extent = 
               Top = 12
               Left = 28
               Bottom = 142
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Varaus"
            Begin Extent = 
               Top = 5
               Left = 470
               Bottom = 165
               Right = 640
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'KaikkiVaraukset'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'KaikkiVaraukset'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Lainaaja"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 184
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 4200
         Alias = 1815
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'LainaajaLista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'LainaajaLista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Lainaus"
            Begin Extent = 
               Top = 0
               Left = 560
               Bottom = 152
               Right = 730
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Laite"
            Begin Extent = 
               Top = 1
               Left = 73
               Bottom = 131
               Right = 243
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Lainaaja"
            Begin Extent = 
               Top = 78
               Left = 290
               Bottom = 219
               Right = 460
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'LainassaOlevatLaitteet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'LainassaOlevatLaitteet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Laite"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 160
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "IDListaVapaatLaitteetTanaan"
            Begin Extent = 
               Top = 5
               Left = 333
               Bottom = 84
               Right = 503
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'LaiteValintaVapaaTanaan'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'LaiteValintaVapaaTanaan'
GO
USE [master]
GO
ALTER DATABASE [Laite] SET  READ_WRITE 
GO
