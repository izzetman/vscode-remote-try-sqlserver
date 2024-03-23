CREATE TABLE [dbo].[VeriAlanlari]
(
  [ID] INT NOT NULL PRIMARY KEY NONCLUSTERED,
  [Ad] NVARCHAR(100) NOT NULL,
  [Aciklama] NVARCHAR(100) NULL,
  [AltVeriTipID] INT NOT NULL
)

GO

ALTER TABLE [dbo].[VeriAlanlari] ADD CONSTRAINT [FK_VeriAlanlari_AltVeriTipleri] FOREIGN KEY ([AltVeriTipID]) REFERENCES [dbo].[AltVeriTipleri]([ID])
