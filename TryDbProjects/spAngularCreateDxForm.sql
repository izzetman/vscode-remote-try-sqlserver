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
