CREATE TABLE [Programlama].[Metodlar]
(
  [ID] INT NOT NULL PRIMARY KEY NONCLUSTERED IDENTITY(1,1),
  [Ad] NVARCHAR(100) NOT NULL,
  [SinifID] INT NOT NULL,
  [Aciklama] NVARCHAR(100) NULL,
  [Kod] NVARCHAR(MAX) NOT NULL,
  [DonusTipi] NVARCHAR(100) NOT NULL,
  [YapiciMi] BIT NOT NULL DEFAULT 0
)

GO

ALTER TABLE [Programlama].[Metodlar] ADD CONSTRAINT [FK_Metodlar_Siniflar] FOREIGN KEY ([SinifID]) REFERENCES [Programlama].[Siniflar]([ID])
