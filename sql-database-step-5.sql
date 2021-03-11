USE [master]
GO
/****** Object:  Database [business3]    Script Date: 12/24/2019 9:56:43 PM ******/
CREATE DATABASE [business3]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'business3', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\business3.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'business3_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\business3_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [business3] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [business3].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [business3] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [business3] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [business3] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [business3] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [business3] SET ARITHABORT OFF 
GO
ALTER DATABASE [business3] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [business3] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [business3] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [business3] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [business3] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [business3] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [business3] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [business3] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [business3] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [business3] SET  ENABLE_BROKER 
GO
ALTER DATABASE [business3] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [business3] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [business3] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [business3] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [business3] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [business3] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [business3] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [business3] SET RECOVERY FULL 
GO
ALTER DATABASE [business3] SET  MULTI_USER 
GO
ALTER DATABASE [business3] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [business3] SET DB_CHAINING OFF 
GO
ALTER DATABASE [business3] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [business3] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [business3] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [business3] SET QUERY_STORE = OFF
GO
USE [business3]
GO
/****** Object:  Table [dbo].[EMPLOYEE]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EMPLOYEE](
	[EmployeeID] [int] IDENTITY(100,1) NOT NULL,
	[EmployeeName] [varchar](12) NULL,
	[EmployeeSurname] [varchar](12) NULL,
	[DateOfBirth] [int] NULL,
	[Age]  AS ((2019)-[DateOfBirth]),
	[Telephone] [varchar](13) NULL,
	[Adress] [varchar](100) NULL,
	[DateOfHired] [int] NULL,
	[DateOfWorkingYear]  AS ((2019)-[DateOfHired]),
	[WorkingArea] [varchar](15) NULL,
	[salary] [int] NULL,
 CONSTRAINT [EMPLOYEE_PK] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SALESPERSON]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SALESPERSON](
	[SEmployeeID] [int] NOT NULL,
	[SalesAmount] [int] NULL,
	[TotalProfit] [int] NULL,
	[NumberOfCostumer] [int] NULL,
	[EarnedBounty]  AS ([TotalProfit]*(0.20)),
	[SDepartmentID] [int] NULL,
 CONSTRAINT [SALESPERSON_PK] PRIMARY KEY CLUSTERED 
(
	[SEmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_SalesEmployee]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_SalesEmployee]
AS
SELECT        dbo.EMPLOYEE.EmployeeName, dbo.EMPLOYEE.EmployeeSurname, dbo.EMPLOYEE.salary, dbo.SALESPERSON.SalesAmount, dbo.SALESPERSON.TotalProfit, dbo.SALESPERSON.NumberOfCostumer
FROM            dbo.SALESPERSON INNER JOIN
                         dbo.EMPLOYEE ON dbo.SALESPERSON.SEmployeeID = dbo.EMPLOYEE.EmployeeID
GO
/****** Object:  Table [dbo].[BUYING_EMPLOYEE]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BUYING_EMPLOYEE](
	[BEmployeeID] [int] NOT NULL,
	[TotalSpentMoney] [int] NULL,
	[SecurityBankCode] [varchar](10) NULL,
	[BDepartmentID] [int] NULL,
 CONSTRAINT [BUYING_EMPLOYEE_PK] PRIMARY KEY CLUSTERED 
(
	[BEmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_BuyingEmployee]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_BuyingEmployee]
AS
SELECT        dbo.EMPLOYEE.EmployeeName, dbo.EMPLOYEE.salary, dbo.BUYING_EMPLOYEE.SecurityBankCode, dbo.BUYING_EMPLOYEE.TotalSpentMoney
FROM            dbo.EMPLOYEE INNER JOIN
                         dbo.BUYING_EMPLOYEE ON dbo.EMPLOYEE.EmployeeID = dbo.BUYING_EMPLOYEE.BEmployeeID
GO
/****** Object:  Table [dbo].[CALL_CENTER_EMPLOYEE]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CALL_CENTER_EMPLOYEE](
	[CEmployeeID] [int] NOT NULL,
	[DeskNumber] [varchar](4) NULL,
	[DeskPhoneNumber] [varchar](13) NULL,
	[NumberOfSpeakingPeoples] [int] NULL,
	[CDepartmentID] [int] NULL,
 CONSTRAINT [CALL_CENTER_EMPLOYEE_PK] PRIMARY KEY CLUSTERED 
(
	[CEmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CALL_CENTER_EMPLOYEE_FOREIGN]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CALL_CENTER_EMPLOYEE_FOREIGN](
	[FCEmployeeID] [int] NOT NULL,
	[ListeningCountries] [varchar](50) NULL,
 CONSTRAINT [CALL_CENTER_EMPLOYEE_FOREIGN_PK] PRIMARY KEY CLUSTERED 
(
	[FCEmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FOREIGN_LANGUAGE_CERTIFICATE]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FOREIGN_LANGUAGE_CERTIFICATE](
	[LicenceID] [int] IDENTITY(100,1) NOT NULL,
	[LanguageName] [varchar](10) NULL,
	[FCEmployeeID] [int] NULL,
 CONSTRAINT [FOREIGN_LANGUAGE_CERTIFICATE_PK] PRIMARY KEY CLUSTERED 
(
	[LicenceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_Call_center_Foreign_Employee]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Call_center_Foreign_Employee]
AS
SELECT        dbo.EMPLOYEE.EmployeeName, dbo.EMPLOYEE.EmployeeSurname, dbo.EMPLOYEE.salary, dbo.CALL_CENTER_EMPLOYEE.DeskNumber, dbo.CALL_CENTER_EMPLOYEE.DeskPhoneNumber, 
                         dbo.FOREIGN_LANGUAGE_CERTIFICATE.LanguageName
FROM            dbo.EMPLOYEE INNER JOIN
                         dbo.CALL_CENTER_EMPLOYEE ON dbo.EMPLOYEE.EmployeeID = dbo.CALL_CENTER_EMPLOYEE.CEmployeeID INNER JOIN
                         dbo.CALL_CENTER_EMPLOYEE_FOREIGN ON dbo.CALL_CENTER_EMPLOYEE.CEmployeeID = dbo.CALL_CENTER_EMPLOYEE_FOREIGN.FCEmployeeID INNER JOIN
                         dbo.FOREIGN_LANGUAGE_CERTIFICATE ON dbo.CALL_CENTER_EMPLOYEE_FOREIGN.FCEmployeeID = dbo.FOREIGN_LANGUAGE_CERTIFICATE.FCEmployeeID
GO
/****** Object:  Table [dbo].[BROKER_SALESPERSON]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BROKER_SALESPERSON](
	[BSEmployeeID] [int] NOT NULL,
	[BillRate] [float] NULL,
 CONSTRAINT [BROKER_SALESPERSON_PK] PRIMARY KEY CLUSTERED 
(
	[BSEmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BROKER_SALESPERSON_DOMESTIC]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BROKER_SALESPERSON_DOMESTIC](
	[DBSEmployee] [int] NOT NULL,
	[WorkingRegion] [varchar](50) NULL,
 CONSTRAINT [BROKER_SALESPERSON_DOMESTIC_PK] PRIMARY KEY CLUSTERED 
(
	[DBSEmployee] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BROKER_SALESPERSON_OVERSEAS]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BROKER_SALESPERSON_OVERSEAS](
	[OBSEmployee] [int] NOT NULL,
	[WorkingCountriesName] [varchar](50) NULL,
 CONSTRAINT [BROKER_SALESPERSON_OVERSEAS_PK] PRIMARY KEY CLUSTERED 
(
	[OBSEmployee] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BUYING]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BUYING](
	[BuyingID] [int] IDENTITY(100,1) NOT NULL,
	[ProductName] [varchar](15) NULL,
	[ProductDescription] [varchar](50) NULL,
	[Amount] [int] NULL,
	[TotalPrice] [int] NULL,
	[BEmployeeID] [int] NULL,
	[SupplierID] [int] NULL,
 CONSTRAINT [BUYING_PK] PRIMARY KEY CLUSTERED 
(
	[BuyingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BUYING_DEPARTMENT]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BUYING_DEPARTMENT](
	[BDepartmentID] [int] NOT NULL,
	[CostOfPurchasedFabric] [int] NULL,
	[CostOfPurchasedButton] [int] NULL,
	[CostOfPurchasedYarn] [int] NULL,
 CONSTRAINT [BUYING_DEPARTMENT_PK] PRIMARY KEY CLUSTERED 
(
	[BDepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CALL_CENTER_DEPARTMENT]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CALL_CENTER_DEPARTMENT](
	[CDepartmentID] [int] NOT NULL,
	[NumberOfCostumersSpoken] [int] NULL,
	[NumberOfSolvingProblem] [int] NULL,
 CONSTRAINT [CALL_CENTER_DEPARTMENT_PK] PRIMARY KEY CLUSTERED 
(
	[CDepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CALL_CENTER_EMPLOYEE_NATIONAL]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CALL_CENTER_EMPLOYEE_NATIONAL](
	[NCEmployeeID] [int] NOT NULL,
	[NumberOfInternalComplaints] [int] NULL,
	[ListeningRegion] [varchar](50) NULL,
 CONSTRAINT [CALL_CENTER_EMPLOYEE_NATIONAL_PK] PRIMARY KEY CLUSTERED 
(
	[NCEmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CONTRACT_BROKER]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONTRACT_BROKER](
	[ContractID] [int] IDENTITY(100,1) NOT NULL,
	[ContractTopic] [varchar](1000) NULL,
	[ContrantDate] [varchar](15) NULL,
	[DeadLine] [varchar](15) NULL,
	[BSEmployeeID] [int] NULL,
 CONSTRAINT [CONTRACT_BROKER_PK] PRIMARY KEY CLUSTERED 
(
	[ContractID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[COSTUMER]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COSTUMER](
	[CostumerID] [int] IDENTITY(100,1) NOT NULL,
	[CostumerName] [varchar](10) NULL,
	[CostumerPhone] [varchar](13) NULL,
	[DSEmployeeID] [int] NULL,
 CONSTRAINT [COSTUMER_PK] PRIMARY KEY CLUSTERED 
(
	[CostumerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEPARTMENT]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEPARTMENT](
	[DepartmentID] [int] IDENTITY(0,1) NOT NULL,
	[AnnualCost] [int] NULL,
	[NumberOfEmployee] [int] NULL,
	[StartWorkTime] [char](10) NULL,
	[EndWorkTime] [char](10) NULL,
	[NumberOfAnnualLeave] [char](3) NULL,
 CONSTRAINT [DEPARTMENT_PK] PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DOMESTIC_SALESPERSON]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DOMESTIC_SALESPERSON](
	[DSEmployeeID] [int] NOT NULL,
	[WorkingRegion] [varchar](50) NULL,
 CONSTRAINT [DOMESTIC_SALESPERSON_PK] PRIMARY KEY CLUSTERED 
(
	[DSEmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EXPORTER_LICENCE]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EXPORTER_LICENCE](
	[CertificateID] [int] IDENTITY(100,1) NOT NULL,
	[CountryName] [varchar](10) NULL,
	[OBSEmployee] [int] NULL,
 CONSTRAINT [EXPORTER_LICENCE_PK] PRIMARY KEY CLUSTERED 
(
	[CertificateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FACTORY_WORKER]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FACTORY_WORKER](
	[FEmployeeID] [int] NOT NULL,
	[ProducedShirtsAmount] [int] NULL,
	[NumberOfMakingManufacturingDefect] [int] NULL,
	[PDepartmentID] [int] NULL,
 CONSTRAINT [FACTORY_WORKER_PK] PRIMARY KEY CLUSTERED 
(
	[FEmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FOREIGN_COSTUMER]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FOREIGN_COSTUMER](
	[FCostumerID] [int] IDENTITY(100,1) NOT NULL,
	[CostumerName] [varchar](10) NULL,
	[CostumerPhone] [varchar](13) NULL,
	[Zipcode] [varchar](9) NULL,
	[CostumerLanguage] [varchar](10) NULL,
	[Country] [varchar](10) NULL,
	[OSEmployeeID] [int] NULL,
 CONSTRAINT [FOREIGN_COSTUMER_PK] PRIMARY KEY CLUSTERED 
(
	[FCostumerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OVERSEAS_SALESPERSON]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OVERSEAS_SALESPERSON](
	[OSEmployeeID] [int] NOT NULL,
	[WorkingCountriesNames] [varchar](50) NULL,
 CONSTRAINT [OVERSEAS_SALESPERSON_PK] PRIMARY KEY CLUSTERED 
(
	[OSEmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PRODUCTION_DEPARTMENT]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTION_DEPARTMENT](
	[PDepartmentID] [int] NOT NULL,
	[AmountOfProducedPlainShirts] [int] NULL,
	[AmountOfProducedPatternedShirts] [int] NULL,
	[NumberOfMakingManufacturingDefect] [int] NULL,
	[ErrorRateInManufacturedShirts] [real] NULL,
 CONSTRAINT [PRODUCTION_DEPARTMENT_PK] PRIMARY KEY CLUSTERED 
(
	[PDepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SALES_DEPARTMENT]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SALES_DEPARTMENT](
	[SDepartmentID] [int] NOT NULL,
	[SalesAmount] [int] NULL,
	[TotalProfit] [int] NULL,
	[NumberOfTotalCostumer] [int] NULL,
 CONSTRAINT [SALES_DEPARTMENT_PK] PRIMARY KEY CLUSTERED 
(
	[SDepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SUPPLIER]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SUPPLIER](
	[SupplierID] [int] IDENTITY(100,1) NOT NULL,
	[SupplierName] [varchar](10) NULL,
	[SupplierPhone] [varchar](10) NULL,
	[SupplierAdress] [varchar](50) NULL,
 CONSTRAINT [SUPPLIER_PK] PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TRANSPORTATION_DEPARTMENT]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRANSPORTATION_DEPARTMENT](
	[TDepartmentID] [int] NOT NULL,
	[NumberOfAirlineDelivery] [int] NULL,
	[NumberOfHighwayDelivery] [int] NULL,
	[NumberOfSeawayDelivery] [int] NULL,
 CONSTRAINT [TRANSPORTATION_DEPARTMENT_PK] PRIMARY KEY CLUSTERED 
(
	[TDepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TRANSPORTATION_EMPLOYEE]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRANSPORTATION_EMPLOYEE](
	[TEmployeeID] [int] NOT NULL,
	[TransportationCode] [varchar](9) NULL,
	[TDepartmentID] [int] NULL,
 CONSTRAINT [TRANSPORTATION_EMPLOYEE_PK] PRIMARY KEY CLUSTERED 
(
	[TEmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[BROKER_SALESPERSON] ([BSEmployeeID], [BillRate]) VALUES (123, 15)
GO
INSERT [dbo].[BROKER_SALESPERSON] ([BSEmployeeID], [BillRate]) VALUES (124, 15)
GO
INSERT [dbo].[BROKER_SALESPERSON_DOMESTIC] ([DBSEmployee], [WorkingRegion]) VALUES (123, N'Marmara')
GO
INSERT [dbo].[BROKER_SALESPERSON_OVERSEAS] ([OBSEmployee], [WorkingCountriesName]) VALUES (124, N'France')
GO
SET IDENTITY_INSERT [dbo].[BUYING] ON 
GO
INSERT [dbo].[BUYING] ([BuyingID], [ProductName], [ProductDescription], [Amount], [TotalPrice], [BEmployeeID], [SupplierID]) VALUES (101, N'WhiteFabric', N'good quality of fabric', 50000, 450000, 112, 106)
GO
INSERT [dbo].[BUYING] ([BuyingID], [ProductName], [ProductDescription], [Amount], [TotalPrice], [BEmployeeID], [SupplierID]) VALUES (102, N'BLACKFabric', N'light fabrics', 3000, 35000, 113, 107)
GO
INSERT [dbo].[BUYING] ([BuyingID], [ProductName], [ProductDescription], [Amount], [TotalPrice], [BEmployeeID], [SupplierID]) VALUES (111, N'colour', N'6 different colour', 4500, 40000, 114, 106)
GO
INSERT [dbo].[BUYING] ([BuyingID], [ProductName], [ProductDescription], [Amount], [TotalPrice], [BEmployeeID], [SupplierID]) VALUES (112, N'button', N'white button', 2500, 500, 112, 108)
GO
INSERT [dbo].[BUYING] ([BuyingID], [ProductName], [ProductDescription], [Amount], [TotalPrice], [BEmployeeID], [SupplierID]) VALUES (113, N'yarn', N'white yarn', 10000, 20000, 113, 102)
GO
SET IDENTITY_INSERT [dbo].[BUYING] OFF
GO
INSERT [dbo].[BUYING_DEPARTMENT] ([BDepartmentID], [CostOfPurchasedFabric], [CostOfPurchasedButton], [CostOfPurchasedYarn]) VALUES (0, 4500000, 33000, 60000)
GO
INSERT [dbo].[BUYING_DEPARTMENT] ([BDepartmentID], [CostOfPurchasedFabric], [CostOfPurchasedButton], [CostOfPurchasedYarn]) VALUES (1, 9000000, 33000, 98000)
GO
INSERT [dbo].[BUYING_DEPARTMENT] ([BDepartmentID], [CostOfPurchasedFabric], [CostOfPurchasedButton], [CostOfPurchasedYarn]) VALUES (2, 6000000, 33000, 60000)
GO
INSERT [dbo].[BUYING_DEPARTMENT] ([BDepartmentID], [CostOfPurchasedFabric], [CostOfPurchasedButton], [CostOfPurchasedYarn]) VALUES (3, 5000000, 33000, 60000)
GO
INSERT [dbo].[BUYING_EMPLOYEE] ([BEmployeeID], [TotalSpentMoney], [SecurityBankCode], [BDepartmentID]) VALUES (103, 540000, N'B657875', 1)
GO
INSERT [dbo].[BUYING_EMPLOYEE] ([BEmployeeID], [TotalSpentMoney], [SecurityBankCode], [BDepartmentID]) VALUES (112, 495600, N'A705431', 1)
GO
INSERT [dbo].[BUYING_EMPLOYEE] ([BEmployeeID], [TotalSpentMoney], [SecurityBankCode], [BDepartmentID]) VALUES (113, 110000, N'B897013', 1)
GO
INSERT [dbo].[BUYING_EMPLOYEE] ([BEmployeeID], [TotalSpentMoney], [SecurityBankCode], [BDepartmentID]) VALUES (114, 47800, N'C432423', 1)
GO
INSERT [dbo].[BUYING_EMPLOYEE] ([BEmployeeID], [TotalSpentMoney], [SecurityBankCode], [BDepartmentID]) VALUES (126, 478003, N'C432423', 1)
GO
INSERT [dbo].[BUYING_EMPLOYEE] ([BEmployeeID], [TotalSpentMoney], [SecurityBankCode], [BDepartmentID]) VALUES (133, 54744, N'C4324235', 1)
GO
INSERT [dbo].[BUYING_EMPLOYEE] ([BEmployeeID], [TotalSpentMoney], [SecurityBankCode], [BDepartmentID]) VALUES (140, 47800, N'C432423', 1)
GO
INSERT [dbo].[CALL_CENTER_DEPARTMENT] ([CDepartmentID], [NumberOfCostumersSpoken], [NumberOfSolvingProblem]) VALUES (3, 3210, 1800)
GO
INSERT [dbo].[CALL_CENTER_EMPLOYEE] ([CEmployeeID], [DeskNumber], [DeskPhoneNumber], [NumberOfSpeakingPeoples], [CDepartmentID]) VALUES (116, N'45', N'2122299905', 750, 3)
GO
INSERT [dbo].[CALL_CENTER_EMPLOYEE] ([CEmployeeID], [DeskNumber], [DeskPhoneNumber], [NumberOfSpeakingPeoples], [CDepartmentID]) VALUES (117, N'76', N'2122299901', 450, 3)
GO
INSERT [dbo].[CALL_CENTER_EMPLOYEE_FOREIGN] ([FCEmployeeID], [ListeningCountries]) VALUES (117, N'South Africa, France')
GO
INSERT [dbo].[CALL_CENTER_EMPLOYEE_NATIONAL] ([NCEmployeeID], [NumberOfInternalComplaints], [ListeningRegion]) VALUES (116, 75, N'Akdeniz, Anadolu')
GO
SET IDENTITY_INSERT [dbo].[CONTRACT_BROKER] ON 
GO
INSERT [dbo].[CONTRACT_BROKER] ([ContractID], [ContractTopic], [ContrantDate], [DeadLine], [BSEmployeeID]) VALUES (100, N'Selling shirt from france with 15 comission ..........', N'2015', N'2020', 124)
GO
INSERT [dbo].[CONTRACT_BROKER] ([ContractID], [ContractTopic], [ContrantDate], [DeadLine], [BSEmployeeID]) VALUES (101, N'Selling shirts from marmara', N'2014', N'2021', 123)
GO
SET IDENTITY_INSERT [dbo].[CONTRACT_BROKER] OFF
GO
SET IDENTITY_INSERT [dbo].[COSTUMER] ON 
GO
INSERT [dbo].[COSTUMER] ([CostumerID], [CostumerName], [CostumerPhone], [DSEmployeeID]) VALUES (100, N'melih', N'05075261075', 100)
GO
INSERT [dbo].[COSTUMER] ([CostumerID], [CostumerName], [CostumerPhone], [DSEmployeeID]) VALUES (101, N'Hakkı', N'05085461810', 100)
GO
INSERT [dbo].[COSTUMER] ([CostumerID], [CostumerName], [CostumerPhone], [DSEmployeeID]) VALUES (102, N'Metin', N'50821312132', 120)
GO
INSERT [dbo].[COSTUMER] ([CostumerID], [CostumerName], [CostumerPhone], [DSEmployeeID]) VALUES (103, N'bulut', N'50656543453', 121)
GO
INSERT [dbo].[COSTUMER] ([CostumerID], [CostumerName], [CostumerPhone], [DSEmployeeID]) VALUES (104, N'recep', N'50564665456', 122)
GO
INSERT [dbo].[COSTUMER] ([CostumerID], [CostumerName], [CostumerPhone], [DSEmployeeID]) VALUES (105, N'hakkı', N'50323423423', 121)
GO
INSERT [dbo].[COSTUMER] ([CostumerID], [CostumerName], [CostumerPhone], [DSEmployeeID]) VALUES (106, N'Kader', N'54093534453', 120)
GO
INSERT [dbo].[COSTUMER] ([CostumerID], [CostumerName], [CostumerPhone], [DSEmployeeID]) VALUES (107, N'Mehmet', N'50532423442', 122)
GO
INSERT [dbo].[COSTUMER] ([CostumerID], [CostumerName], [CostumerPhone], [DSEmployeeID]) VALUES (108, N'Melike', N'55675634244', 120)
GO
INSERT [dbo].[COSTUMER] ([CostumerID], [CostumerName], [CostumerPhone], [DSEmployeeID]) VALUES (109, N'Varol', N'50832424322', 121)
GO
INSERT [dbo].[COSTUMER] ([CostumerID], [CostumerName], [CostumerPhone], [DSEmployeeID]) VALUES (110, N'Ömer', N'50942423423', 120)
GO
INSERT [dbo].[COSTUMER] ([CostumerID], [CostumerName], [CostumerPhone], [DSEmployeeID]) VALUES (111, N'Faruk', N'50832423424', 121)
GO
SET IDENTITY_INSERT [dbo].[COSTUMER] OFF
GO
SET IDENTITY_INSERT [dbo].[DEPARTMENT] ON 
GO
INSERT [dbo].[DEPARTMENT] ([DepartmentID], [AnnualCost], [NumberOfEmployee], [StartWorkTime], [EndWorkTime], [NumberOfAnnualLeave]) VALUES (0, 150000, 10, N'9.30      ', N'18.00     ', N'25 ')
GO
INSERT [dbo].[DEPARTMENT] ([DepartmentID], [AnnualCost], [NumberOfEmployee], [StartWorkTime], [EndWorkTime], [NumberOfAnnualLeave]) VALUES (1, 29000000, 7, N'9.30      ', N'18.00     ', N'30 ')
GO
INSERT [dbo].[DEPARTMENT] ([DepartmentID], [AnnualCost], [NumberOfEmployee], [StartWorkTime], [EndWorkTime], [NumberOfAnnualLeave]) VALUES (2, 900000, 16, N'8.00      ', N'18.00     ', N'20 ')
GO
INSERT [dbo].[DEPARTMENT] ([DepartmentID], [AnnualCost], [NumberOfEmployee], [StartWorkTime], [EndWorkTime], [NumberOfAnnualLeave]) VALUES (3, 50000, 2, N'8.00      ', N'18.30     ', N'15 ')
GO
INSERT [dbo].[DEPARTMENT] ([DepartmentID], [AnnualCost], [NumberOfEmployee], [StartWorkTime], [EndWorkTime], [NumberOfAnnualLeave]) VALUES (4, 70000, 5, N'8.00      ', N'18.30     ', N'15 ')
GO
SET IDENTITY_INSERT [dbo].[DEPARTMENT] OFF
GO
INSERT [dbo].[DOMESTIC_SALESPERSON] ([DSEmployeeID], [WorkingRegion]) VALUES (100, N'Marmara')
GO
INSERT [dbo].[DOMESTIC_SALESPERSON] ([DSEmployeeID], [WorkingRegion]) VALUES (120, N'Anadolu')
GO
INSERT [dbo].[DOMESTIC_SALESPERSON] ([DSEmployeeID], [WorkingRegion]) VALUES (121, N'Marmara')
GO
INSERT [dbo].[DOMESTIC_SALESPERSON] ([DSEmployeeID], [WorkingRegion]) VALUES (122, N'Ege')
GO
SET IDENTITY_INSERT [dbo].[EMPLOYEE] ON 
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (100, N'Atakan', N'Yılmaz', 1980, N'05075431897', N'istanbul,eminönü,yeşildirek,no 90', 2005, N'Department', 3000)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (101, N'Varol', N'koç', 1990, N'5317435758', N'istanbul, fatih no 78', 2010, N'Department', 5000)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (102, N'Ömer', N'Faruk', 1990, N'5431232132', N'istanbul fatih no 89', 2011, N'Department', 5000)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (103, N'Mert', N'Egi', 1991, N'5345435345', N'istanbul , avcılar , gürün sokak no 76', 2013, N'Department', 5000)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (104, N'Yasin', N'Yılmaz', 1990, N'5435345345', N'istanbul, etiler , no 89', 2010, N'Department', 5500)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (105, N'İbrahim', N'özdemir', 1980, N'5767786745', N'istanbul , beylikdüzü , no 76', 2005, N'Department', 4500)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (107, N'Mehmet', N'Soyacı', 1980, N'5076541345', N'istanbul , fatih , no 45', 2003, N'Department', 5800)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (109, N'Kemal', N'Nergiz', 1980, N'5045691239', N'istanbul , sariyer, no 56', 2007, N'Department', 5200)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (110, N'Faruk', N'bilgehan', 1990, N'5047672331', N'istanbul , laleli , no 45', 2009, N'Department', 4500)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (111, N'Celil', N'soy', 1980, N'5049821313', N'istanbul , beylikdüzü no 65', 2003, N'Department', 4900)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (112, N'Mehmet', N'Kemal', 1988, N'5023945786', N'istanbul , avcılar no 45', 2005, N'Department', 5900)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (113, N'Kemal', N'Deva ', 1981, N'5098436675', N'istanbul , etiler no 45', 2006, N'Department', 4500)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (114, N'Mehmet', N'sarı', 1984, N'5049879865', N'istanbul , bağcılar', 2007, N'he/she quit!!!', 0)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (116, N'Mina', N'Küçük', 1968, N'5075261017', N'istanbul , çatalca no 78', 2001, N'Department', 5900)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (117, N'Hakan', N'özder', 1970, N'5086345776', N'istanbul , höyük , no 56', 2008, N'Department', 6500)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (118, N'Zülel', N'sarı', 1980, N'5049784584', N'istanbul , sariyer , no 45', 2010, N'Department', 4900)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (119, N'zehra', N'kaya', 1988, N'5099834298', N'istanbul , fatih , no 56', 2011, N'Department', 3800)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (120, N'İbrahim ', N'bayar', 1992, N'5099834928', N'istanbul , fatih , no 65', 2015, N'Department', 2800)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (121, N'Hikmet', N'söylemez', 1994, N'5354535435', N'istanbul , laleli , no 56', 2017, N'Department', 2600)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (122, N'Beyza', N'kaya', 1992, N'5433424324', N'istanbul , fatih no 65', 2015, N'Department', 3100)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (123, N'Hakan', N'bilmiş', 1994, N'5675435353', N'istanbul , sariyer ,no453', 2014, N'Department', 3400)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (124, N'Bilal', N'Konar', 1989, N'5324234244', N'istanbul , avcılar ,no 55', 2009, N'Department', 3600)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (125, N'Ramiz', N'Karaeski', 1960, N'5045231231', N'istanbul , sefiri sokak no 100', 2000, N'mekanın sahibi', 20000)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (126, N'Beyza', N'Durmuş', 1992, N'5094953435', N'istanbul , sefaköy no 54', 2002, N'Cleaner ', 3500)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (127, N'Mehmet', N'Faruk', 1985, N'5032432422', N'istanbul , sefaköy no 54', 2005, N'Security', 3700)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (128, N'Yasin', N'Tufan', 2000, N'5098931231', N'istanbul , sariyer no 76', 2018, N'Intern', 450)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (130, N'mert', N'eği', 1996, N'893264736', N'hacılar', 2010, N'software', 10000)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (131, N'halil', N'inalcık', 1927, N'5395396767', N'beyoğlu', 2010, N'yazar', 7000)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (132, N'ilber', N'ortaylı', 1957, N'5393934953', N'eminönü', 0, N'yazar', 20000)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (133, N'Einstain', N'albert', 1880, N'5929449329', N'duseldorf', 0, N'Physics', 20000)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (137, N'zeynep', N'albert', 1888, N'5929449343', N'duseldorf', 2012, N'teacher', 7000)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (138, N'yalçın', N'eği', 1984, N'5379347474', N'sedefsaray', 2012, N'production', 7000)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (139, N'Kemal', N'yılmaz', 1983, N'5045691352', N'istanbul , sariyer, no 56', 2007, N'Department', 6000)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (140, N'zehra', N'baktır', 1989, N'5099834765', N'istanbul , fatih , no 56', 2018, N'Department', 4800)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (141, N'Bilal', N'sonses', 1998, N'5324256789', N'istanbul , avcılar ,no 79', 2009, N'Department', 6000)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (142, N'İbrahim', N'yılmaz', 1956, N'5767937545', N'istanbul , beylikdüzü , no 76', 2005, N'Department', 8000)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (143, N'Mina', N'yılmaz', 2014, N'5075261017', N'istanbul , çatalca no 123', 2012, N'Department', 1000)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (144, N'Hakan', N'deniz', 1989, N'56754310000', N'istanbul , sariyer ,no453', 2014, N'Department', 2700)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (145, N'Celil', N'mete', 1989, N'5049821643', N'istanbul , beylikdüzü no 65', 2003, N'Department', 5500)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (146, N'ezel', N'eyşan', 2005, N'6784563912', N'ATV', 2005, N'Department', 20000)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (147, N'Mehmet', N'soykan', 1997, N'5076541345', N'üsküdar', 2015, N'Department', 5800)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (148, N'Mert', N'deniz', 1991, N'5345435345', N'istanbul , avcılar , gürün sokak no 76', 2013, N'Department', 7000)
GO
INSERT [dbo].[EMPLOYEE] ([EmployeeID], [EmployeeName], [EmployeeSurname], [DateOfBirth], [Telephone], [Adress], [DateOfHired], [WorkingArea], [salary]) VALUES (149, N'İbrahim', N'demir', 1980, N'5767786745', N' beylikdüzü , no 81', 2002, N'Department', 45000)
GO
SET IDENTITY_INSERT [dbo].[EMPLOYEE] OFF
GO
SET IDENTITY_INSERT [dbo].[EXPORTER_LICENCE] ON 
GO
INSERT [dbo].[EXPORTER_LICENCE] ([CertificateID], [CountryName], [OBSEmployee]) VALUES (100, N'France ', 124)
GO
SET IDENTITY_INSERT [dbo].[EXPORTER_LICENCE] OFF
GO
INSERT [dbo].[FACTORY_WORKER] ([FEmployeeID], [ProducedShirtsAmount], [NumberOfMakingManufacturingDefect], [PDepartmentID]) VALUES (101, 250, 12, 2)
GO
INSERT [dbo].[FACTORY_WORKER] ([FEmployeeID], [ProducedShirtsAmount], [NumberOfMakingManufacturingDefect], [PDepartmentID]) VALUES (102, 300, 18, 2)
GO
INSERT [dbo].[FACTORY_WORKER] ([FEmployeeID], [ProducedShirtsAmount], [NumberOfMakingManufacturingDefect], [PDepartmentID]) VALUES (103, 560, 67, 2)
GO
INSERT [dbo].[FACTORY_WORKER] ([FEmployeeID], [ProducedShirtsAmount], [NumberOfMakingManufacturingDefect], [PDepartmentID]) VALUES (104, 300, 32, 2)
GO
INSERT [dbo].[FACTORY_WORKER] ([FEmployeeID], [ProducedShirtsAmount], [NumberOfMakingManufacturingDefect], [PDepartmentID]) VALUES (105, 300, 23, 2)
GO
INSERT [dbo].[FACTORY_WORKER] ([FEmployeeID], [ProducedShirtsAmount], [NumberOfMakingManufacturingDefect], [PDepartmentID]) VALUES (107, 760, 34, 2)
GO
INSERT [dbo].[FACTORY_WORKER] ([FEmployeeID], [ProducedShirtsAmount], [NumberOfMakingManufacturingDefect], [PDepartmentID]) VALUES (109, 359, 25, 2)
GO
INSERT [dbo].[FACTORY_WORKER] ([FEmployeeID], [ProducedShirtsAmount], [NumberOfMakingManufacturingDefect], [PDepartmentID]) VALUES (110, 760, 55, 2)
GO
INSERT [dbo].[FACTORY_WORKER] ([FEmployeeID], [ProducedShirtsAmount], [NumberOfMakingManufacturingDefect], [PDepartmentID]) VALUES (111, 760, 55, 2)
GO
INSERT [dbo].[FACTORY_WORKER] ([FEmployeeID], [ProducedShirtsAmount], [NumberOfMakingManufacturingDefect], [PDepartmentID]) VALUES (118, 761, 55, 2)
GO
INSERT [dbo].[FACTORY_WORKER] ([FEmployeeID], [ProducedShirtsAmount], [NumberOfMakingManufacturingDefect], [PDepartmentID]) VALUES (125, 760, 55, 2)
GO
INSERT [dbo].[FACTORY_WORKER] ([FEmployeeID], [ProducedShirtsAmount], [NumberOfMakingManufacturingDefect], [PDepartmentID]) VALUES (131, 359, 253, 2)
GO
INSERT [dbo].[FACTORY_WORKER] ([FEmployeeID], [ProducedShirtsAmount], [NumberOfMakingManufacturingDefect], [PDepartmentID]) VALUES (144, 950, 700, 2)
GO
INSERT [dbo].[FACTORY_WORKER] ([FEmployeeID], [ProducedShirtsAmount], [NumberOfMakingManufacturingDefect], [PDepartmentID]) VALUES (146, 700, 120, 2)
GO
INSERT [dbo].[FACTORY_WORKER] ([FEmployeeID], [ProducedShirtsAmount], [NumberOfMakingManufacturingDefect], [PDepartmentID]) VALUES (148, 350, 27, 2)
GO
INSERT [dbo].[FACTORY_WORKER] ([FEmployeeID], [ProducedShirtsAmount], [NumberOfMakingManufacturingDefect], [PDepartmentID]) VALUES (149, 600, 28, 2)
GO
SET IDENTITY_INSERT [dbo].[FOREIGN_COSTUMER] ON 
GO
INSERT [dbo].[FOREIGN_COSTUMER] ([FCostumerID], [CostumerName], [CostumerPhone], [Zipcode], [CostumerLanguage], [Country], [OSEmployeeID]) VALUES (100, N'malaz', N'97182442312', N'67000', N'french', N'France', 118)
GO
INSERT [dbo].[FOREIGN_COSTUMER] ([FCostumerID], [CostumerName], [CostumerPhone], [Zipcode], [CostumerLanguage], [Country], [OSEmployeeID]) VALUES (101, N'Daniel', N'49545112312', N'68159', N'german', N'germany', 119)
GO
INSERT [dbo].[FOREIGN_COSTUMER] ([FCostumerID], [CostumerName], [CostumerPhone], [Zipcode], [CostumerLanguage], [Country], [OSEmployeeID]) VALUES (102, N'Sancez', N'39213123321', N'76700', N'english', N'Italy', 125)
GO
INSERT [dbo].[FOREIGN_COSTUMER] ([FCostumerID], [CostumerName], [CostumerPhone], [Zipcode], [CostumerLanguage], [Country], [OSEmployeeID]) VALUES (103, N'Hana', N'97121313131', N'67000', N'french', N'France', 118)
GO
INSERT [dbo].[FOREIGN_COSTUMER] ([FCostumerID], [CostumerName], [CostumerPhone], [Zipcode], [CostumerLanguage], [Country], [OSEmployeeID]) VALUES (104, N'Shima', N'49883787234', N'68150', N'german', N'Germany', 119)
GO
SET IDENTITY_INSERT [dbo].[FOREIGN_COSTUMER] OFF
GO
SET IDENTITY_INSERT [dbo].[FOREIGN_LANGUAGE_CERTIFICATE] ON 
GO
INSERT [dbo].[FOREIGN_LANGUAGE_CERTIFICATE] ([LicenceID], [LanguageName], [FCEmployeeID]) VALUES (100, N'France', 117)
GO
SET IDENTITY_INSERT [dbo].[FOREIGN_LANGUAGE_CERTIFICATE] OFF
GO
INSERT [dbo].[OVERSEAS_SALESPERSON] ([OSEmployeeID], [WorkingCountriesNames]) VALUES (118, N'France')
GO
INSERT [dbo].[OVERSEAS_SALESPERSON] ([OSEmployeeID], [WorkingCountriesNames]) VALUES (119, N'Germany')
GO
INSERT [dbo].[OVERSEAS_SALESPERSON] ([OSEmployeeID], [WorkingCountriesNames]) VALUES (125, N'Italy')
GO
INSERT [dbo].[PRODUCTION_DEPARTMENT] ([PDepartmentID], [AmountOfProducedPlainShirts], [AmountOfProducedPatternedShirts], [NumberOfMakingManufacturingDefect], [ErrorRateInManufacturedShirts]) VALUES (2, 7200000, 500000, 1500, 2)
GO
INSERT [dbo].[SALES_DEPARTMENT] ([SDepartmentID], [SalesAmount], [TotalProfit], [NumberOfTotalCostumer]) VALUES (0, 75950000, 2970000, 37)
GO
INSERT [dbo].[SALESPERSON] ([SEmployeeID], [SalesAmount], [TotalProfit], [NumberOfCostumer], [SDepartmentID]) VALUES (100, 80000, 15000, 10, 0)
GO
INSERT [dbo].[SALESPERSON] ([SEmployeeID], [SalesAmount], [TotalProfit], [NumberOfCostumer], [SDepartmentID]) VALUES (118, 75000, 14000, 10, 0)
GO
INSERT [dbo].[SALESPERSON] ([SEmployeeID], [SalesAmount], [TotalProfit], [NumberOfCostumer], [SDepartmentID]) VALUES (119, 90000, 17000, 15, 0)
GO
INSERT [dbo].[SALESPERSON] ([SEmployeeID], [SalesAmount], [TotalProfit], [NumberOfCostumer], [SDepartmentID]) VALUES (120, 100000, 21000, 23, 0)
GO
INSERT [dbo].[SALESPERSON] ([SEmployeeID], [SalesAmount], [TotalProfit], [NumberOfCostumer], [SDepartmentID]) VALUES (121, 60000, 13000, 9, 0)
GO
INSERT [dbo].[SALESPERSON] ([SEmployeeID], [SalesAmount], [TotalProfit], [NumberOfCostumer], [SDepartmentID]) VALUES (122, 45000, 12000, 7, 0)
GO
INSERT [dbo].[SALESPERSON] ([SEmployeeID], [SalesAmount], [TotalProfit], [NumberOfCostumer], [SDepartmentID]) VALUES (123, 75000, 19000, 8, 0)
GO
INSERT [dbo].[SALESPERSON] ([SEmployeeID], [SalesAmount], [TotalProfit], [NumberOfCostumer], [SDepartmentID]) VALUES (124, 40000, 10000, 12, 0)
GO
INSERT [dbo].[SALESPERSON] ([SEmployeeID], [SalesAmount], [TotalProfit], [NumberOfCostumer], [SDepartmentID]) VALUES (125, 100000, 20500, 19, 0)
GO
INSERT [dbo].[SALESPERSON] ([SEmployeeID], [SalesAmount], [TotalProfit], [NumberOfCostumer], [SDepartmentID]) VALUES (126, 190003, 8, 750003, 0)
GO
SET IDENTITY_INSERT [dbo].[SUPPLIER] ON 
GO
INSERT [dbo].[SUPPLIER] ([SupplierID], [SupplierName], [SupplierPhone], [SupplierAdress]) VALUES (102, N'Hakan', N'5075261018', N'Bursa merkez halıcılar karşışı no 56')
GO
INSERT [dbo].[SUPPLIER] ([SupplierID], [SupplierName], [SupplierPhone], [SupplierAdress]) VALUES (104, N'MEHMET', N'5304561012', N'ANTALYA MERKES , YEŞİLDİREK NO 322')
GO
INSERT [dbo].[SUPPLIER] ([SupplierID], [SupplierName], [SupplierPhone], [SupplierAdress]) VALUES (105, N'HAKKI', N'5075231017', N'KAYSERİ,ZARA,KİRAZLİ NO 45')
GO
INSERT [dbo].[SUPPLIER] ([SupplierID], [SupplierName], [SupplierPhone], [SupplierAdress]) VALUES (106, N'Rasim', N'5054551213', N'Istanbul,fatih,laleli no 67')
GO
INSERT [dbo].[SUPPLIER] ([SupplierID], [SupplierName], [SupplierPhone], [SupplierAdress]) VALUES (107, N'RIZA', N'5025263245', N'Istanbul,eminönü,gürün han no 45')
GO
INSERT [dbo].[SUPPLIER] ([SupplierID], [SupplierName], [SupplierPhone], [SupplierAdress]) VALUES (108, N'Ali', N'5045321765', N'Adana,yayla,ihlamur sokak no 45')
GO
SET IDENTITY_INSERT [dbo].[SUPPLIER] OFF
GO
INSERT [dbo].[TRANSPORTATION_DEPARTMENT] ([TDepartmentID], [NumberOfAirlineDelivery], [NumberOfHighwayDelivery], [NumberOfSeawayDelivery]) VALUES (4, 240, 125, 180)
GO
INSERT [dbo].[TRANSPORTATION_EMPLOYEE] ([TEmployeeID], [TransportationCode], [TDepartmentID]) VALUES (109, N'A13E', 4)
GO
INSERT [dbo].[TRANSPORTATION_EMPLOYEE] ([TEmployeeID], [TransportationCode], [TDepartmentID]) VALUES (110, N'A16D', 4)
GO
INSERT [dbo].[TRANSPORTATION_EMPLOYEE] ([TEmployeeID], [TransportationCode], [TDepartmentID]) VALUES (111, N'A20C', 4)
GO
INSERT [dbo].[TRANSPORTATION_EMPLOYEE] ([TEmployeeID], [TransportationCode], [TDepartmentID]) VALUES (137, N'A35C', 4)
GO
INSERT [dbo].[TRANSPORTATION_EMPLOYEE] ([TEmployeeID], [TransportationCode], [TDepartmentID]) VALUES (142, N'A35C', 4)
GO
ALTER TABLE [dbo].[BROKER_SALESPERSON]  WITH CHECK ADD  CONSTRAINT [BROKER_SALESPERSON_FK] FOREIGN KEY([BSEmployeeID])
REFERENCES [dbo].[SALESPERSON] ([SEmployeeID])
GO
ALTER TABLE [dbo].[BROKER_SALESPERSON] CHECK CONSTRAINT [BROKER_SALESPERSON_FK]
GO
ALTER TABLE [dbo].[BROKER_SALESPERSON_DOMESTIC]  WITH CHECK ADD  CONSTRAINT [BROKER_SALESPERSON_DOMESTIC_FK] FOREIGN KEY([DBSEmployee])
REFERENCES [dbo].[BROKER_SALESPERSON] ([BSEmployeeID])
GO
ALTER TABLE [dbo].[BROKER_SALESPERSON_DOMESTIC] CHECK CONSTRAINT [BROKER_SALESPERSON_DOMESTIC_FK]
GO
ALTER TABLE [dbo].[BROKER_SALESPERSON_OVERSEAS]  WITH CHECK ADD  CONSTRAINT [BROKER_SALESPERSON_OVERSEAS_FK] FOREIGN KEY([OBSEmployee])
REFERENCES [dbo].[BROKER_SALESPERSON] ([BSEmployeeID])
GO
ALTER TABLE [dbo].[BROKER_SALESPERSON_OVERSEAS] CHECK CONSTRAINT [BROKER_SALESPERSON_OVERSEAS_FK]
GO
ALTER TABLE [dbo].[BUYING]  WITH CHECK ADD  CONSTRAINT [BUYING_FK1] FOREIGN KEY([BEmployeeID])
REFERENCES [dbo].[BUYING_EMPLOYEE] ([BEmployeeID])
GO
ALTER TABLE [dbo].[BUYING] CHECK CONSTRAINT [BUYING_FK1]
GO
ALTER TABLE [dbo].[BUYING]  WITH CHECK ADD  CONSTRAINT [BUYING_FK2] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[SUPPLIER] ([SupplierID])
GO
ALTER TABLE [dbo].[BUYING] CHECK CONSTRAINT [BUYING_FK2]
GO
ALTER TABLE [dbo].[BUYING_DEPARTMENT]  WITH CHECK ADD  CONSTRAINT [BUYING_DEPARTMENT_FK] FOREIGN KEY([BDepartmentID])
REFERENCES [dbo].[DEPARTMENT] ([DepartmentID])
GO
ALTER TABLE [dbo].[BUYING_DEPARTMENT] CHECK CONSTRAINT [BUYING_DEPARTMENT_FK]
GO
ALTER TABLE [dbo].[BUYING_EMPLOYEE]  WITH CHECK ADD  CONSTRAINT [BUYING_EMPLOYEE_FK1] FOREIGN KEY([BEmployeeID])
REFERENCES [dbo].[EMPLOYEE] ([EmployeeID])
GO
ALTER TABLE [dbo].[BUYING_EMPLOYEE] CHECK CONSTRAINT [BUYING_EMPLOYEE_FK1]
GO
ALTER TABLE [dbo].[BUYING_EMPLOYEE]  WITH CHECK ADD  CONSTRAINT [BUYING_EMPLOYEE_FK2] FOREIGN KEY([BDepartmentID])
REFERENCES [dbo].[BUYING_DEPARTMENT] ([BDepartmentID])
GO
ALTER TABLE [dbo].[BUYING_EMPLOYEE] CHECK CONSTRAINT [BUYING_EMPLOYEE_FK2]
GO
ALTER TABLE [dbo].[CALL_CENTER_DEPARTMENT]  WITH CHECK ADD  CONSTRAINT [CALL_CENTER_DEPARTMENT_FK] FOREIGN KEY([CDepartmentID])
REFERENCES [dbo].[DEPARTMENT] ([DepartmentID])
GO
ALTER TABLE [dbo].[CALL_CENTER_DEPARTMENT] CHECK CONSTRAINT [CALL_CENTER_DEPARTMENT_FK]
GO
ALTER TABLE [dbo].[CALL_CENTER_EMPLOYEE]  WITH CHECK ADD  CONSTRAINT [CALL_CENTER_EMPLOYEE_FK1] FOREIGN KEY([CEmployeeID])
REFERENCES [dbo].[EMPLOYEE] ([EmployeeID])
GO
ALTER TABLE [dbo].[CALL_CENTER_EMPLOYEE] CHECK CONSTRAINT [CALL_CENTER_EMPLOYEE_FK1]
GO
ALTER TABLE [dbo].[CALL_CENTER_EMPLOYEE]  WITH CHECK ADD  CONSTRAINT [CALL_CENTER_EMPLOYEE_FK2] FOREIGN KEY([CDepartmentID])
REFERENCES [dbo].[CALL_CENTER_DEPARTMENT] ([CDepartmentID])
GO
ALTER TABLE [dbo].[CALL_CENTER_EMPLOYEE] CHECK CONSTRAINT [CALL_CENTER_EMPLOYEE_FK2]
GO
ALTER TABLE [dbo].[CALL_CENTER_EMPLOYEE_FOREIGN]  WITH CHECK ADD  CONSTRAINT [CALL_CENTER_EMPLOYEE_FOREIGN_FK] FOREIGN KEY([FCEmployeeID])
REFERENCES [dbo].[CALL_CENTER_EMPLOYEE] ([CEmployeeID])
GO
ALTER TABLE [dbo].[CALL_CENTER_EMPLOYEE_FOREIGN] CHECK CONSTRAINT [CALL_CENTER_EMPLOYEE_FOREIGN_FK]
GO
ALTER TABLE [dbo].[CALL_CENTER_EMPLOYEE_NATIONAL]  WITH CHECK ADD  CONSTRAINT [CALL_CENTER_EMPLOYEE_NATIONAL_FK] FOREIGN KEY([NCEmployeeID])
REFERENCES [dbo].[CALL_CENTER_EMPLOYEE] ([CEmployeeID])
GO
ALTER TABLE [dbo].[CALL_CENTER_EMPLOYEE_NATIONAL] CHECK CONSTRAINT [CALL_CENTER_EMPLOYEE_NATIONAL_FK]
GO
ALTER TABLE [dbo].[CONTRACT_BROKER]  WITH CHECK ADD  CONSTRAINT [CONTRACT_BROKER_FK] FOREIGN KEY([BSEmployeeID])
REFERENCES [dbo].[BROKER_SALESPERSON] ([BSEmployeeID])
GO
ALTER TABLE [dbo].[CONTRACT_BROKER] CHECK CONSTRAINT [CONTRACT_BROKER_FK]
GO
ALTER TABLE [dbo].[COSTUMER]  WITH CHECK ADD  CONSTRAINT [COSTUMER_FK] FOREIGN KEY([DSEmployeeID])
REFERENCES [dbo].[DOMESTIC_SALESPERSON] ([DSEmployeeID])
GO
ALTER TABLE [dbo].[COSTUMER] CHECK CONSTRAINT [COSTUMER_FK]
GO
ALTER TABLE [dbo].[DOMESTIC_SALESPERSON]  WITH CHECK ADD  CONSTRAINT [DOMESTIC_SALESPERSON_FK] FOREIGN KEY([DSEmployeeID])
REFERENCES [dbo].[SALESPERSON] ([SEmployeeID])
GO
ALTER TABLE [dbo].[DOMESTIC_SALESPERSON] CHECK CONSTRAINT [DOMESTIC_SALESPERSON_FK]
GO
ALTER TABLE [dbo].[EXPORTER_LICENCE]  WITH CHECK ADD  CONSTRAINT [EXPORTER_LICENCE_FK] FOREIGN KEY([OBSEmployee])
REFERENCES [dbo].[BROKER_SALESPERSON_OVERSEAS] ([OBSEmployee])
GO
ALTER TABLE [dbo].[EXPORTER_LICENCE] CHECK CONSTRAINT [EXPORTER_LICENCE_FK]
GO
ALTER TABLE [dbo].[FACTORY_WORKER]  WITH CHECK ADD  CONSTRAINT [FACTORY_WORKER_FK1] FOREIGN KEY([FEmployeeID])
REFERENCES [dbo].[EMPLOYEE] ([EmployeeID])
GO
ALTER TABLE [dbo].[FACTORY_WORKER] CHECK CONSTRAINT [FACTORY_WORKER_FK1]
GO
ALTER TABLE [dbo].[FACTORY_WORKER]  WITH CHECK ADD  CONSTRAINT [FACTORY_WORKER_FK2] FOREIGN KEY([PDepartmentID])
REFERENCES [dbo].[PRODUCTION_DEPARTMENT] ([PDepartmentID])
GO
ALTER TABLE [dbo].[FACTORY_WORKER] CHECK CONSTRAINT [FACTORY_WORKER_FK2]
GO
ALTER TABLE [dbo].[FOREIGN_COSTUMER]  WITH CHECK ADD  CONSTRAINT [FOREIGN_COSTUMER_FK] FOREIGN KEY([OSEmployeeID])
REFERENCES [dbo].[OVERSEAS_SALESPERSON] ([OSEmployeeID])
GO
ALTER TABLE [dbo].[FOREIGN_COSTUMER] CHECK CONSTRAINT [FOREIGN_COSTUMER_FK]
GO
ALTER TABLE [dbo].[FOREIGN_LANGUAGE_CERTIFICATE]  WITH CHECK ADD  CONSTRAINT [FOREIGN_LANGUAGE_CERTIFICATE_FK] FOREIGN KEY([FCEmployeeID])
REFERENCES [dbo].[CALL_CENTER_EMPLOYEE_FOREIGN] ([FCEmployeeID])
GO
ALTER TABLE [dbo].[FOREIGN_LANGUAGE_CERTIFICATE] CHECK CONSTRAINT [FOREIGN_LANGUAGE_CERTIFICATE_FK]
GO
ALTER TABLE [dbo].[OVERSEAS_SALESPERSON]  WITH CHECK ADD  CONSTRAINT [OVERSEAS_SALESPERSON_FK] FOREIGN KEY([OSEmployeeID])
REFERENCES [dbo].[SALESPERSON] ([SEmployeeID])
GO
ALTER TABLE [dbo].[OVERSEAS_SALESPERSON] CHECK CONSTRAINT [OVERSEAS_SALESPERSON_FK]
GO
ALTER TABLE [dbo].[PRODUCTION_DEPARTMENT]  WITH CHECK ADD  CONSTRAINT [PRODUCTION_DEPARTMENT_FK] FOREIGN KEY([PDepartmentID])
REFERENCES [dbo].[DEPARTMENT] ([DepartmentID])
GO
ALTER TABLE [dbo].[PRODUCTION_DEPARTMENT] CHECK CONSTRAINT [PRODUCTION_DEPARTMENT_FK]
GO
ALTER TABLE [dbo].[SALES_DEPARTMENT]  WITH CHECK ADD  CONSTRAINT [SALES_DEPARTMENT_FK] FOREIGN KEY([SDepartmentID])
REFERENCES [dbo].[DEPARTMENT] ([DepartmentID])
GO
ALTER TABLE [dbo].[SALES_DEPARTMENT] CHECK CONSTRAINT [SALES_DEPARTMENT_FK]
GO
ALTER TABLE [dbo].[SALESPERSON]  WITH CHECK ADD  CONSTRAINT [SALESPERSON_FK1] FOREIGN KEY([SEmployeeID])
REFERENCES [dbo].[EMPLOYEE] ([EmployeeID])
GO
ALTER TABLE [dbo].[SALESPERSON] CHECK CONSTRAINT [SALESPERSON_FK1]
GO
ALTER TABLE [dbo].[SALESPERSON]  WITH CHECK ADD  CONSTRAINT [SALESPERSON_FK2] FOREIGN KEY([SDepartmentID])
REFERENCES [dbo].[SALES_DEPARTMENT] ([SDepartmentID])
GO
ALTER TABLE [dbo].[SALESPERSON] CHECK CONSTRAINT [SALESPERSON_FK2]
GO
ALTER TABLE [dbo].[TRANSPORTATION_DEPARTMENT]  WITH CHECK ADD  CONSTRAINT [TRANSPORTATION_DEPARTMENT_FK] FOREIGN KEY([TDepartmentID])
REFERENCES [dbo].[DEPARTMENT] ([DepartmentID])
GO
ALTER TABLE [dbo].[TRANSPORTATION_DEPARTMENT] CHECK CONSTRAINT [TRANSPORTATION_DEPARTMENT_FK]
GO
ALTER TABLE [dbo].[TRANSPORTATION_EMPLOYEE]  WITH CHECK ADD  CONSTRAINT [TRANSPORTATION_EMPLOYEE_FK1] FOREIGN KEY([TEmployeeID])
REFERENCES [dbo].[EMPLOYEE] ([EmployeeID])
GO
ALTER TABLE [dbo].[TRANSPORTATION_EMPLOYEE] CHECK CONSTRAINT [TRANSPORTATION_EMPLOYEE_FK1]
GO
ALTER TABLE [dbo].[TRANSPORTATION_EMPLOYEE]  WITH CHECK ADD  CONSTRAINT [TRANSPORTATION_EMPLOYEE_FK2] FOREIGN KEY([TDepartmentID])
REFERENCES [dbo].[TRANSPORTATION_DEPARTMENT] ([TDepartmentID])
GO
ALTER TABLE [dbo].[TRANSPORTATION_EMPLOYEE] CHECK CONSTRAINT [TRANSPORTATION_EMPLOYEE_FK2]
GO
/****** Object:  StoredProcedure [dbo].[sp_Insert_CERTIFICATE]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Proc [dbo].[sp_Insert_CERTIFICATE]
(
@LanguageName nvarchar(10),
@FCEmployeeID int
)
AS
BEGIN
   insert into FOREIGN_LANGUAGE_CERTIFICATE(LanguageName, FCEmployeeID )
   values (@LanguageName , @FCEmployeeID)

end
GO
/****** Object:  StoredProcedure [dbo].[sp_supplier]    Script Date: 12/24/2019 9:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[sp_supplier]
(
@SupplierName nvarchar(10),
@SupplierPhone nvarchar(13),
@SupplierAdress nvarchar(50)
)
AS
BEGIN
        Insert into SUPPLIER(SupplierName,SupplierPhone,SupplierAdress)
        Values( @SupplierName  , @SupplierPhone ,@SupplierAdress )
end
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
         Begin Table = "EMPLOYEE"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 232
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "BUYING_EMPLOYEE"
            Begin Extent = 
               Top = 6
               Left = 499
               Bottom = 136
               Right = 684
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_BuyingEmployee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_BuyingEmployee'
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
         Begin Table = "EMPLOYEE"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 232
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "CALL_CENTER_EMPLOYEE"
            Begin Extent = 
               Top = 6
               Left = 270
               Bottom = 136
               Right = 505
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "CALL_CENTER_EMPLOYEE_FOREIGN"
            Begin Extent = 
               Top = 6
               Left = 543
               Bottom = 102
               Right = 731
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FOREIGN_LANGUAGE_CERTIFICATE"
            Begin Extent = 
               Top = 6
               Left = 769
               Bottom = 119
               Right = 942
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Call_center_Foreign_Employee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Call_center_Foreign_Employee'
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
         Begin Table = "SALESPERSON"
            Begin Extent = 
               Top = 6
               Left = 300
               Bottom = 136
               Right = 498
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EMPLOYEE"
            Begin Extent = 
               Top = 6
               Left = 536
               Bottom = 136
               Right = 730
            End
            DisplayFlags = 280
            TopColumn = 7
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_SalesEmployee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_SalesEmployee'
GO
USE [master]
GO
ALTER DATABASE [business3] SET  READ_WRITE 
GO
