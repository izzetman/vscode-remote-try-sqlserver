IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Programlama].[SinifAlanlari]') AND type in (N'U'))
    DROP TABLE [Programlama].[SinifAlanlari]

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Programlama].[MetodUygulamalari]') AND type in (N'U'))
    DROP TABLE [Programlama].[MetodUygulamalari]

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Programlama].[MetodParametreleri]') AND type in (N'U'))
    DROP TABLE [Programlama].[MetodParametreleri]

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Programlama].[Metodlar]') AND type in (N'U'))
    DROP TABLE [Programlama].[Metodlar]

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Programlama].[SinifTuremeler]') AND type in (N'U'))
    DROP TABLE [Programlama].[SinifTuremeler]

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Programlama].[SinifUygulananArabirimler]') AND type in (N'U'))
    DROP TABLE [Programlama].[SinifUygulananArabirimler]

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Programlama].[SinifUygulamalari]') AND type in (N'U'))
    DROP TABLE [Programlama].[SinifUygulamalari]

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Programlama].[Siniflar]') AND type in (N'U'))
    DROP TABLE [Programlama].[Siniflar]

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VeriAlanlariKosullari]') AND type in (N'U'))
    DROP TABLE [dbo].[VeriAlanlariKosullari]

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VeriAlanKosullari]') AND type in (N'U'))
    DROP TABLE [dbo].[VeriAlanKosullari]

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OlguVeriAlanlari]') AND type in (N'U'))
    DROP TABLE [dbo].[OlguVeriAlanlari]

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OlguHiyerarsi]') AND type in (N'U'))
    DROP TABLE [dbo].[OlguHiyerarsi]

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Olgular]') AND type in (N'U'))
    DROP TABLE [dbo].[Olgular]
  
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VeriAlanlari]') AND type in (N'U'))
    DROP TABLE [dbo].[VeriAlanlari]

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AltVeriTipleri]') AND type in (N'U'))
    DROP TABLE [dbo].[AltVeriTipleri]

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VeriTipleri]') AND type in (N'U'))
    DROP TABLE [dbo].[VeriTipleri]

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OlguTipleri]') AND type in (N'U'))
    DROP TABLE [dbo].[OlguTipleri]

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAngularCreateDxForm]'))
    DROP PROCEDURE [dbo].[spAngularCreateDxForm]

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spAngularCreateDxDataGrid]'))
    DROP PROCEDURE [dbo].[spAngularCreateDxDataGrid]

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PascalToCamelCase]'))
    DROP FUNCTION [dbo].[PascalToCamelCase]

GO

IF EXISTS (SELECT * FROM sys.schemas WHERE name = N'Programlama')
    DROP SCHEMA [Programlama]