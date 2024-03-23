CREATE TABLE [dbo].[OlguHiyerarsi]
(
  [ID] INT NOT NULL PRIMARY KEY NONCLUSTERED,
  [OlguID] INT NOT NULL,
  [UstOlguID] INT NOT NULL,
  [OlguVeriAlaniID] INT NOT NULL,
  [KompozitMi] BIT NOT NULL
)

GO

ALTER TABLE [dbo].[OlguHiyerarsi] ADD CONSTRAINT [FK_OlguHiyerarsi_Olgular] FOREIGN KEY ([OlguID]) REFERENCES [dbo].[Olgular]([ID])

GO

ALTER TABLE [dbo].[OlguHiyerarsi] ADD CONSTRAINT [FK_OlguHiyerarsi_Olgular_1] FOREIGN KEY ([UstOlguID]) REFERENCES [dbo].[Olgular]([ID])

GO

ALTER TABLE [dbo].[OlguHiyerarsi] ADD CONSTRAINT [FK_OlguHiyerarsi_VeriAlanlari] FOREIGN KEY ([OlguVeriAlaniID]) REFERENCES [dbo].[VeriAlanlari]([ID])
