CREATE TABLE [dbo].[goals
] (
    [Id]       INT  NOT NULL,
    [calories] INT  NULL,
    [user_id]  INT  NULL,
    [date]     DATE NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_goals
_ToUsers] FOREIGN KEY ([user_id]) REFERENCES [dbo].[users] ([Id])
);

