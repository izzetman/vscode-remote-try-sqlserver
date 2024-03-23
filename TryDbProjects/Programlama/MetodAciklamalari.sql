CREATE TABLE [Programlama].[MetodAciklamalari]
(
  [ID] INT NOT NULL PRIMARY KEY NONCLUSTERED IDENTITY(1,1),
  [MetodID] INT NOT NULL,
  [Aciklama] NVARCHAR(100) NOT NULL,
  [Kod] NVARCHAR(MAX) NOT NULL
)

GO

ALTER TABLE [Programlama].[MetodAciklamalari] ADD CONSTRAINT [FK_MetodAciklamalari_Metodlar] FOREIGN KEY ([MetodID]) REFERENCES [Programlama].[Metodlar]([ID])
