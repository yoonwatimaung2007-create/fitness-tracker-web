CREATE TABLE [dbo].[users] (
    [Id]       INT          IDENTITY (1, 1) NOT NULL,
    [name]     VARCHAR (30) NULL,
    [password] VARCHAR (12) NULL,
    [Email] NVARCHAR(100) NULL, 
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

