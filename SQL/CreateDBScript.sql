USE [master]
GO
/****** Object:  Database [OpenDoors]    Script Date: 8/10/2020 2:15:00 PM ******/
CREATE DATABASE [OpenDoors]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'OpenDoors', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\OpenDoors.mdf' , SIZE = 860160KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'OpenDoors_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\OpenDoors_log.ldf' , SIZE = 860160KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [OpenDoors] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [OpenDoors].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [OpenDoors] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [OpenDoors] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [OpenDoors] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [OpenDoors] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [OpenDoors] SET ARITHABORT OFF 
GO
ALTER DATABASE [OpenDoors] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [OpenDoors] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [OpenDoors] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [OpenDoors] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [OpenDoors] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [OpenDoors] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [OpenDoors] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [OpenDoors] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [OpenDoors] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [OpenDoors] SET  DISABLE_BROKER 
GO
ALTER DATABASE [OpenDoors] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [OpenDoors] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [OpenDoors] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [OpenDoors] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [OpenDoors] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [OpenDoors] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [OpenDoors] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [OpenDoors] SET RECOVERY FULL 
GO
ALTER DATABASE [OpenDoors] SET  MULTI_USER 
GO
ALTER DATABASE [OpenDoors] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [OpenDoors] SET DB_CHAINING OFF 
GO
ALTER DATABASE [OpenDoors] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [OpenDoors] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [OpenDoors] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'OpenDoors', N'ON'
GO
ALTER DATABASE [OpenDoors] SET QUERY_STORE = OFF
GO
USE [OpenDoors]
GO
/****** Object:  Table [dbo].[Images]    Script Date: 8/10/2020 2:15:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Images](
	[ImageId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[ImageData] [varbinary](max) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Images] PRIMARY KEY CLUSTERED 
(
	[ImageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OpenDoorLogs]    Script Date: 8/10/2020 2:15:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpenDoorLogs](
	[OpenDoorLogsId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[ImageData] [varbinary](max) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[RecognitionProbability] [float] NOT NULL,
 CONSTRAINT [PK_OpenDoorLogs] PRIMARY KEY CLUSTERED 
(
	[OpenDoorLogsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 8/10/2020 2:15:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[EMail] [nvarchar](100) NULL,
	[UserName] [nvarchar](100) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UsersUserNameIndex]    Script Date: 8/10/2020 2:15:00 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UsersUserNameIndex] ON [dbo].[Users]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Images] ADD  CONSTRAINT [DF_Images_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[OpenDoorLogs] ADD  CONSTRAINT [DF_OpenDoorLogs_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_CreationDate]  DEFAULT (getdate()) FOR [CreationDate]
GO
ALTER TABLE [dbo].[Images]  WITH NOCHECK ADD  CONSTRAINT [FK_Images_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Images] CHECK CONSTRAINT [FK_Images_Users]
GO
ALTER TABLE [dbo].[OpenDoorLogs]  WITH NOCHECK ADD  CONSTRAINT [FK_OpenDoorLogs_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[OpenDoorLogs] CHECK CONSTRAINT [FK_OpenDoorLogs_Users]
GO
/****** Object:  StoredProcedure [dbo].[usp_ExportImage]    Script Date: 8/10/2020 2:15:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ExportImage] (
   @PicName INT
   ,@ImageFolderPath NVARCHAR(1000)
   ,@Filename NVARCHAR(1000)
   )
AS
BEGIN
   DECLARE @ImageData VARBINARY (max);
   DECLARE @Path2OutFile NVARCHAR (2000);
   DECLARE @Obj INT
 
   SET NOCOUNT ON
 
   SELECT @ImageData = (
         SELECT convert (VARBINARY (max), ImageData, 1)
         FROM Images
         WHERE ImageId = @PicName
         );
 
   SET @Path2OutFile = CONCAT (
         @ImageFolderPath
         ,'\'
         , @Filename
         );
    BEGIN TRY
     EXEC sp_OACreate 'ADODB.Stream' ,@Obj OUTPUT;
     EXEC sp_OASetProperty @Obj ,'Type',1;
     EXEC sp_OAMethod @Obj,'Open';
     EXEC sp_OAMethod @Obj,'Write', NULL, @ImageData;
     EXEC sp_OAMethod @Obj,'SaveToFile', NULL, @Path2OutFile, 2;
     EXEC sp_OAMethod @Obj,'Close';
     EXEC sp_OADestroy @Obj;
    END TRY
    
 BEGIN CATCH
  EXEC sp_OADestroy @Obj;
 END CATCH
 
   SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[uspExportOpenDoorImage]    Script Date: 8/10/2020 2:15:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[uspExportOpenDoorImage] (
   @PicName INT
   ,@ImageFolderPath NVARCHAR(1000)
   ,@Filename NVARCHAR(1000)
   )
AS
BEGIN
   DECLARE @ImageData VARBINARY (max);
   DECLARE @Path2OutFile NVARCHAR (2000);
   DECLARE @Obj INT
 
   SET NOCOUNT ON
 
   SELECT @ImageData = (
         SELECT convert (VARBINARY (max), ImageData, 1)
         FROM OpenDoorLogs
         WHERE OpenDoorLogsId = @PicName
         );
 
   SET @Path2OutFile = CONCAT (
         @ImageFolderPath
         ,'\'
         , @Filename
         );
    BEGIN TRY
     EXEC sp_OACreate 'ADODB.Stream' ,@Obj OUTPUT;
     EXEC sp_OASetProperty @Obj ,'Type',1;
     EXEC sp_OAMethod @Obj,'Open';
     EXEC sp_OAMethod @Obj,'Write', NULL, @ImageData;
     EXEC sp_OAMethod @Obj,'SaveToFile', NULL, @Path2OutFile, 2;
     EXEC sp_OAMethod @Obj,'Close';
     EXEC sp_OADestroy @Obj;
    END TRY
    
 BEGIN CATCH
  EXEC sp_OADestroy @Obj;
 END CATCH
 
   SET NOCOUNT OFF
END
GO
USE [master]
GO
ALTER DATABASE [OpenDoors] SET  READ_WRITE 
GO
