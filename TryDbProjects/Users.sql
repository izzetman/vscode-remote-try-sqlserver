CREATE SCHEMA Programlama

GO

CREATE TABLE [Programlama].[Siniflar]
(
  [ID] INT NOT NULL PRIMARY KEY NONCLUSTERED IDENTITY(1,1),
  [Ad] NVARCHAR(100) NOT NULL
)

GO

CREATE TABLE [Programlama].[SinifTuremeler]
(
  [ID] INT NOT NULL PRIMARY KEY NONCLUSTERED IDENTITY(1,1),
  [SinifID] INT NOT NULL,
  [TuredigiSinifAdi] NVARCHAR(100) NOT NULL
)

GO

ALTER TABLE [Programlama].[SinifTuremeler] ADD CONSTRAINT [FK_SinifTuremeler_Siniflar] FOREIGN KEY ([SinifID]) REFERENCES [Programlama].[Siniflar]([ID])

GO

CREATE TABLE [Programlama].[SinifUygulananArabirimler]
(
  [ID] INT NOT NULL PRIMARY KEY NONCLUSTERED IDENTITY(1,1),
  [SinifID] INT NOT NULL,
  [UygulananArabirimAdi] NVARCHAR(100) NOT NULL
)

GO

ALTER TABLE [Programlama].[SinifUygulananArabirimler] ADD CONSTRAINT [FK_SinifUygulananArabirimler_Siniflar] FOREIGN KEY ([SinifID]) REFERENCES [Programlama].[Siniflar]([ID])

GO

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

GO

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

GO

CREATE TABLE [Programlama].[SinifAlanlari]
(
  [ID] INT NOT NULL PRIMARY KEY NONCLUSTERED IDENTITY(1,1),
  [Ad] NVARCHAR(100) NOT NULL,
  [Aciklama] NVARCHAR(100) NULL,
  [SinifID] INT NOT NULL,
  [VeriTipi] NVARCHAR(100) NOT NULL,
  [Kod] NVARCHAR(MAX) NOT NULL
)

GO

ALTER TABLE [Programlama].[SinifAlanlari] ADD CONSTRAINT [FK_SinifAlanlari_Siniflar] FOREIGN KEY ([SinifID]) REFERENCES [Programlama].[Siniflar]([ID])

GO

CREATE TABLE [Programlama].[SinifAciklamalari]
(
  [ID] INT NOT NULL PRIMARY KEY NONCLUSTERED IDENTITY(1,1),
  [SinifID] INT NOT NULL,
  [Aciklama] NVARCHAR(100) NOT NULL,
  [Kod] NVARCHAR(MAX) NOT NULL
)

GO

ALTER TABLE [Programlama].[SinifAciklamalari] ADD CONSTRAINT [FK_SinifAciklamalari_Siniflar] FOREIGN KEY ([SinifID]) REFERENCES [Programlama].[Siniflar]([ID])

GO

CREATE TABLE [Programlama].[MetodAciklamalari]
(
  [ID] INT NOT NULL PRIMARY KEY NONCLUSTERED IDENTITY(1,1),
  [MetodID] INT NOT NULL,
  [Aciklama] NVARCHAR(100) NOT NULL,
  [Kod] NVARCHAR(MAX) NOT NULL
)

GO

ALTER TABLE [Programlama].[MetodAciklamalari] ADD CONSTRAINT [FK_MetodAciklamalari_Metodlar] FOREIGN KEY ([MetodID]) REFERENCES [Programlama].[Metodlar]([ID])

GO

CREATE TABLE [dbo].[VeriTipleri]
(
  [ID] INT NOT NULL PRIMARY KEY NONCLUSTERED,
  [Ad] NVARCHAR(100) NOT NULL
)

-- INSERT INTO [dbo].[VeriTipleri] ([ID], [Ad])
--  VALUES (1, N'Metin'),
--         (2, N'Tamsayı'),
--         (3, N'Ondalıklı Sayı'),
--         (4, N'Tarih ve Saat'),
--         (5, N'Boole'),
--         (6, N'GUID'),
--         (7, N'XML'),
--         (8, N'Binary')
GO

CREATE TABLE [dbo].[AltVeriTipleri]
(
  [ID] INT NOT NULL PRIMARY KEY NONCLUSTERED,
  [Ad] NVARCHAR(100) NOT NULL,
  [VeriTipID] INT NOT NULL
)

-- INSERT INTO [dbo].[AltVeriTipleri] ([ID], [Ad], [VeriTipID])
--  VALUES (1, N'Metin', 1),
--         (2, N'Tamsayı', 2),
--         (3, N'Ondalıklı Sayı', 3),
--         (4, N'Tarih', 4),
--         (5, N'Tarih ve Saat', 4),
--         (6, N'Evet/Hayır', 5),
--         (7, N'GUID', 6),
--         (8, N'XML', 7),
--         (9, N'Dosya', 8),
--         (10, N'e-posta', 1),
--         (11, N'Parola', 8),
--         (12, N'Saat', 4),
--         (100, N'Malzeme Tanım Id', 2)


GO

ALTER TABLE [dbo].[AltVeriTipleri] ADD CONSTRAINT [FK_AltVeriTipleri_VeriTipleri] FOREIGN KEY ([VeriTipID]) REFERENCES [dbo].[VeriTipleri]([ID])

GO

CREATE TABLE [dbo].[Olgular]
(
  [ID] INT NOT NULL PRIMARY KEY NONCLUSTERED IDENTITY(1,1),
  [Ad] NVARCHAR(100) NOT NULL,
  [Aciklama] NVARCHAR(100) NULL
)

GO

-- INSERT INTO [dbo].[Olgular] ([Ad])
-- VALUES (N'MalzemeTanimAgac', N'Ürün Ağacı'),
--        (N'MalzemeTanimAgacDetay', N'Ürün Ağacı Detayı'),
--        (N'MalzemeTanim', N'Malzeme Tanım')
GO

CREATE TABLE [dbo].[VeriAlanlari]
(
  [ID] INT NOT NULL PRIMARY KEY NONCLUSTERED,
  [Ad] NVARCHAR(100) NOT NULL,
  [Aciklama] NVARCHAR(100) NULL,
  [AltVeriTipID] INT NOT NULL
)

GO

ALTER TABLE [dbo].[VeriAlanlari] ADD CONSTRAINT [FK_VeriAlanlari_AltVeriTipleri] FOREIGN KEY ([AltVeriTipID]) REFERENCES [dbo].[AltVeriTipleri]([ID])

GO

-- INSERT INTO [dbo].[VeriAlanlari] ([ID], [Ad], [Aciklama], [AltVeriTipID])
-- VALUES (1, N'ID', NULL, 2),
--       (2, N'Ad', NULL, 1),
--       (3, N'Soyad', NULL, 1),
--       (4, N'Kod', NULL, 1),
--       (5, N'DogumTarihi', N'Doğum Tarihi', 4),
--       (6, N'OlusturulmaTarihi', N'Oluşturulma Tarihi', 4),
--       (7, N'GuncellemeTarihi', N'Güncelleme Tarihi', 4),
--       (8, N'ePosta', N'E-Posta', 10),
--       (9, N'Parola', N'Parola', 11),
--       (10, N'Onaylandi', N'Onaylandı', 6),
--       (11, N'GUID', NULL, 6),
--       (12, N'XML', NULL, 7),
--       (13, N'DosyaIcerik', N'Dosya İçeriği', 8),
--       (14, N'AnaMalzemeTanimId', N'Ana Malzeme Tanım', 100),
--       (15, N'MalzemeTanimId', N'Malzeme Tanım ID', 100),
--       (16, N'UstMalzemeTanimId', N'Üst Malzeme Tanım', 100),
--       (17, N'Miktar', N'Miktar', 2),
--       (18, N'MiktarBirimId', N'Miktar Birim', 2),
--       (19, N'Aktif', N'Aktif', 5),
--       (20, N'AltMalzemeTanimVarYok', N'Alt Malzeme Tanım Var/Yok', 5),
--       (21, N'Seviye', N'Seviye', 2)


GO

CREATE TABLE [dbo].[VeriAlanKosullari]
(
  [ID] INT NOT NULL PRIMARY KEY NONCLUSTERED,
  [Kosul] NVARCHAR(100) NOT NULL
)

GO

-- INSERT INTO [dbo].[VeriAlanKosullari] ([ID], [Kosul])
-- VALUES (1, N'Zorunlu'),
--        (2, N'Tam Uzunluk'),
--        (3, N'Min Uzunluk'),
--        (4, N'Max Uzunluk'),
--        (5, N'Min Tarih'),
--        (6, N'Max Tarih'),
--        (7, N'Min Tamsayı'),
--        (8, N'Max Tamsayı'),
--        (9, N'Min Ondalıklı Sayı'),
--        (10, N'Max Ondalıklı Sayı'),
--        (11, N'RegEx Format')

GO

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

GO

-- INSERT INTO [dbo].[VeriAlanlariKosullari] ([VeriAlanID], [VeriAlaniKosulID], [Deger])
-- VALUES (1, 1, N'1'),
--        (2, 1, N'1'),
--        (2, 4, N'100'),
--        (3, 1, N'1'),
--        (3, 4, N'100'),
--        (4, 1, N'1'),
--        (4, 4, N'50'),
--        (5, 1, N'1'),
--        (5, 5, N'1900-01-01'),
--        (17, 1, N'1'),
--        (17, 7, N'1'),
--        (18, 1, N'1'),
--        (18, 7, N'1'),
--        (19, 1, N'1'),
--        (20, 1, N'1'),
--        (21, 1, N'1'),
--        (21, 9, N'0.000001')

GO

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

GO

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

GO

-- Procedure : spAngularCreateDxForm
-- Description : Veri alanlarına göre dx-form ve ilgili devextreme elementlerini veri tiplerini dikkate alarak oluşturur.
-- Metin veri tipi için textbox,
-- tamsayı veri tipi için numberbox, ondalıklı sayı veri tipi için numberbox,
-- tarih veri tipi için datebox, tarih ve saat veri tipi için datetimebox,
-- boole veri tipi için checkbox,
-- guid veri tipi için textbox, xml veri tipi için textbox, binary veri tipi için fileuploader gibi.
-- Parameters : @OlguID INT
-- Returns : Oluşturulan HTML kodunu geri çevirir.
CREATE PROCEDURE [dbo].[spAngularCreateDxForm]
  @OlguID INT
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @OlguAd NVARCHAR(100) = (SELECT [Ad]
  FROM [dbo].[Olgular]
  WHERE [ID] = @OlguID)

  DECLARE @HTML NVARCHAR(MAX) = N'<dx-form [formData]="formData" [showColonAfterLabel]="true" colCount="4">';

  DECLARE @VeriAlanID INT, @VeriAlanAd NVARCHAR(100), @AltVeriTipID INT, @AltVeriTipAd NVARCHAR(100)

  DECLARE cur CURSOR FOR
  SELECT VA.[ID], VA.[Ad], AVT.[ID], AVT.[Ad]
  FROM [dbo].[VeriAlanlari] AS VA
    INNER JOIN [dbo].[AltVeriTipleri] AS AVT ON VA.[AltVeriTipID] = AVT.[ID]
    INNER JOIN [dbo].[OlguVeriAlanlari] AS OVA ON VA.[ID] = OVA.[VeriAlanID]
  WHERE OVA.[OlguID] = @OlguID

  OPEN cur
  FETCH NEXT FROM cur INTO @VeriAlanID, @VeriAlanAd, @AltVeriTipID, @AltVeriTipAd

  WHILE @@FETCH_STATUS = 0
  BEGIN
    SET @HTML = @HTML + N'<dx-item [label]="''' + @VeriAlanAd + N'''">' + CHAR(13) + CHAR(10)

    IF @AltVeriTipAd = N'Metin' OR @AltVeriTipAd = N'e-posta' OR @AltVeriTipAd = N'Parola'
    BEGIN
      SET @HTML = @HTML + N'<dx-item editorType="dxTextBox" dataField="' + @VeriAlanAd + N'"></dx-item>' + CHAR(13) + CHAR(10)
    END
    ELSE IF @AltVeriTipAd = N'Tamsayı'
    BEGIN
      SET @HTML = @HTML + N'<dx-item editorType="dxNumberBox" dataField="' + @VeriAlanAd + N'"></dx-item>' + CHAR(13) + CHAR(10)
    END
    ELSE IF @AltVeriTipAd = N'Ondalıklı Sayı'
    BEGIN
      SET @HTML = @HTML + N'<dx-item editorType="dxNumberBox" dataField="' + @VeriAlanAd + N'"></dx-item>' + CHAR(13) + CHAR(10)
    END
    ELSE IF @AltVeriTipAd = N'Tarih'
    BEGIN
      SET @HTML = @HTML + N'<dx-item editorType="dxDateBox" dataField="' + @VeriAlanAd + N'"></dx-item>' + CHAR(13) + CHAR(10)
    END
    ELSE IF @AltVeriTipAd = N'Tarih ve Saat'
    BEGIN
      SET @HTML = @HTML + N'<dx-item editorType="dxDateBox" dataField="' + @VeriAlanAd + N'"></dx-item>' + CHAR(13) + CHAR(10)
    END
    ELSE IF @AltVeriTipAd = N'Evet/Hayır'
    BEGIN
      SET @HTML = @HTML + N'<dx-item editorType="dxCheckBox" dataField="' + @VeriAlanAd + N'"></dx-item>' + CHAR(13) + CHAR(10)
    END
    ELSE IF @AltVeriTipAd = N'GUID'
    BEGIN
      SET @HTML = @HTML + N'<dx-item editorType="dxTextBox" dataField="' + @VeriAlanAd + N'"></dx-item>' + CHAR(13) + CHAR(10)
    END
    ELSE IF @AltVeriTipAd = N'XML'
    BEGIN
      SET @HTML = @HTML + N'<dx-item editorType="dxTextBox" dataField="' + @VeriAlanAd + N'"></dx-item>' + CHAR(13) + CHAR(10)
    END
    ELSE IF @AltVeriTipAd = N'Binary'
    BEGIN
      SET @HTML = @HTML + N'<dx-item editorType="dxFileUploader" dataField="' + @VeriAlanAd + N'"></dx-item>' + CHAR(13) + CHAR(10)
    END
    ELSE IF @AltVeriTipAd = N'Malzeme Tanım Id'
    BEGIN
      SET @HTML = @HTML + N'<dxi-item dataField="' + @VeriAlanAd + N'">' + CHAR(13) + CHAR(10)
      SET @HTML = @HTML + N'<div *dxTemplate>' + CHAR(13) + CHAR(10)
      SET @HTML = @HTML + N'<app-malzeme-bul [secilenMalzemeId]="formData.' + @VeriAlanAd + N'"' + CHAR(13) + CHAR(10)
      SET @HTML = @HTML + N'(secilenMalzemeIdChange)="onSecilenMalzemeIdChanged(this, $event)"></app-malzeme-bul>' + CHAR(13) + CHAR(10)
      SET @HTML = @HTML + N'</div>' + CHAR(13) + CHAR(10)
      SET @HTML = @HTML + N'</dxi-item>' + CHAR(13) + CHAR(10)
    END
    ELSE
      SET @HTML = @HTML + N'<dx-item editorType="dxTextBox" dataField="' + @VeriAlanAd + N'"></dx-item>'

    SET @HTML = @HTML + N'</dx-item>' + CHAR(13) + CHAR(10)
  END

  CLOSE cur
  DEALLOCATE cur

  SET @HTML = @HTML + N'</dx-form>' + CHAR(13) + CHAR(10)

  PRINT(@HTML)
END

GO

-- Procedure : spAngularCreateDxDataGrid
-- Description : Veri alanlarına göre dx-data-grid ve ilgili devextreme elementlerini veri tiplerini dikkate alarak oluşturur.
-- Parameters : @OlguID INT
-- Returns : Oluşturulan HTML kodunu geri çevirir.
CREATE PROCEDURE [dbo].[spAngularCreateDxDataGrid]
  @OlguID INT
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @OlguAd NVARCHAR(100) = (SELECT [Ad]
  FROM [dbo].[Olgular]
  WHERE [ID] = @OlguID)

  DECLARE @HTML NVARCHAR(MAX) = N'<dx-data-grid [dataSource]="dataSource" [showBorders]="true" [showColumnLines]="true" [showRowLines]="true">';

  DECLARE @VeriAlanID INT, @VeriAlanAd NVARCHAR(100), @VeriAlanAciklama NVARCHAR(100), @AltVeriTipID INT, @AltVeriTipAd NVARCHAR(100)

  DECLARE cur CURSOR FOR
  SELECT VA.[ID], VA.[Ad], VA.[Aciklama], AVT.[ID], AVT.[Ad]
  FROM [dbo].[VeriAlanlari] AS VA
    INNER JOIN [dbo].[AltVeriTipleri] AS AVT ON VA.[AltVeriTipID] = AVT.[ID]
    INNER JOIN [dbo].[OlguVeriAlanlari] AS OVA ON VA.[ID] = OVA.[VeriAlanID]
  WHERE OVA.[OlguID] = @OlguID

  OPEN cur
  FETCH NEXT FROM cur INTO @VeriAlanID, @VeriAlanAd, @VeriAlanAciklama, @AltVeriTipID, @AltVeriTipAd

  SET @HTML = @HTML + N'<dxo-paging [enabled]="true"></dxo-paging>' + CHAR(13) + CHAR(10)
  SET @HTML = @HTML + N'<dxo-pager [showPageSizeSelector]="true" [allowedPageSizes]="[5, 10, 20]" [showInfo]="true"></dxo-pager>' + CHAR(13) + CHAR(10)

  WHILE @@FETCH_STATUS = 0
  BEGIN
    SET @HTML = @HTML + N'<dxi-column dataField="' + @VeriAlanAd + N'" caption="' + ISNULL(@VeriAlanAciklama, @VeriAlanAd) + N'">' + CHAR(13) + CHAR(10)

    DECLARE @AlanZorunluMu BIT = ISNULL((SELECT Deger
    FROM [dbo].[VeriAlanlariKosullari]
    WHERE [VeriAlanID] = @VeriAlanID AND [VeriAlaniKosulID] = 1), 0)

    IF @AlanZorunluMu = 1
      SET @HTML = @HTML + N'<dxi-validation-rule type="required"></dxi-validation-rule>' + CHAR(13) + CHAR(10)

    SET @HTML = @HTML + N'</dxi-column>' + CHAR(13) + CHAR(10)

    FETCH NEXT FROM cur INTO @VeriAlanID, @VeriAlanAd, @VeriAlanAciklama, @AltVeriTipID, @AltVeriTipAd
  END

  CLOSE cur
  DEALLOCATE cur

  SET @HTML = @HTML + N'</dx-data-grid>' + CHAR(13) + CHAR(10)

  PRINT (@HTML)

-- SELECT @HTML
END


GO

-- Procedure : spAngularCreateComponent
-- Description : Veri alanlarına göre Angular bileşenini oluşturur. Bunu Programlama şeması altındaki Sinif ve ilgili alt tabloları doldurarak yapar.
-- Parameters : @OlguID INT
-- Returns : Void
CREATE PROCEDURE [dbo].[spAngularCreateComponent]
  @OlguID INT
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @OlguAd NVARCHAR(100) = (SELECT [Ad] FROM [dbo].[Olgular] WHERE [ID] = @OlguID)

  DECLARE @SinifID INT = (SELECT [ID] FROM [Programlama].[Siniflar] WHERE [Ad] = dbo.PascalToCamelCase(@OlguAd))

  IF @SinifID IS NULL
  BEGIN
    INSERT INTO [Programlama].[Siniflar]([Ad])
    VALUES(dbo.PascalToCamelCase(@OlguAd))

    SET @SinifID = SCOPE_IDENTITY()
  END

  /*
  SINIF AÇIKLAMASI

  @Component({
  selector: 'app-urun-recete-listeleme',
  templateUrl: './urun-recete-listeleme.component.html',
  styleUrls: ['./urun-recete-listeleme.component.scss']
})
İlk önce ilgili sınıfta bu açıklamanın olup olmadığını kontrol et
  */

  DECLARE @SinifAciklamaID INT = (SELECT [ID] FROM [Programlama].[SinifAciklamalari] WHERE [SinifID] = @SinifID AND [Aciklama] = N'Component')

  IF @SinifAciklamaID IS NULL
  BEGIN
    INSERT INTO [Programlama].[SinifAciklamalari]([SinifID], [Aciklama], [Kod])
    VALUES(@SinifID, N'Component', N'@Component({
                                        selector: ''app-' + dbo.PascalToCamelCase(@OlguAd) + ''',
                                        templateUrl: ''./' + dbo.PascalToCamelCase(@OlguAd) + '.component.html'',
                                        styleUrls: [''./' + dbo.PascalToCamelCase(@OlguAd) + '.component.scss'']
                                      })')

    SET @SinifAciklamaID = SCOPE_IDENTITY()
  END

  /*
export class UrunAgacListelemeComponent implements OnInit
uygulanan arabirimler
*/
  DECLARE @SinifUygulananArabirimID INT = (SELECT [ID]
  FROM [Programlama].[SinifUygulananArabirimler]
  WHERE [SinifID] = @SinifID AND [UygulananArabirimAdi] = N'OnInit')

  IF @SinifUygulananArabirimID IS NULL
  BEGIN
    INSERT INTO [Programlama].[SinifUygulananArabirimler]([SinifID], [UygulananArabirimAdi])
    VALUES(@SinifID, N'OnInit')

    SET @SinifUygulananArabirimID = SCOPE_IDENTITY()
  END

  DECLARE @YapiciMetodID INT = (SELECT [ID] FROM [Programlama].[Metodlar] WHERE [Ad] = N'constructor' AND [SinifID] = @SinifID)

  IF @YapiciMetodID IS NULL
  BEGIN
    INSERT INTO [Programlama].[Metodlar]([Ad], [SinifID], [Kod], [DonusTipi], [YapiciMi])
    VALUES(N'constructor', @SinifID, N'', N'void', 1)

    SET @YapiciMetodID = SCOPE_IDENTITY()
  END

  /*
  İlgili olgunun parent olguları ve hangi alan üzerinde hiyerarşi kurulduğu bulunur.
  Örneğin; MalzemeTanimAgac olgusu MazlemeTanim olgusunun child tablosudur ve ilişki MalzemeTanimId üzerinde kurulmuştur.
  Bulunan hiyerarşiler için lookup veri kaynağı alanları oluşturulur.
  uretimRotaListesi: UretimRotaDTO[] = [];
  Sonra be veri kaynağı alanını API'den yükleyecek metod yazılır.
  private loadUretimRotaListesi() {
    this.uretimRotaService.listBy({}).subscribe({
      next: (r) => {
        this.uretimRotaListesi = r.data;
      },
      error: (r) => {
        console.error('Üretim Rota Listeleme Hatası:', r);
      }
    });
  }
  Son olarak da uretimRotaService servisi yapıcı metoda inject edilir.
*/
  DECLARE @OlguHiyerarsiID INT, @UstOlguID INT, @OlguVeriAlaniID INT, @KompozitMi BIT

  DECLARE cur CURSOR FOR
  SELECT [ID], [UstOlguID], [OlguVeriAlaniID], [KompozitMi] FROM [dbo].[OlguHiyerarsi] WHERE [OlguID] = @OlguID

  OPEN cur
  FETCH NEXT FROM cur INTO @OlguHiyerarsiID, @UstOlguID, @OlguVeriAlaniID, @KompozitMi

  WHILE @@FETCH_STATUS = 0
  BEGIN
    DECLARE @UstOlguAd NVARCHAR(100) = (SELECT [Ad] FROM [dbo].[Olgular] WHERE [ID] = @UstOlguID)

    DECLARE @OlguVeriFKAlanAd NVARCHAR(100) = (SELECT [Ad] FROM [dbo].[VeriAlanlari] WHERE [ID] = @OlguVeriAlaniID)

    DECLARE @AramaVeriKaynagiAlanAdi NVARCHAR(MAX) = dbo.PascalToCamelCase(@UstOlguAd) + N'Listesi'

    DECLARE @AramaVeriKaynagiAlanID INT = (SELECT [ID]
    FROM [Programlama].[SinifAlanlari]
    WHERE [SinifID] = @SinifID AND [Ad] = @AramaVeriKaynagiAlanAdi)

    IF @AramaVeriKaynagiAlanID IS NULL
    BEGIN
      INSERT INTO [Programlama].[SinifAlanlari]
        ([Ad], [Aciklama], [SinifID], [VeriTipi], [Kod])
      VALUES
        (@AramaVeriKaynagiAlanAdi, N'Arayüzde kullanılacak veri kaynağı alanı', @SinifID, dbo.PascalToCamelCase(@UstOlguAd) +'DTO[]', N'[]')

      SET @AramaVeriKaynagiAlanID = SCOPE_IDENTITY()
    END

    DECLARE @MetodAdi NVARCHAR(100) = N'load' + dbo.PascalToCamelCase(@AramaVeriKaynagiAlanAdi)

    DECLARE @MetodID INT = (SELECT [ID]
    FROM [Programlama].[Metodlar]
    WHERE [Ad] = @MetodAdi AND [SinifID] = @SinifID)

    IF @MetodID IS NULL
    BEGIN
      INSERT INTO [Programlama].[Metodlar]
        ([Ad], [SinifID], [Kod], [DonusTipi])
      VALUES
        (@MetodAdi, @SinifID, N'this.' + dbo.PascalToCamelCase(@UstOlguAd) + N'Service.listBy({}).subscribe({
                                                                          next: (r) => {
                                                                            this.' + @AramaVeriKaynagiAlanAdi + ' = r.data;
                                                                          },
                                                                          error: (r) => {
                                                                            console.error("Listeleme Hatası:", r);
                                                                          }
                                                                        });', N'void')

      SET @MetodID = SCOPE_IDENTITY()
    END

    DECLARE @ServisSinifAdi NVARCHAR(MAX) = dbo.PascalToCamelCase(@UstOlguAd) + N'Service'

    -- YAPICI METODU BULARAK SERVİSİ İNJECT ET
    INSERT INTO Programlama.MetodParametreleri([MetodID], [Ad], [Aciklama], [VeriTipi])
    VALUES(@YapiciMetodID, @ServisSinifAdi, N'İlgili servis sınıfı', @ServisSinifAdi)

    -- ngOnInit METODUNU EKLE
    DECLARE @ngOnInitMetodID INT = (SELECT [ID]
    FROM [Programlama].[Metodlar]
    WHERE [Ad] = N'ngOnInit' AND [SinifID] = @SinifID)

    IF @ngOnInitMetodID IS NULL
    BEGIN
      INSERT INTO [Programlama].[Metodlar]
        ([Ad], [SinifID], [Kod], [DonusTipi])
      VALUES
        (N'ngOnInit', @SinifID, N'', N'void')

      SET @ngOnInitMetodID = SCOPE_IDENTITY()
    END

    FETCH NEXT FROM cur INTO @OlguHiyerarsiID, @UstOlguID, @OlguVeriAlaniID, @KompozitMi
  END
END

GO

CREATE FUNCTION dbo.PascalToCamelCase (@input NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN
  DECLARE @length INT = LEN(@input)

  IF @length = 0
      RETURN @input

  IF @length = 1
      RETURN LOWER(@input)

  DECLARE @output NVARCHAR(MAX) = LOWER(SUBSTRING(@input, 1, 1)) + SUBSTRING(@input, 2, @length - 1)

  RETURN @output
END