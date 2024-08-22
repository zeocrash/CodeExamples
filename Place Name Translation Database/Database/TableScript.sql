
/****** Object:  Table [dbo].[T_Language]    Script Date: 22/08/2024 01:33:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[T_Language](
	[lng_ID] [int] IDENTITY(1,1) NOT NULL,
	[lng_Name] [varchar](50) NOT NULL,
	[lng_Code] [char](2) NOT NULL,
 CONSTRAINT [PK_T_Language] PRIMARY KEY CLUSTERED 
(
	[lng_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[T_Places]    Script Date: 22/08/2024 01:33:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[T_Places](
	[plc_ID] [int] IDENTITY(1,1) NOT NULL,
	[plc_Name] [varchar](255) NOT NULL,
 CONSTRAINT [PK_T_Places] PRIMARY KEY CLUSTERED 
(
	[plc_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



/****** Object:  Table [dbo].[T_Translations]    Script Date: 22/08/2024 01:38:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[T_Translations](
	[trns_lng_ID] [int] NOT NULL,
	[trns_plc_ID] [int] NOT NULL,
	[trns_NameTranslation] [varchar](255) NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[T_Translations]  WITH CHECK ADD  CONSTRAINT [FK_T_Translations_T_Language] FOREIGN KEY([trns_lng_ID])
REFERENCES [dbo].[T_Language] ([lng_ID])
GO

ALTER TABLE [dbo].[T_Translations] CHECK CONSTRAINT [FK_T_Translations_T_Language]
GO

ALTER TABLE [dbo].[T_Translations]  WITH CHECK ADD  CONSTRAINT [FK_T_Translations_T_Places] FOREIGN KEY([trns_plc_ID])
REFERENCES [dbo].[T_Places] ([plc_ID])
GO

ALTER TABLE [dbo].[T_Translations] CHECK CONSTRAINT [FK_T_Translations_T_Places]
GO



--Tables Created, populate Data

INSERT INTO [dbo].[T_Language]
           ([lng_Name]
           ,[lng_Code])
     VALUES
('Abkhazian'				,'ab'),
('Afar'						,'aa'),
('Afrikaans'				,'af'),
('Akan'						,'ak'),
('Albanian'					,'sq'),
('Amharic'					,'am'),
('Arabic'					,'ar'),
('Aragonese'				,'an'),
('Armenian'					,'hy'),
('Assamese'					,'as'),
('Avaric'					,'av'),
('Aymara'					,'ay'),
('Azerbaijani'				,'az'),
('Bambara'					,'bm'),
('Bashkir'					,'ba'),
('Basque'					,'eu'),
('Belarusian'				,'be'),
('Bengali'					,'bn'),
('Bislama'					,'bi'),
('Bosnian'					,'bs'),
('Breton'					,'br'),
('Bulgarian'				,'bg'),
('Burmese'					,'my'),
('Catalan'					,'ca')

