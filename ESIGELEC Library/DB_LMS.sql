USE [master]
GO
/****** Object:  Database [DB_LMS]    Script Date: 6/27/2016 6:12:10 PM ******/
CREATE DATABASE [DB_LMS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DB_LMS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\DB_LMS.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DB_LMS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\DB_LMS_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [DB_LMS] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DB_LMS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DB_LMS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DB_LMS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DB_LMS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DB_LMS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DB_LMS] SET ARITHABORT OFF 
GO
ALTER DATABASE [DB_LMS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DB_LMS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DB_LMS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DB_LMS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DB_LMS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DB_LMS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DB_LMS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DB_LMS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DB_LMS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DB_LMS] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DB_LMS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DB_LMS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DB_LMS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DB_LMS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DB_LMS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DB_LMS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DB_LMS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DB_LMS] SET RECOVERY FULL 
GO
ALTER DATABASE [DB_LMS] SET  MULTI_USER 
GO
ALTER DATABASE [DB_LMS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DB_LMS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DB_LMS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DB_LMS] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [DB_LMS] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DB_LMS', N'ON'
GO
USE [DB_LMS]
GO
/****** Object:  UserDefinedFunction [dbo].[getBookStock]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[getBookStock] 
(
	-- Add the parameters for the function here
	@bookid int
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @stock int

	-- Add the T-SQL statements to compute the return value here
	SELECT @stock = bok_stock from tbl_Book
	where bok_ID = @bookid

	-- Return the result of the function
	RETURN @stock

END

GO
/****** Object:  Table [dbo].[tbl_Book]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_Book](
	[bok_ID] [int] IDENTITY(1,1) NOT NULL,
	[bok_name] [varchar](50) NOT NULL,
	[bok_author] [varchar](50) NULL,
	[bok_edition] [int] NULL,
	[bok_pages] [int] NULL,
	[bok_publish] [int] NULL,
	[srm_ID] [int] NULL,
	[bok_status] [varchar](20) NULL,
	[bok_stock] [int] NULL CONSTRAINT [DF_tbl_Book_bok_stock]  DEFAULT ((0)),
 CONSTRAINT [PK__tbl_Book__5A9060A498BB49A9] PRIMARY KEY CLUSTERED 
(
	[bok_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_BookRegister]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_BookRegister](
	[br_ID] [int] IDENTITY(1,1) NOT NULL,
	[br_date] [date] NULL,
	[mem_ID] [int] NULL,
	[br_num] [int] NULL,
	[bok_ID] [int] NULL,
	[br_outDate] [date] NULL,
	[br_inDate] [date] NULL,
	[br_qty] [int] NULL,
	[br_fine] [float] NULL,
	[br_status] [varchar](20) NULL,
	[br_outin] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[br_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_Member]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_Member](
	[mem_ID] [int] IDENTITY(1,1) NOT NULL,
	[mem_name] [varchar](50) NOT NULL,
	[mem_email] [varchar](50) NULL,
	[mem_address] [varchar](50) NULL,
	[mem_mobile] [varchar](50) NULL,
	[mem_dob] [date] NULL,
	[mem_doj] [date] NULL,
	[pln_name] [varchar](50) NOT NULL,
	[mem_status] [varchar](20) NULL,
	[pln_ID] [int] NULL,
 CONSTRAINT [PK_tbl_Member] PRIMARY KEY CLUSTERED 
(
	[mem_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_Plan]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_Plan](
	[pln_ID] [int] IDENTITY(1,1) NOT NULL,
	[pln_name] [varchar](50) NULL,
	[pln_doc] [date] NULL,
	[pln_bookLimit] [int] NULL,
	[pln_bookHold] [int] NULL,
	[pln_validity] [int] NULL,
	[pln_amount] [float] NULL,
	[pln_discount] [float] NULL,
	[pln_status] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[pln_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_Profile]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_Profile](
	[pro_ID] [int] IDENTITY(1,1) NOT NULL,
	[pro_name] [varchar](50) NULL,
	[pro_email] [varchar](50) NULL,
	[pro_mobile] [varchar](50) NULL,
	[pro_password] [varchar](50) NULL,
	[pro_address] [varchar](50) NULL,
	[rol_roleName] [varchar](50) NOT NULL,
	[pro_status] [varchar](20) NULL,
 CONSTRAINT [PK__tbl_Prof__1B146A0384A75331] PRIMARY KEY CLUSTERED 
(
	[pro_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_Purchase]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_Purchase](
	[pur_ID] [int] IDENTITY(1,1) NOT NULL,
	[pur_date] [date] NULL,
	[pur_from] [varchar](50) NULL,
	[pur_num] [int] NULL,
	[bok_ID] [int] NOT NULL,
	[bok_name] [varchar](50) NOT NULL,
	[pur_qty] [int] NULL,
	[pur_rate] [float] NULL,
	[pur_amount] [float] NULL,
	[pur_status] [varchar](50) NULL,
 CONSTRAINT [PK__tbl_Purc__B676A143B54270F9] PRIMARY KEY CLUSTERED 
(
	[pur_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_Rack]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_Rack](
	[rck_ID] [int] IDENTITY(1,1) NOT NULL,
	[rck_name] [varchar](50) NULL,
	[rck_status] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[rck_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_Role]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_Role](
	[rol_ID] [int] IDENTITY(1,1) NOT NULL,
	[rol_roleName] [varchar](50) NOT NULL,
	[rol_status] [varchar](20) NULL,
 CONSTRAINT [PK__tbl_Role__CF31E05B15B6EC69] PRIMARY KEY CLUSTERED 
(
	[rol_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_section]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_section](
	[sec_ID] [int] IDENTITY(1,1) NOT NULL,
	[sec_name] [varchar](50) NULL,
	[sec_status] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[sec_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_SectionRackMap]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_SectionRackMap](
	[srm_ID] [int] IDENTITY(1,1) NOT NULL,
	[sec_ID] [int] NULL,
	[rck_ID] [int] NULL,
	[srm_print] [varchar](50) NULL,
	[srm_status] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[srm_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_Stock]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_Stock](
	[stk_ID] [int] IDENTITY(1,1) NOT NULL,
	[bok_ID] [int] NULL,
	[bok_name] [varchar](50) NULL,
	[pur_qty] [int] NULL,
	[stk_status] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[stk_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_transaction]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_transaction](
	[trn_ID] [int] IDENTITY(1,1) NOT NULL,
	[trn_date] [date] NULL,
	[mem_ID] [int] NULL,
	[mem_name] [varchar](50) NULL,
	[trn_amount] [float] NULL,
	[trn_fine] [float] NULL,
	[trn_type] [varchar](50) NULL,
	[trn_status] [varchar](20) NULL,
 CONSTRAINT [PK__tbl_tran__3E30CB27EF231C08] PRIMARY KEY CLUSTERED 
(
	[trn_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_Wish]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Wish](
	[wishID] [int] IDENTITY(1,1) NOT NULL,
	[bookID] [int] NULL,
	[memberID] [int] NULL,
	[status] [int] NULL CONSTRAINT [DF_tbl_Wish_status]  DEFAULT ((0)),
 CONSTRAINT [PK_tbl_Wish] PRIMARY KEY CLUSTERED 
(
	[wishID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[tbl_Book] ON 

INSERT [dbo].[tbl_Book] ([bok_ID], [bok_name], [bok_author], [bok_edition], [bok_pages], [bok_publish], [srm_ID], [bok_status], [bok_stock]) VALUES (1, N'Java Core', N'Jyti', 11, 100, 2010, 0, N'Active', 10)
INSERT [dbo].[tbl_Book] ([bok_ID], [bok_name], [bok_author], [bok_edition], [bok_pages], [bok_publish], [srm_ID], [bok_status], [bok_stock]) VALUES (2, N'Java Servlet', N'jyti', 5, 100, 2001, 0, N'Active', 0)
INSERT [dbo].[tbl_Book] ([bok_ID], [bok_name], [bok_author], [bok_edition], [bok_pages], [bok_publish], [srm_ID], [bok_status], [bok_stock]) VALUES (3, N'WPF Tutorial', N'Mr. Grave', 3, 250, 2011, 0, N'Active', 10)
INSERT [dbo].[tbl_Book] ([bok_ID], [bok_name], [bok_author], [bok_edition], [bok_pages], [bok_publish], [srm_ID], [bok_status], [bok_stock]) VALUES (4, N'HTML5 Tutorial', N'Bishal Thapaliya', 5, 150, 2013, 0, N'Active', 15)
INSERT [dbo].[tbl_Book] ([bok_ID], [bok_name], [bok_author], [bok_edition], [bok_pages], [bok_publish], [srm_ID], [bok_status], [bok_stock]) VALUES (5, N'JSP & Servlet', N'Tega Amankhwah', 6, 300, 2014, 0, N'Active', 0)
INSERT [dbo].[tbl_Book] ([bok_ID], [bok_name], [bok_author], [bok_edition], [bok_pages], [bok_publish], [srm_ID], [bok_status], [bok_stock]) VALUES (6, N'C# Tutorial', N'Mr. Donald', 3, 500, 2015, 0, N'Unavailable', 4)
INSERT [dbo].[tbl_Book] ([bok_ID], [bok_name], [bok_author], [bok_edition], [bok_pages], [bok_publish], [srm_ID], [bok_status], [bok_stock]) VALUES (7, N'C# asp.net', N'jyoti', 1, 100, 2015, 0, N'Available', 99)
SET IDENTITY_INSERT [dbo].[tbl_Book] OFF
SET IDENTITY_INSERT [dbo].[tbl_BookRegister] ON 

INSERT [dbo].[tbl_BookRegister] ([br_ID], [br_date], [mem_ID], [br_num], [bok_ID], [br_outDate], [br_inDate], [br_qty], [br_fine], [br_status], [br_outin]) VALUES (1, NULL, 1, NULL, 3, CAST(N'2016-06-07' AS Date), CAST(N'2016-06-25' AS Date), NULL, NULL, NULL, 0)
INSERT [dbo].[tbl_BookRegister] ([br_ID], [br_date], [mem_ID], [br_num], [bok_ID], [br_outDate], [br_inDate], [br_qty], [br_fine], [br_status], [br_outin]) VALUES (3, NULL, 1, NULL, 3, CAST(N'2016-06-10' AS Date), CAST(N'2016-06-27' AS Date), NULL, NULL, NULL, 0)
INSERT [dbo].[tbl_BookRegister] ([br_ID], [br_date], [mem_ID], [br_num], [bok_ID], [br_outDate], [br_inDate], [br_qty], [br_fine], [br_status], [br_outin]) VALUES (4, NULL, 1, NULL, 6, CAST(N'2016-06-29' AS Date), CAST(N'2016-06-25' AS Date), NULL, NULL, NULL, 0)
INSERT [dbo].[tbl_BookRegister] ([br_ID], [br_date], [mem_ID], [br_num], [bok_ID], [br_outDate], [br_inDate], [br_qty], [br_fine], [br_status], [br_outin]) VALUES (5, NULL, 3, NULL, 6, CAST(N'2016-06-20' AS Date), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[tbl_BookRegister] ([br_ID], [br_date], [mem_ID], [br_num], [bok_ID], [br_outDate], [br_inDate], [br_qty], [br_fine], [br_status], [br_outin]) VALUES (6, NULL, 4, NULL, 7, CAST(N'2016-06-27' AS Date), NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[tbl_BookRegister] ([br_ID], [br_date], [mem_ID], [br_num], [bok_ID], [br_outDate], [br_inDate], [br_qty], [br_fine], [br_status], [br_outin]) VALUES (7, NULL, 3, NULL, 7, CAST(N'2016-06-26' AS Date), CAST(N'2016-06-27' AS Date), NULL, NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[tbl_BookRegister] OFF
SET IDENTITY_INSERT [dbo].[tbl_Member] ON 

INSERT [dbo].[tbl_Member] ([mem_ID], [mem_name], [mem_email], [mem_address], [mem_mobile], [mem_dob], [mem_doj], [pln_name], [mem_status], [pln_ID]) VALUES (1, N'Bishal Thapaliya', N'bishal@thapaliya.com', N'Technopole', N'951753846', CAST(N'1985-09-19' AS Date), CAST(N'2015-09-14' AS Date), N'Plan 1', N'Active', NULL)
INSERT [dbo].[tbl_Member] ([mem_ID], [mem_name], [mem_email], [mem_address], [mem_mobile], [mem_dob], [mem_doj], [pln_name], [mem_status], [pln_ID]) VALUES (2, N'Jyoti Adhikari', N'jyoti@adhikari.com', N'Rouvray', N'987456756', CAST(N'1985-09-11' AS Date), CAST(N'2015-09-09' AS Date), N'Plan 2', N'Active', NULL)
INSERT [dbo].[tbl_Member] ([mem_ID], [mem_name], [mem_email], [mem_address], [mem_mobile], [mem_dob], [mem_doj], [pln_name], [mem_status], [pln_ID]) VALUES (3, N'Wai bo', N'wa@a.com', N'Rouen', N'1212', CAST(N'2016-06-27' AS Date), CAST(N'2016-06-28' AS Date), N'Plan 1', N'Active', 1)
INSERT [dbo].[tbl_Member] ([mem_ID], [mem_name], [mem_email], [mem_address], [mem_mobile], [mem_dob], [mem_doj], [pln_name], [mem_status], [pln_ID]) VALUES (4, N'Tega Philip', N'tega@philip.com', N'Technopole', N'98746512', CAST(N'2016-06-06' AS Date), CAST(N'2016-06-20' AS Date), N'Plan 2', N'Active', 2)
SET IDENTITY_INSERT [dbo].[tbl_Member] OFF
SET IDENTITY_INSERT [dbo].[tbl_Plan] ON 

INSERT [dbo].[tbl_Plan] ([pln_ID], [pln_name], [pln_doc], [pln_bookLimit], [pln_bookHold], [pln_validity], [pln_amount], [pln_discount], [pln_status]) VALUES (1, N'Plan 1', CAST(N'2016-05-31' AS Date), 10, 5, 10, 100, 20, N'Active')
INSERT [dbo].[tbl_Plan] ([pln_ID], [pln_name], [pln_doc], [pln_bookLimit], [pln_bookHold], [pln_validity], [pln_amount], [pln_discount], [pln_status]) VALUES (2, N'Plan 2', CAST(N'2016-06-25' AS Date), 10, 10, 10, 1, 1, N'Active')
SET IDENTITY_INSERT [dbo].[tbl_Plan] OFF
SET IDENTITY_INSERT [dbo].[tbl_Profile] ON 

INSERT [dbo].[tbl_Profile] ([pro_ID], [pro_name], [pro_email], [pro_mobile], [pro_password], [pro_address], [rol_roleName], [pro_status]) VALUES (1, N'Admin', N'admin@esigelec.com', N'123456789', N'admin', N'Rouen', N'admin', N'active')
INSERT [dbo].[tbl_Profile] ([pro_ID], [pro_name], [pro_email], [pro_mobile], [pro_password], [pro_address], [rol_roleName], [pro_status]) VALUES (2, N'Bishal', N'bishal@esigelec.com', N'987654321', N'bishal', N'Rouen', N'admin', N'active')
INSERT [dbo].[tbl_Profile] ([pro_ID], [pro_name], [pro_email], [pro_mobile], [pro_password], [pro_address], [rol_roleName], [pro_status]) VALUES (4, N'Prince Ogenokoho', N'prince@philip.com', N'423756981', N'prince', N'Technopole', N'Admin', N'Inactive')
INSERT [dbo].[tbl_Profile] ([pro_ID], [pro_name], [pro_email], [pro_mobile], [pro_password], [pro_address], [rol_roleName], [pro_status]) VALUES (5, N'Samuel Grave', N'samual@esigelec.fr', N'123456', N'samual', N'Rouen', N'Admin', N'Active')
SET IDENTITY_INSERT [dbo].[tbl_Profile] OFF
SET IDENTITY_INSERT [dbo].[tbl_Purchase] ON 

INSERT [dbo].[tbl_Purchase] ([pur_ID], [pur_date], [pur_from], [pur_num], [bok_ID], [bok_name], [pur_qty], [pur_rate], [pur_amount], [pur_status]) VALUES (1, CAST(N'2016-06-25' AS Date), N'abc Supplier', 0, 1, N'Java Core', 10, 110, 1100, N'Paid')
INSERT [dbo].[tbl_Purchase] ([pur_ID], [pur_date], [pur_from], [pur_num], [bok_ID], [bok_name], [pur_qty], [pur_rate], [pur_amount], [pur_status]) VALUES (2, CAST(N'2016-05-31' AS Date), N'Abc Suppliers', 0, 3, N'WPF Tutorial', 10, 50, 500, N'Paid')
INSERT [dbo].[tbl_Purchase] ([pur_ID], [pur_date], [pur_from], [pur_num], [bok_ID], [bok_name], [pur_qty], [pur_rate], [pur_amount], [pur_status]) VALUES (3, CAST(N'2016-06-15' AS Date), N'Xyz supplier', 0, 4, N'HTML5 Tutorial', 15, 30, 450, N'Paid')
INSERT [dbo].[tbl_Purchase] ([pur_ID], [pur_date], [pur_from], [pur_num], [bok_ID], [bok_name], [pur_qty], [pur_rate], [pur_amount], [pur_status]) VALUES (5, CAST(N'2016-06-27' AS Date), N'rouen store', 0, 7, N'C# asp.net', 100, 10, 1000, N'Paid')
SET IDENTITY_INSERT [dbo].[tbl_Purchase] OFF
SET IDENTITY_INSERT [dbo].[tbl_section] ON 

INSERT [dbo].[tbl_section] ([sec_ID], [sec_name], [sec_status]) VALUES (1, N'Computer Science', N'Active')
INSERT [dbo].[tbl_section] ([sec_ID], [sec_name], [sec_status]) VALUES (2, N'Mathematics', N'Active')
INSERT [dbo].[tbl_section] ([sec_ID], [sec_name], [sec_status]) VALUES (3, N'Electronics', N'Active')
INSERT [dbo].[tbl_section] ([sec_ID], [sec_name], [sec_status]) VALUES (4, N'Electrical Engineering', N'Active')
SET IDENTITY_INSERT [dbo].[tbl_section] OFF
SET IDENTITY_INSERT [dbo].[tbl_Wish] ON 

INSERT [dbo].[tbl_Wish] ([wishID], [bookID], [memberID], [status]) VALUES (1, 2, 2, 1)
INSERT [dbo].[tbl_Wish] ([wishID], [bookID], [memberID], [status]) VALUES (2, 2, 3, 0)
SET IDENTITY_INSERT [dbo].[tbl_Wish] OFF
ALTER TABLE [dbo].[tbl_BookRegister]  WITH CHECK ADD  CONSTRAINT [FK_tbl_BookRegister_tbl_Book] FOREIGN KEY([bok_ID])
REFERENCES [dbo].[tbl_Book] ([bok_ID])
GO
ALTER TABLE [dbo].[tbl_BookRegister] CHECK CONSTRAINT [FK_tbl_BookRegister_tbl_Book]
GO
ALTER TABLE [dbo].[tbl_BookRegister]  WITH CHECK ADD  CONSTRAINT [FK_tbl_BookRegister_tbl_Member] FOREIGN KEY([mem_ID])
REFERENCES [dbo].[tbl_Member] ([mem_ID])
GO
ALTER TABLE [dbo].[tbl_BookRegister] CHECK CONSTRAINT [FK_tbl_BookRegister_tbl_Member]
GO
ALTER TABLE [dbo].[tbl_Member]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Member_tbl_Plan] FOREIGN KEY([pln_ID])
REFERENCES [dbo].[tbl_Plan] ([pln_ID])
GO
ALTER TABLE [dbo].[tbl_Member] CHECK CONSTRAINT [FK_tbl_Member_tbl_Plan]
GO
ALTER TABLE [dbo].[tbl_Purchase]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Purchase_tbl_Book] FOREIGN KEY([bok_ID])
REFERENCES [dbo].[tbl_Book] ([bok_ID])
GO
ALTER TABLE [dbo].[tbl_Purchase] CHECK CONSTRAINT [FK_tbl_Purchase_tbl_Book]
GO
/****** Object:  StoredProcedure [dbo].[proc_book_getByID]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_book_getByID] 
	-- Add the parameters for the stored procedure here
	@bok_ID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   SELECT * FROM tbl_Book
   WHERE bok_ID = @bok_ID
   
END

GO
/****** Object:  StoredProcedure [dbo].[proc_book_getList]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_book_getList] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT * FROM tbl_Book
	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_book_inout]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_book_inout] 
	-- Add the parameters for the stored procedure her
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT tbl_Book.bok_ID, tbl_Book.bok_name ,
	(SELECT COUNT(*) FROM tbl_BookRegister 
	WHERE bok_ID = tbl_Book.bok_ID AND tbl_BookRegister.br_outin = 1) AS Bookout ,
	(SELECT bok_stock FROM tbl_Book WHERE bok_ID = tbl_BookRegister.bok_ID) AS Stock
	FROM  tbl_BookRegister
	INNER JOIN	tbl_Book
	ON tbl_BookRegister.bok_ID = tbl_Book.bok_ID
	AND tbl_BookRegister.br_outin = 1
   
END

GO
/****** Object:  StoredProcedure [dbo].[proc_book_List]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_book_List] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

    SELECT * FROM tbl_Book
	WHERE tbl_Book.bok_stock = 0 

	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_book_remove]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_book_remove] 
	-- Add the parameters for the stored procedure here
	@bok_ID INT
AS
BEGIN
	DELETE FROM tbl_Book
	WHERE bok_ID = @bok_ID
END

GO
/****** Object:  StoredProcedure [dbo].[proc_book_save]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_book_save] 
	-- Add the parameters for the stored procedure here
	@bok_ID INT,
	@bok_name VARCHAR(50),
	@bok_author VARCHAR(50),
	@bok_edition INT,
	@bok_pages INT,
	@bok_publish INT,
	@srm_ID INT,
	@bok_status VARCHAR(20)
AS
BEGIN
	
	IF(@bok_ID IS NULL OR @bok_ID = 0)
	
	BEGIN
	INSERT INTO tbl_Book (bok_name, bok_author, bok_edition, bok_pages, bok_publish, srm_ID, bok_status)
	VALUES(@bok_name, @bok_author, @bok_edition, @bok_pages, @bok_publish, @srm_ID, @bok_status)

	END
	ELSE
	BEGIN
	UPDATE tbl_Book
	SET 
		bok_name = @bok_name,
		bok_author = @bok_author,
		bok_edition = @bok_edition,
		bok_pages = @bok_pages,
		bok_publish = @bok_publish,
		srm_ID = @srm_ID,
		bok_status = @bok_status
	WHERE
		bok_ID = @bok_ID
	END
END

GO
/****** Object:  StoredProcedure [dbo].[proc_book_search]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_book_search]
	-- Add the parameters for the stored procedure here
	@bok_name VARCHAR(50)
AS
BEGIN
	SELECT * FROM tbl_Book
	WHERE bok_name LIKE '%' + @bok_name + '%'
	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_bookRegister_getByBookID]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_bookRegister_getByBookID] 
	-- Add the parameters for the stored procedure here
	@bok_ID int , 
	@flag int -- 0 for book , 1 for member , 2 - for all

AS
BEGIN
	Declare @sql varchar(max)
	set @sql = 'Select tbl_BookRegister.* , tbl_Book.bok_name , 
	tbl_Member.mem_name 
	FROM tbl_BookRegister
	INNER JOIN tbl_Book
	ON tbl_BookRegister.bok_ID = tbl_Book.bok_ID
	INNER JOIN tbl_Member
	ON
	tbl_BookRegister.mem_ID = tbl_Member.mem_ID
	AND
	tbl_BookRegister.br_outin = 1 '  
	IF (@flag = 0 ) begin
		set @sql = @sql + '	AND tbl_BookRegister.bok_ID = ' + '''' + convert(varchar(10),@bok_ID,116) + ''''
	end
	else if(@flag = 1) begin
		set @sql = @sql + '	AND tbl_BookRegister.mem_ID = ' + '''' + convert(varchar(10),@bok_ID,116) + ''''
	end
	else 
	set @sql = @sql

	exec(@sql)

	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_bookRegister_getByID]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_bookRegister_getByID] 
	-- Add the parameters for the stored procedure here
	@br_ID INT

AS
BEGIN
	
	SELECT * FROM tbl_BookRegister
	WHERE br_ID = @br_ID
	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_bookRegister_getList]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_bookRegister_getList] 
	-- Add the parameters for the stored procedure here
	

AS
BEGIN
	
	SELECT * FROM tbl_BookRegister
	
	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_bookRegister_remove]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_bookRegister_remove] 
	-- Add the parameters for the stored procedure here
	@br_ID INT

AS
BEGIN
	
	DELETE FROM tbl_BookRegister 
	WHERE br_ID = @br_ID

END

GO
/****** Object:  StoredProcedure [dbo].[proc_bookRegister_save]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_bookRegister_save] 
	-- Add the parameters for the stored procedure here
	@br_ID INT,
	@br_date DATE,
	@mem_ID INT,
--	//@br_num INT,
	@bok_ID INT,
	--@br_outDate DATE,
	--//@br_inDate DATE,
	--//@br_qty INT,
--	@br_fine FLOAT,
--	@br_status VARCHAR(20) , 
	@br_outin int
	
AS
BEGIN
 

 if(@br_outin = 1) 
 Begin
     IF(@br_ID IS NULL OR @br_ID = 0)
		BEGIN
			INSERT INTO tbl_BookRegister
				( mem_ID, bok_ID, br_outin , br_outDate)
			VALUES
				( @mem_ID, @bok_ID  ,  @br_outin , @br_date)
		END
 End

 /*
	IF(@br_ID IS NULL OR @br_ID = 0)
	BEGIN
		INSERT INTO tbl_BookRegister
			(br_date, mem_ID, br_num, bok_ID, br_outDate, br_inDate, br_qty, br_fine, br_status, br_outin)
		VALUES
			(@br_date, @mem_ID, @br_num, @bok_ID, @br_outDate, @br_inDate, @br_qty, @br_fine, @br_status , @br_outin)
	END
	ELSE
	BEGIN
		UPDATE tbl_BookRegister
		SET br_date = @br_date,
			mem_ID = @mem_ID,
			br_num = @br_num,
			bok_ID = @bok_ID,
			br_outDate = @br_outDate,
			br_inDate = @br_inDate,
			br_qty = @br_qty,
			br_fine = @br_fine,
			br_status = @br_status,
			br_outin = @br_outin
		WHERE
			br_ID = @br_ID
	END

	*/

END

GO
/****** Object:  StoredProcedure [dbo].[proc_bookRegisterin_save]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_bookRegisterin_save] 
	-- Add the parameters for the stored procedure here
	@br_ID INT
	
AS
BEGIN
 

 Update tbl_BookRegister set
 br_inDate = getdate(),
 br_outin = 0 
 where br_ID = @br_ID
 /*
	IF(@br_ID IS NULL OR @br_ID = 0)
	BEGIN
		INSERT INTO tbl_BookRegister
			(br_date, mem_ID, br_num, bok_ID, br_outDate, br_inDate, br_qty, br_fine, br_status, br_outin)
		VALUES
			(@br_date, @mem_ID, @br_num, @bok_ID, @br_outDate, @br_inDate, @br_qty, @br_fine, @br_status , @br_outin)
	END
	ELSE
	BEGIN
		UPDATE tbl_BookRegister
		SET br_date = @br_date,
			mem_ID = @mem_ID,
			br_num = @br_num,
			bok_ID = @bok_ID,
			br_outDate = @br_outDate,
			br_inDate = @br_inDate,
			br_qty = @br_qty,
			br_fine = @br_fine,
			br_status = @br_status,
			br_outin = @br_outin
		WHERE
			br_ID = @br_ID
	END

	*/

END

GO
/****** Object:  StoredProcedure [dbo].[proc_Login]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_Login] 
	-- Add the parameters for the stored procedure here
	@username VARCHAR(50),
	@password VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT pro_ID as proid FROM tbl_Profile
	WHERE pro_name = @username AND pro_password = @password
END

GO
/****** Object:  StoredProcedure [dbo].[proc_member_getByID]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_member_getByID]
	-- Add the parameters for the stored procedure here
	@mem_ID INT
AS
BEGIN
	
	SELECT * FROM tbl_Member
	WHERE mem_ID = @mem_ID;
	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_member_getList]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_member_getList]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	
	SELECT * FROM tbl_Member
	
	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_member_remove]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_member_remove]
	-- Add the parameters for the stored procedure here
	@mem_ID INT
AS
BEGIN
	
	DELETE FROM tbl_Member
	WHERE mem_ID = @mem_ID;
	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_member_save]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_member_save] 
	-- Add the parameters for the stored procedure here
	@mem_ID INT,
	@mem_name VARCHAR(50),
	@mem_email VARCHAR(50),
	@mem_address VARCHAR(50),
	@mem_mobile VARCHAR(50),
	@mem_dob DATE,
	@mem_doj DATE,
	@pln_name VARCHAR(50),
	@mem_status VARCHAR(20)
AS
BEGIN
	
	Declare @pln_id int
	SELECT @pln_id = pln_ID FROM  tbl_Plan
	WHERE pln_name = @pln_name
	IF (@mem_ID IS NULL OR @mem_ID = 0)
	BEGIN 
		INSERT INTO tbl_Member (mem_name, mem_email, mem_address, mem_mobile, mem_dob, mem_doj, pln_name, mem_status,pln_ID)
		VALUES(@mem_name, @mem_email, @mem_address, @mem_mobile, @mem_dob, @mem_doj, @pln_name, @mem_status , @pln_id)
	END
	ELSE
	BEGIN
		UPDATE tbl_Member
		SET mem_name = @mem_name,
			mem_email = @mem_email,
			mem_address = @mem_address,
			mem_mobile = @mem_mobile,
			mem_dob = @mem_dob,
			mem_doj = @mem_doj,
			pln_name = @pln_name,
			mem_status = @mem_status,
			pln_ID = @pln_id
		WHERE 
			mem_ID = @mem_ID
	END

END

GO
/****** Object:  StoredProcedure [dbo].[proc_member_search]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_member_search]
	-- Add the parameters for the stored procedure here
	@mem_name VARCHAR(50)
AS
BEGIN
	SELECT * FROM tbl_Member
	WHERE mem_name LIKE '%' + @mem_name + '%'
	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_plan_getByID]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_plan_getByID]
	-- Add the parameters for the stored procedure here
	@pln_ID INT
AS
BEGIN
	
	SELECT * FROM tbl_Plan
	WHERE pln_ID = @pln_ID	
	
	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_plan_getList]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_plan_getList]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	
	SELECT * FROM tbl_Plan
	
	
	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_plan_remove]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_plan_remove]
	-- Add the parameters for the stored procedure here
	@pln_ID INT
AS
BEGIN
	
	DELETE FROM tbl_Plan
	WHERE pln_ID = @pln_ID	
	
	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_plan_save]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_plan_save]
	-- Add the parameters for the stored procedure here
	@pln_ID INT,
	@pln_name VARCHAR(50),
	@pln_doc DATE,
	@pln_bookLimit INT,
	@pln_bookHold INT,
	@pln_validity INT,
	@pln_amount FLOAT,
	@pln_discount FLOAT,
	@pln_status VARCHAR(20)

AS
BEGIN
	
	IF(@pln_ID IS NULL OR @pln_ID = 0)
	BEGIN
		INSERT INTO tbl_Plan (pln_name, pln_doc, pln_bookLimit, pln_bookHold, pln_validity, pln_amount, pln_discount, pln_status)
		VALUES(@pln_name, @pln_doc, @pln_bookLimit, @pln_bookHold, @pln_validity, @pln_amount, @pln_discount, @pln_status)
	END
	ELSE
	BEGIN
		UPDATE tbl_Plan
		SET pln_name = @pln_name,
			pln_doc = @pln_doc,
			pln_bookLimit = @pln_bookLimit,
			pln_bookHold = @pln_bookHold,
			pln_validity = @pln_validity,
			pln_amount = @pln_amount,
			pln_discount = @pln_discount,
			pln_status = @pln_status
		WHERE pln_ID = @pln_ID
	END	
	
	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_plan_search]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_plan_search]
	-- Add the parameters for the stored procedure here
	@pln_name VARCHAR(50)
AS
BEGIN
	SELECT * FROM tbl_Plan
	WHERE pln_name LIKE '%' + @pln_name + '%'
	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_profile_getByID]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_profile_getByID]
	-- Add the parameters for the stored procedure here
	@pro_ID INT
AS
BEGIN
	SELECT * FROM tbl_Profile
	WHERE pro_ID = @pro_ID
	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_profile_getList]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_profile_getList]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	SELECT * FROM tbl_Profile
	
	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_profile_remove]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_profile_remove]
	-- Add the parameters for the stored procedure here
	@pro_ID INT
AS
BEGIN
	DELETE FROM tbl_Profile
	WHERE pro_ID = @pro_ID
	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_profile_save]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_profile_save]
	-- Add the parameters for the stored procedure here
	@pro_ID INT,
	@pro_name VARCHAR(50),
	@pro_email VARCHAR(50),
	@pro_mobile VARCHAR(50),
	@pro_password VARCHAR(50),
	@pro_address VARCHAR(50),
	@rol_roleName VARCHAR(50),
	@pro_status VARCHAR(20)
AS
BEGIN
	
	IF(@pro_ID IS NULL OR @pro_ID = 0)
	BEGIN
		INSERT INTO tbl_Profile (pro_name, pro_email, pro_mobile, pro_password, pro_address, rol_roleName, pro_status)
		VALUES(@pro_name, @pro_email, @pro_mobile, @pro_password, @pro_address, @rol_roleName, @pro_status)
	END
	ELSE
	BEGIN
		UPDATE tbl_Profile
		SET	pro_name = @pro_name,
			pro_email = @pro_email,
			pro_mobile = @pro_mobile,
			pro_password = @pro_password,
			pro_address = @pro_address,
			rol_roleName = @rol_roleName,
			pro_status = @pro_status
		WHERE pro_ID = @pro_ID
	END
	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_profile_search]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_profile_search]
	-- Add the parameters for the stored procedure here
	@pro_name VARCHAR(50)
AS
BEGIN
	SELECT * FROM tbl_Profile
	WHERE pro_name LIKE '%' + @pro_name + '%'
	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_purchase_getByID]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_purchase_getByID]
	-- Add the parameters for the stored procedure here
	@pur_ID INT
AS
BEGIN
	SELECT * FROM tbl_Purchase
	WHERE pur_ID = @pur_ID
END

GO
/****** Object:  StoredProcedure [dbo].[proc_purchase_getList]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_purchase_getList]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	SELECT * FROM tbl_Purchase
	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_purchase_remove]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_purchase_remove]
	-- Add the parameters for the stored procedure here
	@pur_ID INT
AS
BEGIN
	DELETE FROM tbl_Purchase
	WHERE pur_ID = @pur_ID
END

GO
/****** Object:  StoredProcedure [dbo].[proc_purchase_save]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_purchase_save]
	-- Add the parameters for the stored procedure here
	@pur_ID INT,
	@pur_date DATE,
	@pur_from VARCHAR(50),
	@pur_num INT,
	@bok_ID INT,
	@bok_name VARCHAR(50),
	@pur_qty INT,
	@pur_rate FLOAT,
	@pur_amount FLOAT,
	@pur_status VARCHAR(20)
AS
BEGIN
	IF(@pur_ID IS NULL OR @pur_ID = 0)
	BEGIN
		INSERT INTO tbl_Purchase (pur_date, pur_from, pur_num, bok_ID, bok_name, pur_qty, pur_rate, pur_amount, pur_status)
		VALUES(@pur_date, @pur_from, @pur_num, @bok_ID, @bok_name, @pur_qty, @pur_rate, @pur_amount, @pur_status)
	END
	ELSE
	BEGIN
		UPDATE tbl_Purchase
		SET pur_date = @pur_date,
			pur_from = @pur_from,
			pur_num =  @pur_num,
			bok_ID = @bok_ID,
			bok_name = @bok_name,
			pur_qty = @pur_qty,
			pur_rate = @pur_rate,
			pur_amount = @pur_amount,
			pur_status = @pur_status
		WHERE pur_ID = @pur_ID
	END
END

GO
/****** Object:  StoredProcedure [dbo].[proc_rack_getByID]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_rack_getByID]
	-- Add the parameters for the stored procedure here
	@rck_ID INT
AS
BEGIN
	SELECT * FROM tbl_Rack
	WHERE rck_ID = @rck_ID
END

GO
/****** Object:  StoredProcedure [dbo].[proc_rack_getList]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_rack_getList]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	SELECT * FROM tbl_Rack
	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_rack_remove]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_rack_remove]
	-- Add the parameters for the stored procedure here
	@rck_ID INT
AS
BEGIN
	DELETE FROM tbl_Rack
	WHERE rck_ID = @rck_ID
END

GO
/****** Object:  StoredProcedure [dbo].[proc_rack_save]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_rack_save]
	-- Add the parameters for the stored procedure here
	@rck_ID INT,
	@rck_name VARCHAR(50),
	@rck_status VARCHAR(20)
AS
BEGIN
	IF(@rck_ID IS NULL OR @rck_ID = 0)
	BEGIN
		INSERT INTO tbl_Rack(rck_name, rck_status)
		VALUES(@rck_name, @rck_status)
	END
	ELSE
	BEGIN
		UPDATE tbl_Rack
		SET rck_name = @rck_name,
			rck_status = @rck_status
		WHERE rck_ID = @rck_ID
	END
END

GO
/****** Object:  StoredProcedure [dbo].[proc_rack_search]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_rack_search]
	-- Add the parameters for the stored procedure here
	@rck_name VARCHAR(50)
AS
BEGIN
	SELECT * FROM tbl_Rack
	WHERE rck_name LIKE '%' + @rck_name + '%'
	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_role_getByID]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_role_getByID]
	-- Add the parameters for the stored procedure here
	@rol_ID INT
AS
BEGIN
	SELECT * FROM tbl_Role
	WHERE rol_ID = @rol_ID
END

GO
/****** Object:  StoredProcedure [dbo].[proc_role_getList]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_role_getList]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	SELECT * FROM tbl_Role
	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_role_remove]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_role_remove]
	-- Add the parameters for the stored procedure here
	@rol_ID INT
AS
BEGIN
	DELETE FROM tbl_Role
	WHERE rol_ID = @rol_ID
END

GO
/****** Object:  StoredProcedure [dbo].[proc_role_save]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_role_save]
	-- Add the parameters for the stored procedure here
	@rol_ID INT,
	@rol_roleName VARCHAR(50),
	@rol_status VARCHAR(20)
AS
BEGIN
	IF(@rol_ID IS NULL OR @rol_ID = 0)
	BEGIN
		INSERT INTO tbl_Role(rol_roleName, rol_status)
		VALUES(@rol_roleName, @rol_status)
	END
	ELSE
	BEGIN
		UPDATE tbl_Role
		SET rol_roleName = @rol_roleName,
			rol_status = @rol_status
		WHERE rol_ID = @rol_ID
	END

END

GO
/****** Object:  StoredProcedure [dbo].[proc_role_search]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_role_search]
	-- Add the parameters for the stored procedure here
	@rol_rolName VARCHAR(50)
AS
BEGIN
	SELECT * FROM tbl_Role
	WHERE rol_roleName LIKE '%' + @rol_rolName + '%'
	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_secRackMap_getByID]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_secRackMap_getByID]
	-- Add the parameters for the stored procedure here
	@srm_ID INT
AS
BEGIN
	SELECT * FROM tbl_SectionRackMap
	WHERE srm_ID = @srm_ID
END

GO
/****** Object:  StoredProcedure [dbo].[proc_secRackMap_getList]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_secRackMap_getList]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	SELECT * FROM tbl_SectionRackMap
	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_secRackMap_remove]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_secRackMap_remove]
	-- Add the parameters for the stored procedure here
	@srm_ID INT
AS
BEGIN
	DELETE FROM tbl_SectionRackMap
	WHERE srm_ID = @srm_ID
END

GO
/****** Object:  StoredProcedure [dbo].[proc_secRackMap_save]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_secRackMap_save]
	-- Add the parameters for the stored procedure here
	@srm_ID INT,
	@sec_ID INT,
	@rck_ID INT,
	@srm_print VARCHAR(50),
	@srm_status VARCHAR(20)
AS
BEGIN
	IF(@srm_ID IS NULL OR @srm_ID=0)
	BEGIN
		INSERT INTO tbl_SectionRackMap (sec_ID, rck_ID, srm_print, srm_status)
		VALUES(@sec_ID, @rck_ID, @srm_print, @srm_status)
	END
	ELSE
	BEGIN
		UPDATE tbl_SectionRackMap
		SET	sec_ID = @sec_ID,
			rck_ID = @rck_ID,
			srm_print = @srm_print,
			srm_status = @srm_status
		WHERE srm_ID = @srm_ID
	END
END

GO
/****** Object:  StoredProcedure [dbo].[proc_section_getByID]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_section_getByID]
	-- Add the parameters for the stored procedure here
	@sec_ID INT
AS
BEGIN
	SELECT * FROM tbl_section
	WHERE sec_ID = @sec_ID
END

GO
/****** Object:  StoredProcedure [dbo].[proc_section_getList]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_section_getList]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	SELECT * FROM tbl_section
	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_section_remove]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_section_remove]
	-- Add the parameters for the stored procedure here
	@sec_ID INT
AS
BEGIN
	DELETE FROM tbl_section
	WHERE sec_ID = @sec_ID
END

GO
/****** Object:  StoredProcedure [dbo].[proc_section_save]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_section_save]
	-- Add the parameters for the stored procedure here
	@sec_ID INT,
	@sec_name VARCHAR(50),
	@sec_status VARCHAR(20)
AS
BEGIN
	IF(@sec_ID IS NULL OR @sec_ID = 0)
	BEGIN
		INSERT INTO tbl_section(sec_name, sec_status)
		VALUES(@sec_name, @sec_status)
	END
	ELSE
	BEGIN
		UPDATE tbl_section
		SET sec_name = @sec_name,
			sec_status = @sec_status
		WHERE sec_ID = @sec_ID
	END
		
END

GO
/****** Object:  StoredProcedure [dbo].[proc_section_search]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_section_search]
	-- Add the parameters for the stored procedure here
	@sec_name VARCHAR(50)
AS
BEGIN
	SELECT * FROM tbl_section
	WHERE sec_name LIKE '%' + @sec_name + '%'
	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_stock_getByID]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_stock_getByID]
	-- Add the parameters for the stored procedure here
	@stk_id INT
AS
BEGIN
	SELECT * FROM tbl_Stock
	WHERE stk_ID = @stk_id
END

GO
/****** Object:  StoredProcedure [dbo].[proc_stock_getList]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_stock_getList]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	SELECT * FROM tbl_Stock
	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_stock_remove]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_stock_remove]
	-- Add the parameters for the stored procedure here
	@stk_id INT
AS
BEGIN
	DELETE FROM tbl_Stock
	WHERE stk_ID = @stk_id
END

GO
/****** Object:  StoredProcedure [dbo].[proc_stock_save]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_stock_save]
	-- Add the parameters for the stored procedure here
	@stk_id INT,
	@bok_ID INT,
	@bok_name VARCHAR(50),
	@pur_qty INT,
	@stk_status VARCHAR(20) 
AS
BEGIN
	IF(@stk_id IS NULL OR @stk_id = 0)
	BEGIN
		INSERT INTO tbl_Stock(bok_ID, bok_name, pur_qty, stk_status)
		VALUES(@bok_ID, @bok_name, @pur_qty, @stk_status)
	END
	ELSE
	BEGIN
		UPDATE tbl_Stock
		SET bok_ID = @bok_ID,
			bok_name = @bok_name,
			pur_qty = @pur_qty,
			stk_status = @stk_status
		WHERE stk_ID = @stk_id

	END
	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_transaction_getByID]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_transaction_getByID]
	-- Add the parameters for the stored procedure here
	@trn_ID INT
AS
BEGIN
	SELECT * FROM tbl_transaction
	WHERE trn_ID = @trn_ID
END

GO
/****** Object:  StoredProcedure [dbo].[proc_transaction_getList]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_transaction_getList]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	SELECT * FROM tbl_transaction
	
END

GO
/****** Object:  StoredProcedure [dbo].[proc_transaction_remove]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_transaction_remove]
	-- Add the parameters for the stored procedure here
	@trn_ID INT
AS
BEGIN
	DELETE FROM tbl_transaction
	WHERE trn_ID = @trn_ID
END

GO
/****** Object:  StoredProcedure [dbo].[proc_transaction_save]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_transaction_save]
	-- Add the parameters for the stored procedure here
	@trn_ID INT,
	@trn_date DATE,
	@mem_ID INT,
	@mem_name VARCHAR(50),
	@trn_amount FLOAT,
	@trn_fine FLOAT,
	@trn_type VARCHAR(50),
	@trn_status VARCHAR(20)
AS
BEGIN
	IF(@trn_ID IS NULL OR @trn_ID = 0)
	BEGIN
		INSERT INTO tbl_transaction (trn_date, mem_ID, mem_name, trn_amount, trn_fine, trn_type, trn_status)
		VALUES(@trn_date, @mem_ID, @mem_name, @trn_amount, @trn_fine, @trn_type, @trn_status)
	END
	ELSE
	BEGIN
		UPDATE tbl_transaction
		SET trn_date = @trn_date,
			mem_ID = @mem_ID,
			mem_name = @mem_name,
			trn_amount = @trn_amount,
			trn_fine = @trn_fine,
			trn_type = @trn_type,
			trn_status = @trn_status
		WHERE trn_ID = @trn_ID
	END
END

GO
/****** Object:  StoredProcedure [dbo].[proc_wish_list]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_wish_list] 
	-- Add the parameters for the stored procedure her
AS
BEGIN
	
	select tbl_Wish.*, tbl_Book.bok_name , tbl_Member.mem_name 
	from tbl_Wish
	INNER JOIN 
	tbl_Book
	ON tbl_Wish.bookID = tbl_Book.bok_ID
	INNER JOIN
	tbl_Member
	ON
	tbl_Wish.memberID = tbl_Member.mem_ID
	WHERE
	tbl_Wish.status = 0 


END

GO
/****** Object:  StoredProcedure [dbo].[proc_wish_remove]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_wish_remove] 
	-- Add the parameters for the stored procedure her
	@wishid int
AS
BEGIN
	
	UPDATE tbl_Wish set
	status = 1
	where wishID = @wishid
	



END

GO
/****** Object:  StoredProcedure [dbo].[proc_wish_save]    Script Date: 6/27/2016 6:12:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_wish_save] 
	-- Add the parameters for the stored procedure her
	@bookid int,
	@memberid int
AS
BEGIN
	
	
	INSERT INTO tbl_Wish(bookID,memberID)
	VALUES(@bookid , @memberid)



END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 - in / 1 - out' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tbl_BookRegister', @level2type=N'COLUMN',@level2name=N'br_outin'
GO
USE [master]
GO
ALTER DATABASE [DB_LMS] SET  READ_WRITE 
GO
