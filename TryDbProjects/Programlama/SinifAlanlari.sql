CREATE TABLE [Programlama].[SinifAlanlari]
(
  [ID] INT NOT NULL PRIMARY KEY NONCLUSTERED IDENTITY(1,1),
  [Ad] NVARCHAR(100) NOT NULL,
  [Aciklama] NVARCHAR(100) NULL,
  [SinifID] INT NOT NULL,
  [VeriTipi] NVARCHAR(100) NOT NULL,
  [Kod] NVARCHAR(MAX) NOT NULL
)

GO

ALTER TABLE [Programlama].[SinifAlanlari] ADD CONSTRAINT [FK_SinifAlanlari_Siniflar] FOREIGN KEY ([SinifID]) REFERENCES [Programlama].[Siniflar]([ID])
