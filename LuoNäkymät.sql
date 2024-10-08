USE [Laite]
GO
/****** Object:  View [dbo].[KaikkiVaraukset]    Script Date: 26.8.2024 11.22.42 ******/
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
/****** Object:  View [dbo].[AktiivisetVaraukset]    Script Date: 26.8.2024 11.22.42 ******/
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
/****** Object:  View [dbo].[IDListaLainassa]    Script Date: 26.8.2024 11.22.42 ******/
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
/****** Object:  View [dbo].[IDListaVarausTanaan]    Script Date: 26.8.2024 11.22.42 ******/
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
/****** Object:  View [dbo].[IDListaEiVapaaTanaan]    Script Date: 26.8.2024 11.22.42 ******/
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
/****** Object:  View [dbo].[IDListaVapaatLaitteetTanaan]    Script Date: 26.8.2024 11.22.42 ******/
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
/****** Object:  View [dbo].[LaiteValintaVapaaTanaan]    Script Date: 26.8.2024 11.22.42 ******/
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
/****** Object:  View [dbo].[LainaajaLista]    Script Date: 26.8.2024 11.22.42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[LainaajaLista]
AS
SELECT        TOP (100) PERCENT LainaajaID, Sukunimi + ' ' + Etunimi AS Kokonimi
FROM            dbo.Lainaaja
GO
/****** Object:  View [dbo].[LainassaOlevatLaitteet]    Script Date: 26.8.2024 11.22.42 ******/
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
