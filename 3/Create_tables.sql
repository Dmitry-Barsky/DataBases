USE [KB301_Kolmogortsev]
GO

CREATE TABLE [Auto].[Post] (
	[PostId] [tinyint] NOT NULL,
	[PostName] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [Auto].[PolicePost] (
	[CarNumber] [nvarchar](6) NOT NULL,
	[CarRegion] [nvarchar](3) NOT NULL,
	[CarTime] [time](0) NOT NULL,
	[CarEntryExit] [nvarchar](3) NOT NULL,
	[PostId] [tinyint] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [Auto].[PolicePost] 
WITH CHECK ADD CONSTRAINT [FK_Post] FOREIGN KEY([PostId])
REFERENCES [Auto].[Post] ([PostId])
ON UPDATE CASCADE
GO

ALTER TABLE [Auto].[PolicePost] 
CHECK CONSTRAINT [FK_Post]
GO

ALTER TABLE [Auto].[PolicePost]  
WITH CHECK ADD CHECK  (([CarNumber] like '_[0-9][0-9][0-9]__' AND NOT [CarNumber] like '_000__' AND [CarNumber] like '[юбейлмнпярсу]___[юбейлмнпярсу][юбейлмнпярсу]'))
GO

ALTER TABLE [Auto].[PolicePost]  
WITH CHECK ADD CHECK  (([CarRegion] like '[0-9][1-9]' OR [CarRegion] like '1[0-9][0-9]' OR [CarRegion] like '2[0-9][0-9]' OR [CarRegion] like '7[0-9][0-9]'))
GO


CREATE TABLE [Auto].[Region] (
	[MainRegion] [nvarchar](3) NOT NULL,
	[NameRegion] [nvarchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MainRegion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [Auto].[VariactionRegion] (
	[MainRegion] [nvarchar](3) NOT NULL,
	[VariactionRegion] [nvarchar](3) NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [Auto].[VariactionRegion]  WITH CHECK ADD  CONSTRAINT [FK_Region] FOREIGN KEY([MainRegion])
REFERENCES [Auto].[Region] ([MainRegion])
ON UPDATE CASCADE
GO

ALTER TABLE [Auto].[VariactionRegion] CHECK CONSTRAINT [FK_Region]
GO


