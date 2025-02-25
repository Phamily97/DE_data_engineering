CREATE TABLE requestStorageTest(
	[id] [int] NOT NULL,
	[title] [nvarchar](max) NOT NULL,
	[slug] [nvarchar](max) NULL,
	[price] [decimal](18, 0) NULL,
	[description] [nvarchar](max) NULL,
	[category] [nvarchar](max) NULL,
	[images] [nvarchar](max) NULL,
	[creationAT] [datetime2](7) NULL,
	[updatedAT] [datetime2](7) NULL
)