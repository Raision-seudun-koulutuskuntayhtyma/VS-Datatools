USE [Laite]
GO
INSERT [dbo].[Laitetyyppi] ([Laitetyyppi], [Lisatieto]) VALUES (N'Audiotallennin', N'Äänen nauhoittamiseen tarkoitetut laiteet, myös Zoom-vido/äänitalllentimet')
INSERT [dbo].[Laitetyyppi] ([Laitetyyppi], [Lisatieto]) VALUES (N'Kamera', N'Tavalliset kamerat, esim. järjestelmäkamerat ja muut ei-videokamerat')
INSERT [dbo].[Laitetyyppi] ([Laitetyyppi], [Lisatieto]) VALUES (N'Mikrofoni', N'Erilaiset mikrofonit, joissa ei ole omaa tallenninta')
INSERT [dbo].[Laitetyyppi] ([Laitetyyppi], [Lisatieto]) VALUES (N'Videokamera', N'Varsinaiset videokamerat, Zoom-laitteet kirjataan Audio tallentimiin')
GO
SET IDENTITY_INSERT [dbo].[Laite] ON 

INSERT [dbo].[Laite] ([LaiteID], [Laitetyyppi], [Nimi], [Lisatieto]) VALUES (1, N'Audiotallennin', N'Zoom Q9', N'Audiotallennin-videokamera, tuotta vain laajakuvaa, hyvä ääni')
INSERT [dbo].[Laite] ([LaiteID], [Laitetyyppi], [Nimi], [Lisatieto]) VALUES (2, N'Mikrofoni', N'Rode NT1-USB', N'Hyvälaatuinen kondensaattorimikrofoni USB-lähtö ja 3,5 mm kuulokeliitäntä')
INSERT [dbo].[Laite] ([LaiteID], [Laitetyyppi], [Nimi], [Lisatieto]) VALUES (3, N'Audiotallennin', N'Zoom HN1', N'MicroSD-korttia käyttävä 24 bit tallennin AAA paristot')
INSERT [dbo].[Laite] ([LaiteID], [Laitetyyppi], [Nimi], [Lisatieto]) VALUES (4, N'Mikrofoni', N'Shure SM5', NULL)
INSERT [dbo].[Laite] ([LaiteID], [Laitetyyppi], [Nimi], [Lisatieto]) VALUES (5, N'Kamera', N'Sony 4K', N'4k Videokamera 50 x zoom')
SET IDENTITY_INSERT [dbo].[Laite] OFF
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
SET IDENTITY_INSERT [dbo].[Varaus] ON 

INSERT [dbo].[Varaus] ([VarausID], [LainaajaID], [LaiteID], [Alkaa], [Paattyy]) VALUES (1, N'456654', 1, CAST(N'2024-08-26T00:00:00.000' AS DateTime), CAST(N'2024-08-29T00:00:00.000' AS DateTime))
INSERT [dbo].[Varaus] ([VarausID], [LainaajaID], [LaiteID], [Alkaa], [Paattyy]) VALUES (2, N'olli.ope@raseko.fi', 4, CAST(N'2024-08-30T00:00:00.000' AS DateTime), CAST(N'2024-08-30T00:00:00.000' AS DateTime))
INSERT [dbo].[Varaus] ([VarausID], [LainaajaID], [LaiteID], [Alkaa], [Paattyy]) VALUES (3, N'12345', 3, CAST(N'2024-08-19T00:00:00.000' AS DateTime), CAST(N'2024-08-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Varaus] ([VarausID], [LainaajaID], [LaiteID], [Alkaa], [Paattyy]) VALUES (4, N'12346', 5, CAST(N'2024-08-22T00:00:00.000' AS DateTime), CAST(N'2024-08-23T00:00:00.000' AS DateTime))
INSERT [dbo].[Varaus] ([VarausID], [LainaajaID], [LaiteID], [Alkaa], [Paattyy]) VALUES (5, N'12345', 2, CAST(N'2024-08-20T00:00:00.000' AS DateTime), CAST(N'2024-08-23T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Varaus] OFF
GO
