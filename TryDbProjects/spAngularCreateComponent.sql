-- Procedure : spAngularCreateComponent
-- Description : Veri alanlarına göre Angular bileşenini oluşturur. Bunu Programlama şeması altındaki Sinif ve ilgili alt tabloları doldurarak yapar.
-- Parameters : @OlguID INT
-- Returns : Void
CREATE PROCEDURE [dbo].[spAngularCreateComponent]
  @OlguID INT
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @OlguAd NVARCHAR(100) = (SELECT [Ad]
  FROM [dbo].[Olgular]
  WHERE [ID] = @OlguID)

  DECLARE @SinifID INT = (SELECT [ID]
  FROM [Programlama].[Siniflar]
  WHERE [Ad] = dbo.PascalToCamelCase(@OlguAd))

  IF @SinifID IS NULL
  BEGIN
    INSERT INTO [Programlama].[Siniflar]
      ([Ad])
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

  DECLARE @SinifAciklamaID INT = (SELECT [ID]
  FROM [Programlama].[SinifAciklamalari]
  WHERE [SinifID] = @SinifID AND [Aciklama] = N'Component')

  IF @SinifAciklamaID IS NULL
  BEGIN
    INSERT INTO [Programlama].[SinifAciklamalari]
      ([SinifID], [Aciklama], [Kod])
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
    INSERT INTO [Programlama].[SinifUygulananArabirimler]
      ([SinifID], [UygulananArabirimAdi])
    VALUES(@SinifID, N'OnInit')

    SET @SinifUygulananArabirimID = SCOPE_IDENTITY()
  END

  DECLARE @YapiciMetodID INT = (SELECT [ID]
  FROM [Programlama].[Metodlar]
  WHERE [Ad] = N'constructor' AND [SinifID] = @SinifID)

  IF @YapiciMetodID IS NULL
  BEGIN
    INSERT INTO [Programlama].[Metodlar]
      ([Ad], [SinifID], [Kod], [DonusTipi], [YapiciMi])
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
  SELECT [ID], [UstOlguID], [OlguVeriAlaniID], [KompozitMi]
  FROM [dbo].[OlguHiyerarsi]
  WHERE [OlguID] = @OlguID

  OPEN cur
  FETCH NEXT FROM cur INTO @OlguHiyerarsiID, @UstOlguID, @OlguVeriAlaniID, @KompozitMi

  WHILE @@FETCH_STATUS = 0
  BEGIN
    DECLARE @UstOlguAd NVARCHAR(100) = (SELECT [Ad]
    FROM [dbo].[Olgular]
    WHERE [ID] = @UstOlguID)

    DECLARE @OlguVeriFKAlanAd NVARCHAR(100) = (SELECT [Ad]
    FROM [dbo].[VeriAlanlari]
    WHERE [ID] = @OlguVeriAlaniID)

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
    INSERT INTO [Programlama].[MetodParametreleri]
      ([MetodID], [Ad], [Aciklama], [VeriTipi])
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
