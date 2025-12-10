USE [master]
GO
/****** Object:  Database [MedRegistryDb]    Script Date: 08.12.2025 0:01:37 ******/
CREATE DATABASE [MedRegistryDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MedRegistryDb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\MedRegistryDb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MedRegistryDb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\MedRegistryDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [MedRegistryDb] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MedRegistryDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MedRegistryDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MedRegistryDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MedRegistryDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MedRegistryDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MedRegistryDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [MedRegistryDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MedRegistryDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MedRegistryDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MedRegistryDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MedRegistryDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MedRegistryDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MedRegistryDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MedRegistryDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MedRegistryDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MedRegistryDb] SET  ENABLE_BROKER 
GO
ALTER DATABASE [MedRegistryDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MedRegistryDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MedRegistryDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MedRegistryDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MedRegistryDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MedRegistryDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MedRegistryDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MedRegistryDb] SET RECOVERY FULL 
GO
ALTER DATABASE [MedRegistryDb] SET  MULTI_USER 
GO
ALTER DATABASE [MedRegistryDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MedRegistryDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MedRegistryDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MedRegistryDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MedRegistryDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MedRegistryDb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'MedRegistryDb', N'ON'
GO
ALTER DATABASE [MedRegistryDb] SET QUERY_STORE = ON
GO
ALTER DATABASE [MedRegistryDb] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [MedRegistryDb]
GO
/****** Object:  Table [dbo].[Appointments]    Script Date: 08.12.2025 0:01:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Appointments](
	[AppointmentID] [int] IDENTITY(1,1) NOT NULL,
	[PatientID] [int] NOT NULL,
	[DoctorID] [int] NOT NULL,
	[AppointmentStart] [datetime] NOT NULL,
	[AppointmentEnd] [datetime] NOT NULL,
	[Status] [nvarchar](50) NULL,
	[Purpose] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[AppointmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doctors]    Script Date: 08.12.2025 0:01:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doctors](
	[DoctorID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[SpecializationID] [int] NOT NULL,
	[LicenseNumber] [nvarchar](50) NULL,
	[WorkExperienceYears] [int] NULL,
	[CabinetNumber] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[DoctorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MedicalRecords]    Script Date: 08.12.2025 0:01:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedicalRecords](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[PatientID] [int] NOT NULL,
	[DoctorID] [int] NOT NULL,
	[AppointmentID] [int] NULL,
	[RecordDate] [datetime] NOT NULL,
	[Diagnosis] [nvarchar](255) NULL,
	[Treatment] [nvarchar](max) NULL,
	[Notes] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Patients]    Script Date: 08.12.2025 0:01:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patients](
	[PatientID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[BirthDate] [date] NULL,
	[Gender] [nvarchar](10) NULL,
	[Address] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[PatientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 08.12.2025 0:01:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Schedule]    Script Date: 08.12.2025 0:01:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Schedule](
	[ScheduleID] [int] IDENTITY(1,1) NOT NULL,
	[DoctorID] [int] NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[IsAvailable] [bit] NULL,
	[WorkDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ScheduleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Specializations]    Script Date: 08.12.2025 0:01:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Specializations](
	[SpecializationID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SpecializationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 08.12.2025 0:01:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[PasswordHash] [nvarchar](255) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[MiddleName] [nvarchar](50) NULL,
	[Phone] [nvarchar](20) NULL,
	[Email] [nvarchar](100) NULL,
	[RoleID] [int] NOT NULL,
	[Address] [nvarchar](255) NULL,
	[MedicalPolicy] [nvarchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Appointments] ON 

INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (1, 1, 1, CAST(N'2025-12-11T09:00:00.000' AS DateTime), CAST(N'2025-12-11T09:30:00.000' AS DateTime), N'Выполнено', N'Консультация')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (2, 2, 2, CAST(N'2025-12-11T10:00:00.000' AS DateTime), CAST(N'2025-12-11T10:30:00.000' AS DateTime), N'Ожидает', N'Осмотр')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (6, 7, 1003, CAST(N'2025-11-13T09:00:00.000' AS DateTime), CAST(N'2025-11-13T09:30:00.000' AS DateTime), N'Ожидает', N'10')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (1003, 4, 3, CAST(N'2025-11-12T15:00:00.000' AS DateTime), CAST(N'2025-11-12T15:30:00.000' AS DateTime), N'Отменено', N'осмотр')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (1004, 7, 1005, CAST(N'2025-11-28T12:15:00.000' AS DateTime), CAST(N'2025-11-28T12:45:00.000' AS DateTime), N'Выполнено', N'Повторный приём')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (1005, 4, 1005, CAST(N'2025-11-28T14:15:00.000' AS DateTime), CAST(N'2025-11-28T14:45:00.000' AS DateTime), N'Отменено', N'Вакцинация')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (1006, 4, 1, CAST(N'2025-11-12T14:00:00.000' AS DateTime), CAST(N'2025-11-12T14:30:00.000' AS DateTime), N'Отменено', N'Консультация')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (1007, 4, 1005, CAST(N'2025-12-03T11:15:00.000' AS DateTime), CAST(N'2025-12-03T11:45:00.000' AS DateTime), N'Выполнено', N'Другое')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (2007, 4, 1004, CAST(N'2025-12-03T12:00:00.000' AS DateTime), CAST(N'2025-12-03T12:30:00.000' AS DateTime), N'Ожидает', N'Консультация')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (2008, 1011, 2, CAST(N'2025-12-01T09:00:00.000' AS DateTime), CAST(N'2025-12-01T09:30:00.000' AS DateTime), N'Ожидает', N'Консультация')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (2009, 1011, 2, CAST(N'2025-12-01T09:30:00.000' AS DateTime), CAST(N'2025-12-01T10:00:00.000' AS DateTime), N'Отменено', N'Сдача анализов')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (2010, 1011, 2, CAST(N'2025-12-01T10:00:00.000' AS DateTime), CAST(N'2025-12-01T10:30:00.000' AS DateTime), N'Выполнено', N'Вакцинация')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (2011, 4, 1005, CAST(N'2025-11-28T10:30:00.000' AS DateTime), CAST(N'2025-11-28T11:00:00.000' AS DateTime), N'Выполнено', N'Консультация')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (2012, 4, 1005, CAST(N'2025-11-28T11:00:00.000' AS DateTime), CAST(N'2025-11-28T11:30:00.000' AS DateTime), N'Выполнено', N'Сдача анализов')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (2013, 7, 1005, CAST(N'2025-12-01T11:30:00.000' AS DateTime), CAST(N'2025-12-01T12:00:00.000' AS DateTime), N'Ожидает', N'Снятие швов')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (2014, 4, 1005, CAST(N'2025-12-02T09:45:00.000' AS DateTime), CAST(N'2025-12-02T10:15:00.000' AS DateTime), N'Выполнено', N'Сдача анализов')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (2015, 4, 1005, CAST(N'2025-12-03T09:00:00.000' AS DateTime), CAST(N'2025-12-03T09:30:00.000' AS DateTime), N'Ожидает', N'Снятие швов')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (3013, 4, 1005, CAST(N'2025-12-05T09:30:00.000' AS DateTime), CAST(N'2025-12-05T10:00:00.000' AS DateTime), N'Отменено', N'Проверка результатов лечения')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (3014, 1013, 1005, CAST(N'2025-12-03T10:30:00.000' AS DateTime), CAST(N'2025-12-03T11:00:00.000' AS DateTime), N'Ожидает', N'Повторный приём')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (3015, 1013, 1005, CAST(N'2025-12-04T08:45:00.000' AS DateTime), CAST(N'2025-12-04T09:15:00.000' AS DateTime), N'Выполнено', N'Вакцинация')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (3016, 1013, 1005, CAST(N'2025-12-04T10:15:00.000' AS DateTime), CAST(N'2025-12-04T10:45:00.000' AS DateTime), N'Отменено', N'Плановый осмотр')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (3017, 4, 1005, CAST(N'2025-12-06T10:00:00.000' AS DateTime), CAST(N'2025-12-06T10:30:00.000' AS DateTime), N'Ожидает', N'Снятие швов')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (3018, 1013, 1005, CAST(N'2025-12-06T09:15:00.000' AS DateTime), CAST(N'2025-12-06T09:45:00.000' AS DateTime), N'Ожидает', N'Повторный приём')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (3019, 1013, 1005, CAST(N'2025-12-06T11:15:00.000' AS DateTime), CAST(N'2025-12-06T11:45:00.000' AS DateTime), N'Ожидает', N'Получение справки')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (3020, 1013, 1005, CAST(N'2025-12-06T12:45:00.000' AS DateTime), CAST(N'2025-12-06T13:15:00.000' AS DateTime), N'Ожидает', N'Выписка рецепта')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (3021, 1013, 1005, CAST(N'2025-12-05T10:00:00.000' AS DateTime), CAST(N'2025-12-05T10:30:00.000' AS DateTime), N'Выполнено', N'Консультация')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (3022, 1013, 1005, CAST(N'2025-12-05T09:15:00.000' AS DateTime), CAST(N'2025-12-05T09:45:00.000' AS DateTime), N'Выполнено', N'Консультация')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (3023, 1013, 1005, CAST(N'2025-12-05T13:15:00.000' AS DateTime), CAST(N'2025-12-05T13:45:00.000' AS DateTime), N'Отменено', N'Вакцинация')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (3024, 1013, 1005, CAST(N'2025-12-06T10:30:00.000' AS DateTime), CAST(N'2025-12-06T11:00:00.000' AS DateTime), N'Ожидает', N'Проверка результатов лечения')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (3025, 1014, 1005, CAST(N'2025-12-06T19:30:00.000' AS DateTime), CAST(N'2025-12-06T20:00:00.000' AS DateTime), N'Ожидает', N'Сдача анализов')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (3026, 1014, 1005, CAST(N'2025-12-06T18:30:00.000' AS DateTime), CAST(N'2025-12-06T19:00:00.000' AS DateTime), N'Ожидает', N'Повторный приём')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (3027, 1014, 1005, CAST(N'2025-12-06T16:45:00.000' AS DateTime), CAST(N'2025-12-06T17:15:00.000' AS DateTime), N'Ожидает', N'Сдача анализов')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (3028, 1014, 1005, CAST(N'2025-12-07T14:30:00.000' AS DateTime), CAST(N'2025-12-07T15:00:00.000' AS DateTime), N'Отменено', N'Повторный приём')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (3029, 1014, 1005, CAST(N'2025-12-07T17:45:00.000' AS DateTime), CAST(N'2025-12-07T18:15:00.000' AS DateTime), N'Выполнено', N'Консультация')
INSERT [dbo].[Appointments] ([AppointmentID], [PatientID], [DoctorID], [AppointmentStart], [AppointmentEnd], [Status], [Purpose]) VALUES (3030, 1014, 1005, CAST(N'2025-12-07T09:00:00.000' AS DateTime), CAST(N'2025-12-07T09:30:00.000' AS DateTime), N'Ожидает', N'Консультация')
SET IDENTITY_INSERT [dbo].[Appointments] OFF
GO
SET IDENTITY_INSERT [dbo].[Doctors] ON 

INSERT [dbo].[Doctors] ([DoctorID], [UserID], [SpecializationID], [LicenseNumber], [WorkExperienceYears], [CabinetNumber]) VALUES (1, 3, 1, N'LIC-001', 8, N'101')
INSERT [dbo].[Doctors] ([DoctorID], [UserID], [SpecializationID], [LicenseNumber], [WorkExperienceYears], [CabinetNumber]) VALUES (2, 4, 2, N'LIC-002', 12, N'202')
INSERT [dbo].[Doctors] ([DoctorID], [UserID], [SpecializationID], [LicenseNumber], [WorkExperienceYears], [CabinetNumber]) VALUES (3, 12, 2, NULL, NULL, N'444')
INSERT [dbo].[Doctors] ([DoctorID], [UserID], [SpecializationID], [LicenseNumber], [WorkExperienceYears], [CabinetNumber]) VALUES (1003, 1012, 4, NULL, NULL, N'о')
INSERT [dbo].[Doctors] ([DoctorID], [UserID], [SpecializationID], [LicenseNumber], [WorkExperienceYears], [CabinetNumber]) VALUES (1004, 1013, 3, NULL, NULL, N'111')
INSERT [dbo].[Doctors] ([DoctorID], [UserID], [SpecializationID], [LicenseNumber], [WorkExperienceYears], [CabinetNumber]) VALUES (1005, 1014, 3, NULL, NULL, N'121')
INSERT [dbo].[Doctors] ([DoctorID], [UserID], [SpecializationID], [LicenseNumber], [WorkExperienceYears], [CabinetNumber]) VALUES (1006, 2012, 2, NULL, NULL, N'345')
INSERT [dbo].[Doctors] ([DoctorID], [UserID], [SpecializationID], [LicenseNumber], [WorkExperienceYears], [CabinetNumber]) VALUES (1007, 2014, 4, NULL, NULL, N'77')
INSERT [dbo].[Doctors] ([DoctorID], [UserID], [SpecializationID], [LicenseNumber], [WorkExperienceYears], [CabinetNumber]) VALUES (1008, 2018, 4, NULL, 5, N'312')
INSERT [dbo].[Doctors] ([DoctorID], [UserID], [SpecializationID], [LicenseNumber], [WorkExperienceYears], [CabinetNumber]) VALUES (2008, 3019, 1, NULL, NULL, N'555')
INSERT [dbo].[Doctors] ([DoctorID], [UserID], [SpecializationID], [LicenseNumber], [WorkExperienceYears], [CabinetNumber]) VALUES (3008, 4028, 4, NULL, NULL, N'123')
SET IDENTITY_INSERT [dbo].[Doctors] OFF
GO
SET IDENTITY_INSERT [dbo].[MedicalRecords] ON 

INSERT [dbo].[MedicalRecords] ([RecordID], [PatientID], [DoctorID], [AppointmentID], [RecordDate], [Diagnosis], [Treatment], [Notes]) VALUES (1, 1, 1, 1, CAST(N'2025-11-19T16:45:38.560' AS DateTime), N'Заболевание', N'выпить аскорбинку', N'а что ты хотел?')
INSERT [dbo].[MedicalRecords] ([RecordID], [PatientID], [DoctorID], [AppointmentID], [RecordDate], [Diagnosis], [Treatment], [Notes]) VALUES (2, 4, 1005, 1005, CAST(N'2025-11-19T18:24:58.033' AS DateTime), N'Заболевание', N'аскорбинка', N'')
INSERT [dbo].[MedicalRecords] ([RecordID], [PatientID], [DoctorID], [AppointmentID], [RecordDate], [Diagnosis], [Treatment], [Notes]) VALUES (3, 1, 1, 1, CAST(N'2025-11-23T23:53:21.427' AS DateTime), N'йоу', N'йоу', N'йоу')
INSERT [dbo].[MedicalRecords] ([RecordID], [PatientID], [DoctorID], [AppointmentID], [RecordDate], [Diagnosis], [Treatment], [Notes]) VALUES (4, 7, 1005, 1004, CAST(N'2025-11-25T16:48:23.703' AS DateTime), N'простудился пацанчик', N'пить карвалол', N'прийти на следующей неделе')
INSERT [dbo].[MedicalRecords] ([RecordID], [PatientID], [DoctorID], [AppointmentID], [RecordDate], [Diagnosis], [Treatment], [Notes]) VALUES (1004, 7, 1005, 1004, CAST(N'2025-11-26T16:42:23.943' AS DateTime), N'йоу', N'йоу', N'')
INSERT [dbo].[MedicalRecords] ([RecordID], [PatientID], [DoctorID], [AppointmentID], [RecordDate], [Diagnosis], [Treatment], [Notes]) VALUES (1005, 4, 1005, 2011, CAST(N'2025-11-29T15:10:24.757' AS DateTime), N'йоу', N'йоу', N'йоу')
INSERT [dbo].[MedicalRecords] ([RecordID], [PatientID], [DoctorID], [AppointmentID], [RecordDate], [Diagnosis], [Treatment], [Notes]) VALUES (1006, 4, 1005, 2012, CAST(N'2025-11-29T15:12:18.813' AS DateTime), N'Хорошо', N'Хорошо', N'')
INSERT [dbo].[MedicalRecords] ([RecordID], [PatientID], [DoctorID], [AppointmentID], [RecordDate], [Diagnosis], [Treatment], [Notes]) VALUES (2005, 4, 1005, 2011, CAST(N'2025-12-03T21:19:54.307' AS DateTime), N'йоу', N'йоу', N'')
INSERT [dbo].[MedicalRecords] ([RecordID], [PatientID], [DoctorID], [AppointmentID], [RecordDate], [Diagnosis], [Treatment], [Notes]) VALUES (2006, 4, 1005, 2011, CAST(N'2025-12-05T00:50:28.047' AS DateTime), N'йоу', N'йоу', N'йоу')
INSERT [dbo].[MedicalRecords] ([RecordID], [PatientID], [DoctorID], [AppointmentID], [RecordDate], [Diagnosis], [Treatment], [Notes]) VALUES (2007, 1013, 1005, 3014, CAST(N'2025-12-05T00:50:59.040' AS DateTime), N'ещё раз', N'ещё раз 1', N'')
INSERT [dbo].[MedicalRecords] ([RecordID], [PatientID], [DoctorID], [AppointmentID], [RecordDate], [Diagnosis], [Treatment], [Notes]) VALUES (2008, 1013, 1005, 3015, CAST(N'2025-12-05T00:51:11.890' AS DateTime), N'ещё раз 1', N'ещё раз 2', N'')
INSERT [dbo].[MedicalRecords] ([RecordID], [PatientID], [DoctorID], [AppointmentID], [RecordDate], [Diagnosis], [Treatment], [Notes]) VALUES (2009, 4, 1005, 1005, CAST(N'2025-12-05T00:51:30.047' AS DateTime), N'ещё раз 1', N'ещё раз 2', N'ещё раз 3')
INSERT [dbo].[MedicalRecords] ([RecordID], [PatientID], [DoctorID], [AppointmentID], [RecordDate], [Diagnosis], [Treatment], [Notes]) VALUES (2010, 1013, 1005, 3021, CAST(N'2025-12-05T01:05:21.033' AS DateTime), N'ещё раз 5', N'ещё раз 5', N'ещё раз 5')
INSERT [dbo].[MedicalRecords] ([RecordID], [PatientID], [DoctorID], [AppointmentID], [RecordDate], [Diagnosis], [Treatment], [Notes]) VALUES (2011, 1014, 1005, 3030, CAST(N'2025-12-07T23:23:22.683' AS DateTime), N'Привет', N'Выпей это пж', N'')
SET IDENTITY_INSERT [dbo].[MedicalRecords] OFF
GO
SET IDENTITY_INSERT [dbo].[Patients] ON 

INSERT [dbo].[Patients] ([PatientID], [UserID], [BirthDate], [Gender], [Address]) VALUES (1, 5, CAST(N'1990-04-10' AS Date), N'Жен', N'Архангельск, ул. Ломоносова 12')
INSERT [dbo].[Patients] ([PatientID], [UserID], [BirthDate], [Gender], [Address]) VALUES (2, 6, CAST(N'1985-06-20' AS Date), N'Жен', N'Архангельск, пр. Троицкий 45')
INSERT [dbo].[Patients] ([PatientID], [UserID], [BirthDate], [Gender], [Address]) VALUES (4, 1008, NULL, NULL, NULL)
INSERT [dbo].[Patients] ([PatientID], [UserID], [BirthDate], [Gender], [Address]) VALUES (5, 1009, NULL, NULL, NULL)
INSERT [dbo].[Patients] ([PatientID], [UserID], [BirthDate], [Gender], [Address]) VALUES (6, 1010, NULL, NULL, NULL)
INSERT [dbo].[Patients] ([PatientID], [UserID], [BirthDate], [Gender], [Address]) VALUES (7, 2011, NULL, NULL, NULL)
INSERT [dbo].[Patients] ([PatientID], [UserID], [BirthDate], [Gender], [Address]) VALUES (8, 2013, NULL, NULL, NULL)
INSERT [dbo].[Patients] ([PatientID], [UserID], [BirthDate], [Gender], [Address]) VALUES (9, 2015, NULL, NULL, NULL)
INSERT [dbo].[Patients] ([PatientID], [UserID], [BirthDate], [Gender], [Address]) VALUES (10, 2016, NULL, NULL, NULL)
INSERT [dbo].[Patients] ([PatientID], [UserID], [BirthDate], [Gender], [Address]) VALUES (11, 2017, NULL, NULL, NULL)
INSERT [dbo].[Patients] ([PatientID], [UserID], [BirthDate], [Gender], [Address]) VALUES (1011, 3017, NULL, NULL, NULL)
INSERT [dbo].[Patients] ([PatientID], [UserID], [BirthDate], [Gender], [Address]) VALUES (1013, 4022, NULL, NULL, NULL)
INSERT [dbo].[Patients] ([PatientID], [UserID], [BirthDate], [Gender], [Address]) VALUES (1014, 4027, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Patients] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (1, N'Администратор')
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (3, N'Врач')
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (4, N'Пациент')
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (2, N'Регистратор')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Schedule] ON 

INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3009, 2, CAST(N'2026-12-06T09:01:00.000' AS DateTime), CAST(N'2026-12-06T17:01:00.000' AS DateTime), 1, CAST(N'2026-12-06' AS Date))
INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3010, 3, CAST(N'2027-12-06T09:02:00.000' AS DateTime), CAST(N'2027-12-06T17:02:00.000' AS DateTime), 1, CAST(N'2027-12-06' AS Date))
INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3011, 1003, CAST(N'2028-12-06T09:03:00.000' AS DateTime), CAST(N'2028-12-06T17:03:00.000' AS DateTime), 1, CAST(N'2028-12-06' AS Date))
INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3012, 1004, CAST(N'2029-12-06T09:04:00.000' AS DateTime), CAST(N'2029-12-06T17:04:00.000' AS DateTime), 1, CAST(N'2029-12-06' AS Date))
INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3013, 1005, CAST(N'2030-12-06T09:05:00.000' AS DateTime), CAST(N'2030-12-06T17:05:00.000' AS DateTime), 1, CAST(N'2030-12-06' AS Date))
INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3014, 1006, CAST(N'2031-12-06T09:06:00.000' AS DateTime), CAST(N'2031-12-06T17:06:00.000' AS DateTime), 1, CAST(N'2031-12-06' AS Date))
INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3015, 1007, CAST(N'2032-12-06T09:07:00.000' AS DateTime), CAST(N'2032-12-06T17:07:00.000' AS DateTime), 1, CAST(N'2032-12-06' AS Date))
INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3016, 1008, CAST(N'2033-12-06T09:08:00.000' AS DateTime), CAST(N'2033-12-06T17:08:00.000' AS DateTime), 1, CAST(N'2033-12-06' AS Date))
INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3017, 2008, CAST(N'2034-12-06T09:09:00.000' AS DateTime), CAST(N'2034-12-06T17:09:00.000' AS DateTime), 1, CAST(N'2034-12-06' AS Date))
INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3018, 1005, CAST(N'2025-12-07T08:00:00.000' AS DateTime), CAST(N'2025-12-07T20:00:00.000' AS DateTime), 1, CAST(N'2025-12-07' AS Date))
INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3019, 1, CAST(N'2025-12-08T09:00:00.000' AS DateTime), CAST(N'2025-12-08T17:00:00.000' AS DateTime), 1, CAST(N'2025-12-08' AS Date))
INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3020, 2, CAST(N'2025-12-08T09:00:00.000' AS DateTime), CAST(N'2025-12-08T17:00:00.000' AS DateTime), 1, CAST(N'2025-12-08' AS Date))
INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3021, 3, CAST(N'2026-12-08T09:01:00.000' AS DateTime), CAST(N'2026-12-08T17:01:00.000' AS DateTime), 1, CAST(N'2026-12-08' AS Date))
INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3022, 1003, CAST(N'2025-12-09T09:00:00.000' AS DateTime), CAST(N'2025-12-09T17:00:00.000' AS DateTime), 1, CAST(N'2025-12-09' AS Date))
INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3023, 1004, CAST(N'2027-12-08T09:02:00.000' AS DateTime), CAST(N'2027-12-08T17:02:00.000' AS DateTime), 1, CAST(N'2027-12-08' AS Date))
INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3024, 1005, CAST(N'2025-12-10T09:00:00.000' AS DateTime), CAST(N'2025-12-10T17:00:00.000' AS DateTime), 1, CAST(N'2025-12-10' AS Date))
INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3025, 1006, CAST(N'2028-12-08T09:03:00.000' AS DateTime), CAST(N'2028-12-08T17:03:00.000' AS DateTime), 1, CAST(N'2028-12-08' AS Date))
INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3026, 1007, CAST(N'2025-12-11T09:00:00.000' AS DateTime), CAST(N'2025-12-11T17:00:00.000' AS DateTime), 1, CAST(N'2025-12-11' AS Date))
INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3027, 1008, CAST(N'2029-12-08T09:04:00.000' AS DateTime), CAST(N'2029-12-08T17:04:00.000' AS DateTime), 1, CAST(N'2029-12-08' AS Date))
INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3028, 2008, CAST(N'2025-12-12T09:00:00.000' AS DateTime), CAST(N'2025-12-12T17:00:00.000' AS DateTime), 1, CAST(N'2025-12-12' AS Date))
INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3029, 2, CAST(N'2025-12-09T09:00:00.000' AS DateTime), CAST(N'2025-12-09T17:00:00.000' AS DateTime), 1, CAST(N'2025-12-09' AS Date))
INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3030, 3, CAST(N'2025-12-10T09:00:00.000' AS DateTime), CAST(N'2025-12-10T17:00:00.000' AS DateTime), 1, CAST(N'2025-12-10' AS Date))
INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3031, 1003, CAST(N'2025-12-11T09:00:00.000' AS DateTime), CAST(N'2025-12-11T17:00:00.000' AS DateTime), 1, CAST(N'2025-12-11' AS Date))
INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3032, 1004, CAST(N'2025-12-12T09:00:00.000' AS DateTime), CAST(N'2025-12-12T17:00:00.000' AS DateTime), 1, CAST(N'2025-12-12' AS Date))
INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3033, 1005, CAST(N'2025-12-13T09:00:00.000' AS DateTime), CAST(N'2025-12-13T17:00:00.000' AS DateTime), 1, CAST(N'2025-12-13' AS Date))
INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3034, 1006, CAST(N'2025-12-14T09:00:00.000' AS DateTime), CAST(N'2025-12-14T17:00:00.000' AS DateTime), 1, CAST(N'2025-12-14' AS Date))
INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3035, 1007, CAST(N'2025-12-15T09:00:00.000' AS DateTime), CAST(N'2025-12-15T17:00:00.000' AS DateTime), 1, CAST(N'2025-12-15' AS Date))
INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3036, 1008, CAST(N'2025-12-16T09:00:00.000' AS DateTime), CAST(N'2025-12-16T17:00:00.000' AS DateTime), 1, CAST(N'2025-12-16' AS Date))
INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3037, 2008, CAST(N'2025-12-17T09:00:00.000' AS DateTime), CAST(N'2025-12-17T17:00:00.000' AS DateTime), 1, CAST(N'2025-12-17' AS Date))
INSERT [dbo].[Schedule] ([ScheduleID], [DoctorID], [StartTime], [EndTime], [IsAvailable], [WorkDate]) VALUES (3038, 3008, CAST(N'2025-12-18T09:00:00.000' AS DateTime), CAST(N'2025-12-18T17:00:00.000' AS DateTime), 1, CAST(N'2025-12-18' AS Date))
SET IDENTITY_INSERT [dbo].[Schedule] OFF
GO
SET IDENTITY_INSERT [dbo].[Specializations] ON 

INSERT [dbo].[Specializations] ([SpecializationID], [Name]) VALUES (2, N'Кардиолог')
INSERT [dbo].[Specializations] ([SpecializationID], [Name]) VALUES (4, N'Педиатр')
INSERT [dbo].[Specializations] ([SpecializationID], [Name]) VALUES (1, N'Терапевт')
INSERT [dbo].[Specializations] ([SpecializationID], [Name]) VALUES (3, N'Хирург')
SET IDENTITY_INSERT [dbo].[Specializations] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FirstName], [LastName], [MiddleName], [Phone], [Email], [RoleID], [Address], [MedicalPolicy]) VALUES (1, N'a', N'123jue', N'Иван', N'Иванов', N'Иванович', N'79990000001', N'admin@mail.ru', 1, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FirstName], [LastName], [MiddleName], [Phone], [Email], [RoleID], [Address], [MedicalPolicy]) VALUES (2, N'reg1', N'HASH123', N'Мария', N'Соколова', N'Петровна', N'79990000002', N'reg1@mail.ru', 2, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FirstName], [LastName], [MiddleName], [Phone], [Email], [RoleID], [Address], [MedicalPolicy]) VALUES (3, N'doc_smirnov', N'HASH123', N'Алексей', N'Смирнов', N'Павлович', N'79990000003', N'smirnov@mail.ru', 3, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FirstName], [LastName], [MiddleName], [Phone], [Email], [RoleID], [Address], [MedicalPolicy]) VALUES (4, N'doc_borisova', N'HASH123', N'Ольга', N'Борисова', N'Игоревна', N'79990000004', N'borisova@mail.ru', 3, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FirstName], [LastName], [MiddleName], [Phone], [Email], [RoleID], [Address], [MedicalPolicy]) VALUES (5, N'pat_ivanova', N'HASH123', N'Елена', N'Иванова', N'Андреевна', N'79990000005', N'ivanova@mail.ru', 4, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FirstName], [LastName], [MiddleName], [Phone], [Email], [RoleID], [Address], [MedicalPolicy]) VALUES (6, N'pat_petrova', N'HASH123', N'Мария', N'Петрова', N'Олеговна', N'79990000006', N'petrova@mail.ru', 4, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FirstName], [LastName], [MiddleName], [Phone], [Email], [RoleID], [Address], [MedicalPolicy]) VALUES (9, N'7', N'1eeeee', N'1', N'1', N'1', N'11111111111', N'1@1', 4, N'1', N'1')
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FirstName], [LastName], [MiddleName], [Phone], [Email], [RoleID], [Address], [MedicalPolicy]) VALUES (11, N'10', N'1010uu', N'10', N'11', N'10', N'89110001122', N'10@mail.ru', 4, N'10', N'10')
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FirstName], [LastName], [MiddleName], [Phone], [Email], [RoleID], [Address], [MedicalPolicy]) VALUES (12, N'йоу.йоу', N'123', N'йоу', N'йоу', N'йоу', NULL, NULL, 3, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FirstName], [LastName], [MiddleName], [Phone], [Email], [RoleID], [Address], [MedicalPolicy]) VALUES (1008, N'11', N'1111qq', N'11', N'11', N'11', N'89110001122', N'11@11.ru', 4, N'11', N'11')
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FirstName], [LastName], [MiddleName], [Phone], [Email], [RoleID], [Address], [MedicalPolicy]) VALUES (1009, N'12', N'1212ee', N'Иван', N'Иванов', N'Иванович', N'89110001122', N'11@11.ru', 4, N'11', N'11111111')
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FirstName], [LastName], [MiddleName], [Phone], [Email], [RoleID], [Address], [MedicalPolicy]) VALUES (1010, N'16', N'1616ww', N'Иван', N'Иванов', N'Иванович', N'89110001122', N'16@mail.ru', 4, N'Пушкинская 34', N'1000000000')
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FirstName], [LastName], [MiddleName], [Phone], [Email], [RoleID], [Address], [MedicalPolicy]) VALUES (1012, N'о.о', N'123', N'о', N'о', N'о', NULL, NULL, 3, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FirstName], [LastName], [MiddleName], [Phone], [Email], [RoleID], [Address], [MedicalPolicy]) VALUES (1013, N'егор.чугин', N'123', N'Егор', N'Чугин', N'Валерьевич', NULL, NULL, 3, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FirstName], [LastName], [MiddleName], [Phone], [Email], [RoleID], [Address], [MedicalPolicy]) VALUES (1014, N'задворная.вероника.622', N'lwOmGVPs', N'Вероника', N'Задворная', N'Евгеньевна', N'89210835074', N'veronikazadvornaya@gmail.com', 3, N'-', N'01234567890')
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FirstName], [LastName], [MiddleName], [Phone], [Email], [RoleID], [Address], [MedicalPolicy]) VALUES (2011, N'15', N'1515кк', N'Иван', N'Иванов', N'Иванович', N'+79210001122', N'11@mail.ru', 2, N'ул. Пушкин д. 12', N'1123456789012345')
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FirstName], [LastName], [MiddleName], [Phone], [Email], [RoleID], [Address], [MedicalPolicy]) VALUES (2012, N'йоу.йоу.698', N'xcmd3a8S', N'йоу', N'йоу', N'йоу', N'89110001122', N'2@mail.ru', 3, N'Ул. Пушкина д. 12', N'100000000000')
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FirstName], [LastName], [MiddleName], [Phone], [Email], [RoleID], [Address], [MedicalPolicy]) VALUES (2013, N'17', N'1717цц', N'Иван', N'Иванов', N'Иванович', N'89700001122', N'11@mail.ru', 2, N'Ул. Пушкина д 12', N'1000000000')
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FirstName], [LastName], [MiddleName], [Phone], [Email], [RoleID], [Address], [MedicalPolicy]) VALUES (2014, N'иванов.иван.515', N'wknsgo2T', N'Иван', N'Иванов', N'Иванович', N'89110001122', N'13@mail..ru', 3, N'Воронина 30к4', N'0123456678')
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FirstName], [LastName], [MiddleName], [Phone], [Email], [RoleID], [Address], [MedicalPolicy]) VALUES (2015, N'ApJLukun', N'123jue', N'Игорь', N'Кленин', N'Николаевич', N'89110001122', N'klenin@gmail.com', 4, N'Ломоносова 102', N'1234567890123456')
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FirstName], [LastName], [MiddleName], [Phone], [Email], [RoleID], [Address], [MedicalPolicy]) VALUES (2016, N'jjj', N'123jue', N'Денис', N'Дружнин', N'', N'89110001122', N'11@gmail.com', 4, N'Варава 12', N'1234567890123456')
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FirstName], [LastName], [MiddleName], [Phone], [Email], [RoleID], [Address], [MedicalPolicy]) VALUES (2017, N'uu', N'123iii', N'Игорь', N'Кленин', N'', N'89110001122', N'8@mail.ru', 4, N'Ломоносова 102', N'1234567890123456')
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FirstName], [LastName], [MiddleName], [Phone], [Email], [RoleID], [Address], [MedicalPolicy]) VALUES (2018, N'дружинин.денис.217', N'uKtYaE3d', N'Денис', N'Дружини', N'', N'89110001122', N'16@mail..ru', 3, N'Ломоносова 102', N'1234567890123456')
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FirstName], [LastName], [MiddleName], [Phone], [Email], [RoleID], [Address], [MedicalPolicy]) VALUES (3017, N'kkk', N'kkkkkk', N'Артём', N'Артёмович', N'Артёмов', N'+79113334441', N'123@mail.ru', 4, N'Ломоносова 102', N'1234567890123456')
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FirstName], [LastName], [MiddleName], [Phone], [Email], [RoleID], [Address], [MedicalPolicy]) VALUES (3019, N'лебедев.владимир.702', N'oHMiZpZ5', N'Владимир', N'Лебедев', N'Давидович', N'7(15)760-42-20 ', N'dademoippecre-6005@yopmail.com', 3, N'Ломоносова 1', N'4002539546066388')
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FirstName], [LastName], [MiddleName], [Phone], [Email], [RoleID], [Address], [MedicalPolicy]) VALUES (4022, N'qwe5', N'qweqwe1', N'Артё', N'Артё', N'Артём', N'89110001123', N'е@gmail.cok', 4, N'ул Ломоносова 106', N'1234567890123456')
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FirstName], [LastName], [MiddleName], [Phone], [Email], [RoleID], [Address], [MedicalPolicy]) VALUES (4027, N'www1', N'цццууу1', N'Проверк', N'Проверк', N'', N'89116740842', N'email@email.co', 4, N'ул.Гагарина 30', N'1234567890123456')
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FirstName], [LastName], [MiddleName], [Phone], [Email], [RoleID], [Address], [MedicalPolicy]) VALUES (4028, N'привет.привет.288', N'zLOExbq6', N'привет', N'привет', N'', N'123123123123', N'1231231@mail.ru', 3, N'', N'123123123123')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
/****** Object:  Index [UQ__Doctors__1788CCAD862AA35F]    Script Date: 08.12.2025 0:01:38 ******/
ALTER TABLE [dbo].[Doctors] ADD UNIQUE NONCLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Patients__1788CCAD89BF22B2]    Script Date: 08.12.2025 0:01:38 ******/
ALTER TABLE [dbo].[Patients] ADD UNIQUE NONCLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Roles__8A2B6160934E2B5F]    Script Date: 08.12.2025 0:01:38 ******/
ALTER TABLE [dbo].[Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Speciali__737584F63BD7905F]    Script Date: 08.12.2025 0:01:38 ******/
ALTER TABLE [dbo].[Specializations] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__536C85E44962B4D5]    Script Date: 08.12.2025 0:01:38 ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MedicalRecords] ADD  DEFAULT (getdate()) FOR [RecordDate]
GO
ALTER TABLE [dbo].[Schedule] ADD  DEFAULT ((1)) FOR [IsAvailable]
GO
ALTER TABLE [dbo].[Schedule] ADD  DEFAULT ('2025-01-01') FOR [WorkDate]
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD  CONSTRAINT [FK_Appointments_Doctors] FOREIGN KEY([DoctorID])
REFERENCES [dbo].[Doctors] ([DoctorID])
GO
ALTER TABLE [dbo].[Appointments] CHECK CONSTRAINT [FK_Appointments_Doctors]
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD  CONSTRAINT [FK_Appointments_Patients] FOREIGN KEY([PatientID])
REFERENCES [dbo].[Patients] ([PatientID])
GO
ALTER TABLE [dbo].[Appointments] CHECK CONSTRAINT [FK_Appointments_Patients]
GO
ALTER TABLE [dbo].[Doctors]  WITH CHECK ADD  CONSTRAINT [FK_Doctors_Specializations] FOREIGN KEY([SpecializationID])
REFERENCES [dbo].[Specializations] ([SpecializationID])
GO
ALTER TABLE [dbo].[Doctors] CHECK CONSTRAINT [FK_Doctors_Specializations]
GO
ALTER TABLE [dbo].[Doctors]  WITH CHECK ADD  CONSTRAINT [FK_Doctors_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Doctors] CHECK CONSTRAINT [FK_Doctors_Users]
GO
ALTER TABLE [dbo].[MedicalRecords]  WITH CHECK ADD  CONSTRAINT [FK_MR_Appointments] FOREIGN KEY([AppointmentID])
REFERENCES [dbo].[Appointments] ([AppointmentID])
GO
ALTER TABLE [dbo].[MedicalRecords] CHECK CONSTRAINT [FK_MR_Appointments]
GO
ALTER TABLE [dbo].[MedicalRecords]  WITH CHECK ADD  CONSTRAINT [FK_MR_Doctors] FOREIGN KEY([DoctorID])
REFERENCES [dbo].[Doctors] ([DoctorID])
GO
ALTER TABLE [dbo].[MedicalRecords] CHECK CONSTRAINT [FK_MR_Doctors]
GO
ALTER TABLE [dbo].[MedicalRecords]  WITH CHECK ADD  CONSTRAINT [FK_MR_Patients] FOREIGN KEY([PatientID])
REFERENCES [dbo].[Patients] ([PatientID])
GO
ALTER TABLE [dbo].[MedicalRecords] CHECK CONSTRAINT [FK_MR_Patients]
GO
ALTER TABLE [dbo].[Patients]  WITH CHECK ADD  CONSTRAINT [FK_Patients_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Patients] CHECK CONSTRAINT [FK_Patients_Users]
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD  CONSTRAINT [FK_Schedule_Doctors] FOREIGN KEY([DoctorID])
REFERENCES [dbo].[Doctors] ([DoctorID])
GO
ALTER TABLE [dbo].[Schedule] CHECK CONSTRAINT [FK_Schedule_Doctors]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Roles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Roles]
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD  CONSTRAINT [CHK_Appointment_Status] CHECK  (([Status]='Отменено' OR [Status]='Выполнено' OR [Status]='Ожидает'))
GO
ALTER TABLE [dbo].[Appointments] CHECK CONSTRAINT [CHK_Appointment_Status]
GO
USE [master]
GO
ALTER DATABASE [MedRegistryDb] SET  READ_WRITE 
GO
