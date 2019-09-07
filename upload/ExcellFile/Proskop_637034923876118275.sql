

			
			DECLARE @firma_id int
			DECLARE @kullanici_id int
			DECLARE @departmanlar nvarchar(5)

			SET	@firma_id = 1
			SET @kullanici_id = 2
			SET @departmanlar = '1,2'


			select *, count(*) as sayi 
			from (select case when isler.durum = 'false' then 'ÝPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BÝTTÝ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECÝKTÝ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLÝYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDÝYOR' end as is_durum from ucgem_is_listesi isler join ucgem_firma_kullanici_listesi ekleyen on ekleyen.id = isler.ekleyen_id where isler.durum = 'true' and isler.firma_id = @firma_id and (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = @kullanici_id) > 0 and isler.cop = 'false') as tablo 
			group by tablo.is_durum; 
			
			
			select *, count(*) as sayi from (select case when isler.durum = 'false' then 'ÝPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BÝTTÝ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECÝKTÝ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLÝYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDÝYOR' end as is_durum from ucgem_is_listesi isler join ucgem_firma_kullanici_listesi ekleyen on ekleyen.id = isler.ekleyen_id where isler.durum = 'true' and isler.firma_id = @firma_id and (select top 1 metin from dbo.Split(replace(isler.gorevliler,'null','0'), ',') where metin != '' + @kullanici_id + '' and dbo.isReallyNumeric(metin)=1)>0 and isler.ekleyen_id = @kullanici_id and isler.cop = 'false') as tablo group by tablo.is_durum;select * from (select id, departman_adi as adi, 'departman' as tip, 'Departmanlar' as grup from tanimlama_departman_listesi where firma_id = @firma_id and durum = 'true' and cop = 'false' and (SELECT COUNT(value) FROM STRING_SPLIT(@departmanlar, ',') WHERE value = id) > 0 UNION select id, firma_adi, 'firma', 'Firmalar' from ucgem_firma_listesi where ekleyen_firma_id = @firma_id and durum = 'true' and cop = 'false' UNION select id, proje_adi, 'proje', 'Projeler' from ucgem_proje_listesi where firma_id = @firma_id and durum = 'true' and cop = 'false') etiketler order by adi asc
