CREATE TABLE [Programlama].[SinifAciklamalari]
(
  [ID] INT NOT NULL PRIMARY KEY NONCLUSTERED IDENTITY(1,1),
  [SinifID] INT NOT NULL,
  [Aciklama] NVARCHAR(100) NOT NULL,
  [Kod] NVARCHAR(MAX) NOT NULL
)

GO

ALTER TABLE [Programlama].[SinifAciklamalari] ADD CONSTRAINT [FK_SinifAciklamalari_Siniflar] FOREIGN KEY ([SinifID]) REFERENCES [Programlama].[Siniflar]([ID])
