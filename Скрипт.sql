USE [master]
GO
/****** Object:  Database [PhoneDirectory]    Script Date: 15.05.2024 11:45:58 ******/
CREATE DATABASE [PhoneDirectory]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PhoneDirectory', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\PhoneDirectory.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PhoneDirectory_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\PhoneDirectory_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [PhoneDirectory] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PhoneDirectory].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PhoneDirectory] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PhoneDirectory] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PhoneDirectory] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PhoneDirectory] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PhoneDirectory] SET ARITHABORT OFF 
GO
ALTER DATABASE [PhoneDirectory] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PhoneDirectory] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PhoneDirectory] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PhoneDirectory] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PhoneDirectory] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PhoneDirectory] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PhoneDirectory] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PhoneDirectory] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PhoneDirectory] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PhoneDirectory] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PhoneDirectory] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PhoneDirectory] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PhoneDirectory] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PhoneDirectory] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PhoneDirectory] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PhoneDirectory] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PhoneDirectory] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PhoneDirectory] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PhoneDirectory] SET  MULTI_USER 
GO
ALTER DATABASE [PhoneDirectory] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PhoneDirectory] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PhoneDirectory] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PhoneDirectory] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PhoneDirectory] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PhoneDirectory] SET QUERY_STORE = OFF
GO
USE [PhoneDirectory]
GO
/****** Object:  Table [dbo].[company]    Script Date: 15.05.2024 11:45:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[company](
	[id] [int] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_company] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[contact]    Script Date: 15.05.2024 11:45:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[contact](
	[id] [int] NOT NULL,
	[lastname] [nvarchar](50) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[surname] [nvarchar](50) NOT NULL,
	[phone] [nvarchar](50) NOT NULL,
	[e-mail] [nvarchar](100) NULL,
	[company] [int] NULL,
	[position] [int] NULL,
	[contact_group] [int] NULL,
	[birthday] [date] NULL,
	[photo] [varbinary](100) NULL,
 CONSTRAINT [PK_contact] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[contact_group]    Script Date: 15.05.2024 11:45:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[contact_group](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_contact_group] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[position]    Script Date: 15.05.2024 11:45:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[position](
	[id] [int] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_position] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[company] ([id], [name]) VALUES (1, N'Компания 1')
INSERT [dbo].[company] ([id], [name]) VALUES (2, N'Компания 2')
INSERT [dbo].[company] ([id], [name]) VALUES (3, N'Компания 3')
INSERT [dbo].[company] ([id], [name]) VALUES (4, N'Компания 4')
INSERT [dbo].[company] ([id], [name]) VALUES (5, N'Компания 5')
GO
INSERT [dbo].[contact] ([id], [lastname], [name], [surname], [phone], [e-mail], [company], [position], [contact_group], [birthday], [photo]) VALUES (1, N'Иванов', N'Иван', N'Иванович', N'+7 (999) 123-45-67', N'ivanov@example.com', 1, 2, 1, CAST(N'1980-01-01' AS Date), NULL)
INSERT [dbo].[contact] ([id], [lastname], [name], [surname], [phone], [e-mail], [company], [position], [contact_group], [birthday], [photo]) VALUES (2, N'Петров', N'Петр', N'Петрович', N'+7 (999) 234-56-78', N'petrov@example.com', 2, 3, 2, CAST(N'1985-02-02' AS Date), NULL)
INSERT [dbo].[contact] ([id], [lastname], [name], [surname], [phone], [e-mail], [company], [position], [contact_group], [birthday], [photo]) VALUES (3, N'Сидоров', N'Сидор', N'Сидорович', N'+7 (999) 345-67-89', N'sidorov@example.com', 3, 4, 3, CAST(N'1990-03-03' AS Date), NULL)
INSERT [dbo].[contact] ([id], [lastname], [name], [surname], [phone], [e-mail], [company], [position], [contact_group], [birthday], [photo]) VALUES (4, N'Васильев', N'Василий', N'Васильевич', N'+7 (999) 456-78-90', N'vasilyev@example.com', 4, 5, 1, CAST(N'1995-04-04' AS Date), NULL)
INSERT [dbo].[contact] ([id], [lastname], [name], [surname], [phone], [e-mail], [company], [position], [contact_group], [birthday], [photo]) VALUES (5, N'Кузнецов', N'Кузьма', N'Кузьмич', N'+7 (999) 567-89-01', N'kuznetsov@example.com', 5, 1, 2, CAST(N'2000-05-05' AS Date), NULL)
GO
INSERT [dbo].[contact_group] ([id], [name]) VALUES (1, N'Родственники')
INSERT [dbo].[contact_group] ([id], [name]) VALUES (2, N'Друзья')
INSERT [dbo].[contact_group] ([id], [name]) VALUES (3, N'Коллеги')
GO
INSERT [dbo].[position] ([id], [name]) VALUES (1, N'Должность 1')
INSERT [dbo].[position] ([id], [name]) VALUES (2, N'Должность 2')
INSERT [dbo].[position] ([id], [name]) VALUES (3, N'Должность 3')
INSERT [dbo].[position] ([id], [name]) VALUES (4, N'Должность 4')
INSERT [dbo].[position] ([id], [name]) VALUES (5, N'Должность 5')
GO
ALTER TABLE [dbo].[contact]  WITH CHECK ADD  CONSTRAINT [FK_contact_company] FOREIGN KEY([company])
REFERENCES [dbo].[company] ([id])
GO
ALTER TABLE [dbo].[contact] CHECK CONSTRAINT [FK_contact_company]
GO
ALTER TABLE [dbo].[contact]  WITH CHECK ADD  CONSTRAINT [FK_contact_contact_group] FOREIGN KEY([contact_group])
REFERENCES [dbo].[contact_group] ([id])
GO
ALTER TABLE [dbo].[contact] CHECK CONSTRAINT [FK_contact_contact_group]
GO
ALTER TABLE [dbo].[contact]  WITH CHECK ADD  CONSTRAINT [FK_contact_position] FOREIGN KEY([position])
REFERENCES [dbo].[position] ([id])
GO
ALTER TABLE [dbo].[contact] CHECK CONSTRAINT [FK_contact_position]
GO
USE [master]
GO
ALTER DATABASE [PhoneDirectory] SET  READ_WRITE 
GO
