CREATE TABLE [dbo].[AltVeriTipleri]
(
  [ID] INT NOT NULL PRIMARY KEY NONCLUSTERED,
  [Ad] NVARCHAR(100) NOT NULL,
  [VeriTipID] INT NOT NULL
)

GO

ALTER TABLE [dbo].[AltVeriTipleri] ADD CONSTRAINT [FK_AltVeriTipleri_VeriTipleri] FOREIGN KEY ([VeriTipID]) REFERENCES [dbo].[VeriTipleri]([ID])
