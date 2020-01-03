


select ISNULL((SELECT TOP 1 SUBSTRING( f.firma_adi, 1, 3)FROM ucgem_firma_listesi f ),'') + SUBSTRING(CONVERT(NVARCHAR(10), DATEPART(year, isler.ekleme_tarihi)),3,2) + RIGHT('0'+CONVERT(NVARCHAR(10), DATEPART(MONTH, isler.ekleme_tarihi)), 2) + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), isler.id),1,4), 4 )  AS is_kodu, isnull(isler.renk, '') as renk,

 Replace(Replace( STUFF(((select '~<span class="hiddenspan">' + replace(replace(etiket.adi, '(', ''), ')','') + '</span>' from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, ''), '&lt;', '<'), '&gt;', '>') hidden_etiketler, 
 
 case when isler.durum = 'false' then 'ÝPTAL' 
 when ISNULL(isler.tamamlanma_orani,0) = 100 then 'BÝTTÝ'
 when ISNULL(isler.tamamlanma_orani,0) = 0 then 'BEKLÝYOR' 
 when ISNULL(isler.tamamlanma_orani,0) > 0 and ISNULL(isler.tamamlanma_orani,0) < 100 then 'DEVAM EDÝYOR' 
 when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECÝKTÝ' 

 end as is_durum, 

 (select CONVERT(nvarchar(50), kullanici.id) + '~' + isnull(kullanici.personel_resim,'') + '~' + isnull(kullanici.personel_ad,'') + ' ' + isnull(kullanici.personel_soyad,'') + '|' from ucgem_firma_kullanici_listesi kullanici with(nolock) where (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), kullanici.id) ) > 0 for xml path('')) as gorevli_personeller, 
 
 STUFF(((select '~' + etiket.adi from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, '') as departman_isimleri, 

 ekleyen.personel_ad + ' ' + ekleyen.personel_soyad as ekleyen_adsoyad, 
 isler.* from ucgem_is_listesi isler with(nolock) join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id where isler.durum = 'true' and isler.firma_id = 1 and ((SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), 72) ) > 0) and 
 
 case when isler.durum = 'false' then 'ÝPTAL' 
 when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BÝTTÝ' 
 when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLÝYOR'
 when ISNULL(isler.tamamlanma_orani,0) > 0 and ISNULL(isler.tamamlanma_orani,0) < 100 then 'DEVAM EDÝYOR' 
 when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECÝKTÝ' 
  
 end = 'DEVAM EDÝYOR' and isler.cop = 'false' order by (convert(datetime, isler.guncelleme_tarihi) + convert(datetime, isler.guncelleme_saati)) desc;



 select ISNULL((SELECT TOP 1 SUBSTRING( f.firma_adi, 1, 3)FROM ucgem_firma_listesi f ),'') + SUBSTRING(CONVERT(NVARCHAR(10), DATEPART(year, isler.ekleme_tarihi)),3,2) + RIGHT('0'+CONVERT(NVARCHAR(10), DATEPART(MONTH, isler.ekleme_tarihi)), 2) + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), isler.id),1,4), 4 )  AS is_kodu, isnull(isler.renk, '') as renk, 
 
 Replace(Replace( STUFF(((select '~<span class="hiddenspan">' + replace(replace(etiket.adi, '(', ''), ')','') + '</span>' from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, ''), '&lt;', '<'), '&gt;', '>') hidden_etiketler,
 
  case when isler.durum = 'false' then 'ÝPTAL' 
  when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BÝTTÝ' 
  when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECÝKTÝ' 
  when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLÝYOR' 
  when ISNULL(isler.tamamlanma_orani,0) < 100 then 'DEVAM EDÝYOR' 
  end as is_durum, 
  
  (select CONVERT(nvarchar(50), kullanici.id) + '~' + isnull(kullanici.personel_resim,'') + '~' + isnull(kullanici.personel_ad,'') + ' ' + isnull(kullanici.personel_soyad,'') + '|' from ucgem_firma_kullanici_listesi kullanici with(nolock) where (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), kullanici.id) ) > 0 for xml path('')) as gorevli_personeller, 
  
  STUFF(((select '~' + etiket.adi from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, '') as departman_isimleri, 
  
  ekleyen.personel_ad + ' ' + ekleyen.personel_soyad as ekleyen_adsoyad, 
  isler.* from ucgem_is_listesi isler with(nolock) join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id where isler.durum = 'true' and isler.firma_id = 1 and ((SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), 72) ) > 0) and 
  
  case when isler.durum = 'false' then 'ÝPTAL' 
  when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BÝTTÝ' 
  when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECÝKTÝ' 
  when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLÝYOR' 
  when ISNULL(isler.tamamlanma_orani,0) < 100 then 'DEVAM EDÝYOR' 
  end = 'GECÝKTÝ' and isler.cop = 'false' order by (convert(datetime, isler.guncelleme_tarihi) + convert(datetime, isler.guncelleme_saati)) desc;












  select *, count(*) as sayi from (select case when isler.durum = 'false' then 'ÝPTAL' 
												when ISNULL(isler.tamamlanma_orani,0) = 0 then 'BEKLÝYOR'
												when ISNULL(isler.tamamlanma_orani,0) = 100 then 'BÝTTÝ'  
												when ISNULL(isler.tamamlanma_orani,0) > 0 and ISNULL(isler.tamamlanma_orani,0) < 100 then 'DEVAM EDÝYOR'
												(case when when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECÝKTÝ' end) end as is_durum 
  
  from ucgem_is_listesi isler join ucgem_firma_kullanici_listesi ekleyen on ekleyen.id = isler.ekleyen_id where isler.durum = 'true' and isler.firma_id = 1 and (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = 72) > 0 and isler.cop = 'false') as tablo group by tablo.is_durum; 
  
  select *, count(*) as sayi from (select case when isler.durum = 'false' then 'ÝPTAL' 
  
  when ISNULL(isler.tamamlanma_orani,0) = 0 then 'BEKLÝYOR'
  when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BÝTTÝ'  
  when ISNULL(isler.tamamlanma_orani,0) > 0 and ISNULL(isler.tamamlanma_orani,0) < 100 and GETDATE() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'DEVAM EDÝYOR'
  when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECÝKTÝ' 
  end as is_durum 
  
  from ucgem_is_listesi isler join ucgem_firma_kullanici_listesi ekleyen on ekleyen.id = isler.ekleyen_id where isler.durum = 'true' and isler.firma_id = 1 and (select top 1 metin from dbo.Split(replace(isler.gorevliler,'null','0'), ',') where metin != '' + 72 + '' and dbo.isReallyNumeric(metin)=1)>0 and isler.ekleyen_id = 72 and isler.cop = 'false') as tablo group by tablo.is_durum;select * from (select id, departman_adi as adi, 'departman' as tip, 'Departmanlar' as grup from tanimlama_departman_listesi where firma_id = 1 and durum = 'true' and cop = 'false' and (SELECT COUNT(value) FROM STRING_SPLIT('', ',') WHERE value = id) > 0 UNION select id, firma_adi, 'firma', 'Firmalar' from ucgem_firma_listesi where ekleyen_firma_id = 1 and durum = 'true' and cop = 'false' UNION select id, proje_adi, 'proje', 'Projeler' from ucgem_proje_listesi where firma_id = 1 and durum = 'true' and cop = 'false') etiketler order by adi asc