CREATE TABLE [Programlama].[SinifUygulananArabirimler]
(
  [ID] INT NOT NULL PRIMARY KEY NONCLUSTERED IDENTITY(1,1),
  [SinifID] INT NOT NULL,
  [UygulananArabirimAdi] NVARCHAR(100) NOT NULL
)

GO

ALTER TABLE [Programlama].[SinifUygulananArabirimler] ADD CONSTRAINT [FK_SinifUygulananArabirimler_Siniflar] FOREIGN KEY ([SinifID]) REFERENCES [Programlama].[Siniflar]([ID])
