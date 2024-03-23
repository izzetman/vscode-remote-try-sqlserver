CREATE TABLE [Programlama].[MetodParametreleri]
(
  [ID] INT NOT NULL PRIMARY KEY NONCLUSTERED IDENTITY(1,1),
  [MetodID] INT NOT NULL,
  [Ad] NVARCHAR(100) NOT NULL,
  [Aciklama] NVARCHAR(100) NULL,
  [VeriTipi] NVARCHAR(100) NOT NULL
)

GO

ALTER TABLE [Programlama].[MetodParametreleri] ADD CONSTRAINT [FK_MetodParametreleri_Metodlar] FOREIGN KEY ([MetodID]) REFERENCES [Programlama].[Metodlar]([ID])