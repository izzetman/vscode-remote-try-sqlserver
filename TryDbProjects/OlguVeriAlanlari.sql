CREATE TABLE [dbo].[OlguVeriAlanlari]
(
  [ID] INT NOT NULL PRIMARY KEY NONCLUSTERED,
  [VeriAlanID] INT NOT NULL,
  [OlguID] INT NOT NULL
)

GO

ALTER TABLE [dbo].[OlguVeriAlanlari] ADD CONSTRAINT [FK_OlguVeriAlanlari_VeriAlanlari] FOREIGN KEY ([VeriAlanID]) REFERENCES [dbo].[VeriAlanlari]([ID])

GO

ALTER TABLE [dbo].[OlguVeriAlanlari] ADD CONSTRAINT [FK_OlguVeriAlanlari_Olgular] FOREIGN KEY ([OlguID]) REFERENCES [dbo].[Olgular]([ID])
