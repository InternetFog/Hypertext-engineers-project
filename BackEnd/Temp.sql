USE [TitmeTable]
GO

ALTER TABLE [dbo].[Audience] DROP CONSTRAINT [FK_Audience_Location_SVG]
GO

ALTER TABLE [dbo].[Audience] DROP CONSTRAINT [FK_Audience_Building]
GO

/****** Object:  Table [dbo].[Audience]    Script Date: 23.11.2022 21:07:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Audience]') AND type in (N'U'))
DROP TABLE [dbo].[Audience]
GO

/****** Object:  Table [dbo].[Audience]    Script Date: 23.11.2022 21:07:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Audience](
	[ID] [int] NOT NULL,
	[Building_ID] [int] NOT NULL,
	[Location_ID] [int] NOT NULL,
	[SVG_ID] [int] NOT NULL,
	[Title] [varchar](50) NOT NULL,
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

/****** Object:  Table [dbo].[Building]    Script Date: 23.11.2022 21:07:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Building]') AND type in (N'U'))
DROP TABLE [dbo].[Building]
GO

/****** Object:  Table [dbo].[Building]    Script Date: 23.11.2022 21:07:36 ******/
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

/****** Object:  Table [dbo].[Department]    Script Date: 23.11.2022 21:07:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Department]') AND type in (N'U'))
DROP TABLE [dbo].[Department]
GO

/****** Object:  Table [dbo].[Department]    Script Date: 23.11.2022 21:07:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Department](
	[ID] [int] NOT NULL,
	[Title] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

USE [TitmeTable]
GO

ALTER TABLE [dbo].[Edited_Leson] DROP CONSTRAINT [FK_Edited_Leson_Official_Leson]
GO

ALTER TABLE [dbo].[Edited_Leson] DROP CONSTRAINT [FK_Edited_Leson_Edition_Type]
GO

/****** Object:  Table [dbo].[Edited_Leson]    Script Date: 23.11.2022 21:07:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Edited_Leson]') AND type in (N'U'))
DROP TABLE [dbo].[Edited_Leson]
GO

/****** Object:  Table [dbo].[Edited_Leson]    Script Date: 23.11.2022 21:07:52 ******/
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

/****** Object:  Table [dbo].[Edition_Type]    Script Date: 23.11.2022 21:08:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Edition_Type]') AND type in (N'U'))
DROP TABLE [dbo].[Edition_Type]
GO

/****** Object:  Table [dbo].[Edition_Type]    Script Date: 23.11.2022 21:08:04 ******/
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

/****** Object:  Table [dbo].[Group]    Script Date: 23.11.2022 21:08:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Group]') AND type in (N'U'))
DROP TABLE [dbo].[Group]
GO

/****** Object:  Table [dbo].[Group]    Script Date: 23.11.2022 21:08:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Group](
	[ID] [int] NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Cource] [tinyint] NOT NULL,
 CONSTRAINT [PK_Group] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

USE [TitmeTable]
GO

/****** Object:  Table [dbo].[Leson_Type]    Script Date: 23.11.2022 21:08:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Leson_Type]') AND type in (N'U'))
DROP TABLE [dbo].[Leson_Type]
GO

/****** Object:  Table [dbo].[Leson_Type]    Script Date: 23.11.2022 21:08:20 ******/
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

/****** Object:  Table [dbo].[Location_SVG]    Script Date: 23.11.2022 21:08:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Location_SVG]') AND type in (N'U'))
DROP TABLE [dbo].[Location_SVG]
GO

/****** Object:  Table [dbo].[Location_SVG]    Script Date: 23.11.2022 21:08:31 ******/
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

ALTER TABLE [dbo].[Official_Leson] DROP CONSTRAINT [FK_Official_Leson_Work_Time]
GO

ALTER TABLE [dbo].[Official_Leson] DROP CONSTRAINT [FK_Official_Leson_Work_Day]
GO

ALTER TABLE [dbo].[Official_Leson] DROP CONSTRAINT [FK_Official_Leson_Teacher]
GO

ALTER TABLE [dbo].[Official_Leson] DROP CONSTRAINT [FK_Official_Leson_Leson_Type]
GO

ALTER TABLE [dbo].[Official_Leson] DROP CONSTRAINT [FK_Official_Leson_Group]
GO

ALTER TABLE [dbo].[Official_Leson] DROP CONSTRAINT [FK_Official_Leson_Audience]
GO

/****** Object:  Table [dbo].[Official_Leson]    Script Date: 23.11.2022 21:08:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Official_Leson]') AND type in (N'U'))
DROP TABLE [dbo].[Official_Leson]
GO

/****** Object:  Table [dbo].[Official_Leson]    Script Date: 23.11.2022 21:08:39 ******/
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
	[Title] [varchar](50) NOT NULL,
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

USE [TitmeTable]
GO

ALTER TABLE [dbo].[Teacher] DROP CONSTRAINT [FK_Teacher_Department]
GO

/****** Object:  Table [dbo].[Teacher]    Script Date: 23.11.2022 21:08:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Teacher]') AND type in (N'U'))
DROP TABLE [dbo].[Teacher]
GO

/****** Object:  Table [dbo].[Teacher]    Script Date: 23.11.2022 21:08:47 ******/
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

/****** Object:  Table [dbo].[Work_Day]    Script Date: 23.11.2022 21:08:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Work_Day]') AND type in (N'U'))
DROP TABLE [dbo].[Work_Day]
GO

/****** Object:  Table [dbo].[Work_Day]    Script Date: 23.11.2022 21:08:53 ******/
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

/****** Object:  Table [dbo].[Work_Time]    Script Date: 23.11.2022 21:08:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Work_Time]') AND type in (N'U'))
DROP TABLE [dbo].[Work_Time]
GO

/****** Object:  Table [dbo].[Work_Time]    Script Date: 23.11.2022 21:08:59 ******/
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

