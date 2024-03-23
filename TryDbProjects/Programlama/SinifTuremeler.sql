CREATE TABLE [Programlama].[SinifTuremeler]
(
  [ID] INT NOT NULL PRIMARY KEY NONCLUSTERED IDENTITY(1,1),
  [SinifID] INT NOT NULL,
  [TuredigiSinifAdi] NVARCHAR(100) NOT NULL
)

GO

ALTER TABLE [Programlama].[SinifTuremeler] ADD CONSTRAINT [FK_SinifTuremeler_Siniflar] FOREIGN KEY ([SinifID]) REFERENCES [Programlama].[Siniflar]([ID])