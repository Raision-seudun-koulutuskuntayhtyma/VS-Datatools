-- Siirrytään varmuuden vuoksi MASTER-tietokantaan
USE master
GO

-- Luodaan uusi tietokanta LAITE
CREATE DATABASE [Laite]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Laite', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Laite.mdf' , SIZE = 5120KB , FILEGROWTH = 10%)
 LOG ON 
( NAME = N'Laite_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Laite_log.ldf' , SIZE = 1024KB , FILEGROWTH = 10%)
 COLLATE Finnish_Swedish_CI_AS
 WITH LEDGER = OFF
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
ALTER DATABASE [Laite] SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF)
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
ALTER DATABASE [Laite] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Laite] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Laite] SET  READ_WRITE 
GO
ALTER DATABASE [Laite] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Laite] SET  MULTI_USER 
GO
ALTER DATABASE [Laite] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Laite] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Laite] SET DELAYED_DURABILITY = DISABLED 
GO
USE [Laite]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = On;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = Primary;
GO
USE [Laite]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [Laite] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO

-- Luodaan tietokannan taulut

CREATE TABLE Laitetyyppi (
                Laitetyyppi VARCHAR(30) NOT NULL,
                Lisatieto VARCHAR(250) NOT NULL,
                CONSTRAINT Laitetyyppi_pk PRIMARY KEY (Laitetyyppi)
)

-- Comment for table [Laitetyyppi]: Minkä tyyppinen laite tai tarvike. Luokittelua varten

-- Comment for column [Laitetyyppi]: Laitetyypin nimitys, esim videokamera, kaapeli tms.


CREATE TABLE Lainaaja (
                LainaajaID VARCHAR(50) NOT NULL,
                Etunimi VARCHAR(30) NOT NULL,
                Sukunimi VARCHAR(50) NOT NULL,
                Ryhma VARCHAR(50) NOT NULL,
                Puhelin VARCHAR(20),
                Sahkoposti VARCHAR(30),
                CONSTRAINT Lainaaja_pk PRIMARY KEY (LainaajaID)
)

-- Comment for table [Lainaaja]: Lainaajan henkilötiedot

-- Comment for column [LainaajaID]: Oppilasnumero tai henkilökunnan sähköpostiosoite

-- Comment for column [Ryhmä]: Luokka tai osasto, johon lainaaja kuuluu


CREATE TABLE Laite (
                LaiteID INT IDENTITY NOT NULL,
                Laitetyyppi VARCHAR(30) NOT NULL,
                Nimi VARCHAR(50) NOT NULL,
                Lisatieto VARCHAR(250),
                CONSTRAINT Laite_pk PRIMARY KEY (LaiteID)
)

-- Comment for table [Laite]: Tavarat ja tarvikkeet, joita voi lainata

-- Comment for column [LaiteID]: Automaattisesti kasvava numero, josta tulostetaan viivakooditarra.

-- Comment for column [Laitetyyppi]: Laitetyypin nimitys, esim videokamera, kaapeli tms.

-- Comment for column [Nimi]: Laitteen tai tarvikkeen nimitys


CREATE TABLE Varaus (
                VarausID INT IDENTITY NOT NULL,
                LainaajaID VARCHAR(50) NOT NULL,
                LaiteID INT NOT NULL,
                Alkaa DATETIME NOT NULL,
                Paattyy DATETIME NOT NULL,
                CONSTRAINT Varaus_pk PRIMARY KEY (VarausID)
)

CREATE TABLE Lainaus (
                LainausID INT IDENTITY NOT NULL,
                LaiteID INT NOT NULL,
                LainaajaID VARCHAR(50) NOT NULL,
                Lainauspaiva DATETIME NOT NULL,
                Palautuaspaiva DATETIME,
                CONSTRAINT Lainaus_pk PRIMARY KEY (LainausID)
)

-- Määritellään taulujen väliset relaatiot perus-viiteavain pareina

ALTER TABLE Laite ADD CONSTRAINT Laitetyyppi_Laite_fk
FOREIGN KEY (Laitetyyppi)
REFERENCES Laitetyyppi (Laitetyyppi)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE Lainaus ADD CONSTRAINT Lainaaja_Lainaus_fk
FOREIGN KEY (LainaajaID)
REFERENCES Lainaaja (LainaajaID)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE Varaus ADD CONSTRAINT Lainaaja_Varaus_fk
FOREIGN KEY (LainaajaID)
REFERENCES Lainaaja (LainaajaID)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE Lainaus ADD CONSTRAINT Laite_Lainaus_fk
FOREIGN KEY (LaiteID)
REFERENCES Laite (LaiteID)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE Varaus ADD CONSTRAINT Laite_Varaus_fk
FOREIGN KEY (LaiteID)
REFERENCES Laite (LaiteID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
