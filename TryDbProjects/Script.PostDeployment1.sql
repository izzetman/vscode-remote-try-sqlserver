GO

INSERT INTO [dbo].[VeriTipleri] ([ID], [Ad])
VALUES (1, N'Metin'),
       (2, N'Tamsayı'),
       (3, N'Ondalıklı Sayı'),
       (4, N'Tarih ve Saat'),
       (5, N'Boole'),
       (6, N'GUID'),
       (7, N'XML'),
       (8, N'Binary')

GO

INSERT INTO [dbo].[AltVeriTipleri] ([ID], [Ad], [VeriTipID])
VALUES (1, N'Metin', 1),
       (2, N'Tamsayı', 2),
       (3, N'Ondalıklı Sayı', 3),
       (4, N'Tarih', 4),
       (5, N'Tarih ve Saat', 4),
       (6, N'Evet/Hayır', 5),
       (7, N'GUID', 6),
       (8, N'XML', 7),
       (9, N'Dosya', 8),
       (10, N'e-posta', 1),
       (11, N'Parola', 8),
       (12, N'Saat', 4),
       (100, N'Malzeme Tanım Id', 2)

GO

INSERT INTO [dbo].[VeriAlanKosullari] ([ID], [Kosul])
VALUES (1, N'Zorunlu'),
       (2, N'Tam Uzunluk'),
       (3, N'Min Uzunluk'),
       (4, N'Max Uzunluk'),
       (5, N'Min Tarih'),
       (6, N'Max Tarih'),
       (7, N'Min Tamsayı'),
       (8, N'Max Tamsayı'),
       (9, N'Min Ondalıklı Sayı'),
       (10, N'Max Ondalıklı Sayı'),
       (11, N'RegEx Format')

GO

INSERT INTO [dbo].[VeriAlanlari] ([ID], [Ad], [Aciklama], [AltVeriTipID])
VALUES (1, N'ID', NULL, 2),
       (2, N'Ad', NULL, 1),
       (3, N'Soyad', NULL, 1),
       (4, N'Kod', NULL, 1),
       (5, N'DogumTarihi', N'Doğum Tarihi', 4),
       (6, N'OlusturulmaTarihi', N'Oluşturulma Tarihi', 4),
       (7, N'GuncellemeTarihi', N'Güncelleme Tarihi', 4),
       (8, N'ePosta', N'E-Posta', 10),
       (9, N'Parola', N'Parola', 11),
       (10, N'Onaylandi', N'Onaylandı', 6),
       (11, N'GUID', NULL, 6),
       (12, N'XML', NULL, 7),
       (13, N'DosyaIcerik', N'Dosya İçeriği', 8),
       (14, N'AnaMalzemeTanimId', N'Ana Malzeme Tanım', 100),
       (15, N'MalzemeTanimId', N'Malzeme Tanım', 100),
       (16, N'UstMalzemeTanimId', N'Üst Malzeme Tanım', 100),
       (17, N'Miktar', N'Miktar', 3),
       (18, N'MiktarBirimId', N'Miktar Birim', 2),
       (19, N'Aktif', N'Aktif', 5),
       (20, N'AltMalzemeTanimVarYok', N'Alt Malzeme Tanım Var/Yok', 5),
       (21, N'Seviye', N'Seviye', 2)

GO

INSERT INTO [dbo].[VeriAlanlariKosullari] ([VeriAlanID], [VeriAlaniKosulID], [Deger])
VALUES (1, 1, N'1'),
       (2, 1, N'1'),
       (2, 4, N'100'),
       (3, 1, N'1'),
       (3, 4, N'100'),
       (4, 1, N'1'),
       (4, 4, N'50'),
       (5, 1, N'1'),
       (5, 5, N'1900-01-01'),
       (17, 1, N'1'),
       (17, 7, N'1'),
       (18, 1, N'1'),
       (18, 7, N'1'),
       (19, 1, N'1'),
       (20, 1, N'1'),
       (21, 1, N'1'),
       (21, 9, N'0.000001')

GO

INSERT INTO [dbo].[Olgular] ([Ad], [Aciklama])
VALUES (N'MalzemeTanimAgac', N'Ürün Ağacı'),
       (N'MalzemeTanimAgacDetay', N'Ürün Ağacı Detayı'),
       (N'MalzemeTanim', N'Malzeme Tanım')

GO

INSERT INTO [dbo].[OlguVeriAlanlari] ([ID], [VeriAlanID], [OlguID])
VALUES (1, 1, 1), -- MalzemeTanimAgac, ID
       (2, 14, 1), -- MalzemeTanimAgac, AnaMalzemeTanimId
       (3, 15, 1), -- MalzemeTanimAgac, MalzemeTanimId
       (4, 16, 1), -- MalzemeTanimAgac, UstMalzemeTanimId
       (5, 17, 1), -- MalzemeTanimAgac, Miktar
       (6, 18, 1), -- MalzemeTanimAgac, MiktarBirimId
       (7, 19, 1), -- MalzemeTanimAgac, Aktif
       (8, 20, 1), -- MalzemeTanimAgac, AltMalzemeTanimVarYok
       (9, 21, 1), -- MalzemeTanimAgac, Seviye
       (10, 1, 2), -- MalzemeTanimAgacDetay, ID
       (11, 15, 2), -- MalzemeTanimAgacDetay, MalzemeTanimId
       (12, 16, 2), -- MalzemeTanimAgacDetay, UstMalzemeTanimId
       (13, 21, 2) -- MalzemeTanimAgacDetay, Seviye

GO

INSERT INTO [dbo].[OlguHiyerarsi] ([ID], [OlguID], [UstOlguID], [OlguVeriAlaniID], [KompozitMi])
VALUES (1, 1, 3, 2, 0), -- MalzemeTanimAgac, MalzemeTanim, AnaMalzemeTanimId
       (2, 1, 3, 3, 0), -- MalzemeTanimAgac, MalzemeTanim, MalzemeTanimId
       (3, 1, 3, 4, 0), -- MalzemeTanimAgac, MalzemeTanim, UstMalzemeTanimId
       (4, 2, 3, 15, 0), -- MalzemeTanimAgacDetay, MalzemeTanimId
       (5, 2, 3, 16, 0), -- MalzemeTanimAgacDetay, UstMalzemeTanimId
       (6, 2, 1, 14, 0) -- MalzemeTanimAgac, AnaMalzemeTanimId

GO