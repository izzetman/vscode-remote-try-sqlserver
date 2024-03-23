CREATE TABLE [dbo].[VeriAlanlariKosullari]
(
  [ID] INT NOT NULL PRIMARY KEY NONCLUSTERED IDENTITY(1,1),
  [VeriAlanID] INT NOT NULL,
  [VeriAlaniKosulID] INT NOT NULL,
  [Deger] NVARCHAR(100) NOT NULL
)

GO

ALTER TABLE [dbo].[VeriAlanlariKosullari] ADD CONSTRAINT [FK_VeriAlanlariKosullari_VeriAlanlari] FOREIGN KEY ([VeriAlanID]) REFERENCES [dbo].[VeriAlanlari]([ID])

GO

ALTER TABLE [dbo].[VeriAlanlariKosullari] ADD CONSTRAINT [FK_VeriAlanlariKosullari_VeriAlanKosullari] FOREIGN KEY ([VeriAlaniKosulID]) REFERENCES [dbo].[VeriAlanKosullari]([ID])