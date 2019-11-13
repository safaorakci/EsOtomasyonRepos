<!--#include virtual="/data_root/conn.asp"-->
<!--#include virtual="/data_root/functions.asp"-->
<%
    Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
    Response.CodePage = 65001


    if gp(3) = "taseron_yonetimi" then
        Server.Execute("/System_root/taseron/taseron_ans.asp")
    elseif gp(3)="taseron_detay" then
        Server.Execute("/System_root/taseron/taseron_detay.asp")
    elseif gp(3) = "sirket_ayarlari" then
        Server.Execute("/System_root/sirket/sirket_ayarlari.asp")
    elseif gp(3) = "firma_detaylari" then
        Server.Execute("/System_root/firma_yonetimi/firma_detaylari.asp")
    elseif gp(3) = "taseron_detaylari" then
        Server.Execute("/System_root/taseron_yonetimi/taseron_detaylari.asp")
    elseif gp(3) = "toplanti_yonetimi" then
        Server.Execute("/System_root/toplanti_yonetimi/toplanti_ans.asp")
    elseif gp(3) = "toplanti_detay" then
        Server.Execute("/System_root/toplanti_yonetimi/toplanti_detay.asp")
    elseif gp(3) = "finansman_yonetimi" then
        Server.Execute("/System_root/finansman_yonetimi/finansman_ans.asp")
    elseif gp(3) = "finansman_detay" then
        Server.Execute("/System_root/finansman_yonetimi/finansman_detay.asp")
    elseif gp(3) = "kategori_tanimlamalari" then
        Server.Execute("/System_root/tanimlamalar/kategori_tanimlamalari.asp")
    elseif gp(3) = "yasakli_izin_gunleri" then
        Server.Execute("/System_root/tanimlamalar/yasakli_izin_gunleri.asp")
    elseif gp(3) = "ajax_request" then
        Server.Execute("/ajax/islem1.asp")
    elseif gp(3) = "ajax_request2" then
        Server.Execute("/ajax/islem2.asp")
    elseif gp(3) = "ajax_request3" then
        Server.Execute("/ajax/islem3.asp")
    elseif gp(3) = "ajax_request4" then
        Server.Execute("/ajax/islem4.asp")
    elseif gp(3) = "ajax_request5" then
        Server.Execute("/ajax/islem5.asp")
    elseif gp(3) = "ajax_request6" then
        Server.Execute("/ajax/islem6.asp")
    elseif gp(3) = "ajax_ajanda" then
        Server.Execute("/ajax/ajanda.asp")
    elseif gp(3) = "montaj_is_detay" then
        Server.Execute("/ajax/is_detay.asp")
    elseif gp(3) = "dosya_indir" then
        Server.Execute("/formlar/dosya_indir.asp")
    elseif gp(3) = "dosya_ac" then
        Server.Execute("/formlar/dosya_ac.asp")
    elseif gp(3) = "cari_makbuz" then
        Server.Execute("/formlar/cari_makbuz.asp")
    elseif gp(3) = "personel_detaylari" then
        Server.Execute("/System_Root/personel_yonetimi/personel_detaylari.asp")
    elseif gp(3) = "ajanda" then
        Server.Execute("/system_root/ajanda/ajanda_ans.asp")
    elseif gp(3) = "santiye_detay" then
        Server.Execute("/System_Root/santiyeler/santiye_detay.asp")
    elseif gp(3) = "anasayfa" then
        Server.Execute("/System_root/anasayfa/anasayfa.asp")    
    elseif gp(3) = "ajax_timeline" then
        Server.Execute("/ajax/timeline.asp")
    elseif gp(3) = "kaynak_is_yuku_cizelgesi" then
        Server.Execute("/araclar/kaynak_is_yuku_cizelgesi.asp")
    elseif gp(3) = "ajax_bildirim" then
        Server.Execute("/ajax/bildirim.asp")
    elseif gp(3) = "bildirim_merkezi" then
        Server.Execute("/System_root/anasayfa/bildirim_merkezi.asp")
    elseif gp(3) = "beta_hatalari" then
        Server.Execute("/system_root/beta/beta_hatalari.asp")
    elseif gp(3) = "logout" then
        Server.Execute("/logout.asp")
    elseif gp(3) = "ajax_planlama" then
        Server.Execute("/ajax/planlama.asp")
    elseif gp(3) = "rapor_personel_is_yuku" then
        Server.Execute("/System_root/raporlar/rapor_personel_is_yuku.asp")
    elseif gp(3) = "form_personel_is_yuku" then
        Server.Execute("/System_root/formlar/rapor_personel_is_yuku.asp")
    elseif gp(3) = "rapor_departmanlardaki_is_hacmi" then
        Server.Execute("/System_root/raporlar/rapor_departmanlardaki_is_hacmi.asp")
    elseif gp(3) = "rapor_is_gucu_verimlilik" then
        Server.Execute("/System_root/raporlar/rapor_is_gucu_verimlilik.asp")
    elseif gp(3) = "form_personel_is_yuku_verimlilik" then
        Server.Execute("/System_root/formlar/rapor_is_gucu_verimlilik.asp")
    elseif gp(3) = "personel_performans_raporu" then
        Server.Execute("/System_root/raporlar/personel_performans_raporu.asp")
    elseif gp(3) = "proje_adam_saat_raporu" then
        Server.Execute("/System_root/raporlar/proje_adam_saat_raporu.asp")
    elseif gp(3) = "departman_adam_saat_raporu" then
        Server.Execute("/System_root/raporlar/departman_adam_saat_raporu.asp")    
    elseif gp(3) = "proje_maliyet_raporu" then
        Server.Execute("/System_root/raporlar/proje_maliyet_raporu.asp")
    elseif gp(3) = "personel_adam_saat_raporu" then
        Server.Execute("/System_root/raporlar/personel_adam_saat_raporu.asp")
    elseif gp(3) = "tahsilatlar_raporu" then
        Server.Execute("/System_root/raporlar/tahsilatlar_raporu.asp")
    elseif gp(3) = "odemeler_raporu" then
        Server.Execute("/System_root/raporlar/odemeler_raporu.asp")
    elseif gp(3) = "nakit_akis_raporu" then
        Server.Execute("/System_root/raporlar/nakit_akis_raporu.asp")
    elseif gp(3) = "form_departmanlardaki_is_hacmi" then
        Server.Execute("/System_root/formlar/form_departmanlardaki_is_hacmi.asp")
    elseif gp(3) = "form_personel_performans_raporu" then
        Server.Execute("/System_root/formlar/form_personel_performans_raporu.asp")
    elseif gp(3) = "form_proje_adam_saat_raporu" then
        Server.Execute("/System_root/formlar/form_proje_adam_saat_raporu.asp")
    elseif gp(3) = "form_departman_adam_saat_raporu" then
        Server.Execute("/System_root/formlar/form_departman_adam_saat_raporu.asp")
    elseif gp(3) = "form_proje_maliyet_raporu" then
        Server.Execute("/System_root/formlar/form_proje_maliyet_raporu.asp")
    elseif gp(3) = "form_personel_adam_saat_raporu" then
        Server.Execute("/System_root/formlar/form_personel_adam_saat_raporu.asp")
    elseif gp(3) = "form_tahsilatlar_raporu" then
        Server.Execute("/System_root/formlar/form_tahsilatlar_raporu.asp")
    elseif gp(3) = "form_odemeler_raporu" then
        Server.Execute("/System_root/formlar/form_odemeler_raporu.asp")
    elseif gp(3) = "form_nakit_akis_raporu" then
        Server.Execute("/System_root/formlar/form_nakit_akis_raporu.asp")
    elseif gp(3) = "izin_talep_formu" then
        Server.Execute("/System_root/formlar/izin_talep_formu.asp")
    elseif gp(3) = "mesai_bildirim_formu" then
        Server.Execute("/System_root/formlar/mesai_bildirim_formu.asp")
    elseif gp(3) = "satinalma_formu" then
        Server.Execute("/System_root/formlar/satinalma_formu.asp")
    elseif gp(3) = "teknik_servis_formu" then
        Server.Execute("/System_root/formlar/teknik_servis_formu.asp")
    elseif gp(3) = "teknik_servis_formu2" then
        Server.Execute("/System_root/formlar/teknik_servis_formu2.asp")

    elseif gp(3) = "profil_ayarlari" then
        Server.Execute("/System_root/sirket/profil_ayarlari.asp")
        elseif gp(3) = "montaj_profil_ayarlari" then
        Server.Execute("/System_root/sirket/montaj_profil_ayarlari.asp")
    elseif gp(3) = "yeni_firma_detaylari" then
        Server.Execute("/System_root/yonetim/yeni_firma_detaylari.asp")
    elseif gp(3) = "form_gantt_liste_gorunumu" then
        Server.Execute("/System_root/formlar/form_gantt_liste_gorunumu.asp")
    elseif gp(3) = "ajax_dil" then
        Server.Execute("/ajax/dil.asp")
    elseif gp(3) = "parcalar" then
        Server.Execute("/System_root/parcalar/parcalar.asp")
    elseif gp(3) = "satinalma-siparisleri" then
        Server.Execute("/System_root/satinalma/satinalma-siparisleri.asp")
    elseif gp(3) = "talepler" then
        Server.Execute("/System_root/talepler/talepler.asp")
    elseif gp(3) = "is_listesi_yeni" then
        Server.Execute("/System_root/is_emirleri/is_emirleri.asp")   
    elseif gp(3) = "otomatik_is_akislari" then
        Server.Execute("/System_root/is_emirleri/otomatik_is_akislari.asp")  
    elseif gp(3) = "uretim_sablonlari" then
        Server.Execute("/System_root/uretim_sablonlari/uretim_sablonlari.asp")  
    elseif gp(3) = "ajax_uretim_sablon" then
        Server.Execute("/ajax/uretim_sablon.asp")  
    elseif gp(3) = "bakim_yonetimi" then
        Server.Execute("/System_root/bakim/bakim_yonetimi.asp")
    end if

%>