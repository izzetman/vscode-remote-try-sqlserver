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
