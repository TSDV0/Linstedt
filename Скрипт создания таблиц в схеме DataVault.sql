/** Скрипт создания таблиц в схеме DataVault по книге Linstedt */

USE [master]
GO
/****** Object:  Database [DataVault]    Script Date: 3/9/2015 4:25:44 PM ******/
CREATE DATABASE [DataVault]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DataVault', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\DataVault.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [ARCHIVE] 
( NAME = N'DataVault_archive', FILENAME = N'G:\DataVault_archive.ndf' , SIZE = 5120000KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%), 
 FILEGROUP [BUSINESS] 
( NAME = N'DataVault_business', FILENAME = N'D:\DataVault_business.ndf' , SIZE = 51200000KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024000KB ), 
 FILEGROUP [DATA] 
( NAME = N'DataVault_data', FILENAME = N'D:\DataVault_data.ndf' , SIZE = 153600000KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10240000KB ), 
 FILEGROUP [INDEX] 
( NAME = N'DataVault_index', FILENAME = N'F:\DataVault_index.ndf' , SIZE = 10240000KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'DataVault_log', FILENAME = N'E:\DataVault_log.ldf' , SIZE = 10240000KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [DataVault] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DataVault].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DataVault] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DataVault] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DataVault] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DataVault] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DataVault] SET ARITHABORT OFF 
GO
ALTER DATABASE [DataVault] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DataVault] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DataVault] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DataVault] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DataVault] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DataVault] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DataVault] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DataVault] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DataVault] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DataVault] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DataVault] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DataVault] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DataVault] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DataVault] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DataVault] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DataVault] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DataVault] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DataVault] SET RECOVERY FULL 
GO
ALTER DATABASE [DataVault] SET  MULTI_USER 
GO
ALTER DATABASE [DataVault] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DataVault] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DataVault] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DataVault] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [DataVault] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DataVault', N'ON'
GO
USE [DataVault]
GO
/****** Object:  User [log]    Script Date: 3/9/2015 4:25:44 PM ******/
CREATE USER [log] FOR LOGIN [log] WITH DEFAULT_SCHEMA=[log]
GO
ALTER ROLE [db_owner] ADD MEMBER [log]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [log]
GO
ALTER ROLE [db_datareader] ADD MEMBER [log]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [log]
GO
/****** Object:  Schema [biz]    Script Date: 3/9/2015 4:25:44 PM ******/
CREATE SCHEMA [biz]
GO
/****** Object:  Schema [log]    Script Date: 3/9/2015 4:25:44 PM ******/
CREATE SCHEMA [log]
GO
/****** Object:  Schema [raw]    Script Date: 3/9/2015 4:25:44 PM ******/
CREATE SCHEMA [raw]
GO
USE [DataVault]
GO
/****** Object:  Sequence [log].[TLinkEventNo]    Script Date: 3/9/2015 4:25:44 PM ******/
CREATE SEQUENCE [log].[TLinkEventNo] 
 AS [bigint]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO
/****** Object:  Table [biz].[LinkRecommendedFlight]    Script Date: 3/9/2015 4:25:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [biz].[LinkRecommendedFlight](
	[RecommendedFlightHashKey] [char](32) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
	[CarrierHashKey] [char](32) NOT NULL,
	[OriginHashKey] [char](32) NOT NULL,
	[DestHashKey] [char](32) NOT NULL
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [biz].[SALPerson]    Script Date: 3/9/2015 4:25:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [biz].[SALPerson](
	[SALPersonHashKey] [char](32) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
	[PersonMasterHashKey] [char](32) NOT NULL,
	[PersonDuplicateHashKey] [char](32) NOT NULL,
	[Score] [real] NOT NULL
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [biz].[SatCleansedPassenger]    Script Date: 3/9/2015 4:25:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [biz].[SatCleansedPassenger](
	[PersonHashKey] [varchar](32) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[LoadEndDate] [datetime2](7) NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
	[Sequence] [int] NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[LastName_Status] [nvarchar](100) NULL,
	[LastName_Confidence] [nvarchar](100) NULL,
	[LastName_Reason] [nvarchar](4000) NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[FirstName_Status] [nvarchar](100) NULL,
	[FirstName_Confidence] [nvarchar](100) NULL,
	[FirstName_Reason] [nvarchar](4000) NULL,
	[MiddleName] [nvarchar](50) NOT NULL,
	[MiddleName_Status] [nvarchar](100) NULL,
	[MiddleName_Confidence] [nvarchar](100) NULL,
	[MiddleName_Reason] [nvarchar](4000) NULL,
	[Suffix] [nvarchar](50) NULL,
	[Suffix_Status] [nvarchar](100) NULL,
	[Suffix_Confidence] [nvarchar](100) NULL,
	[Suffix_Reason] [nvarchar](4000) NULL,
	[DOB] [date] NULL,
	[DOB_Status] [nvarchar](100) NULL,
	[DOB_Confidence] [nvarchar](100) NULL,
	[DOB_Reason] [nvarchar](4000) NULL,
	[Sex] [varchar](1) NOT NULL,
	[Sex_Status] [nvarchar](100) NULL,
	[Sex_Confidence] [nvarchar](100) NULL,
	[Sex_Reason] [nvarchar](4000) NULL,
	[Record Status] [nvarchar](100) NULL,
	[Appended Data] [nvarchar](4000) NULL,
	[Appended Data Schema] [nvarchar](4000) NULL
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [log].[HubComputer]    Script Date: 3/9/2015 4:25:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [log].[HubComputer](
	[ComputerHashKey] [char](32) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[RecordSource] [varchar](50) NOT NULL,
	[computer] [varchar](128) NOT NULL
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [log].[HubEventType]    Script Date: 3/9/2015 4:25:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [log].[HubEventType](
	[EventTypeHashKey] [char](32) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[RecordSource] [varchar](50) NOT NULL,
	[event] [sysname] NOT NULL
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [log].[HubOperator]    Script Date: 3/9/2015 4:25:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [log].[HubOperator](
	[OperatorHashKey] [char](32) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[RecordSource] [varchar](50) NOT NULL,
	[operator] [varchar](128) NOT NULL
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [log].[HubSource]    Script Date: 3/9/2015 4:25:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [log].[HubSource](
	[SourceHashKey] [char](32) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[RecordSource] [varchar](50) NOT NULL,
	[sourceid] [uniqueidentifier] NOT NULL
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [log].[SatSource]    Script Date: 3/9/2015 4:25:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [log].[SatSource](
	[SourceHashKey] [char](32) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[LoadEndDate] [datetime2](7) NULL,
	[RecordSource] [varchar](50) NOT NULL,
	[source] [nvarchar](1024) NOT NULL
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [log].[TLinkEvent]    Script Date: 3/9/2015 4:25:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [log].[TLinkEvent](
	[EventHashKey] [char](32) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[RecordSource] [varchar](50) NOT NULL,
	[EventTypeHashKey] [char](32) NOT NULL,
	[ComputerHashKey] [char](32) NOT NULL,
	[OperatorHashKey] [char](32) NOT NULL,
	[SourceHashKey] [char](32) NOT NULL,
	[id] [bigint] NOT NULL,
	[executionid] [uniqueidentifier] NOT NULL,
	[starttime] [datetime] NOT NULL,
	[endtime] [datetime] NOT NULL,
	[datacode] [int] NOT NULL
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [log].[TSatDiagnosticExEvent]    Script Date: 3/9/2015 4:25:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [log].[TSatDiagnosticExEvent](
	[EventHashKey] [char](32) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[RecordSource] [varchar](50) NOT NULL,
	[message] [xml] NOT NULL
) ON [DATA] TEXTIMAGE_ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [log].[TSatEvent]    Script Date: 3/9/2015 4:25:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [log].[TSatEvent](
	[EventHashKey] [char](32) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[RecordSource] [varchar](50) NOT NULL,
	[databytes] [image] NULL,
	[message] [nvarchar](2048) NOT NULL
) ON [DATA] TEXTIMAGE_ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [log].[TSatOnPipelinePreComponentCallEvent]    Script Date: 3/9/2015 4:25:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [log].[TSatOnPipelinePreComponentCallEvent](
	[EventHashKey] [char](32) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[RecordSource] [varchar](50) NOT NULL,
	[message] [varchar](2048) NOT NULL,
	[recordcount] [int] NOT NULL,
	[component] [varchar](128) NOT NULL,
	[step] [varchar](128) NOT NULL
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [raw].[HubAirlineID]    Script Date: 3/9/2015 4:25:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [raw].[HubAirlineID](
	[AirlineIDHashKey] [char](32) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
	[AirlineID] [smallint] NULL
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [raw].[HubAirportCode]    Script Date: 3/9/2015 4:25:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [raw].[HubAirportCode](
	[AirportCodeHashKey] [char](32) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
	[AirportCode] [nvarchar](3) NULL
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [raw].[HubCarrier]    Script Date: 3/9/2015 4:25:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [raw].[HubCarrier](
	[CarrierHashKey] [char](32) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
	[Carrier] [nvarchar](2) NULL
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [raw].[HubFlightNum]    Script Date: 3/9/2015 4:25:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [raw].[HubFlightNum](
	[FlightNumHashKey] [char](32) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
	[LastSeenDate] [datetime2](7) NOT NULL,
	[Carrier] [nvarchar](2) NULL,
	[FlightNum] [smallint] NULL
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [raw].[HubPerson]    Script Date: 3/9/2015 4:25:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [raw].[HubPerson](
	[PersonHashKey] [char](32) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[MiddleName] [nvarchar](50) NOT NULL,
	[DOB] [int] NOT NULL
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [raw].[HubTailNum]    Script Date: 3/9/2015 4:25:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [raw].[HubTailNum](
	[TailNumHashKey] [char](32) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
	[TailNum] [nvarchar](6) NULL
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [raw].[LinkFlightNumCarrier]    Script Date: 3/9/2015 4:25:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [raw].[LinkFlightNumCarrier](
	[FlightNumCarrierHashKey] [char](32) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
	[FlightNumHashKey] [char](32) NOT NULL,
	[CarrierHashKey] [char](32) NOT NULL
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [raw].[RefCodes]    Script Date: 3/9/2015 4:25:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[RefCodes](
	[Group] [nvarchar](50) NOT NULL,
	[Code] [nvarchar](250) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Abbreviation] [nvarchar](2) NULL,
	[Sort Order] [int] NOT NULL,
	[External Reference] [nvarchar](255) NULL,
	[Comments] [nvarchar](max) NULL,
	[Record Source] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_RefCodes] PRIMARY KEY CLUSTERED 
(
	[Group] ASC,
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA] TEXTIMAGE_ON [DATA]

GO
/****** Object:  Table [raw].[RefRegion]    Script Date: 3/9/2015 4:25:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raw].[RefRegion](
	[Code] [nvarchar](2) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Abbreviation] [nvarchar](2) NOT NULL,
	[Sort Order] [int] NOT NULL,
	[External Reference] [nvarchar](255) NULL,
	[Comments] [nvarchar](max) NULL,
 CONSTRAINT [PK_RefRegion] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA] TEXTIMAGE_ON [DATA]

GO
/****** Object:  Table [raw].[RefSatCodes]    Script Date: 3/9/2015 4:25:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [raw].[RefSatCodes](
	[Group] [nvarchar](50) NOT NULL,
	[Code] [nvarchar](2) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[LoadEndDate] [datetime2](7) NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
	[HashDiff] [char](32) NOT NULL,
	[ID] [int] NOT NULL,
	[MUID] [uniqueidentifier] NOT NULL,
	[VersionName] [nvarchar](50) NOT NULL,
	[VersionNumber] [int] NOT NULL,
	[VersionFlag] [nvarchar](50) NULL,
	[Name] [nvarchar](250) NULL,
	[ChangeTrackingMask] [int] NOT NULL,
	[Abbreviation] [nvarchar](2) NULL,
	[Sort Order] [decimal](38, 0) NULL,
	[External Reference] [nvarchar](255) NULL,
	[Record Source] [nvarchar](100) NULL,
	[Comments] [nvarchar](4000) NULL,
	[EnterDateTime] [datetime2](3) NOT NULL,
	[EnterUserName] [nvarchar](100) NULL,
	[EnterVersionNumber] [int] NULL,
	[LastChgDateTime] [datetime2](3) NOT NULL,
	[LastChgUserName] [nvarchar](100) NULL,
	[LastChgVersionNumber] [int] NULL,
	[ValidationStatus] [nvarchar](250) NULL,
 CONSTRAINT [PK_RefSatCodes] PRIMARY KEY CLUSTERED 
(
	[Group] ASC,
	[Code] ASC,
	[LoadDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [raw].[RefSatRegion]    Script Date: 3/9/2015 4:25:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [raw].[RefSatRegion](
	[Code] [nvarchar](2) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[LoadEndDate] [datetime2](7) NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
	[HashDiff] [char](32) NOT NULL,
	[ID] [int] NOT NULL,
	[MUID] [uniqueidentifier] NOT NULL,
	[VersionName] [nvarchar](50) NOT NULL,
	[VersionNumber] [int] NOT NULL,
	[VersionFlag] [nvarchar](50) NULL,
	[Name] [nvarchar](250) NULL,
	[ChangeTrackingMask] [int] NOT NULL,
	[Abbreviation] [nvarchar](2) NULL,
	[Sort Order] [decimal](38, 0) NULL,
	[External Reference] [nvarchar](255) NULL,
	[Record Source] [nvarchar](100) NULL,
	[Comments] [nvarchar](4000) NULL,
	[EnterDateTime] [datetime2](3) NOT NULL,
	[EnterUserName] [nvarchar](100) NULL,
	[EnterVersionNumber] [int] NULL,
	[LastChgDateTime] [datetime2](3) NOT NULL,
	[LastChgUserName] [nvarchar](100) NULL,
	[LastChgVersionNumber] [int] NULL,
	[ValidationStatus] [nvarchar](250) NULL,
 CONSTRAINT [PK_RefSatRegion] PRIMARY KEY CLUSTERED 
(
	[Code] ASC,
	[LoadDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [raw].[SatAirlineIDEffectivity]    Script Date: 3/9/2015 4:25:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [raw].[SatAirlineIDEffectivity](
	[AirlineIDHashKey] [char](32) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[LoadEndDate] [datetime2](7) NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
	[Year Start] [int] NOT NULL,
	[Year End] [int] NOT NULL,
	[ValidFrom] [datetime2](7) NOT NULL,
	[ValidTo] [datetime2](7) NULL
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [raw].[SatCarrier]    Script Date: 3/9/2015 4:25:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [raw].[SatCarrier](
	[CarrierHashKey] [char](32) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[LoadEndDate] [datetime2](7) NULL,
	[Code] [nvarchar](250) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Corporate Name] [nvarchar](100) NULL,
	[Abbreviation] [nvarchar](3) NULL,
	[Unique Abbreviation] [nvarchar](10) NULL,
	[Group_Code] [nvarchar](250) NULL,
	[Region_Code] [nvarchar](250) NULL,
	[Satisfaction Rank] [decimal](38, 0) NULL,
	[Sort Order] [decimal](38, 0) NULL,
	[External Reference] [nvarchar](255) NULL,
	[Comments] [nvarchar](4000) NULL
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [raw].[SatContact]    Script Date: 3/9/2015 4:25:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [raw].[SatContact](
	[PersonHashKey] [char](32) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[Sequence] [int] NOT NULL,
	[LoadEndDate] [datetime2](7) NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
	[ContactLast] [nvarchar](50) NOT NULL,
	[ContactFirst] [nvarchar](50) NOT NULL,
	[ContactMiddle] [nvarchar](50) NULL,
	[ContactDOB] [int] NOT NULL
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [raw].[SatDestAirport]    Script Date: 3/9/2015 4:25:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [raw].[SatDestAirport](
	[AirportHashKey] [char](32) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[LoadEndDate] [datetime2](7) NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
	[HashDiff] [char](32) NOT NULL,
	[DestCityName] [nvarchar](100) NOT NULL,
	[DestState] [nvarchar](2) NOT NULL,
	[DestStateName] [nvarchar](100) NOT NULL,
	[DestCityMarketID] [int] NOT NULL,
	[DestStateFips] [smallint] NOT NULL,
	[DestWac] [smallint] NOT NULL
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [raw].[SatFlightNumEffectivity]    Script Date: 3/9/2015 4:25:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [raw].[SatFlightNumEffectivity](
	[FlightNumHashKey] [char](32) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[LoadEndDate] [datetime2](7) NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
	[DeletedDate] [datetime2](7) NULL
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [raw].[SatOriginAirport]    Script Date: 3/9/2015 4:25:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [raw].[SatOriginAirport](
	[AirportHashKey] [char](32) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[LoadEndDate] [datetime2](7) NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
	[OriginCityName] [nvarchar](100) NOT NULL,
	[OriginState] [nvarchar](2) NOT NULL,
	[OriginStateName] [nvarchar](100) NOT NULL,
	[OriginCityMarketID] [int] NOT NULL,
	[OriginStateFips] [smallint] NOT NULL,
	[OriginWac] [smallint] NOT NULL
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [raw].[SatPassenger]    Script Date: 3/9/2015 4:25:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [raw].[SatPassenger](
	[PersonHashKey] [char](32) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[Sequence] [int] NOT NULL,
	[LoadEndDate] [datetime2](7) NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[MiddleName] [nvarchar](50) NULL,
	[Suffix] [nvarchar](50) NULL,
	[DOB] [int] NOT NULL,
	[Sex] [char](1) NOT NULL
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [raw].[SatTailNumReserved]    Script Date: 3/9/2015 4:25:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [raw].[SatTailNumReserved](
	[TailNumHashKey] [char](32) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[LoadEndDate] [int] NULL,
	[Code] [nvarchar](251) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Registrant_Name] [nvarchar](250) NULL,
	[Reserve Date] [datetime2](3) NULL,
	[Reservation Type_Name] [nvarchar](250) NULL,
	[Expiration Notice Date] [datetime2](3) NULL,
	[Aircraft Registration Number For Change] [nvarchar](10) NULL,
	[External Reference] [nvarchar](255) NULL,
	[Comments] [nvarchar](4000) NULL
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [raw].[TLinkFlight]    Script Date: 3/9/2015 4:25:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [raw].[TLinkFlight](
	[FlightHashKey] [char](32) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
	[CarrierHashKey] [char](32) NOT NULL,
	[FlightNumHashKey] [char](32) NOT NULL,
	[TailNumHashKey] [char](32) NOT NULL,
	[OriginHashKey] [char](32) NOT NULL,
	[DestHashKey] [char](32) NOT NULL,
	[FlightDate] [datetime2](7) NOT NULL
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [raw].[TSatFlight]    Script Date: 3/9/2015 4:25:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [raw].[TSatFlight](
	[FlightHashKey] [char](32) NOT NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
	[Year] [smallint] NULL,
	[Quarter] [smallint] NULL,
	[Month] [smallint] NULL,
	[DayOfMonth] [smallint] NULL,
	[DayOfWeek] [smallint] NULL,
	[CRSDepTime] [smallint] NULL,
	[DepTime] [smallint] NULL,
	[DepDelay] [smallint] NULL,
	[DepDelayMinutes] [smallint] NULL,
	[DepDel15] [bit] NULL,
	[DepartureDelayGroups] [smallint] NULL,
	[DepTimeBlk] [nvarchar](9) NULL,
	[TaxiOut] [smallint] NULL,
	[WheelsOff] [smallint] NULL,
	[WheelsOn] [smallint] NULL,
	[TaxiIn] [smallint] NULL,
	[CRSArrTime] [smallint] NULL,
	[ArrTime] [smallint] NULL,
	[ArrDelay] [smallint] NULL,
	[ArrDelayMinutes] [smallint] NULL,
	[ArrDel15] [bit] NULL,
	[ArrivalDelayGroups] [smallint] NULL,
	[ArrTimeBlk] [nvarchar](9) NULL,
	[Cancelled] [bit] NULL,
	[CancellationCode] [nvarchar](10) NULL,
	[Diverted] [bit] NULL,
	[CRSElapsedTime] [smallint] NULL,
	[ActualElapsedTime] [smallint] NULL,
	[AirTime] [smallint] NULL,
	[Flights] [smallint] NULL,
	[Distance] [int] NULL,
	[DistanceGroup] [int] NULL,
	[CarrierDelay] [smallint] NULL,
	[WeatherDelay] [smallint] NULL,
	[NASDelay] [smallint] NULL,
	[SecurityDelay] [smallint] NULL,
	[LateAircraftDelay] [smallint] NULL,
	[FirstDepTime] [smallint] NULL,
	[TotalAddGTime] [smallint] NULL,
	[LongestAddGTime] [smallint] NULL
) ON [DATA]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [raw].[RefDistanceGroup]    Script Date: 3/9/2015 4:25:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [raw].[RefDistanceGroup] 
AS
SELECT 
	[Code]
	,[Name]
	,[Abbreviation]
	,[Min Value]
	,[Max Value]
    ,[Sort Order]
    ,[External Reference]
    ,[Comments]
FROM 
	[StageArea].[mds].[BTS_DistanceGroup_DWH]

GO
/****** Object:  View [biz].[TSatFlight]    Script Date: 3/9/2015 4:25:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [biz].[TSatFlight] AS
SELECT 
       [FlightHashKey]
      ,[LoadDate]
      ,'SR4711' AS RecordSource
      ,[Year]
      ,[Quarter]
      ,[Month]
      ,[DayOfMonth]
      ,[DayOfWeek]
      ,[CRSDepTime]
      ,[DepTime]
      ,[DepDelay]
      ,[DepDelayMinutes]
      ,[DepDel15]
      ,[DepartureDelayGroups]
      ,[DepTimeBlk]
      ,[TaxiOut]
      ,[WheelsOff]
      ,[WheelsOn]
      ,[TaxiIn]
      ,[CRSArrTime]
      ,[ArrTime]
      ,[ArrDelay]
      ,[ArrDelayMinutes]
      ,[ArrDel15]
      ,[ArrivalDelayGroups]
      ,[ArrTimeBlk]
      ,[Cancelled]
      ,[CancellationCode]
      ,[Diverted]
      ,[CRSElapsedTime]
      ,[ActualElapsedTime]
      ,[AirTime]
      ,[Flights]
      ,[Distance] AS DistanceM
	  ,[Distance] * 0.87 AS DistanceNM
	  ,[Distance] * 1.6 AS DistanceKM
	  ,[Distance] / IIF([AirTime] = 0, NULL, [AirTime]*1.0) AS Speed
      ,[DistanceGroup]
      ,[CarrierDelay]
      ,[WeatherDelay]
      ,[NASDelay]
      ,[SecurityDelay]
      ,[LateAircraftDelay]
      ,[FirstDepTime]
      ,[TotalAddGTime]
      ,[LongestAddGTime]
FROM 
      [DataVault].[raw].[TSatFlight];

GO
/****** Object:  View [biz].[TSatCleansedFlight]    Script Date: 3/9/2015 4:25:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [biz].[TSatCleansedFlight] AS
SELECT 
       [FlightHashKey]
      ,[LoadDate]
      ,'SR4711.DQ' AS RecordSource
      ,[Year]
      ,[Quarter]
      ,[Month]
      ,[DayOfMonth]
      ,[DayOfWeek]
      ,[CRSDepTime]
      ,[DepTime]
      ,[DepDelay]
      ,[DepDelayMinutes]
      ,[DepDel15]
      ,[DepartureDelayGroups]
      ,[DepTimeBlk]
      ,[TaxiOut]
      ,[WheelsOff]
      ,[WheelsOn]
      ,[TaxiIn]
      ,[CRSArrTime]
      ,[ArrTime]
      ,[ArrDelay]
      ,[ArrDelayMinutes]
      ,[ArrDel15]
      ,[ArrivalDelayGroups]
      ,[ArrTimeBlk]
      ,[Cancelled]
      ,[CancellationCode]
      ,[Diverted]
      ,[CRSElapsedTime]
      ,[ActualElapsedTime]
      ,[AirTime]
      ,[Flights]
      ,[DistanceM]
	  ,[DistanceNM]
	  ,[DistanceKM]
	  ,[Speed]
      ,[DistanceGroup]
	  ,[DataVault].[raw].[RefDistanceGroup].Abbreviation AS DistanceGroupText
      ,[CarrierDelay]
      ,[WeatherDelay]
      ,[NASDelay]
      ,[SecurityDelay]
      ,[LateAircraftDelay]
      ,[FirstDepTime]
      ,[TotalAddGTime]
      ,[LongestAddGTime]
FROM 
      [DataVault].[biz].[TSatFlight] flight
LEFT JOIN
      [DataVault].[raw].[RefDistanceGroup] ON (flight.[DistanceGroup] = [DataVault].[raw].[RefDistanceGroup].Code)

	






GO
/****** Object:  View [biz].[TSatCleansedFlight2]    Script Date: 3/9/2015 4:25:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [biz].[TSatCleansedFlight2] AS
SELECT 
       [FlightHashKey]
      ,[LoadDate]
      ,[RecordSource]
      ,[Year]
      ,[Quarter]
      ,[Month]
      ,[DayOfMonth]
      ,[DayOfWeek]
      ,[CRSDepTime]
      ,[DepTime]
      ,[DepDelay]
      ,[DepDelayMinutes]
      ,[DepDel15]
      ,[DepartureDelayGroups]
      ,[DepTimeBlk]
      ,[TaxiOut]
      ,[WheelsOff]
      ,[WheelsOn]
      ,[TaxiIn]
      ,[CRSArrTime]
      ,[ArrTime]
      ,[ArrDelay]
      ,[ArrDelayMinutes]
      ,[ArrDel15]
      ,[ArrivalDelayGroups]
      ,[ArrTimeBlk]
      ,[Cancelled]
      ,[CancellationCode]
      ,[Diverted]
      ,[CRSElapsedTime]
      ,[ActualElapsedTime]
      ,[AirTime]
      ,[Flights]
      ,[DistanceM]
	  ,[DistanceNM]
	  ,[DistanceKM]
	  ,[Speed]
      ,[DistanceGroup]
	  ,[DistanceGroupText]
      ,[CarrierDelay]
      ,[WeatherDelay]
      ,[NASDelay]
      ,[SecurityDelay]
      ,[LateAircraftDelay]
      ,[FirstDepTime]
      ,[TotalAddGTime]
      ,[LongestAddGTime]
FROM 
      [DataVault].[biz].[TSatCleansedFlight]
WHERE
	  NOT ([Cancelled] = 0 AND [AirTime] = 0)
	









GO
/****** Object:  View [biz].[SatContact_delete]    Script Date: 3/9/2015 4:25:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [biz].[SatContact_delete] AS
SELECT [PersonHashKey]
      ,[LoadDate]
      ,[Sequence]
      ,[LoadEndDate]
      ,[RecordSource]
      ,UPPER(SUBSTRING([ContactLast], 1, 1)) + LOWER(SUBSTRING([ContactLast], 2, 49)) AS ContactLast
	  ,UPPER(SUBSTRING([ContactFirst], 1, 1)) + LOWER(SUBSTRING([ContactFirst], 2, 49)) AS ContactFirst
      ,UPPER(SUBSTRING([ContactMiddle], 1, 1)) + LOWER(SUBSTRING([ContactMiddle], 2, 49)) AS ContactMiddle
	  ,TRY_CONVERT(DATE, LEFT(ContactDOB, 8)) AS ContactDOB
	  ,IIF(TRY_CONVERT(DATE, LEFT(ContactDOB, 8)) IS NULL, 'Invalid DOB: ' + CONVERT(VARCHAR(50), [ContactDOB]), 'OK') AS ValidationResult
  FROM [DataVault].[raw].[SatContact]

GO
/****** Object:  View [biz].[SatDestAirportCulturalRegion]    Script Date: 3/9/2015 4:25:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [biz].[SatDestAirportCulturalRegion] AS
SELECT [AirportHashKey]
      ,[LoadDate]
      ,[LoadEndDate]
      ,'SR9376' AS [RecordSource]
      ,[HashDiff]
      ,[DestCityName]
      ,[DestState]
      ,[DestStateName]
      ,[DestCityMarketID]
      ,[DestStateFips]
      ,[DestWac]
	  ,CASE 
		WHEN DestState IN ('CT', 'ME', 'MA', 'NH', 'RI', 'VT') THEN 'New England'
		WHEN DestState IN ('DE', 'MD', 'NJ', 'NY', 'PA', 'DC') THEN 'Mid Atlantic'
		WHEN DestState IN ('AL', 'AR', 'FL', 'GA', 'KY', 'LA') THEN 'The South'
		WHEN DestState IN ('MS', 'NC', 'SC', 'TN', 'VA', 'WV') THEN 'The South'
		WHEN DestState IN ('IL', 'IN', 'IA', 'KS', 'MI', 'MN') THEN 'Midwest'
		WHEN DestState IN ('MO', 'NE', 'ND', 'OH', 'SD', 'WI') THEN 'Midwest'
		WHEN DestState IN ('AZ', 'NM', 'OK', 'TX') THEN 'The Southwest'
		WHEN DestState IN ('AK', 'CO', 'CA', 'HI', 'ID', 'MT') THEN 'The West'
		WHEN DestState IN ('NV', 'OR', 'UT', 'WA', 'WY') THEN 'The West'
		ELSE NULL 
	   END AS CulturalRegion
  FROM 
	[DataVault].[raw].[SatDestAirport] src
  


GO
/****** Object:  View [biz].[SatPassenger_delete]    Script Date: 3/9/2015 4:25:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [biz].[SatPassenger_delete] AS
SELECT [PersonHashKey]
      ,[LoadDate]
      ,[Sequence]
      ,[LoadEndDate]
      ,[RecordSource] 
	  ,UPPER(SUBSTRING([LastName], 1, 1)) + LOWER(SUBSTRING([LastName], 2, 49)) AS [LastName]
	  ,UPPER(SUBSTRING([FirstName], 1, 1)) + LOWER(SUBSTRING([FirstName], 2, 49)) AS [FirstName]
      ,UPPER(SUBSTRING([MiddleName], 1, 1)) + LOWER(SUBSTRING([MiddleName], 2, 49)) AS [MiddleName]
	  ,[Suffix]
	  ,TRY_CONVERT(DATE, LEFT(DOB, 8)) AS DOB
	  ,[Sex]
	  ,IIF(TRY_CONVERT(DATE, LEFT(DOB, 8)) IS NULL, 'Invalid DOB: ' + CONVERT(VARCHAR(50), DOB), 'OK') AS ValidationResult
  FROM [DataVault].[raw].[SatPassenger]
GO
/****** Object:  View [raw].[RefState]    Script Date: 3/9/2015 4:25:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [raw].[RefState] 
AS
SELECT 
	[Code]
	,[Name]
	,[Abbreviation]
    ,[Sort Order]
    ,[External Reference]
    ,[Comments]
FROM 
	[MDS].[mdm].[FAA_State_DWH]


GO