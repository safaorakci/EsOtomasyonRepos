<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<!--#include virtual="/data_root/JSON.asp"-->
<!--#include virtual="/data_root/jsonObject.class.asp"-->
<!--#include virtual="/data_root/JSON_read.asp"-->
<script language="JScript" runat="server" src='/js/json2.js'></script>
<script language="JScript" runat="server" src='/js/json3.js'></script>
<script language="JScript" runat="server">


    function CheckProperty(obj, propName) {
        return (typeof obj[propName] != "undefined");
    }

    function jsDateToTurkeyDate(tarih) {

        var gun = new Date(tarih).getDate();
        var ay = new Date(tarih).getMonth() + 1;
        var yil = new Date(tarih).getFullYear();

        if (parseInt(gun) < 10) {
            gun = "0" + gun;
        }
        if (parseInt(ay) < 10) {
            ay = "0" + ay;
        }
        yenitarih = gun + "." + ay + "." + yil;


        

        return yenitarih;
    }
    function getMillisInHoursMinutes(millis) {
        if (typeof (millis) != "number")
            return "";

        var sgn = millis >= 0 ? 1 : -1;
        millis = Math.abs(millis);
        var hour = Math.floor(millis / 3600000);
        var min = Math.floor((millis % 3600000) / 60000);
        return (sgn > 0 ? "" : "-") + pad(hour, 1, "0") + ":" + pad(min, 2, "0");
    }

    function getMillisInHours(millis) {
        if (!millis)
            return "";
        var hour = Math.floor(millis / 3600000);
        return (millis >= 0 ? "" : "-") + pad(hour, 1, "0");
    }

    function gunluk_sure_uygula(effort, toplam_gun) {
        return getMillisInHours((parseFloat(effort) || 0) / parseFloat(toplam_gun) || 0);
    }
    function pad(str, len, ch) {
	    if ((str + "").length < len) {
		    return new Array(len - ('' + str).length + 1).join(ch) + str;
	    } else {
		    return str
	    }
    }

</script>
<%
    
    Response.Clear()
    Response.AddHeader "Content-Type", "application/json"

    proje_id = trn(request("proje_id"))
    tip = trn(request("tip"))
    FirmaID = Request.Cookies("kullanici")("firma_id")

    Function IIf(bClause, sTrue, sFalse)
    If CBool(bClause) Then
        IIf = sTrue
    Else 
        IIf = sFalse
    End If
    End Function

    Function DYPB(pVal)
      If pVal Then
        DYPB = "true"
      Else
        DYPB = "false"
      End If
    End Function


    tip_str = ""
    ters_str = "_uygulama"
    if tip = "uygulama" then
        tip_str = "_uygulama"
        ters_str = ""
    end if


    if trn(request("islem"))="kayit" then
          

          Set myJSON = JSON2.parse(request("prj"))
            for each task in myJSON.tasks

                id =  task.id
                name = task.name
                progress = task.progress
                progressByWorklog = task.progressByWorklog
                irelevance = 0 ' task.relevance
                itype = "" ' task.type
                typeId = "" ' task.typeId
                description = task.description
                code = task.code
                ilevel = task.level
                status = task.status
                depends = task.depends
                start = task.start
                etiket = task.etiket
                duration = task.duration
                iend = task.end
                startIsMilestone = task.startIsMilestone
                endIsMilestone = task.endIsMilestone
                'collapsed = task.collapsed
                canWrite = task.canWrite
                canAdd = task.canAdd
                canDelete = task.canDelete
                canAddIssue = task.canAddIssue
                'hasChild = task.hasChild

  
                startIsMilestone = DYPB(startIsMilestone)
                endIsMilestone = DYPB(endIsMilestone)
                collapsed = DYPB(collapsed)
                canWrite = DYPB(canWrite)
                canAdd = DYPB(canAdd)
                canDelete = DYPB(canDelete)
                canAddIssue = DYPB(canAddIssue)
                canWrite = DYPB(canWrite)
                canWriteOnParent = DYPB(canWriteOnParent)

                start_tarih = jsDateToTurkeyDate(task.start)
                end_tarih = jsDateToTurkeyDate(task.end)

                adimID = 0
                yenikayit = false
                if isnumeric(id) = true then
                    SQL="select * from ahtapot_sablon_gantt_adimlari where proje_id = '"& proje_id &"' and id = '"& id &"' and cop = 'false' and firma_id = '"& FirmaID &"'"
                    set varmi = baglanti.execute(SQL)
                    if varmi.eof then
                        yenikayit = true
                    else

                    progressByWorklog = IIf(progressByWorklog = "Yanlis", 0, 1)
  
                        SQL="update ahtapot_sablon_gantt_adimlari set start_tarih"& tip_str &" = CONVERT(date, '"& start_tarih &"', 103), end_tarih"& tip_str &" = CONVERT(date, '"& end_tarih &"', 103), proje_id = '" & proje_id & "', name = '" & name & "', progress = '" & progress & "', progressByWorklog = '" & progressByWorklog & "', irelevance = '" & irelevance & "', type = '" & itype & "', typeId = '" & typeId & "', description = '" & description & "', code = '" & code & "', ilevel = '" & ilevel & "', status = '" & status & "', depends = '" & depends & "', start"& tip_str &" = '" & start & "', duration"& tip_str &" = '" & duration & "', iend"& tip_str &" = '" & iend & "', startIsMilestone = '" & startIsMilestone & "', endIsMilestone = '" & endIsMilestone & "', collapsed = '" & collapsed & "', canWrite = '" & canWrite & "', canAdd = '" & canAdd & "', canDelete = '" & canDelete & "', canAddIssue = '" & canAddIssue & "', hasChild = '" & hasChild & "' where id = '"& varmi("id") &"' and firma_id = '"& FirmaID &"'"
                        set guncelle = baglanti.execute(SQL)

                        SQL="update ucgem_is_listesi set durum = 'false' where GantAdimID = '"& varmi("id") &"' and cop = 'false' and firma_id = '"& FirmaID &"'"
                        'set guncelle = baglanti.execute(SQL)

                        adimID = varmi("id")

                        SQL="select sablon_adi as proje_adi from uretim_sablonlari where id = '"& proje_id &"' and firma_id = '"& FirmaID &"'"
                        set projeCek = baglanti.execute(SQL)

                        gorevliler = ""
                        If CheckProperty(task, "assigs") Then

                            for each kaynak in task.assigs

                                kaynakID = kaynak.id
                                resourceId = kaynak.resourceId
                                roleId = kaynak.roleId
                                effort = kaynak.effort

                                kaynak_tipi = split(resourceId, "-")(0)
                                kaynak_id = split(resourceId, "-")(1)

                                if trim(kaynak_tipi)="PERSONEL" then
                                    gorevliler = gorevliler & kaynak_id & ","
                                end if

                            next
                        End If

                        if len(gorevliler)>1 then
                            gorevliler = left(gorevliler, len(gorevliler)-1)
                        end if

                        if len(gorevliler)>0 then
                            renk = "rgb(52, 152, 219)"
                            ajanda_gosterim = "1"
                            adi = projeCek("proje_adi") & " - " & name
                            aciklama = projeCek("proje_adi") & " - " & name
                            departmanlar = "proje-" & proje_id
                            oncelik = "Normal"
                            kontrol_bildirim = "null"
                            baslangic_saati = "08:00"
                            baslangic_tarihi = start_tarih
                            bitis_tarihi = end_tarih
                            bitis_saati = "17:00"
                            durum = "true"
                            cop = "false"
                            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
                            firma_id = Request.Cookies("kullanici")("firma_id")
                            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
                            ekleyen_ip = Request.ServerVariables("Remote_Addr")
                            ekleme_tarihi = date
                            ekleme_saati = time
                            guncelleme_tarihi = date
                            guncelleme_saati = time
                            guncelleyen = Request.Cookies("kullanici")("kullanici_adsoyad")
                            GantAdimID  = adimID

                            toplam_gun = DateDiff("d", baslangic_tarihi, bitis_tarihi)
                            if cdbl(toplam_gun)<1 then
                                toplam_gun = 1
                            end if

                            SQL="select id from ucgem_is_listesi where GantAdimID = '"& GantAdimID &"' and cop = 'false' and firma_id = '"& FirmaID &"'"
                            set varmi = baglanti.execute(SQL)
                            if varmi.eof then

                                SQL="set nocount on; insert into ucgem_is_listesi(sinirlama_varmi, GantAdimID, renk, ajanda_gosterim, adi, aciklama, gorevliler, departmanlar, oncelik, kontrol_bildirim, baslangic_tarihi, baslangic_saati, bitis_tarihi, bitis_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, guncelleme_tarihi, guncelleme_saati, guncelleyen) values('1', '"& GantAdimID &"', '"& renk &"', '"& ajanda_gosterim &"', '"& adi &"', '"& aciklama &"', '"& gorevliler &"', '"& departmanlar &"', '"& oncelik &"', '"& kontrol_bildirim &"', '"& baslangic_tarihi &"', '"& baslangic_saati &"', '"& bitis_tarihi &"', '"& bitis_saati &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', '"& ekleme_tarihi &"', '"& ekleme_saati &"', '"& guncelleme_tarihi &"', '"& guncelleme_saati &"', '"& guncelleyen &"'); SELECT SCOPE_IDENTITY() id;"
                                'set isEkle = baglanti.execute(SQL)

                                 'IsID = isEkle(0)

                            else

                                SQL="update ucgem_is_listesi  set durum = 'true',adi = '"& adi &"', aciklama = '"& aciklama &"', gorevliler = '"& gorevliler &"', departmanlar = '"& departmanlar &"', baslangic_tarihi = '"& baslangic_tarihi &"', baslangic_saati = '"& baslangic_saati &"', bitis_tarihi = '"& bitis_tarihi &"', bitis_saati = '"& bitis_saati &"', guncelleme_tarihi = '"& guncelleme_tarihi &"', guncelleme_saati = '"& guncelleme_saati &"', guncelleyen = '"& guncelleyen  &"' where id = '"& varmi("id") &"' and firma_id = '"& FirmaID &"'"
                                'set guncelle = baglanti.execute(SQL)

                                'IsID = varmi("id")

                            end if


                            If CheckProperty(task, "assigs") Then
                                gorevli_personeller = ""
                                for each kaynak in task.assigs

                                    kaynakID = kaynak.id
                                    resourceId = kaynak.resourceId
                                    roleId = kaynak.roleId
                                    effort = kaynak.effort

                                    kaynak_tipi = split(resourceId, "-")(0)
                                    kaynak_id = split(resourceId, "-")(1)

                                    if trim(kaynak_tipi)="PERSONEL" then

                                        is_id = IsID
                                        gorevli_id = kaynak_id
                                        tamamlanma_orani = 0
                                        tamamlanma_tarihi = date
                                        tamamlanma_saati = time


                                        toplam_sure = getMillisInHoursMinutes(effort)
                                        gunluk_sure = gunluk_sure_uygula(effort, toplam_gun)

                                        gorevli_personeller = gorevli_personeller & gorevli_id & ","

                                        SQL="select id from ucgem_is_gorevli_durumlari where is_id = '"& is_id &"' and gorevli_id = '"& gorevli_id &"' and cop = 'false' and firma_id = '"& FirmaID &"'"
                                        set gorevli_varmi = baglanti.execute(SQL)

                                        if gorevli_varmi.eof then

                                            SQL="insert into ucgem_is_gorevli_durumlari(toplam_sure, gunluk_sure, toplam_gun, is_id, gorevli_id, tamamlanma_orani, tamamlanma_tarihi, tamamlanma_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& toplam_sure &"', '"& gunluk_sure &"', '"& toplam_gun &"', '"& is_id &"', '"& gorevli_id &"', '"& tamamlanma_orani &"', '"& tamamlanma_tarihi &"', '"& tamamlanma_saati &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', '"& ekleme_tarihi &"', '"& ekleme_saati &"')"
                                            ' set ekle = baglanti.execute(SQL)

                                            if not trim(gorevli_id) = trim(Request.Cookies("kullanici")("kullanici_id")) then

                                                bildirim = Request.Cookies("kullanici")("kullanici_adsoyad") & " sizi ''"& adi &"'' adlı işte Görvlendirdi."
                                                tip = "is_listesi"
                                                click = "sayfagetir(''/is_listesi/'',''jsid=4559&bildirim=true&bildirim_id="& is_id &"'');"
                                                user_id = gorevli_id
                                                okudumu = "0"
                                                durum = "true"
                                                cop = "false"
                                                firma_kodu = request.Cookies("kullanici")("firma_kodu")
                                                firma_id = request.Cookies("kullanici")("firma_id")
                                                ekleyen_id = request.Cookies("kullanici")("kullanici_id")
                                                ekleyen_ip = Request.ServerVariables("Remote_Addr")
    
                                                SQL="insert into ahtapot_bildirim_listesi(bildirim, tip, click, user_id, okudumu, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& bildirim &"', '"& tip &"', N'"& click &"', '"& user_id &"', '"& okudumu &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', getdate(), getdate()); SET NOCOUNT ON; EXEC MailGonderBildirim @personel_id = '"& gorevli_id &"', @mesaj = '"& bildirim &"';"
                                                ' set ekle2 = baglanti.execute(SQL)

                                                SQL="select personel_ad + ' ' + personel_soyad as personel_adsoyad, * from ucgem_firma_kullanici_listesi where id = '"& gorevli_id &"' and firma_id = '"& FirmaID &"'"
                                                ' Set personelcek = baglanti.execute(SQL)

                                                ' NetGSM_SMS personelcek("personel_telefon"), bildirim

                                            end if

                                        else

                                            SQL="update ucgem_is_gorevli_durumlari set toplam_sure = '"& toplam_sure &"', gunluk_sure = '"& gunluk_sure &"', toplam_gun = '"& toplam_gun &"' where id = '"& gorevli_varmi("id") &"' and firma_id = '"& FirmaID &"'"
                                            ' set guncelle = baglanti.execute(SQL)

                                            SQL="update ucgem_is_listesi set durum = 'true' where GantAdimID = '"& GantAdimID &"' and cop = 'false' and firma_id = '"& FirmaID &"'"
                                            ' set guncelle = baglanti.execute(SQL)

                                        end if

                                        

                                    end if
                                next


                                if len(gorevli_personeller)>0 then

                                    gorevli_personeller = gorevli_personeller & "0"

                                    SQL="delete from ucgem_is_gorevli_durumlari where is_id = '"& is_id &"' and gorevli_id not in ("& gorevli_personeller &") and firma_id = '"& FirmaID &"'"
                                    'set sil = baglanti.execute(SQL)

                                end if

                            End If


                        end if




                    end if
                else
                    yenikayit = true
                end if

                if yenikayit then

                    progressByWorklog = IIf(progressByWorklog = "Yanlis", 0, 1)

                    SQL="SET NOCOUNT ON; insert into ahtapot_sablon_gantt_adimlari(start_tarih"& tip_str &", end_tarih"& tip_str &", start_tarih"& ters_str &", end_tarih"& ters_str &", cop, proje_id , name , progress , progressByWorklog , irelevance , type , typeId , description , code , ilevel , status , depends , start"& tip_str &" , duration"& tip_str &", iend"& tip_str &" , start"& ters_str &" , duration"& ters_str &", iend"& ters_str &" , startIsMilestone , endIsMilestone , collapsed , canWrite , canAdd , canDelete , canAddIssue , hasChild, firma_id) values(CONVERT(date, '"& start_tarih &"', 103), CONVERT(date, '"& end_tarih &"', 103), CONVERT(date, '"& start_tarih &"', 103), CONVERT(date, '"& end_tarih &"', 103), 'false', '" & proje_id & "', '" & name & "', '" & progress & "', '" & progressByWorklog & "', '" & irelevance & "', '" & itype & "', '" & typeId & "', '" & description & "', '" & code & "', '" & ilevel & "', '" & status & "', '" & depends & "', '" & start & "', '" & duration & "', '" & iend & "', '" & start & "', '" & duration & "', '" & iend & "', '" & startIsMilestone & "', '" & endIsMilestone & "', '" & collapsed & "', '" & canWrite & "', '" & canAdd & "', '" & canDelete & "', '" & canAddIssue & "', '" & hasChild & "', '"& FirmaID &"'); SELECT SCOPE_IDENTITY() id;"
    
                    set ekle = baglanti.execute(SQL)

                    adimID = ekle(0)

                    SQL="select sablon_adi as proje_adi from uretim_sablonlari where id = '"& proje_id &"' and firma_id = '"& FirmaID &"'"
                    set projeCek = baglanti.execute(SQL)
                    
                    gorevliler = ""
                    If CheckProperty(task, "assigs") Then

                        for each kaynak in task.assigs

                            kaynakID = kaynak.id
                            resourceId = kaynak.resourceId
                            roleId = kaynak.roleId
                            effort = kaynak.effort

                            kaynak_tipi = split(resourceId, "-")(0)
                            kaynak_id = split(resourceId, "-")(1)

                            if trim(kaynak_tipi)="PERSONEL" then
                                gorevliler = gorevliler & kaynak_id & ","
                            end if

                        next
                    End If


                    if len(gorevliler)>1 then
                        gorevliler = left(gorevliler, len(gorevliler)-1)
                    end if


                    if len(gorevliler)>0 then

                        renk = "rgb(52, 152, 219)"
                        ajanda_gosterim = "1"
                        adi = projeCek("proje_adi") & " - " & name
                        aciklama = projeCek("proje_adi") & " - " & name
                    
                        departmanlar = "proje-" & proje_id
                        oncelik = "Normal"
                        kontrol_bildirim = "null"
                        baslangic_saati = "08:00"
                        baslangic_tarihi = start_tarih
                        bitis_tarihi = end_tarih
                        bitis_saati = "17:00"
                        durum = "true"
                        cop = "false"
                        firma_kodu = Request.Cookies("kullanici")("firma_kodu")
                        firma_id = Request.Cookies("kullanici")("firma_id")
                        ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
                        ekleyen_ip = Request.ServerVariables("Remote_Addr")
                        ekleme_tarihi = date
                        ekleme_saati = time
                        guncelleme_tarihi = date
                        guncelleme_saati = time
                        guncelleyen = Request.Cookies("kullanici")("kullanici_id")
                        GantAdimID  = adimID

                        toplam_gun = DateDiff("d", baslangic_tarihi, bitis_tarihi)
                        if cdbl(toplam_gun)<1 then
                            toplam_gun = 1
                        end if

                        SQL="set nocount on; insert into ucgem_is_listesi(sinirlama_varmi, GantAdimID, renk, ajanda_gosterim, adi, aciklama, gorevliler, departmanlar, oncelik, kontrol_bildirim, baslangic_tarihi, baslangic_saati, bitis_tarihi, bitis_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, guncelleme_tarihi, guncelleme_saati, guncelleyen) values('1', '"& GantAdimID &"', '"& renk &"', '"& ajanda_gosterim &"', '"& adi &"', '"& aciklama &"', '"& gorevliler &"', '"& departmanlar &"', '"& oncelik &"', '"& kontrol_bildirim &"', '"& baslangic_tarihi &"', '"& baslangic_saati &"', '"& bitis_tarihi &"', '"& bitis_saati &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', '"& ekleme_tarihi &"', '"& ekleme_saati &"', '"& guncelleme_tarihi &"', '"& guncelleme_saati &"', '"& guncelleyen &"'); SELECT SCOPE_IDENTITY() id;"
                        ' set isEkle = baglanti.execute(SQL)

                        'IsID = isEkle(0)

                        gorevli_personeller = ""
                        If CheckProperty(task, "assigs") Then
                        
                            for each kaynak in task.assigs

                                kaynakID = kaynak.id
                                resourceId = kaynak.resourceId
                                roleId = kaynak.roleId
                                effort = kaynak.effort

                                kaynak_tipi = split(resourceId, "-")(0)
                                kaynak_id = split(resourceId, "-")(1)

                                if trim(kaynak_tipi)="PERSONEL" then

                                    is_id = IsID
                                    gorevli_id = kaynak_id
                                    tamamlanma_orani = 0
                                    tamamlanma_tarihi = date
                                    tamamlanma_saati = time

                                        gorevli_personeller = gorevli_personeller & gorevli_id & ","

                                        SQL="select id from ucgem_is_gorevli_durumlari where is_id = '"& is_id &"' and gorevli_id = '"& gorevli_id &"' and firma_id = '"& FirmaID &"'"
                                        set gorevli_varmi = baglanti.execute(SQL)

                                        if gorevli_varmi.eof then

                                            toplam_sure = getMillisInHoursMinutes(effort)
                                            gunluk_sure = gunluk_sure_uygula(effort, toplam_gun)

                                            SQL="insert into ucgem_is_gorevli_durumlari(toplam_sure, gunluk_sure, toplam_gun, is_id, gorevli_id, tamamlanma_orani, tamamlanma_tarihi, tamamlanma_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& toplam_sure &"', '"& gunluk_sure &"', '"& toplam_gun &"', '"& is_id &"', '"& gorevli_id &"', '"& tamamlanma_orani &"', '"& tamamlanma_tarihi &"', '"& tamamlanma_saati &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', '"& ekleme_tarihi &"', '"& ekleme_saati &"')"
                                            'set ekle = baglanti.execute(SQL)


                                            if not trim(gorevli_id) = trim(Request.Cookies("kullanici")("kullanici_id")) then
                                                bildirim = Request.Cookies("kullanici")("kullanici_adsoyad") & " sizi ''"& adi &"'' adlı işte Görvlendirdi."
                                                tip = "is_listesi"
                                                click = "sayfagetir(''/is_listesi/'',''jsid=4559&bildirim=true&bildirim_id="& is_id &"'');"
                                                user_id = gorevli_id
                                                okudumu = "0"
                                                durum = "true"
                                                cop = "false"
                                                firma_kodu = request.Cookies("kullanici")("firma_kodu")
                                                firma_id = request.Cookies("kullanici")("firma_id")
                                                ekleyen_id = request.Cookies("kullanici")("kullanici_id")
                                                ekleyen_ip = Request.ServerVariables("Remote_Addr")

                                                SQL="insert into ahtapot_bildirim_listesi(bildirim, tip, click, user_id, okudumu, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& bildirim &"', '"& tip &"', N'"& click &"', '"& user_id &"', '"& okudumu &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', getdate(), getdate()); SET NOCOUNT ON; EXEC MailGonderBildirim @personel_id = '"& gorevli_id &"', @mesaj = '"& bildirim &"';"
                                                ' set ekle2 = baglanti.execute(SQL)

                                                SQL="select personel_ad + ' ' + personel_soyad as personel_adsoyad, * from ucgem_firma_kullanici_listesi where id = '"& gorevli_id &"' and firma_id = '"& FirmaID &"'"
                                                ' Set personelcek = baglanti.execute(SQL)

                                                ' NetGSM_SMS personelcek("personel_telefon"), bildirim

                                            end if

                                        else

                                            SQL="update ucgem_is_gorevli_durumlari set toplam_sure = '"& toplam_sure &"', gunluk_sure = '"& gunluk_sure &"', toplam_gun = '"& toplam_gun &"' where id = '"& gorevli_varmi("id") &"' and firma_id = '"& FirmaID &"'"
                                            ' set guncelle = baglanti.execute(SQL)

                                        end if

                                end if
                            next

                            if len(gorevli_personeller)>0 then

                                gorevli_personeller = gorevli_personeller & "0"

                                SQL="delete from ucgem_is_gorevli_durumlari where is_id = '"& is_id &"' and gorevli_id not in ("& gorevli_personeller &") and firma_id = '"& FirmaID &"'"
                                ' set sil = baglanti.execute(SQL)

                            end if

                        End If
                    end if
                end if


                SQL="delete from sablon_gantt_adim_kaynaklari where adimID = '"& adimID &"' and firma_id = '"& FirmaID &"'"
                set guncelle = baglanti.execute(SQL)
                
                If CheckProperty(task, "assigs") Then

                    for each kaynak in task.assigs

                        kaynakID = kaynak.id
                        resourceId = kaynak.resourceId
                        roleId = kaynak.roleId
                        effort = kaynak.effort

                        kaynak_tipi = split(resourceId, "-")(0)
                        kaynak_id = split(resourceId, "-")(1)

                        toplam_sure = getMillisInHoursMinutes(effort)
                        gunluk_sure = gunluk_sure_uygula(effort, toplam_gun)

                        durum = "true"
                        cop = "false"
                        firma_kodu = Request.Cookies("kullanici")("firma_kodu")
                        firma_id = Request.Cookies("kullanici")("firma_id")
                        ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
                        ekleyen_ip = Request.ServerVariables("Remote_Addr")
                        ekleme_tarihi = date
                        ekleme_saati = time

                        SQL="insert into sablon_gantt_adim_kaynaklari(toplam_sure, gunluk_sure, toplam_gun, adimID, kaynak_tipi, kaynak_id, roleId, effort, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& toplam_sure &"', '"& gunluk_sure &"', '"& toplam_gun &"', '"& adimID &"', '"& kaynak_tipi &"', '"& kaynak_id &"', '"& roleId &"', '"& effort &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', '"& ekleme_tarihi &"', '"& ekleme_saati &"')"
                        set ekle = baglanti.execute(SQL)

                    next

                end if

            next

            if len(trim(myJSON.deletedTaskIds))>0 then
                SQL="update ahtapot_proje_gantt_adimlari set cop = 'true' where id in ("& myJSON.deletedTaskIds &") and firma_id = '"& FirmaID &"'"
                set guncelle = baglanti.execute(SQL)
            end if

            selectedRow = 0
            zoom = myJSON.zoom

            SQL="update uretim_sablonlari set selectedRow = '"& selectedRow &"',  zoom = '"& zoom &"', guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' where id = '"& proje_id &"' and firma_id = '"& FirmaID &"'"
            set guncelle = baglanti.execute(SQL)

            if trim(tip)="uygulama" then
                olay = "Proje Planlama Güncellendi"
            else
                olay = "Proje Uygulama Güncellendi"
            end if

            olay_tarihi = cdate(date)
            olay_saati = time
            departman_id = 0
            durum = "true"
            cop = "false"
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            ekleme_tarihi = date
            ekleme_saati = time

            SQL="insert into ucgem_proje_olay_listesi(proje_id, olay, olay_tarihi, olay_saati, departman_id, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& proje_id &"', '"& olay &"', '"& olay_tarihi &"', '"& olay_saati &"', '"& departman_id &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', '"& ekleme_tarihi &"', '"& ekleme_saati &"')"
            'set olay_ekle = baglanti.execute(SQL)

     elseif trn(request("islem")) = "sil" then
        
        proje_id = trn(request("proje_id"))
        tip = trn(request("tip"))
        cop = "true"
        silen_id = Request.Cookies("kullanici")("kullanici_id")
        silen_ip = Request.ServerVariables("Remote_Addr")
        silme_tarihi = date
        silme_saati = time
        guncelleyen = Request.Cookies("kullanici")("kullanici_adsoyad")

        SQL = "update ahtapot_sablon_gantt_adimlari set cop = '"& cop &"' where proje_id = '"& proje_id &"' and cop = 'false' and firma_id = '"& FirmaID &"'"
        set gantUpdate = baglanti.execute(SQL)

        'SQL = "update ucgem_is_listesi set durum = 'false' where departmanlar = 'proje-"& proje_id &"'"
        'set isUpdate = baglanti.execute(SQL)

    end if

    SQL="select * from ucgem_proje_listesi where id = '" & proje_id &"' and firma_id = '"& FirmaID &"'"
    set proje = baglanti.execute(SQL)
    
    Set  oJSON = New aspJSON
    oJSON.data.Add "ok", true
    oJSON.data.Add "project", oJSON.Collection()
    oJSON.data("project").Add "tasks", oJSON.Collection()
    With oJSON.data("project")("tasks")
        SQL="select STRING_ESCAPE(name, 'json') as name2, STRING_ESCAPE(description, 'json') as description2, * from ahtapot_sablon_gantt_adimlari where proje_id = '"& proje_id &"' and cop = 'false' and firma_id = '"& FirmaID &"'"
        set adim = baglanti.execute(SQL)
        x = 0
        e = ""
        
        do while not adim.eof
            .Add x, oJSON.Collection()
            With .item(x)
                .Add "id", cint(trim(adim("id")))
                .Add "name", (trim(adim("name2")))
                .Add "progress", cint(adim("progress"))
                .Add "progressByWorklog", false
                .Add "relevance", cint(adim("irelevance"))
                .Add "type", ""
                .Add "typeId", ""
                .Add "description", trim(adim("description2"))
                .Add "code", trim(adim("code"))
                .Add "level", cint(adim("ilevel"))
                .Add "status", trim(adim("status"))
                if not adim("etiket") = "NULL" then .Add "etiket", trim(adim("etiket")) else .Add "etiket", e end if
                .Add "depends", trim(adim("depends"))
                .Add "start", cdbl(adim("start" & tip_str))
                .Add "duration", cint(adim("duration" & tip_str))
                .Add "end", cdbl(adim("iend" & tip_str))
                .Add "start_golge", cdbl(adim("start" & ters_str))
                .Add "duration_golge", cint(adim("duration" & ters_str))
                .Add "end_golge", cdbl(adim("iend" & ters_str))
                .Add "startIsMilestone", false
                .Add "endIsMilestone", false
                .Add "collapsed", false
                .Add "canWrite", true
                .Add "canAdd", true
                .Add "canDelete", true
                .Add "canAddIssue", true
                .Add "hasChild", cbool(adim("hasChild"))
                .Add "assigs", oJSON.Collection()
                SQL="select * from sablon_gantt_adim_kaynaklari where adimID = '"& adim("id") &"' and firma_id = '"& FirmaID &"'"
                set kaynak = baglanti.execute(SQL)
                k = 0
                do while not kaynak.eof
                    With .item("assigs")
                        .Add k, oJSON.Collection()
                        With .item(k)
                            .Add "id", trim(kaynak("id"))
                            .Add "resourceId", trim(kaynak("kaynak_tipi") & "-" & kaynak("kaynak_id"))
                            .Add "roleId", trim(kaynak("roleId"))
                            .Add "effort", int(kaynak("effort"))
                        end With
                    end With
                    k = k + 1
                kaynak.movenext
                loop
            End With
            x = x + 1
        adim.movenext
        loop
    End With

    oJSON.data("project").Add "selectedRow", 0
    oJSON.data("project").Add "deletedTaskIds", oJSON.Collection()

    SQL="select * from gantt_kaynaklar where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"'"
    set kaynak = baglanti.execute(SQL)


    oJSON.data("project").Add "resources", oJSON.Collection()
            xx = 0
            With oJSON.data("project")("resources")
                do while not kaynak.eof
                    .Add xx, oJSON.Collection()
                    With .item(xx)
                        str = kaynak("tip") & "-" & kaynak("id")
                        .Add "id", trim(str)
                        .Add "name", trim(kaynak("kaynak"))
                        .Add "tip", trim(kaynak("tip"))
                    end With
                    xx = xx + 1
                kaynak.movenext
                loop

                '.Add 0, oJSON.Collection()
                'With .item(0)
                '    .Add "id", "tmp_1"
                '    .Add "name", "Kaynak 1"
                'end With
                '.Add 1, oJSON.Collection()
                'With .item(1)
                '    .Add "id", "tmp_2"
                '    .Add "name", "Kaynak 2"
                'end With

            end With

    oJSON.data("project").Add "roles", oJSON.Collection()

            With oJSON.data("project")("roles")

                .Add 0, oJSON.Collection()
                With .item(0)
                    .Add "id", "tmp_1"
                    .Add "name", "" & LNG("Proje Yöneticisi") & ""
                end With

            end With

    oJSON.data("project").Add "canWrite", true
    oJSON.data("project").Add "canDelete", true
    oJSON.data("project").Add "canAdd", true
    oJSON.data("project").Add "canWriteOnParent", true
    'oJSON.data("project").Add "zoom", trim(proje("zoom"))
    Response.Write oJSON.JSONoutput
            

    Response.End



%>{"ok": true,"project":{"tasks":[{"id":-1,"name":"Ajax Havalandırma Tesisatı","progress":0,"progressByWorklog":false,"relevance":0,"type":"","typeId":"","description":"","code":"","level":0,"status":"STATUS_ACTIVE","depends":"","start":1533589200000,"duration":20,"end":1535576399999,"startIsMilestone":false,"endIsMilestone":false,"collapsed":false,"canWrite":true,"canAdd":true,"canDelete":true,"canAddIssue":true,"assigs":[],"hasChild":true},{"id":-2,"name":"Kanal İmalatı","progress":0,"progressByWorklog":false,"relevance":0,"type":"","typeId":"","description":"","code":"","level":1,"status":"STATUS_ACTIVE","depends":"","start":1533589200000,"duration":10,"end":1534539599999,"startIsMilestone":false,"endIsMilestone":false,"collapsed":false,"canWrite":true,"canAdd":true,"canDelete":true,"canAddIssue":true,"assigs":[],"hasChild":true},{"id":-3,"name":"Kanal Uygulama","progress":0,"progressByWorklog":false,"relevance":0,"type":"","typeId":"","description":"","code":"","level":2,"status":"STATUS_ACTIVE","depends":"","start":1533589200000,"duration":2,"end":1533761999999,"startIsMilestone":false,"endIsMilestone":false,"collapsed":false,"canWrite":true,"canAdd":true,"canDelete":true,"canAddIssue":true,"assigs":[],"hasChild":false},{"id":-4,"name":"Kanal Vidalama","progress":0,"progressByWorklog":false,"relevance":0,"type":"","typeId":"","description":"","code":"","level":2,"status":"STATUS_SUSPENDED","depends":"3","start":1533762000000,"duration":4,"end":1534193999999,"startIsMilestone":false,"endIsMilestone":false,"collapsed":false,"canWrite":true,"canAdd":true,"canDelete":true,"canAddIssue":true,"assigs":[],"hasChild":false},{"id":-5,"name":"Kanal Döşeme","progress":0,"progressByWorklog":false,"relevance":0,"type":"","typeId":"","description":"","code":"","level":1,"status":"STATUS_SUSPENDED","depends":"2:5","start":1535576400000,"duration":5,"end":1536094799999,"startIsMilestone":false,"endIsMilestone":false,"collapsed":false,"canWrite":true,"canAdd":true,"canDelete":true,"canAddIssue":true,"assigs":[],"hasChild":true},{"id":-6,"name":"Kalın Döşeme","progress":0,"progressByWorklog":false,"relevance":0,"type":"","typeId":"","description":"","code":"","level":2,"status":"STATUS_SUSPENDED","depends":"","start":1535576400000,"duration":2,"end":1535749199999,"startIsMilestone":false,"endIsMilestone":false,"collapsed":false,"canWrite":true,"canAdd":true,"canDelete":true,"canAddIssue":true,"assigs":[],"hasChild":false},{"id":-7,"name":"Orta Boy Döşeme","progress":0,"progressByWorklog":false,"relevance":0,"type":"","typeId":"","description":"","code":"","level":2,"status":"STATUS_SUSPENDED","depends":"6","start":1535922000000,"duration":3,"end":1536181199999,"startIsMilestone":false,"endIsMilestone":false,"collapsed":false,"canWrite":true,"canAdd":true,"canDelete":true,"canAddIssue":true,"assigs":[],"hasChild":false},{"id":-8,"name":"İnce Döşeme","progress":0,"progressByWorklog":false,"relevance":0,"type":"","typeId":"","description":"","code":"","level":2,"status":"STATUS_SUSPENDED","depends":"6","start":1535922000000,"duration":2,"end":1536094799999,"startIsMilestone":false,"endIsMilestone":false,"collapsed":false,"canWrite":true,"canAdd":true,"canDelete":true,"canAddIssue":true,"assigs":[],"hasChild":false}],"selectedRow":2,"deletedTaskIds":[],"resources":[{"id":"tmp_1","name":"Kaynak 1"},{"id":"tmp_2","name":"Kaynak 2"},{"id":"tmp_3","name":"Kaynak 3"},{"id":"tmp_4","name":"Kaynak 4"}],"roles":[{"id":"tmp_1","name":"Proje Yöneticisi"},{"id":"tmp_2","name":"İşçi"},{"id":"tmp_3","name":"Taşeron"},{"id":"tmp_4","name":"Müşteri"}],"canWrite":true,"canDelete":true,"canAdd":true,"canWriteOnParent":true,"zoom":"1M"}}