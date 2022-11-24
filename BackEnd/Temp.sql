USE [master]
GO

/****** Object:  Database [TitmeTable]    Script Date: 25.11.2022 0:08:34 ******/
DROP DATABASE [TitmeTable]
GO

/****** Object:  Database [TitmeTable]    Script Date: 25.11.2022 0:08:34 ******/
CREATE DATABASE [TitmeTable]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TitmeTable', FILENAME = N'D:\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\TitmeTable.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TitmeTable_log', FILENAME = N'D:\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\TitmeTable_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TitmeTable].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [TitmeTable] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [TitmeTable] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [TitmeTable] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [TitmeTable] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [TitmeTable] SET ARITHABORT OFF 
GO

ALTER DATABASE [TitmeTable] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [TitmeTable] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [TitmeTable] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [TitmeTable] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [TitmeTable] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [TitmeTable] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [TitmeTable] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [TitmeTable] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [TitmeTable] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [TitmeTable] SET  DISABLE_BROKER 
GO

ALTER DATABASE [TitmeTable] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [TitmeTable] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [TitmeTable] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [TitmeTable] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [TitmeTable] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [TitmeTable] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [TitmeTable] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [TitmeTable] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [TitmeTable] SET  MULTI_USER 
GO

ALTER DATABASE [TitmeTable] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [TitmeTable] SET DB_CHAINING OFF 
GO

ALTER DATABASE [TitmeTable] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [TitmeTable] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [TitmeTable] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [TitmeTable] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO

ALTER DATABASE [TitmeTable] SET QUERY_STORE = OFF
GO

ALTER DATABASE [TitmeTable] SET  READ_WRITE 
GO

USE [TitmeTable]
GO

/****** Object:  Table [dbo].[Building]    Script Date: 25.11.2022 0:10:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Building]') AND type in (N'U'))
DROP TABLE [dbo].[Building]
GO

/****** Object:  Table [dbo].[Building]    Script Date: 25.11.2022 0:10:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Building](
	[ID] [int] NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Address] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Building] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

USE [TitmeTable]
GO

/****** Object:  Table [dbo].[Location_SVG]    Script Date: 25.11.2022 0:10:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Location_SVG](
	[ID] [int] NOT NULL,
	[Data] [text] NOT NULL,
 CONSTRAINT [PK_Location_SVG] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

USE [TitmeTable]
GO

/****** Object:  Table [dbo].[Audience]    Script Date: 25.11.2022 0:10:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Audience](
	[ID] [int] NOT NULL,
	[Building_ID] [int] NULL,
	[Location_ID] [int] NULL,
	[SVG_ID] [int] NULL,
	[Title] [varchar](50) NOT NULL,
	[Floor] [int] NULL,
 CONSTRAINT [PK_Audience] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Audience]  WITH CHECK ADD  CONSTRAINT [FK_Audience_Building] FOREIGN KEY([Building_ID])
REFERENCES [dbo].[Building] ([ID])
GO

ALTER TABLE [dbo].[Audience] CHECK CONSTRAINT [FK_Audience_Building]
GO

ALTER TABLE [dbo].[Audience]  WITH CHECK ADD  CONSTRAINT [FK_Audience_Location_SVG] FOREIGN KEY([Location_ID])
REFERENCES [dbo].[Location_SVG] ([ID])
GO

ALTER TABLE [dbo].[Audience] CHECK CONSTRAINT [FK_Audience_Location_SVG]
GO

USE [TitmeTable]
GO

/****** Object:  Table [dbo].[Info]    Script Date: 25.11.2022 0:11:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Info](
	[Update_Date] [date] NOT NULL,
	[Admin_Login] [varchar](50) NOT NULL,
	[Admin_Password] [varchar](50) NOT NULL,
	[Parsing_Now] [bit] NOT NULL
) ON [PRIMARY]
GO

USE [TitmeTable]
GO

/****** Object:  Table [dbo].[Edition_Type]    Script Date: 25.11.2022 0:11:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Edition_Type](
	[ID] [int] NOT NULL,
	[Title] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Edition_Type] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

USE [TitmeTable]
GO

/****** Object:  Table [dbo].[Edited_Leson]    Script Date: 25.11.2022 0:11:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Edited_Leson](
	[ID] [int] NOT NULL,
	[Official_Lesson_ID] [int] NOT NULL,
	[Type_ID] [int] NOT NULL,
	[Legacy] [bit] NOT NULL,
	[Detail] [text] NOT NULL,
 CONSTRAINT [PK_Edited_Leson] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Edited_Leson]  WITH CHECK ADD  CONSTRAINT [FK_Edited_Leson_Edition_Type] FOREIGN KEY([Type_ID])
REFERENCES [dbo].[Edition_Type] ([ID])
GO

ALTER TABLE [dbo].[Edited_Leson] CHECK CONSTRAINT [FK_Edited_Leson_Edition_Type]
GO

ALTER TABLE [dbo].[Edited_Leson]  WITH CHECK ADD  CONSTRAINT [FK_Edited_Leson_Official_Leson] FOREIGN KEY([Official_Lesson_ID])
REFERENCES [dbo].[Official_Leson] ([ID])
GO

ALTER TABLE [dbo].[Edited_Leson] CHECK CONSTRAINT [FK_Edited_Leson_Official_Leson]
GO

USE [TitmeTable]
GO

/****** Object:  Table [dbo].[Faculty]    Script Date: 25.11.2022 0:11:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Faculty](
	[ID] [int] NOT NULL,
	[Title] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Faculty] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

USE [TitmeTable]
GO

/****** Object:  Table [dbo].[Department]    Script Date: 25.11.2022 0:12:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Department](
	[ID] [int] NOT NULL,
	[Title] [varchar](255) NOT NULL,
	[Faculty_ID] [int] NOT NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Department]  WITH CHECK ADD  CONSTRAINT [FK_Department_Faculty] FOREIGN KEY([Faculty_ID])
REFERENCES [dbo].[Faculty] ([ID])
GO

ALTER TABLE [dbo].[Department] CHECK CONSTRAINT [FK_Department_Faculty]
GO

USE [TitmeTable]
GO

/****** Object:  Table [dbo].[Teacher]    Script Date: 25.11.2022 0:12:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Teacher](
	[ID] [int] NOT NULL,
	[Department_ID] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Teacher] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Teacher]  WITH CHECK ADD  CONSTRAINT [FK_Teacher_Department] FOREIGN KEY([Department_ID])
REFERENCES [dbo].[Department] ([ID])
GO

ALTER TABLE [dbo].[Teacher] CHECK CONSTRAINT [FK_Teacher_Department]
GO

USE [TitmeTable]
GO

/****** Object:  Table [dbo].[TimeTable]    Script Date: 25.11.2022 0:13:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TimeTable](
	[ID] [int] NOT NULL,
	[Title] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TimeTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

USE [TitmeTable]
GO

/****** Object:  Table [dbo].[Group]    Script Date: 25.11.2022 0:13:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Group](
	[ID] [int] NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Cource] [tinyint] NOT NULL,
	[Timetable_ID] [int] NOT NULL,
 CONSTRAINT [PK_Group] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Group]  WITH CHECK ADD  CONSTRAINT [FK_Group_TimeTable] FOREIGN KEY([Timetable_ID])
REFERENCES [dbo].[TimeTable] ([ID])
GO

ALTER TABLE [dbo].[Group] CHECK CONSTRAINT [FK_Group_TimeTable]
GO

USE [TitmeTable]
GO

/****** Object:  Table [dbo].[Work_Time]    Script Date: 25.11.2022 0:13:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Work_Time](
	[ID] [int] NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Start_Time] [time](0) NOT NULL,
	[End_Time] [time](0) NOT NULL,
 CONSTRAINT [PK_Work_Time] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

USE [TitmeTable]
GO

/****** Object:  Table [dbo].[Work_Day]    Script Date: 25.11.2022 0:14:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Work_Day](
	[ID] [int] NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Week] [tinyint] NOT NULL,
 CONSTRAINT [PK_Work_Day] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

USE [TitmeTable]
GO

/****** Object:  Table [dbo].[Leson_Type]    Script Date: 25.11.2022 0:14:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Leson_Type](
	[ID] [int] NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Elective] [bit] NOT NULL,
 CONSTRAINT [PK_Leson_Type] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

USE [TitmeTable]
GO

/****** Object:  Table [dbo].[Official_Leson]    Script Date: 25.11.2022 0:14:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Official_Leson](
	[ID] [int] NOT NULL,
	[Teacher_ID] [int] NOT NULL,
	[Type_ID] [int] NOT NULL,
	[Audience_ID] [int] NOT NULL,
	[Day_ID] [int] NOT NULL,
	[Time_ID] [int] NOT NULL,
	[Group_ID] [int] NOT NULL,
	[Title] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Official_Leson] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Official_Leson]  WITH CHECK ADD  CONSTRAINT [FK_Official_Leson_Audience] FOREIGN KEY([Audience_ID])
REFERENCES [dbo].[Audience] ([ID])
GO

ALTER TABLE [dbo].[Official_Leson] CHECK CONSTRAINT [FK_Official_Leson_Audience]
GO

ALTER TABLE [dbo].[Official_Leson]  WITH CHECK ADD  CONSTRAINT [FK_Official_Leson_Group] FOREIGN KEY([Group_ID])
REFERENCES [dbo].[Group] ([ID])
GO

ALTER TABLE [dbo].[Official_Leson] CHECK CONSTRAINT [FK_Official_Leson_Group]
GO

ALTER TABLE [dbo].[Official_Leson]  WITH CHECK ADD  CONSTRAINT [FK_Official_Leson_Leson_Type] FOREIGN KEY([Type_ID])
REFERENCES [dbo].[Leson_Type] ([ID])
GO

ALTER TABLE [dbo].[Official_Leson] CHECK CONSTRAINT [FK_Official_Leson_Leson_Type]
GO

ALTER TABLE [dbo].[Official_Leson]  WITH CHECK ADD  CONSTRAINT [FK_Official_Leson_Teacher] FOREIGN KEY([Teacher_ID])
REFERENCES [dbo].[Teacher] ([ID])
GO

ALTER TABLE [dbo].[Official_Leson] CHECK CONSTRAINT [FK_Official_Leson_Teacher]
GO

ALTER TABLE [dbo].[Official_Leson]  WITH CHECK ADD  CONSTRAINT [FK_Official_Leson_Work_Day] FOREIGN KEY([Day_ID])
REFERENCES [dbo].[Work_Day] ([ID])
GO

ALTER TABLE [dbo].[Official_Leson] CHECK CONSTRAINT [FK_Official_Leson_Work_Day]
GO

ALTER TABLE [dbo].[Official_Leson]  WITH CHECK ADD  CONSTRAINT [FK_Official_Leson_Work_Time] FOREIGN KEY([Time_ID])
REFERENCES [dbo].[Work_Time] ([ID])
GO

ALTER TABLE [dbo].[Official_Leson] CHECK CONSTRAINT [FK_Official_Leson_Work_Time]
GO

insert into Info values ('2022-11-24', 'string', 'string', 'False')

insert into TimeTable values 
(0, 'Магистратура, Коллерж, ДОУ'),
(1,	'Бакалавриат и специалитет'),
(2,	'Заочное 1'),
(3,	'Заочное 2')

insert into Work_Day values 
(0,	'ПН',	0),
(1,	'ВТ',	0),
(2,	'СР',	0),
(3,	'ЧТ',	0),
(4,	'ПТ',	0),
(5,	'СБ',	0),
(6,	'ПН',	1),
(7,	'ВТ',	1),
(8,	'СР',	1),
(9,	'ЧТ',	1),
(10,	'ПТ',	1),
(11,	'СБ',	1)

insert into Work_Time values
(0,	1,	'09:00:00',	'10:35:00'),
(1,	2,	'10:45:00',	'12:20:00'),
(2,	3,	'13:00:00',	'14:35:00'),
(3,	4,	'14:45:00',	'16:20:00'),
(4,	5,	'16:25:00',	'18:00:00'),
(5,	6,	'18:05:00',	'19:40:00')