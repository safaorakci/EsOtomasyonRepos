<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" bilal -->
<%
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    FirmaID = Request.Cookies("kullanici")("firma_id")

    if trn(request("islem")) = "ToplantiGrubu" then

        FirmaKodu = Request.Cookies("kullanici")("firma_kodu")
        FirmaID = Request.Cookies("kullanici")("firma_id")
        EkleyenID = Request.Cookies("kullanici")("kullanici_id")
        EkleyenIP = Request.ServerVariables("Remote_Addr")

        if trn(request("islem2")) = "Ekle" then
            GrupAdi = trn(request("GrupAdi"))

            SQL = "insert into ToplantiGrubu(GrupAdi, firma_kodu, firma_id, ekleyen_id, ekleyen_ip) values('"& GrupAdi &"', '"& FirmaKodu &"', '"& FirmaID &"', '"& EkleyenID &"', '"& EkleyenIP &"')"
            set ToplantiGrupEkleme = baglanti.execute(SQL)

        elseif trn(request("islem2")) = "Guncelle" then
            GrupID = trn(request("GrupID"))
            GrupAdi = trn(request("GrupAdi"))

            SQL = "update ToplantiGrubu set GrupAdi = '"& GrupAdi &"' where ID = '"& GrupID &"' and firma_id = '"& FirmaID &"'"
            set ToplantiGrupGuncelleme = baglanti.execute(SQL)

        elseif trn(request("islem2")) = "Sil" then
            GrupID = trn(request("GrupID"))

            SQL = "select count(*) as sayi from GrupToplantilari where durum = 1 and cop = 0 and GrupID = '"& GrupID &"' and firma_id = '"& FirmaID &"'"
            set GrupToplantilari = baglanti.execute(SQL)

            if GrupToplantilari("sayi") > 0 then
%>
    <script type="text/javascript">
        $(function () {
            mesaj_ver("Toplantılar", "Bu gruba bağlı kayıt mevcut, Silinemez. !", "warning");
        });
    </script>
<%
            else     
                SQL = "update ToplantiGrubu set cop = 1 where ID = '"& GrupID &"' and firma_id = '"& FirmaID &"'"
                set ToplantiGrupSilme = baglanti.execute(SQL)
            end if

        end if

    SQL = "select * from ToplantiGrubu where durum = 1 and cop = 0 and firma_id = '"& FirmaID &"'"
    set toplantiGrup = baglanti.execute(SQL)

    if toplantiGrup.eof then
%>
<span>Kayıt Bulunamadı.</span>
<%
    else
        do while not toplantiGrup.eof
%>
<style type="text/css">
    .f-20 {
        font-size: 20px !important;
    }

    .vertical-align-text-bottom {
        vertical-align: text-bottom;
    }

    .f-15 {
        font-size: 15px;
    }

    .cursor-pointer {
        cursor: pointer !important;
    }
</style>
<div class="card mb-2 border">
    <div class="card-header p-3 border-bottom" id="headingOne">
        <h6 class="mb-0 card-title">
            <a class="font-weight-normal cursor-pointer vertical-align-text-bottom" data-toggle="collapse" data-target="#collapse<%=toplantiGrup("ID") %>" aria-expanded="false" aria-controls="collapse<%=toplantiGrup("ID") %>">
                <i class="fa fa-arrow-right mr-2"></i><%=toplantiGrup("GrupAdi") %>
            </a>
            <i class="fa fa-trash-o float-right f-20 cursor-pointer ml-2" onclick="ToplantiGrubuSil('<%=toplantiGrup("ID") %>');" title="Grubu Sil"></i>
            <i class="fa fa-pencil float-right f-20 cursor-pointer" onclick="ToplantiGrubuDuzenle('<%=toplantiGrup("ID") %>');" title="Grubu Güncelle"></i>
        </h6>
    </div>

    <div id="collapse<%=toplantiGrup("ID") %>" class="collapse" aria-labelledby="headingOne" data-parent="#accordionExample">
        <div class="card-body p-3">
            <div class="row">
                <div class="col-md-12 mb-2">
                    <button type="button" class="btn btn-success btn-mini float-right" onclick="YeniGrupToplantisiEkle('<%=toplantiGrup("ID") %>');">Yeni Toplantı Ekle</button>
                </div>
                <div class="col-md-12" id="accordionBody<%=toplantiGrup("ID") %>">
                    <script type="text/javascript">
                        GrupToplantilari('<%=toplantiGrup("ID")%>')
                    </script>
                </div>
            </div>
        </div>
    </div>
</div>
<%
        toplantiGrup.movenext
        loop
    end if

    elseif trn(request("islem")) = "ToplantiGrubuDuzenle" then

        GrupID = trn(request("GrupID"))
        SQL = "select * from ToplantiGrubu where durum = 1 and cop = 0 and ID = '"& GrupID &"' and firma_id = '"& FirmaID &"'"
        set ToplantiGrubu = baglanti.execute(SQL)
%>
<div class="modal-header">
    Grup Adı Güncelleme
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<div class="modal-body pt-0">
    <div class="row">
        <div class="col-md-12">
            <div class="form-group mb-1">
                <label class="col-form-label">Grup Adı</label>
                <input type="text" class="form-control form-control-sm" id="GrupAdi<%=GrupID %>" value="<%=ToplantiGrubu("GrupAdi") %>""/>
            </div>
        </div>
    </div>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-info btn-mini" onclick="ToplantiGrubuGuncelle('<%=GrupID %>');">Kaydı Güncelle</button>
</div>
<%

    elseif trn(request("islem")) = "GrupToplantilari" then

        GrupID = trn(request("GrupID"))
        FirmaID = Request.Cookies("kullanici")("firma_id")
        i = 0
        
%>
<div class="dt-responsive table-responsive">
    <table class="table table-bordered table-mini text-nowrap datatableyap w-100">
        <thead>
            <tr>
                <th>No</th>
                <th>Konu</th>
                <th>Katılımcı</th>
                <th>Toplantı Tarihi</th>
                <th>Alınan Kararlar</th>
                <th>Notlar</th>
                <th>Dosya</th>
                <th>İşlem</th>
            </tr>
        </thead>
        <tbody>
            <%
                FirmaID = Request.Cookies("kullanici")("firma_id")
                SQL = "select * from GrupToplantilari where GrupID = '"& GrupID &"' and firma_id = '"& FirmaID &"' and durum = 1 and cop = 0"
                set grupToplantilari = baglanti.execute(SQL)

                if grupToplantilari.eof then
            %>
            <tr>
                <td class="text-center" colspan="8">Kayıt Bulunamadı.!</td>
            </tr>
            <%
                else
                    do while not grupToplantilari.eof
                    kullanicilar = ""
                        i = i + 1
            %>
            <tr>
                <td><%=i %></td>
                <td><%=grupToplantilari("Konu") %></td>
                <%
                    for x = 0 to ubound(split(grupToplantilari("Katilimci"), ","))
                            UserID = split(grupToplantilari("Katilimci"), ",")(x)
                            SQL = "select personel_ad +' '+ personel_soyad as ad_soyad from ucgem_firma_kullanici_listesi where id = '"& UserID &"' and firma_id = '"& FirmaID &"' and durum = 'true' and cop = 'false' and firma_id = '"& FirmaID &"'"
                            set katilimcilar = baglanti.execute(SQL)
                            if kullanicilar = "" then
                                kullanicilar = katilimcilar("ad_soyad")
                            else
                                kullanicilar = kullanicilar & " - " & katilimcilar("ad_soyad")
                            end if
                    next
                %>
                <td><%=kullanicilar %></td>
                <td><%=FormatDate(FormatDateTime(grupToplantilari("ekleme_tarihi"),2), "00") %></td>
                <td>
                    <%
                        if Len(grupToplantilari("AlinanKararlar")) > 30 then
                    %>
                    <%=Mid(grupToplantilari("AlinanKararlar"),1, 30) %>
                    <i class="fa fa-info-circle ml-2 f-20 cursor-pointer" title="<%=grupToplantilari("AlinanKararlar") %>"></i>
                    <%else %>
                    <%=grupToplantilari("AlinanKararlar") %>
                    <%end if %>
                </td>
                <td>
                    <%
                        if Len(grupToplantilari("Notlar")) > 30 then
                    %>
                    <%=Mid(grupToplantilari("Notlar"),1, 30) %>
                    <i class="fa fa-info-circle ml-2 f-20 cursor-pointer" title="<%=grupToplantilari("Notlar") %>"></i>
                    <%else %>
                    <%=grupToplantilari("Notlar") %>
                    <%end if %>
                </td>
                <%
                     if InStr(grupToplantilari("Dosya"), "jpg") or InStr(grupToplantilari("Dosya"), "jpeg") or InStr(grupToplantilari("Dosya"), "png") or InStr(grupToplantilari("Dosya"), "pdf") then
                %>
                <td><%if InStr(grupToplantilari("Dosya"), "pdf") then %> PDF <%else %> Resim <%end if %> <a class="btn btn-info btn-mini ml-2" href="javascript:void(0);" onclick="ToplantiDosyaAc('<%=grupToplantilari("Dosya") %>');">Aç</a></td>
                <%
                    elseif grupToplantilari("Dosya") = null or grupToplantilari("Dosya") = "undefined" then
                %>
                <td class="text-center">---</td>
                <%
                    else
                %>
                <td>Dosya <a class="btn btn-info btn-mini ml-2" href="javascript:void(0);" onclick="ToplantiDosyaAc('<%=grupToplantilari("Dosya") %>');">İndir</a></td>
                <%
                    end if
                %>
                <td>
                    <button type="button" class="btn btn-info btn-mini" onclick="ToplantiDuzenle('<%=GrupID %>', '<%=grupToplantilari("id") %>');">Düzenle</button>
                    <button type="button" class="btn btn-danger btn-mini" onclick="ToplantiSil('<%=GrupID %>', '<%=grupToplantilari("id") %>');">Sil</button>
                </td>
            </tr>
            <%
                        
                            grupToplantilari.movenext
                            loop
                        end if
            %>
        </tbody>
    </table>
</div>
<%
    elseif trn(request("islem")) = "YeniGrupToplantisiEkle" then

        GrupID = trn(request("GrupID"))
        FirmaID = Request.Cookies("kullanici")("firma_id")
%>
<div class="modal-header">
    Yeni Toplantı
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<div class="modal-body pt-0">
    <div class="row">
        <div class="col-md-12">
            <div class="form-group mb-1">
                <label class="col-form-label">Dosya</label>
                <input type="file" class="form-control form-control-sm" id="ToplantiDosya" yol="ToplantiDosya/" folder="ToplantiDosya">
            </div>
            <div class="form-group mb-1">
                <label class="col-form-label">Toplantı Durumu</label>
                <div>
                    <span class="mr-1">Yapılmadı</span>
                    <input type="checkbox" class="form-control form-control-sm js-switch" id="ToplantiYapildi" />
                    <span class="ml-1">Yapıldı</span>
                </div>
            </div>
            <div class="form-group mb-1">
                <label class="col-form-label">Konu</label>
                <input type="text" class="form-control form-control-sm" id="ToplantiKonu" />
            </div>
            <div class="form-group mb-1">
                <label class="col-form-label">Toplantı Tarihi</label>
                <input type="text" class="form-control form-control-sm takvimyap" id="ToplantiTarihi" value="<%=FormatDate(Date, "00") %>" />
            </div>
            <div class="form-group mb-1">
                <label class="col-form-label">Katılımcılar</label>
                <select class="select2 form-control-sm" multiple id="ToplantiKatilimcilar">
                    <%
                        SQL = "select id, personel_ad +' '+ personel_soyad as ad_soyad from ucgem_firma_kullanici_listesi where durum = 'true' and cop = 'false' and firma_id = '"& FirmaID &"'"
                        set kullanicilar = baglanti.execute(SQL)

                        if kullanicilar.eof then
                    %>

                    <%
                        else
                        do while not kullanicilar.eof
                    %>
                    <option value="<%=kullanicilar("id") %>"><%=kullanicilar("ad_soyad") %></option>
                    <%
                        kullanicilar.movenext
                        loop
                        end if
                    %>
                </select>
            </div>
            <div class="form-group mb-1">
                <label class="col-form-label">Alınan Kararlar</label>
                <textarea class="form-control form-control-sm" id="ToplantiAlinanKararlar"></textarea>
            </div>
            <div class="form-group mb-1">
                <label class="col-form-label">Notlar</label>
                <textarea class="form-control form-control-sm" id="ToplantiNotlar"></textarea>
            </div>
        </div>
    </div>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-success btn-mini" onclick="YeniToplantiEkle('<%=GrupID %>');">Yeni Toplantı Ekle</button>
</div>
<%
    elseif trn(request("islem")) = "YeniToplantiEkle" then

        GrupID = trn(request("GrupID"))
        FirmaKodu = Request.Cookies("kullanici")("firma_kodu")
        FirmaID = Request.Cookies("kullanici")("firma_id")
        EkleyenID = Request.Cookies("kullanici")("kullanici_id")
        EkleyenIP = Request.ServerVariables("Remote_Addr")

        SQL = "select personel_ad +' '+ personel_soyad as ad_soyad from ucgem_firma_kullanici_listesi where id = '"& EkleyenID &"' and durum = 'true' and cop = 'false' and firma_id = '"& FirmaID &"'"
        set kullanici = baglanti.execute(SQL)
        
        if trn(request("islem2")) = "Ekle" then
            
            GrupID = trn(request("GrupID"))
            ToplantiDosya = trn(request("ToplantiDosya"))
            ToplantiYapildi = trn(request("ToplantiYapildi"))
            ToplantiKonu = trn(request("ToplantiKonu"))
            ToplantiTarihi = trn(request("ToplantiTarihi"))
            ToplantiKatilimcilar = trn(request("ToplantiKatilimcilar"))
            ToplantiAlinanKararlar = trn(request("ToplantiAlinanKararlar"))
            ToplantiNotlar = trn(request("ToplantiNotlar"))

            SQL = "insert into GrupToplantilari(GrupID, Dosya, Konu, ToplantiYapildi, ToplantiTarihi, Katilimci, AlinanKararlar, Notlar, ekleyen_id, ekleyen_ip, firma_id, firma_kodu) values('"& GrupID &"', '"& ToplantiDosya &"', '"& ToplantiKonu &"', '"& ToplantiYapildi &"', CONVERT(date, '"& ToplantiTarihi &"', 103), '"& ToplantiKatilimcilar &"', '"& ToplantiAlinanKararlar &"', '"& ToplantiNotlar &"', '"& EkleyenID &"', '"& EkleyenIP &"', '"& FirmaID &"', '"& FirmaKodu &"')"
            set GrupTolantiEkle = baglanti.execute(SQL)

            for x = 0 to ubound(split(ToplantiKatilimcilar, ","))
                UserID = split(ToplantiKatilimcilar, ",")(x)

                bildirim = kullanici("ad_soyad") & " sizi, konusu " & ToplantiKonu & " olan toplantıya ekledi"

                SQL = "insert into ahtapot_bildirim_listesi(bildirim, tip, click, user_id, firma_kodu, firma_id, ekleyen_id, ekleyen_ip) values('"& bildirim &"', '', 'sayfagetir(''/toplantilar/'',''jsid=4559'');', '"& UserID &"', '"& FirmaKodu &"', '"& FirmaID &"', '"& EkleyenID &"', '"& EkleyenIP &"')"
                set KatilimciBildirim = baglanti.execute(SQL)
            next

        elseif trn(request("islem2")) = "Sil" then
            
            GrupID = trn(request("GrupID"))
            ToplantiID = trn(request("ToplantiID"))

            SQL = "update GrupToplantilari set cop = 1 where GrupID = '"& GrupID &"' and ID = '"& ToplantiID &"' and firma_id = '"& FirmaID &"'"
            set toplantiSil = baglanti.execute(SQL)

        end if
%>
<div class="dt-responsive table-responsive">
    <table class="table table-bordered table-mini text-nowrap datatableyap w-100">
        <thead>
            <tr>
                <th>No</th>
                <th>Konu</th>
                <th>Katılımcı</th>
                <th>Toplantı Tarihi</th>
                <th>Alınan Kararlar</th>
                <th>Notlar</th>
                <th>Dosya</th>
                <th>İşlem</th>
            </tr>
        </thead>
        <tbody>
            <%
                        SQL = "select * from GrupToplantilari where GrupID = '"& GrupID &"' and durum = 1 and cop = 0 and firma_id = '"& FirmaID &"'"
                        set grupToplantilari = baglanti.execute(SQL)

                        if grupToplantilari.eof then
            %>
            <tr>
                <td class="text-center" colspan="8">Kayıt Bulunamadı.!</td>
            </tr>
            <%
                        else
                            do while not grupToplantilari.eof
                            kullanicilar = ""
                                i = i + 1
            %>
            <tr>
                <td><%=i %></td>
                <td><%=grupToplantilari("Konu") %></td>
                <%
                    for x = 0 to ubound(split(grupToplantilari("Katilimci"), ","))
                            UserID = split(grupToplantilari("Katilimci"), ",")(x)
                            SQL = "select personel_ad +' '+ personel_soyad as ad_soyad from ucgem_firma_kullanici_listesi where id = '"& UserID &"' and durum = 'true' and cop = 'false' and firma_id = '"& FirmaID &"'"
                            set katilimcilar = baglanti.execute(SQL)
                            if kullanicilar = "" then
                                kullanicilar = katilimcilar("ad_soyad")
                            else
                                kullanicilar = kullanicilar & " - " & katilimcilar("ad_soyad")
                            end if
                    next
                %>
                <td><%=kullanicilar %></td>
                <td><%=FormatDate(FormatDateTime(grupToplantilari("ekleme_tarihi"),2), "00") %></td>
                <td>
                    <%
                        if Len(grupToplantilari("AlinanKararlar")) > 30 then
                    %>
                    <%=Mid(grupToplantilari("AlinanKararlar"),1, 30) %>
                    <i class="fa fa-info-circle ml-2 f-20 cursor-pointer" title="<%=grupToplantilari("AlinanKararlar") %>"></i>
                    <%else %>
                    <%=grupToplantilari("AlinanKararlar") %>
                    <%end if %>
                </td>
                <td>
                    <%
                        if Len(grupToplantilari("Notlar")) > 30 then
                    %>
                    <%=Mid(grupToplantilari("Notlar"),1, 30) %>
                    <i class="fa fa-info-circle ml-2 f-20 cursor-pointer" title="<%=grupToplantilari("Notlar") %>"></i>
                    <%else %>
                    <%=grupToplantilari("Notlar") %>
                    <%end if %>
                </td>
                <%
                     if InStr(grupToplantilari("Dosya"), "jpg") or InStr(grupToplantilari("Dosya"), "jpeg") or InStr(grupToplantilari("Dosya"), "png") or InStr(grupToplantilari("Dosya"), "pdf") then
                %>
                <td><%if InStr(grupToplantilari("Dosya"), "pdf") then %> PDF <%else %> Resim <%end if %> <a class="btn btn-info btn-mini ml-2" href="javascript:void(0);" onclick="ToplantiDosyaAc('<%=grupToplantilari("Dosya") %>');">Aç</a></td>
                <%
                    elseif grupToplantilari("Dosya") = null or grupToplantilari("Dosya") = "undefined" then
                %>
                <td class="text-center">---</td>
                <%
                    else
                %>
                <td>Dosya <a class="btn btn-info btn-mini ml-2" href="javascript:void(0);" onclick="ToplantiDosyaAc('<%=grupToplantilari("Dosya") %>');">İndir</a></td>
                <%
                    end if
                %>
                <td>
                    <button type="button" class="btn btn-info btn-mini" onclick="ToplantiDuzenle('<%=GrupID %>', '<%=grupToplantilari("id") %>');">Düzenle</button>
                    <button type="button" class="btn btn-danger btn-mini" onclick="ToplantiSil('<%=GrupID %>', '<%=grupToplantilari("id") %>');">Sil</button>
                </td>
            </tr>
            <%
                        
                            grupToplantilari.movenext
                            loop
                        end if
            %>
        </tbody>
    </table>
</div>
<%
    elseif trn(request("islem")) = "ToplantiGuncelle" then

        GrupID = trn(request("GrupID"))
        FirmaKodu = Request.Cookies("kullanici")("firma_kodu")
        FirmaID = Request.Cookies("kullanici")("firma_id")
        EkleyenID = Request.Cookies("kullanici")("kullanici_id")
        EkleyenIP = Request.ServerVariables("Remote_Addr")

        if trn(request("islem2")) = "GuncellemeEkrani" then
            GrupID = trn(request("GrupID"))
            ToplantiID = trn(request("ToplantiID"))

            SQL = "select * from GrupToplantilari where ID = '"& ToplantiID &"' and GrupID = '"& GrupID &"' and firma_id = '"& FirmaID &"'"
            set toplantiDuzenlemeEkrani = baglanti.execute(SQL)
%>
<div class="modal-header">
    Toplantı Düzenleme
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<div class="modal-body pt-0">
    <div class="row">
        <div class="col-md-12">
            <div class="form-group mb-1">
                <label class="col-form-label">Dosya</label>
                <input type="file" class="form-control form-control-sm" id="ToplantiDosya" yol="ToplantiDosya/" folder="ToplantiDosya" filepath="<%=toplantiDuzenlemeEkrani("Dosya") %>" value="<%=toplantiDuzenlemeEkrani("Dosya") %>">
            </div>
            <div class="form-group mb-1">
                <label class="col-form-label">Toplantı Durumu</label>
                <div>
                    <span class="mr-1">Yapılmadı</span>
                    <input type="checkbox" class="form-control form-control-sm js-switch" id="ToplantiYapildi" <% if toplantiDuzenlemeEkrani("ToplantiYapildi") = True then %> checked <%end if %>/>
                    <span class="ml-1">Yapıldı</span>
                </div>
            </div>
            <div class="form-group mb-1">
                <label class="col-form-label">Konu</label>
                <input type="text" class="form-control form-control-sm" id="ToplantiKonu" value="<%=toplantiDuzenlemeEkrani("Konu") %>" />
            </div>
            <div class="form-group mb-1">
                <label class="col-form-label">Toplantı Tarihi</label>
                <input type="text" class="form-control form-control-sm takvimyap" id="ToplantiTarihi" value="<%=FormatDate(toplantiDuzenlemeEkrani("ToplantiTarihi"), "00") %>" />
            </div>
            <div class="form-group mb-1">
                <label class="col-form-label">Katılımcılar</label>
                <select class="select2 form-control-sm" multiple id="ToplantiKatilimcilar">
                    <%
                        SQL = "select id, personel_ad +' '+ personel_soyad as ad_soyad from ucgem_firma_kullanici_listesi where durum = 'true' and cop = 'false' and firma_id = '"& FirmaID &"'"
                        set kullanicilar = baglanti.execute(SQL)

                        if kullanicilar.eof then
                    %>

                    <%
                        else
                        do while not kullanicilar.eof

                        state = ""
                        for x = 0 to ubound(split(toplantiDuzenlemeEkrani("Katilimci"), ","))
                        user = split(toplantiDuzenlemeEkrani("Katilimci"), ",")(x)
                            if CStr(user) = CStr(kullanicilar("id")) then
                                state = "selected"
                            end if
                        next
                    %>
                    <option <%=state %> value="<%=kullanicilar("id") %>"><%=kullanicilar("ad_soyad") %></option>
                    <%
                        kullanicilar.movenext
                        loop
                        end if
                    %>
                </select>
            </div>
            <div class="form-group mb-1">
                <label class="col-form-label">Alınan Kararlar</label>
                <textarea class="form-control form-control-sm" id="ToplantiAlinanKararlar"><%=toplantiDuzenlemeEkrani("AlinanKararlar") %></textarea>
            </div>
            <div class="form-group mb-1">
                <label class="col-form-label">Notlar</label>
                <textarea class="form-control form-control-sm" id="ToplantiNotlar"><%=toplantiDuzenlemeEkrani("Notlar") %></textarea>
            </div>
        </div>
    </div>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-success btn-mini" onclick="ToplantiGuncelle('<%=GrupID %>', '<%=ToplantiID %>');">Kaydı Güncelle</button>
</div>
<%
        elseif trn(request("islem2")) = "Guncelle" then

            GrupID = trn(request("GrupID"))
            ToplantiID = trn(request("ToplantiID"))
            ToplantiDosya = trn(request("ToplantiDosya"))
            ToplantiKonu = trn(request("ToplantiKonu"))
            ToplantiYapildi = trn(request("ToplantiYapildi"))
            ToplantiTarihi = trn(request("ToplantiTarihi"))
            ToplantiKatilimcilar = trn(request("ToplantiKatilimcilar"))
            ToplantiAlinanKararlar = trn(request("ToplantiAlinanKararlar"))
            ToplantiNotlar = trn(request("ToplantiNotlar"))

            SQL = "update GrupToplantilari set Dosya = '"& ToplantiDosya &"', Konu = '"& ToplantiKonu &"', ToplantiYapildi = '"& ToplantiYapildi &"', ToplantiTarihi = CONVERT(date, '"& ToplantiTarihi &"', 103), Katilimci = '"& ToplantiKatilimcilar &"', AlinanKararlar = '"& ToplantiAlinanKararlar &"', Notlar = '"& ToplantiNotlar &"' where ID = '"& ToplantiID &"' and GrupID = '"& GrupID &"' and firma_id = '"& FirmaID &"'"
            set toplantiGuncelleme = baglanti.execute(SQL)
%>
<div class="dt-responsive table-responsive">
    <table class="table table-bordered table-mini text-nowrap datatableyap w-100">
        <thead>
            <tr>
                <th>No</th>
                <th>Konu</th>
                <th>Katılımcı</th>
                <th>Toplantı Tarihi</th>
                <th>Alınan Kararlar</th>
                <th>Notlar</th>
                <th>Dosya</th>
                <th>İşlem</th>
            </tr>
        </thead>
        <tbody>
            <%
                        SQL = "select * from GrupToplantilari where GrupID = '"& GrupID &"' and durum = 1 and cop = 0 and firma_id = '"& FirmaID &"'"
                        set grupToplantilari = baglanti.execute(SQL)

                        if grupToplantilari.eof then
            %>
            <tr>
                <td class="text-center" colspan="8">Kayıt Bulunamadı.!</td>
            </tr>
            <%
                        else
                            do while not grupToplantilari.eof
                            kullanicilar = ""
                                i = i + 1
            %>
            <tr>
                <td><%=i %></td>
                <td><%=grupToplantilari("Konu") %></td>
                <%
                    for x = 0 to ubound(split(grupToplantilari("Katilimci"), ","))
                            UserID = split(grupToplantilari("Katilimci"), ",")(x)
                            SQL = "select personel_ad +' '+ personel_soyad as ad_soyad from ucgem_firma_kullanici_listesi where id = '"& UserID &"' and durum = 'true' and cop = 'false' and firma_id = '"& FirmaID &"'"
                            set katilimcilar = baglanti.execute(SQL)
                            if kullanicilar = "" then
                                kullanicilar = katilimcilar("ad_soyad")
                            else
                                kullanicilar = kullanicilar & " - " & katilimcilar("ad_soyad")
                            end if
                    next
                %>
                <td><%=kullanicilar %></td>
                <td><%=FormatDate(FormatDateTime(grupToplantilari("ekleme_tarihi"),2), "00") %></td>
                <td>
                    <%
                        if Len(grupToplantilari("AlinanKararlar")) > 30 then
                    %>
                    <%=Mid(grupToplantilari("AlinanKararlar"),1, 30) %>
                    <i class="fa fa-info-circle ml-2 f-20 cursor-pointer" title="<%=grupToplantilari("AlinanKararlar") %>"></i>
                    <%else %>
                    <%=grupToplantilari("AlinanKararlar") %>
                    <%end if %>
                </td>
                <td>
                    <%
                        if Len(grupToplantilari("Notlar")) > 30 then
                    %>
                    <%=Mid(grupToplantilari("Notlar"),1, 30) %>
                    <i class="fa fa-info-circle ml-2 f-20 cursor-pointer" title="<%=grupToplantilari("Notlar") %>"></i>
                    <%else %>
                    <%=grupToplantilari("Notlar") %>
                    <%end if %>
                </td>
                <%
                     if InStr(grupToplantilari("Dosya"), "jpg") or InStr(grupToplantilari("Dosya"), "jpeg") or InStr(grupToplantilari("Dosya"), "png") or InStr(grupToplantilari("Dosya"), "pdf") then
                %>
                <td><%if InStr(grupToplantilari("Dosya"), "pdf") then %> PDF <%else %> Resim <%end if %> <a class="btn btn-info btn-mini ml-2" href="javascript:void(0);" onclick="ToplantiDosyaAc('<%=grupToplantilari("Dosya") %>');">Aç</a></td>
                <%
                    else
                %>
                <td>Dosya <a class="btn btn-info btn-mini ml-2" href="javascript:void(0);" onclick="ToplantiDosyaAc('<%=grupToplantilari("Dosya") %>');">İndir</a></td>
                <%
                    end if
                %>
                <td>
                    <button type="button" class="btn btn-info btn-mini" onclick="ToplantiDuzenle('<%=GrupID %>', '<%=grupToplantilari("id") %>');">Düzenle</button>
                    <button type="button" class="btn btn-danger btn-mini" onclick="ToplantiSil('<%=GrupID %>', '<%=grupToplantilari("id") %>');">Sil</button>
                </td>
            </tr>
            <%
                            grupToplantilari.movenext
                            loop
                        end if
            %>
        </tbody>
    </table>
</div>
<%    
    end if

    'Şirket Kültürü

    elseif trn(request("islem")) = "Departmanlar" then

        FirmaID = Request.Cookies("kullanici")("firma_id")
        i = 0
        SQL = "select id, departman_adi, departman_tipi from tanimlama_departman_listesi where durum = 'true' and cop = 'false' and firma_id = '"& FirmaID &"'"
        set departmanListesi = baglanti.execute(SQL)

        SQL = "select top 1 id from tanimlama_departman_listesi where durum = 'true' and cop = 'false' and firma_id = '"& FirmaID &"' order by id desc"
        set sonKayit = baglanti.execute(SQL)
        
        if departmanListesi.eof then
%>
<span>Kayıt Bulunamadı</span>
<%
        else
            
%>
<table class="table table-bordered table-mini table-striped w-100" id="Departman-Listesi">
    <thead>
        <tr>
            <td>Detay</td>
            <td>Departman Adı</td>
        </tr>
    </thead>
    <tbody>
        <%
                do while not departmanListesi.eof
                i = i + 1
        %>
        <tr>
            <td class="wt-40 text-center"><i class="fa fa-arrow-down cursor-pointer f-15 arrow-icon" id="departmanDetayIcon<%=departmanListesi("id") %>" data-toggle="tooltip" data-placement="top" title="Detay" onclick="DepartmanKurallari('<%=departmanListesi("id") %>');"></i></td>
            <td class="f-15"><%=departmanListesi("departman_adi") %></td>
        </tr>
        <tr class="departman-detay" id="DepartmanUptr<%=departmanListesi("id") %>">
            <td class="departman-detay" colspan="2" id="DepartmanUp<%=departmanListesi("id") %>" style="display: none">
                <div class="card-body departman-detay" id="DepartmanDown<%=departmanListesi("id") %>" style="display: none">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group mb-0">
                                    <label class="col-form-label">Başlık</label>
                                    <input type="text" class="form-control form-control-sm" placeholder="Başlık" id="KuralBasligi<%=departmanListesi("id") %>" />
                                </div>
                                <div class="form-group">
                                    <label class="col-form-label">Açıklama</label>
                                    <textarea class="form-control form-control-sm" placeholder="Açıklama" id="Kurallar<%=departmanListesi("id") %>"></textarea>
                                </div>
                                <button type="button" class="btn btn-success btn-mini float-right" onclick="DepartmanKuraliEkle('<%=departmanListesi("id") %>');">Kaydet</button>
                            </div>
                            <div class="col-md-8">
                                <div class="row">
                                    <div class="col-md-12 pb-2">
                                        <span class="f-15">Kural Listesi</span>
                                    </div>
                                    <div class="col-md-12" id="DepartmanKurallari<%=departmanListesi("id") %>"></div>
                                </div>
                            </div>
                         </div>
                    </div>
                </div>
            </td>
        </tr>
        <%
                departmanListesi.movenext
                loop
                end if
        %>
    </tbody>
</table>
<script type="text/javascript">
    $("#maxRows").val(10).change();
</script>
<%

    elseif trn(request("islem")) = "DepartmanKurallari" then

        DepartmanID = trn(request("DepartmanID"))
        FirmaKodu = Request.Cookies("kullanici")("firma_kodu")
        FirmaID = Request.Cookies("kullanici")("firma_id")
        EkleyenID = Request.Cookies("kullanici")("kullanici_id")
        EkleyenIP = Request.ServerVariables("Remote_Addr")
        i = 0

        if trn(request("islem2")) = "Ekle" then

            DepartmanID = trn(request("DepartmanID"))
            KuralBasligi = trn(request("KuralBasligi"))
            Kurallar = trn(request("Kurallar"))

            SQL = "insert into DepartmanKurallari(DepartmanID, KuralBaslik, Kurallar, firma_kodu, firma_id, ekleyen_id, ekleyen_ip) values('"& DepartmanID &"', '"& KuralBasligi &"', '"& Kurallar &"', '"& FirmaKodu &"', '"& FirmaID &"', '"& EkleyenID &"', '"& EkleyenIP &"')"
            set DepartmanKurallariEkle = baglanti.execute(SQL)

        elseif trn(request("islem2")) = "Guncelle" then

            DepartmanID = trn(request("DepartmanID"))
            ID = trn(request("ID"))
            KuralBasligi = trn(request("KuralBasligi"))
            Kurallar = trn(request("Kurallar"))

            SQL = "update DepartmanKurallari set KuralBaslik = '"& KuralBasligi &"', Kurallar = '"& Kurallar &"' where ID = '"& ID &"' and DepartmanID = '"& DepartmanID &"' and firma_id = '"& FirmaID &"'"
            set DepartmanKurallariGuncelle = baglanti.execute(SQL)

        elseif trn(request("islem2")) = "Sil" then
            
            DepartmanID = trn(request("DepartmanID"))
            ID = trn(request("ID"))
            
            SQL = "update DepartmanKurallari set cop = 1, silen_id = '"& EkleyenID &"', silen_ip = '"& EkleyenIP &"' where ID = '"& ID &"' and firma_id = '"& FirmaID &"'"
            set DepartmanKurallariSil = baglanti.execute(SQL)
        end if
%>
<div class="dt-responsive table-responsive">
    <table class="table table-mini table-bordered text-nowrap datatableyap w-100">
        <thead>
            <tr>
                <th>No</th>
                <th>Başlık</th>
                <th>Açıklama</th>
                <th>Ekleyen</th>
                <th>Ekleme Tarihi</th>
                <th>işlem</th>
            </tr>
        </thead>
        <tbody>
            <%
                SQL = "select dk.ID, dk.DepartmanID, dk.KuralBaslik, dk.Kurallar, dk.ekleme_tarihi, (select personel_ad + ' ' + personel_soyad from ucgem_firma_kullanici_listesi where id = dk.ekleyen_id and firma_id = '"& FirmaID &"') as Ekleyen from DepartmanKurallari dk where dk.DepartmanID = '"& DepartmanID &"' and durum = 1 and cop = 0 and firma_id = '"& FirmaID &"'"
                set DepartmanKurallari = baglanti.execute(SQL)

                if DepartmanKurallari.eof then
            %>
            <tr>
                <td colspan="5" class="text-center">Kayıt Bulunamadı.!</td>
            </tr>
            <%
                else
                    do while not DepartmanKurallari.eof
                    i = i + 1
            %>
            <tr>
                <td><%=i %></td>
                <td><%=DepartmanKurallari("KuralBaslik") %></td>
                <td>
                    <%
                        if Len(DepartmanKurallari("Kurallar")) > 30 then
                    %>
                    <%=Mid(DepartmanKurallari("Kurallar"),1, 30) %>
                    <i class="fa fa-info-circle ml-2 f-20 cursor-pointer" title="<%=DepartmanKurallari("Kurallar") %>"></i>
                    <%else %>
                    <%=DepartmanKurallari("Kurallar") %>
                    <%end if %>
                </td>
                <td><%=DepartmanKurallari("Ekleyen") %></td>
                <td><%=FormatDate(FormatDateTime(DepartmanKurallari("ekleme_tarihi"),2), "00") %></td>
                <td>
                    <button type="button" class="btn btn-info btn-mini" onclick="DepartmanKurallariDuzenle('<%=DepartmanID %>', '<%=DepartmanKurallari("ID") %>');">Düzenle</button>
                    <button type="button" class="btn btn-danger btn-mini" onclick="DepartmanKurallariSil('<%=DepartmanID %>', '<%=DepartmanKurallari("ID") %>');">Sil</button>
                </td>
            </tr>
            <%
                    DepartmanKurallari.movenext
                    loop
                end if
            %>
        </tbody>
    </table>
</div>
<%
    elseif trn(request("islem")) = "DepartmanKurallariDuzenlemeEkrani" then
        
        DepartmanID = trn(request("DepartmanID"))
        ID = trn(request("ID"))

        SQL = "select * from DepartmanKurallari where ID = '"& ID &"' and DepartmanID = '"& DepartmanID &"' and durum = 1 and cop = 0 and firma_id = '"& FirmaID &"'"
        set DepartmanKurallari = baglanti.execute(SQL)
%>
<div class="modal-header">
    Kural Düzenleme
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<div class="modal-body pt-0">
    <div class="row">
        <div class="col-md-12">
            <div class="form-group mb-1">
                <label class="col-form-label">Başlık</label>
                <input type="text" class="form-control form-control-sm" id="EditKuralBasligi<%=DepartmanKurallari("ID") %>" value="<%=DepartmanKurallari("KuralBaslik") %>" />
            </div>
            <div class="form-group mb-1">
                <label class="col-form-label">Açıklama</label>
                <textarea class="form-control form-control-sm" id="EditKurallar<%=DepartmanKurallari("ID") %>"><%=DepartmanKurallari("Kurallar") %></textarea>
            </div>
        </div>
    </div>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-info btn-mini" onclick="DepartmanKurallariGuncelle('<%=DepartmanID %>', '<%=ID %>');">Kaydı Güncelle</button>
</div>
<%
    elseif trn(request("islem")) = "PersonelPuanlama" then
        PersonelID = trn(request("PersonelID"))
        i = 0

        SQL = "select pps.ID, pps.Soru, ISNULL((select SoruPuani from PersonelPuanlamalari where SoruID = pps.ID and PersonelID = '"& PersonelID &"' and firma_id = '"& FirmaID &"'), '0.0') as SoruPuani, ISNULL((select ID from PersonelPuanlamalari where SoruID = pps.ID and PersonelID = '"& PersonelID &"' and firma_id = '"& FirmaID &"'), 0) as PuanID from PersonelPuanlamaSorulari pps where durum = 1 and cop = 0 and firma_id = '"& Request.Cookies("kullanici")("firma_id") &"'"
        set Sorular = baglanti.execute(SQL)
%>
        <%
        if Sorular.eof then
        %>
        <span>Soru Bulunamadı. !</span>
        <%
        else 
        do while not Sorular.eof
            i = i + 1
        %>
            <div class="row align-items-center border">
                <label class="col-md-6 font-weight-bold mb-0 questionTitle"><i class="fa fa-arrow-right mr-2"></i><%=i %>. <%=Sorular("Soru") %></label>
                <input id="Puanlama-<%=Sorular("ID") %>" soru-id="<%=Sorular("ID") %>" value="<%=Sorular("SoruPuani") %>" class="rating-loading">
                <hr />
            </div>
        <%
        Sorular.movenext
        loop
        end if
        %>
        <div class="form-group row pt-3 mb-0">
            <div class="col-md-12 p-0">
                <button type="button" class="btn btn-success btn-sm float-right" onclick="PersonelPuanlamaKaydet('<%=PersonelID %>');">Kaydet</button>
            </div>
        </div>

<script type="text/javascript">
    $(document).ready(function () {
        $(".rating-loading").rating().on("rating:change", function (event, value, caption) {
            $(this).attr("value", parseFloat(value));
        });
    });
</script>
<%
    elseif trn(request("islem")) = "PersonelPuanlamaKaydet" then
        
        FirmaKodu = Request.Cookies("kullanici")("firma_kodu")
        FirmaID = Request.Cookies("kullanici")("firma_id")
        EkleyenID = Request.Cookies("kullanici")("kullanici_id")
        EkleyenIP = Request.ServerVariables("Remote_Addr")

        PersonelID = trn(request("PersonelID"))

        if trn(request("islem2")) = "Ekle" then
            SoruVePuan = trn(request("SoruVePuan"))
                
            for x = 0 to ubound(split(SoruVePuan, "-"))
                soruPuan = split(SoruVePuan, "-")(x)
                
                arr = array("1", "2")
                
                for y = 0 to ubound(split(soruPuan, ","))
                    arr(y) = split(soruPuan, ",")(y)
                next

                SQL = "select * from PersonelPuanlamalari where SoruID = '"& arr(0) &"' and PersonelID = '"& PersonelID &"' and firma_id = '"& FirmaID &"'"
                set puanKontrol = baglanti.execute(SQL)

                if puanKontrol.eof then
                    SQL = "insert into PersonelPuanlamalari(SoruID, SoruPuani, PersonelID, firma_id, firma_kodu, ekleyen_id, ekleyen_ip) values('"& arr(0) &"', '"& arr(1) &"', '"& PersonelID &"', '"& FirmaID &"', '"& FirmaKodu &"', '"& EkleyenID &"', '"& EkleyenIP &"')"
                    set PersonelPuanlamalariEkleme = baglanti.execute(SQL)
                else
                    SQL = "update PersonelPuanlamalari set SoruPuani = '"& arr(1) &"' where PersonelID = '"& PersonelID &"' and SoruID = '"& arr(0) &"' and firma_id = '"& FirmaID &"'"
                    set PersonelPuanlamalariGuncelleme = baglanti.execute(SQL)
                end if
            next

            SQL = "select pps.ID, pps.Soru, ISNULL((select SoruPuani from PersonelPuanlamalari where SoruID = pps.ID and PersonelID = '"& PersonelID &"' and firma_id = '"& FirmaID &"'), '0.0') as SoruPuani, ISNULL((select ID from PersonelPuanlamalari where SoruID = pps.ID and PersonelID = '"& PersonelID &"' and firma_id = '"& FirmaID &"'), 0) as PuanID from PersonelPuanlamaSorulari pps where pps.durum = 1 and pps.cop = 0 and pps.firma_id = '"& FirmaID &"'"
            set Sorular = baglanti.execute(SQL)

            do while not Sorular.eof
%>
<div class="row align-items-center border">
    <label class="col-md-6 font-weight-bold mb-0"><i class="fa fa-arrow-right mr-2"></i><%=i %>. <%=Sorular("Soru") %></label>
    <input id="Puanlama-<%=Sorular("ID") %>" soru-id="<%=Sorular("ID") %>" value="<%=Sorular("SoruPuani") %>" class="rating-loading">
    <hr />
</div>
<script type="text/javascript">
    $(document).ready(function () {
        $(".rating-loading").rating().on("rating:change", function (event, value, caption) {
            $(this).attr("value", parseFloat(value));
        });
    });
</script>
<%
            Sorular.movenext
            loop
%>
<div class="form-group row pt-3 mb-0">
    <div class="col-md-12 p-0">
        <button type="button" class="btn btn-success btn-sm float-right" onclick="PersonelPuanlamaKaydet('<%=PersonelID %>');">Kaydet</button>
    </div>
</div>
<%
        end if
    elseif trn(request("islem")) = "PersonelOneri" then

        FirmaID = Request.Cookies("kullanici")("firma_id")
        FirmaKodu = Request.Cookies("kullanici")("firma_kodu")
        EkleyenID = Request.Cookies("kullanici")("kullanici_id")
        EkleyenIP = Request.ServerVariables("Remote_Addr")
        i = 0

        SQL = "select IsNull(yonetici_yetkisi, 'false') as yonetici from ucgem_firma_kullanici_listesi where id = '"& EkleyenID &"' and firma_id = '"& FirmaID &"'"
        set yetkiKontrol = baglanti.execute(SQL)

        if trn(request("islem2")) = "Ekle" then

            OneriBaslik = trn(request("OneriBaslik"))
            OneriAciklama = trn(request("OneriAciklama"))
            OneriDepartman = trn(request("OneriDepartman"))

            SQL = "insert into PersonelOnerileri(OnerenPersonelID, DepartmanID, Baslik, Aciklama, OneriDurumu, firma_id, firma_kodu, ekleyen_id, ekleyen_ip) values('"& EkleyenID &"', '"& OneriDepartman &"', '"& OneriBaslik &"', '"& OneriAciklama &"', 'degerlendirilmedi', '"& FirmaID &"', '"& FirmaKodu &"', '"& EkleyenID &"', '"& EkleyenIP &"')"
            set PersonelOneriEkle = baglanti.execute(SQL)

        elseif trn(request("islem2")) = "Guncelle" then

            OneriID = trn(request("OneriID"))
            OnerenPersonelID = trn(request("OnerenPersonelID"))
            OneriBaslik = trn(request("OneriBaslik"))
            OneriAciklama = trn(request("OneriAciklama"))
            OneriDepartman = trn(request("OneriDepartman"))

            SQL = "update PersonelOnerileri set DepartmanID = '"& OneriDepartman &"' , Baslik = '"& OneriBaslik &"', Aciklama = '"& OneriAciklama &"' where ID = '"& OneriID &"' and OnerenPersonelID = '"& OnerenPersonelID &"' and firma_id = '"& FirmaID &"'"
            set PersonelOneriGuncelle = baglanti.execute(SQL)

        elseif trn(request("islem2")) = "Sil" then

            OneriID = trn(request("OneriID"))
            OnerenPersonelID = trn(request("OnerenPersonelID"))

            SQL = "update PersonelOnerileri set cop = 1 where ID = '"& OneriID &"' and OnerenPersonelID = '"& OnerenPersonelID &"' and firma_id = '"& FirmaID &"'"
            set PersonelOneriSil = baglanti.execute(SQL)

        elseif trn(request("islem2")) = "Degerlendir" then
            
            OneriID = trn(request("OneriID"))
            OnerenPersonelID = trn(request("OnerenPersonelID"))

            SQL = "select Baslik from PersonelOnerileri where durum = 1 and cop = 0 and ID = '"& OneriID &"' and firma_id = '"& FirmaID &"'"
            set PersonelOneri = baglanti.execute(SQL)

            SQL = "select personel_ad +' '+ personel_soyad as ad_soyad from ucgem_firma_kullanici_listesi where durum = 'true' and cop = 'false' and id = '"& Request.Cookies("kullanici")("kullanici_id") &"' and firma_id = '"& FirmaID &"'"
            set kullanici = baglanti.execute(SQL)
    
            SQL = "update PersonelOnerileri set OneriDurumu = 'degerlendirmeyealindi' where ID = '"& OneriID &"' and OnerenPersonelID = '"& OnerenPersonelID &"' and firma_id = '"& FirmaID &"'"
            set PersonelOneriUygula = baglanti.execute(SQL)

            bildirim = kullanici("ad_soyad") & " eklediğiniz, " & PersonelOneri("Baslik") & " başlıklı Önerinizi Değerlendirmeye Aldı"

            SQL = "insert into ahtapot_bildirim_listesi(bildirim, tip, click, user_id, firma_kodu, firma_id, ekleyen_id, ekleyen_ip) values('"& bildirim &"', '', '', '"& OnerenPersonelID &"', '"& FirmaKodu &"', '"& FirmaID &"', '"& EkleyenID &"', '"& EkleyenIP &"')"
            set EkleyenBildirim = baglanti.execute(SQL)

        elseif trn(request("islem2")) = "Uygula" then
            
            OneriID = trn(request("OneriID"))
            OnerenPersonelID = trn(request("OnerenPersonelID"))

            SQL = "select Baslik from PersonelOnerileri where durum = 1 and cop = 0 and ID = '"& OneriID &"' and firma_id = '"& FirmaID &"'"
            set PersonelOneri = baglanti.execute(SQL)

            SQL = "select personel_ad +' '+ personel_soyad as ad_soyad from ucgem_firma_kullanici_listesi where durum = 'true' and cop = 'false' and id = '"& Request.Cookies("kullanici")("kullanici_id") &"' and firma_id = '"& FirmaID &"'"
            set kullanici = baglanti.execute(SQL)
    
            SQL = "update PersonelOnerileri set OneriDurumu = 'kabuledildi' where ID = '"& OneriID &"' and OnerenPersonelID = '"& OnerenPersonelID &"' and firma_id = '"& FirmaID &"'"
            set PersonelOneriUygula = baglanti.execute(SQL)

            bildirim = kullanici("ad_soyad") & " eklediğiniz, " & PersonelOneri("Baslik") & " başlıklı Önerinizi Kabul Etti"

            SQL = "insert into ahtapot_bildirim_listesi(bildirim, tip, click, user_id, firma_kodu, firma_id, ekleyen_id, ekleyen_ip) values('"& bildirim &"', '', '', '"& OnerenPersonelID &"', '"& FirmaKodu &"', '"& FirmaID &"', '"& EkleyenID &"', '"& EkleyenIP &"')"
            set EkleyenBildirim = baglanti.execute(SQL)

        elseif trn(request("islem2")) = "Reddet" then
            
            OneriID = trn(request("OneriID"))
            OnerenPersonelID = trn(request("OnerenPersonelID"))

            SQL = "select Baslik from PersonelOnerileri where durum = 1 and cop = 0 and ID = '"& OneriID &"' and firma_id = '"& FirmaID &"'"
            set PersonelOneri = baglanti.execute(SQL)

            SQL = "select personel_ad +' '+ personel_soyad as ad_soyad from ucgem_firma_kullanici_listesi where durum = 'true' and cop = 'false' and id = '"& Request.Cookies("kullanici")("kullanici_id") &"' and firma_id = '"& FirmaID &"'"
            set kullanici = baglanti.execute(SQL)
    
            SQL = "update PersonelOnerileri set OneriDurumu = 'reddedildi' where ID = '"& OneriID &"' and OnerenPersonelID = '"& OnerenPersonelID &"' and firma_id = '"& FirmaID &"'"
            set PersonelOneriUygula = baglanti.execute(SQL)

            bildirim = kullanici("ad_soyad") & " eklediğiniz, " & PersonelOneri("Baslik") & " başlıklı Önerinizi Reddetti"

            SQL = "insert into ahtapot_bildirim_listesi(bildirim, tip, click, user_id, firma_kodu, firma_id, ekleyen_id, ekleyen_ip) values('"& bildirim &"', '', '', '"& OnerenPersonelID &"', '"& FirmaKodu &"', '"& FirmaID &"', '"& EkleyenID &"', '"& EkleyenIP &"')"
            set EkleyenBildirim = baglanti.execute(SQL)

        end if
%>
<div class="dt-responsive table-responsive">
    <table class="table table-bordered table-mini w-100 datatableyap">
        <thead>
            <tr>
                <th>No</th>
                <th>Başlık</th>
                <th style="width:145px !important;">Açıklama</th>
                <th>Departman</th>
                <th>Ekleyen</th>
                <th>Durum</th>
                <th style="width:145px !important;">işlem</th>
            </tr>
        </thead>
        <tbody>
            <%
            if yetkiKontrol("yonetici") = "true" then
                SQL = "select po.ID, po.OnerenPersonelID, po.DepartmanID, (select personel_ad +' '+ personel_soyad from ucgem_firma_kullanici_listesi where durum = 'true' and cop = 'false' and firma_id = '"& FirmaID &"' and id = po.ekleyen_id) as Ekleyen, ISNULL((select departman_adi from tanimlama_departman_listesi where durum = 'true' and cop = 'false' and id = po.DepartmanID), '---') as Departman, po.Baslik, po.Aciklama, po.OneriDurumu, po.ekleme_tarihi from PersonelOnerileri po where po.durum = 1 and po.cop = 0 and po.firma_id = '"& FirmaID &"'"
            else
                SQL = "select po.ID, po.OnerenPersonelID, po.DepartmanID, (select personel_ad +' '+ personel_soyad from ucgem_firma_kullanici_listesi where durum = 'true' and cop = 'false' and firma_id = '"& FirmaID &"' and id = po.ekleyen_id) as Ekleyen, ISNULL((select departman_adi from tanimlama_departman_listesi where durum = 'true' and cop = 'false' and id = po.DepartmanID), '---') as Departman, po.Baslik, po.Aciklama, po.OneriDurumu, po.ekleme_tarihi from PersonelOnerileri po where durum = 1 and cop = 0 and OnerenPersonelID = '"& EkleyenID &"' and po.firma_id = '"& FirmaID &"'"
            end if
            set PersonelOnerileri = baglanti.execute(SQL)

            if PersonelOnerileri.eof then
            %>
            <tr>
                <td class="text-center" colspan="6">Kayıt Bulunamadı. !</td>
            </tr>
            <%
            else
                do while not PersonelOnerileri.eof
                i = i + 1
            %>
            <tr>
                <td><%=i %></td>
                <td><%=PersonelOnerileri("Baslik") %></td>
                <td style="white-space:nowrap !important;">
                    <%
                        if Len(PersonelOnerileri("Aciklama")) > 30 then
                    %>
                    <%=Mid(PersonelOnerileri("Aciklama"),1, 30) %>
                    <i class="fa fa-info-circle ml-2 f-20 cursor-pointer" title="<%=PersonelOnerileri("Aciklama") %>"></i>
                    <%else %>
                    <%=PersonelOnerileri("Aciklama") %>
                    <%end if %>
                </td>
                <td><%=PersonelOnerileri("Departman") %></td>
                <td><%=PersonelOnerileri("Ekleyen") %></td>
                <td>
                    <%
                    labelClass = ""
                    labelContent = ""
                    if PersonelOnerileri("OneriDurumu") = "degerlendirilmedi" then
                        labelClass = "label label-warning f-11 text-center"
                        labelContent = "Değerlendirilmedi"
                    elseif PersonelOnerileri("OneriDurumu") = "degerlendirmeyealindi" then
                        labelClass = "label label-primary f-11 text-center"
                        labelContent = "Değerlendirmeye Alındı"
                    elseif PersonelOnerileri("OneriDurumu") = "kabuledildi" then
                        labelClass = "label label-success f-11 text-center"
                        labelContent = "Kabul Edildi"
                    elseif PersonelOnerileri("OneriDurumu") = "reddedildi" then
                        labelClass = "label label-danger f-11 text-center"
                        labelContent = "Reddedildi"
                    end if
                    %>
                    <label class="<%=labelClass %>"><%=labelContent %></label>
                </td>
                <td style="white-space:nowrap !important;">
                    <%
                        state = ""
                        if PersonelOnerileri("OneriDurumu") = "degerlendirmeyealindi" then
                            state = "disabled='disabled'"
                        else
                            state = ""
                        end if
                    %>
                    <button type="button" <%=state %> class="btn btn-info btn-mini" onclick="PersonelOneriDuzenle('<%=PersonelOnerileri("ID") %>', '<%=PersonelOnerileri("OnerenPersonelID") %>', '<%=PersonelOnerileri("DepartmanID") %>');">Düzenle</button>
                    <button type="button" <%=state %> class="btn btn-danger btn-mini mr-2" onclick="PersonelOneriSil('<%=PersonelOnerileri("ID") %>', '<%=PersonelOnerileri("OnerenPersonelID") %>');">Sil</button>
                    <%
                    if yetkiKontrol("yonetici") = "true" then
                    %>
                    <div class="btn-group">
                        <button class="btn btn-secondary btn-mini dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fa fa-cogs"></i>
                        </button>
                        <div class="dropdown-menu">
                            <a class="dropdown-item cursor-pointer" onclick="PersonelOneriDegerlendir('<%=PersonelOnerileri("ID") %>', '<%=PersonelOnerileri("OnerenPersonelID") %>');">Değerlendirmeye Al</a>
                            <a class="dropdown-item cursor-pointer" onclick="PersonelOneriUygula('<%=PersonelOnerileri("ID") %>', '<%=PersonelOnerileri("OnerenPersonelID") %>');">Kabul Et</a>
                            <a class="dropdown-item cursor-pointer" onclick="PersonelOneriReddet('<%=PersonelOnerileri("ID") %>', '<%=PersonelOnerileri("OnerenPersonelID") %>');">Reddet</a>
                        </div>
                    </div>
                    <% end if %>
                </td>
            </tr>
            <%
                PersonelOnerileri.movenext
                loop
            end if
            %>
        </tbody>
    </table>
</div>
<%
    elseif trn(request("islem")) = "PersonelOneriDuzenle" then

        OneriID = trn(request("OneriID"))
        OnerenPersonelID = trn(request("OnerenPersonelID"))
        OnerenDepartmanID = trn(request("OnerenDepartmanID"))
        
        if OnerenDepartmanID = "" or OnerenDepartmanID = null then
            OnerenDepartmanID = 0
        end if

        SQL = "select * from PersonelOnerileri where durum = 1 and cop = 0 and OnerenPersonelID = '"& OnerenPersonelID &"' and ID = '"& OneriID &"' and firma_id = '"& FirmaID &"'"
        set PersonelOnerileri = baglanti.execute(SQL)
%>
<div class="modal-header">
    Öneri Düzenleme
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<div class="modal-body pt-0">
    <div class="row">
        <div class="col-md-12">
            <div class="form-group mb-1">
                <label class="col-form-label">Departman</label>
                <select class="form-control form-control-sm select2" id="OneriDepartman<%=PersonelOnerileri("ID") %>">
                    <option selected="selected" value="0">- Departman Seç -</option>
                    <%
                        SQL = "select id, departman_adi from tanimlama_departman_listesi where durum = 'true' and cop = 'false' and firma_id = '"& FirmaID &"'"
                        set departmanListesi = baglanti.execute(SQL)

                        if not departmanListesi.eof then
                            do while not departmanListesi.eof

                            state = ""
                            if CInt(departmanListesi("id")) = CInt(OnerenDepartmanID) then
                                state = "selected='selected'"
                            else
                                state = ""
                            end if
                    %>
                    <option <%=state %> value="<%=departmanListesi("id") %>"><%=departmanListesi("departman_adi") %></option>
                    <%
                            departmanListesi.movenext
                            loop
                        end if
                    %>
                </select>
            </div>
            <div class="form-group mb-1">
                <label class="col-form-label">Başlık</label>
                <input type="text" class="form-control form-control-sm" id="OneriBaslik<%=PersonelOnerileri("ID") %>" value="<%=PersonelOnerileri("Baslik") %>" />
            </div>
            <div class="form-group mb-1">
                <label class="col-form-label">Açıklama</label>
                <textarea class="form-control form-control-sm" id="OneriAciklama<%=PersonelOnerileri("ID") %>"><%=PersonelOnerileri("Aciklama") %></textarea>
            </div>
        </div>
    </div>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-info btn-mini" onclick="PersonelOneriGuncelle('<%=OneriID %>', '<%=OnerenPersonelID %>', '<%=OnerenDepartmanID %>');">Kaydı Güncelle</button>
</div>
<%
    elseif trn(request("islem")) = "PersonelPuanlamaSorulari" then

        FirmaID = Request.Cookies("kullanici")("firma_id")
        FirmaKodu = Request.Cookies("kullanici")("firma_kodu")
        EkleyenID = Request.Cookies("kullanici")("kullanici_id")
        EkleyenIP = Request.ServerVariables("Remote_Addr")
        i = 0

        if trn(request("islem2")) = "Ekle" then
            
            PuanlamaSorusu = trn(request("PuanlamaSorusu"))
            
            SQL = "insert into PersonelPuanlamaSorulari(Soru, firma_id, firma_kodu, ekleyen_id, ekleyen_ip) values('"& PuanlamaSorusu &"', '"& FirmaID &"', '"& FirmaKodu &"', '"& EkleyenID &"', '"& EkleyenIP &"')"
            set PersonelPuanlamaSorulariEkle = baglanti.execute(SQL)

        elseif trn(request("islem2")) = "Guncelle" then

            PuanlamaSorusu = trn(request("PuanlamaSorusu"))            
            SoruID = trn(request("SoruID"))            

            SQL = "update PersonelPuanlamaSorulari set Soru = '"& PuanlamaSorusu &"' where ID = '"& SoruID &"' and durum = 1 and cop = 0 and firma_id = '"& FirmaID &"'"
            set PersonelPuanlamaSorulariGuncelle = baglanti.execute(SQL)

        elseif trn(request("islem2")) = "Sil" then

            SoruID = trn(request("SoruID"))

            SQL = "update PersonelPuanlamaSorulari set cop = 1 where ID = '"& SoruID &"' and firma_id = '"& FirmaID &"'"
            set PersonelPuanlamaSorulariSil = baglanti.execute(SQL)

        end if
%>
<div class="dt-responsive table-responsive">
    <table class="table table-bordered table-mini text-nowrap datatableyap w-100">
        <thead>
            <tr>
                <th>ID</th>
                <th>Soru</th>
                <th>Ekleyen</th>
                <th>İşlem</th>
            </tr>
        </thead>
        <tbody>
            <%
                SQL = "select ID, Soru, (select personel_ad +' '+ personel_soyad from ucgem_firma_kullanici_listesi where durum = 'true' and cop = 'false' and firma_id = '"& FirmaID &"' and id = pps.ekleyen_id) as Ekleyen from PersonelPuanlamaSorulari pps where durum = 1 and cop = 0 and firma_id = '"& FirmaID &"'"
                set PersonelPuanlamaSorulari = baglanti.execute(SQL)

                if PersonelPuanlamaSorulari.eof then
            %>
            <tr>
                <td colspan="4" class="text-center">Kayıt Bulunamadı. !</td>
            </tr>
            <%
                else
                    do while not PersonelPuanlamaSorulari.eof 
                    i = i + 1
            %>
            <tr>
                <td><%=i %></td>
                <td><%=PersonelPuanlamaSorulari("Soru") %></td>
                <td><%=PersonelPuanlamaSorulari("Ekleyen") %></td>
                <td>
                    <button type="button" class="btn btn-info btn-mini" onclick="PersonelPuanlamaSorulariDuzenle('<%=PersonelPuanlamaSorulari("ID") %>');">Düzenle</button>
                    <button type="button" class="btn btn-danger btn-mini" onclick="PersonelPuanlamaSorulariSil('<%=PersonelPuanlamaSorulari("ID") %>')">Sil</button>
                </td>
            </tr>
            <%
                    PersonelPuanlamaSorulari.movenext
                    loop
                end if
            %>
        </tbody>
    </table>
</div>
<%
    elseif trn(request("islem")) = "PersonelPuanlamaSorulariDuzenle" then

        SoruID = trn(request("SoruID"))
        FirmaID = Request.Cookies("kullanici")("firma_id")

        SQL = "select * from PersonelPuanlamaSorulari where durum = 1 and cop = 0 and firma_id = '"& FirmaID &"' and ID = '"& SoruID &"'"
        set PersonelPuanlamaSorulari = baglanti.execute(SQL)
%>
<div class="modal-header">
    Soru Düzenleme
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<div class="modal-body pt-0">
    <div class="row">
        <div class="col-md-12">
            <div class="form-group mb-1">
                <label class="col-form-label">Puanlama Sorusu</label>
                <input type="text" class="form-control form-control-sm" id="PuanlamaSorusu<%=PersonelPuanlamaSorulari("ID") %>" value="<%=PersonelPuanlamaSorulari("Soru") %>" />
            </div>
        </div>
    </div>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-info btn-mini" onclick="PersonelPuanlamaSorulariGuncelle('<%=PersonelPuanlamaSorulari("ID") %>');">Kaydı Güncelle</button>
</div>
<%
    elseif trn(request("islem")) = "Performans" then
%>
<div class="dt-responsive table-responsive">
    <table class="table table-bordered table-mini datatableyap w-100">
        <thead>
            <tr>
                <th>No</th>
                <th>Personel</th>
                <th>Toplam Puanı</th>
                <th>Toplam Önerileri</th>
                <th>Toplam Kabul Edilen Öneriler</th>
            </tr>
        </thead>
        <tbody>
            <%         
                FirmaID = Request.Cookies("kullanici")("firma_id")
                i = 0

                SQL = "select kl.personel_ad +' '+ kl.personel_soyad as AdSoyad, ISNULL((select sum(CONVERT(decimal(18,2), pp.SoruPuani)) from PersonelPuanlamalari pp join PersonelPuanlamaSorulari pps on pp.SoruID = pps.ID where pp.durum = 1 and pp.cop = 0 and pp.PersonelID = kl.id and pps.durum = 1 and pps.cop = 0 and pps.firma_id = '"& FirmaID &"' and pp.firma_id = '"& FirmaID &"'), 00.00) as Puani, (select COUNT(*) from PersonelOnerileri where OnerenPersonelID = kl.id and durum = 1 and cop = 0 and firma_id = '"& FirmaID &"') as ToplamOneri, (select COUNT(*) from PersonelOnerileri where OnerenPersonelID = kl.id and durum = 1 and cop = 0 and OneriDurumu = 'kabuledildi' and firma_id = '"& FirmaID &"') as KabulEdilenOneri from ucgem_firma_kullanici_listesi kl where durum = 'true' and cop = 'false' and firma_id = '"& FirmaID &"'"
                set PersonelPerformans = baglanti.execute(SQL)

            if not PersonelPerformans.eof then
                do while not PersonelPerformans.eof
                i = i + 1
%>
            <tr>
                <td><%=i %></td>
                <td><%=PersonelPerformans("AdSoyad") %></td>
                <td><%=FormatNumber(PersonelPerformans("Puani"),,,0) %></td>
                <td><%=PersonelPerformans("ToplamOneri") %></td>
                <td><%=PersonelPerformans("KabulEdilenOneri") %></td>
            </tr>
<%
                PersonelPerformans.movenext
                loop
            end if
%>
        </tbody>
    </table>
</div>

<%
    'Yeni iş emirleri listesi

    elseif trn(request("islem")) = "IsDetaylari" then
        
        IsID = trn(request("IsID"))
        FirmaID = request.Cookies("kullanici")("firma_id")

        SQL="EXEC getIsKodu '"& IsID &"'"
        set detay = baglanti.execute(SQL)

        SQL="with cte as (SELECT iss.adi, iss.durum, case when (select COUNT(id) from ucgem_is_calisma_listesi WHERE is_id = '"& IsID &"' and ekleyen_id = gorevli.gorevli_id and firma_id = '"& FirmaID &"') = 0 then '00:00' else dbo.DakikadanSaatYap((SELECT ISNULL( SUM((DATEDIFF(MINUTE, CONVERT(DATETIME, olay.baslangic), CONVERT(DATETIME, olay.bitis)))), 0) FROM dbo.ucgem_is_calisma_listesi olay WITH (NOLOCK) WHERE olay.is_id = gorevli.is_id and olay.ekleyen_id = gorevli.gorevli_id AND olay.durum = 'true' AND olay.cop = 'false' and olay.firma_id = '"& FirmaID &"')) end AS harcanan_sure, CASE WHEN (DATEDIFF(MINUTE, DATEADD(n, (SELECT ISNULL(SUM((DATEDIFF(MINUTE, CONVERT(DATETIME, calisma.baslangic), CONVERT(DATETIME, calisma.bitis)))), 0) FROM dbo.ucgem_is_calisma_listesi calisma WITH (NOLOCK) WHERE calisma.is_id = gorevli.is_id AND calisma.durum = 'true' AND calisma.ekleyen_id = gorevli.gorevli_id and calisma.cop = 'false' and calisma.firma_id = '"& FirmaID &"'), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ), DATEADD( n, dbo.SaattenDakikaYap(ISNULL(gorevli.toplam_sure, '00:00')), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00')))) < 0 THEN '-' ELSE '' END + dbo.DakikadanSaatYap(CASE WHEN (DATEDIFF(n, DATEADD(n, (SELECT ISNULL(SUM((DATEDIFF(n, CONVERT(DATETIME, calisma.baslangic), CONVERT(DATETIME, calisma.bitis)))), 0) FROM dbo.ucgem_is_calisma_listesi calisma WITH (NOLOCK) WHERE calisma.is_id = gorevli.is_id AND calisma.ekleyen_id = gorevli.gorevli_id and calisma.durum = 'true' AND calisma.cop = 'false' and calisma.firma_id = '"& FirmaID &"'), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ), DATEADD(n,dbo.SaattenDakikaYap(ISNULL( gorevli.toplam_sure, '00:00' ) ), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ) ) ) < 0 THEN -1 * DATEDIFF(n, DATEADD( n, (SELECT ISNULL(SUM((DATEDIFF(n, CONVERT(DATETIME, calisma.baslangic), CONVERT( DATETIME, calisma.bitis )))), 0 ) FROM dbo.ucgem_is_calisma_listesi calisma WITH (NOLOCK) WHERE calisma.is_id = gorevli.is_id and calisma.ekleyen_id = gorevli.gorevli_id AND calisma.durum = 'true' AND calisma.cop = 'false' and calisma.firma_id = '"& FirmaID &"'), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ), DATEADD( n, dbo.SaattenDakikaYap(ISNULL( gorevli.toplam_sure, '00:00' ) ), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ) ) ELSE DATEDIFF(n, DATEADD( n, (SELECT ISNULL( SUM((DATEDIFF( n, CONVERT( DATETIME, calisma.baslangic ), CONVERT( DATETIME, calisma.bitis) ) ) ), 0 ) FROM dbo.ucgem_is_calisma_listesi calisma WITH (NOLOCK) WHERE calisma.is_id = gorevli.is_id and calisma.ekleyen_id = gorevli.gorevli_id AND calisma.durum = 'true' AND calisma.cop = 'false' and calisma.firma_id = '"& FirmaID &"'), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ), DATEADD( n, dbo.SaattenDakikaYap(ISNULL(gorevli.toplam_sure, '00:00')), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00'))) END) AS kalan, ISNULL(gorevli.toplam_sure, '0:00') AS toplam_sure, ISNULL(gorevli.gunluk_sure, '0:00') AS gunluk_sure, ISNULL(gorevli.toplam_gun, '0:00') AS toplam_gun, CASE WHEN ISNULL(gorevli.toplam_sure, '0:00') = '0:00' THEN 0 ELSE 1 end AS GantAdimID, ISNULL(sinirlama_varmi, 0) as sinirlama_varmi, CONVERT(DATETIME, gorevli.ekleme_tarihi) + CONVERT(DATETIME, gorevli.ekleme_saati) AS tamamlanma_zamani, kullanici.personel_resim, kullanici.personel_ad + ' ' + kullanici.personel_soyad AS personel_adsoyad, (select g.gorev_adi from tanimlama_gorev_listesi g where g.durum = 'true' and g.cop = 'false' and g.firma_id = '"& FirmaID &"' and id = (SELECT COUNT(value) FROM STRING_SPLIT(kullanici.gorevler, ',') WHERE value = CONVERT(NVARCHAR(50), g.id))) as yetki, gorevli.gorevli_id, gorevli.id, gorevli.tamamlanma_orani FROM ucgem_is_gorevli_durumlari gorevli WITH (NOLOCK) JOIN ucgem_firma_kullanici_listesi kullanici WITH (NOLOCK) ON kullanici.id = gorevli.gorevli_id JOIN ucgem_is_listesi iss ON iss.id = gorevli.is_id WHERE gorevli.is_id = '"& IsID &"' and gorevli.firma_id = '"& FirmaID &"' GROUP BY iss.adi, iss.durum, gorevli.toplam_sure, gorevli.gunluk_sure, gorevli.toplam_gun, ISNULL(iss.GantAdimID, 0), CONVERT(DATETIME, gorevli.ekleme_tarihi) + CONVERT(DATETIME, gorevli.ekleme_saati), kullanici.personel_resim, kullanici.personel_ad + ' ' + kullanici.personel_soyad, kullanici.gorevler, kullanici.id, gorevli.gorevli_id, gorevli.id, gorevli.tamamlanma_orani, gorevli.is_id, iss.baslangic_tarihi, iss.sinirlama_varmi ) select CASE WHEN tamamlanma_orani = 100 THEN 100 WHEN (Convert(int, CONVERT(decimal(15,2), LEFT(harcanan_sure, CHARINDEX(':', harcanan_sure) - 1)) * 60 + CONVERT(int, RIGHT(harcanan_sure, 2))) > Convert(int, CONVERT(decimal(15,2), LEFT(toplam_sure, CHARINDEX(':', toplam_sure) - 1)) * 60 + CONVERT(int, RIGHT(toplam_sure, 2))) AND CONVERT(int, tamamlanma_orani) = 0) THEN 90 WHEN (Convert(int, CONVERT(decimal(15,2), LEFT(harcanan_sure, CHARINDEX(':', harcanan_sure) - 1)) * 60 + CONVERT(int, RIGHT(harcanan_sure, 2))) = 0 and CONVERT(int, tamamlanma_orani) = 0) THEN 0 WHEN Convert(int, CONVERT(decimal(15,2), LEFT(harcanan_sure, CHARINDEX(':', harcanan_sure) - 1)) * 60 + CONVERT(int, RIGHT(harcanan_sure, 2))) > Convert(int, CONVERT(decimal(15,2), LEFT(toplam_sure, CHARINDEX(':', toplam_sure) - 1)) * 60 + CONVERT(int, RIGHT(toplam_sure, 2))) THEN 90 WHEN CONVERT(int, CONVERT(decimal(15,2), LEFT(harcanan_sure, CHARINDEX(':', harcanan_sure) - 1)) * 60 + CONVERT(int, RIGHT(harcanan_sure, 2))) = CONVERT(int, CONVERT(decimal(15,2), LEFT(toplam_sure, CHARINDEX(':', toplam_sure) - 1)) * 60 + CONVERT(int, RIGHT(toplam_sure, 2))) THEN 90 ELSE ISNULL(CONVERT(int, CONVERT(decimal(15,2), LEFT(harcanan_sure, CHARINDEX(':', harcanan_sure) - 1) * 60 + CONVERT(int, RIGHT(harcanan_sure, 2))) / CONVERT(int, CONVERT(decimal(15,2), LEFT(toplam_sure, CHARINDEX(':', toplam_sure) - 1) * 60 + CONVERT(int, RIGHT(toplam_sure, 2)))) * 100), 0) END as tamamlanmorani, * from cte"
        set gorevli = baglanti.execute(SQL)
%>
<div class="row">
    <div class="col-md-4 mb-2">
        <div class="card mb-2 bg-light border round">
            <div class="card-header p-3 border-bottom">
                <a class="cursor-pointer" onclick="TaskDetails('<%=IsID %>', '<%=gorevli("gorevli_id") %>');"><h6 class="card-title mb-0 f-13"><i class="fa fa-arrow-down mr-1"></i> - İş Tanımı</h6></a>
            </div>
            <div class="card-body p-2 TaskDetails" id="TaskDetails<%=IsID %>-<%=gorevli("gorevli_id") %>">
                <div class="row">
                    <div class="col-sm-12">
                        <h6 class="text-muted f-w-400 m-b-40">
                            <%=detay("adi") %>
                        </h6>
                    </div>
                </div>
                <h6 class="m-b-20 p-b-5 b-b-default f-w-600">İş Detayı</h6>
                <div class="row">
                    <div class="col-sm-6 col-xs-12">
                        <p class="m-b-10 f-w-600">İş Kodu</p>
                        <h6 class="text-muted f-w-400"><%=detay("is_kodu") %></h6>
                    </div>
                    <div class="col-sm-6 col-xs-12">
                        <p class="m-b-10 f-w-600">Görevliler</p>
                        <h6 class="text-muted f-w-400"><%=detay("gorevli_personeller") %></h6>
                    </div>
                    <div class="col-sm-6 col-xs-12">
                        <p class="m-b-10 f-w-600">Etiketler</p>
                        <h6 class="text-muted f-w-400">
                            <label class="badge badge-success" data-toggle="tooltip" data-placement="top" title="<%=detay("proje") %>">Proje</label>
                            <label class="badge badge-info" data-toggle="tooltip" data-placement="top" title="<%=detay("firma") %>">Firma</label>
                            <label class="badge badge-primary" data-toggle="tooltip" data-placement="top" title="<%=detay("departman") %>">Departman</label>
                        </h6>
                    </div>
                    <div class="col-sm-6 col-xs-12">
                        <p class="m-b-10 f-w-600">Öncelik</p>
                        <h6 class="text-muted f-w-400"><%=detay("oncelik") %></h6>
                    </div>
                    <div class="col-sm-6 col-xs-12">
                        <p class="m-b-10 f-w-600">Başlangıç</p>
                        <h6 class="text-muted f-w-400">
                            <i class="fa fa-calendar mr-1"></i>
                            <%=cdate(detay("baslangic_tarihi")) %> - <%=left(detay("baslangic_saati"),5) %>
                        </h6>
                    </div>
                    <div class="col-sm-6 col-xs-12">
                        <p class="m-b-10 f-w-600">Bitiş</p>
                        <h6 class="text-muted f-w-400">
                            <i class="fa fa-calendar mr-1"></i>
                            <%=cdate(detay("bitis_tarihi")) %> - <%=left(detay("bitis_saati"),5) %>
                        </h6>
                    </div>
                </div>
                <!--<h6 class="m-b-20 p-b-5 b-b-default f-w-600"></h6>
                <div class="form-group">
                    
                </div>-->
            </div>
        </div>
        <div class="col-md-12 p-0 mt-2">
            <% if trim(detay("is_tipi"))="Servis" then %>
                <a href="javascript:void(0);" class="btn btn-labeled btn-primary btn-mini mr-2" onclick="servis_formu_ac('<%=detay("id") %>'); return false;"><span class="btn-label"><i class="fa fa-edit "></i></span><%=LNG("Servis Formu")%></a>
            <% end if %>

            <% if trim(detay("ekleyen_id")) = trim(Request.Cookies("kullanici")("kullanici_id")) then %>    
                <% if trim(detay("GantAdimIDs"))="0" then %>
                    <a href="javascript:void(0);" class="btn btn-labeled btn-info btn-mini mr-2" onclick="is_kaydini_duzenle('<%=detay("id") %>'); return false;"><span class="btn-label"><i class="fa fa-edit "></i></span><%=LNG("Kaydı Düzenle")%></a>
                <% end if %>

                <% if trim(detay("durum"))="false" then %>
                    <a href="javascript:void(0);" class="btn btn-labeled btn-danger btn-mini mr-2" onclick="isi_iptal_et('<%=detay("id") %>'); return false;"><span class='btn-label'><i class='fa fa-times'></i></span><%=LNG("İşi Aktif Et")%></a>
                <% else %>
                    <a href="javascript:void(0);" class="btn btn-labeled btn-danger btn-mini mr-2" onclick="isi_iptal_et('<%=detay("id") %>'); return false;"><span class="btn-label"><i class="fa fa-times"></i></span><%=LNG("İşi İptal Et")%></a>
                <% end if %>
            <% end if %>
        </div>
    </div>
    <div class="col-md-8">
        <nav>
            <div class="nav nav-tabs" id="nav-tab" role="tablist">
                <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home<%=detay("id") %>" role="tab" aria-controls="nav-home" aria-selected="true">
                    <i class="fa fa-tasks mr-1"></i>
                    İş Durumu
                </a>
                <a class="nav-item nav-link" id="nav-contact-tab" data-toggle="tab" href="#nav-contact<%=detay("id") %>" role="tab" aria-controls="nav-contact" aria-selected="false">
                    <i class="fa fa-folder mr-1"></i>
                    Dosyalar
                </a>
            </div>
        </nav>
        <div class="tab-content border" id="nav-tabContent">
            <div class="tab-pane fade show active" id="nav-home<%=detay("id") %>" role="tabpanel" aria-labelledby="nav-home-tab">
                <%
                    do while not gorevli.eof
                    'response.Write("görevli ID: " & gorevli("gorevli_id"))
                    'response.Write("giriş yapan ID: " & request.Cookies("kullanici")("kullanici_id"))

                        if trim(gorevli("gorevli_id")) = trim(request.Cookies("kullanici")("kullanici_id")) then
                %>
				<div class="card mb-0">
					<div class="card-header p-0">
						<h6 class="card-title">
                            <div class="row pb-2 m-0 TaskDetailHeader" id="TaskDetailHeader<%=IsID %>-<%=gorevli("gorevli_id") %>">
                                <div class="col-lg-3 col-xs-12 pl-2 pt-2 ">
                                    <ul class="media-list display-inline-block">
                                        <li class="media">
                                            <div class="mr-3 align-self-center">
                                                <img class="img-50 round" src="<%=gorevli("personel_resim") %>" />
                                            </div>
                                            <div class="media-body">
                                                <div class="f-15 font-weight-bold"><%=gorevli("personel_adsoyad") %></div>
                                                <ul class="list-inline list-inline-dotted list-inline-condensed font-size-sm text-muted mt-1 font-weight-normal">
                                                    <li class="list-inline-item f-13"><%=gorevli("yetki") %></li>
                                                </ul>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <div class="col-lg-2 col-xs-6 pl-2 pt-2 mt-1">
                                    <ul class="media-list display-inline-block">
                                        <li class="media">
                                            <div class="media-body">
                                                <div class="f-13 font-weight-bold">Planlanan Süre</div>
                                                <ul class="list-inline list-inline-dotted list-inline-condensed font-size-sm text-muted mt-1 font-weight-normal">
                                                    <li class="list-inline-item f-15"><i class="fa fa-clock-o mr-1"></i><%=gorevli("toplam_sure") %></li>
                                                </ul>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <div class="col-lg-2 col-xs-6 pl-2 pt-2 mt-1">
                                    <ul class="media-list display-inline-block">
                                        <li class="media">
                                            <div class="media-body">
                                                <div class="f-13 font-weight-bold">Harcanan Süre</div>
                                                <ul class="list-inline list-inline-dotted list-inline-condensed font-size-sm text-muted mt-1 font-weight-normal">
                                                    <li class="list-inline-item f-15">
                                                        <i class="fa fa-clock-o mr-1"></i> <%=gorevli("harcanan_sure") %>
                                                    </li>
                                                </ul>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <div class="col-lg-2 col-xs-12 pl-2 pt-2 mt-1">
                                    <ul class="media-list">
                                        <li class="media">
                                            <div class="media-body">
                                                <div class="f-13 font-weight-bold">Tamamlama Oranı</div>
                                                <span class="mr-1 mt-1 float-left font-weight-normal" id="ProgresTEXT<%=IsID %>-<%=gorevli("gorevli_id") %>"><%=gorevli("tamamlanmorani") %>%</span>
                                                <div class="progress mb-0 round text-align mt-1">
                                                    <div class="progress-bar" role="progressbar" id="Progres<%=IsID %>-<%=gorevli("gorevli_id") %>" style="width: <%=gorevli("tamamlanmorani") %>%;" aria-valuenow="<%=gorevli("tamamlanmorani") %>" aria-valuemin="0" aria-valuemax="100"></div>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <%if not cdbl(gorevli("tamamlanma_orani")) = 100 then %>
                                    <%if not gorevli("durum") = "false" then %>
                                        <div class="col-lg-3 col-xs-12 pl-2 pt-2 font-weight-normal mt-2 TaskTimer" id="TaskTimer<%=IsID %>-<%=gorevli("gorevli_id") %>">
                                    <div class="card bg-light border mb-0">
                                        <div class="card-header border-bottom p-2">
                                            <h6 class="card-title font-weight-normal">Sayaç</h6>
                                        </div>
                                        <div class="card-body p-2">
                                            <div class="d-flex justify-content-center text-center">
                                                <div class="timer-number font-weight-light">
                                                    <span class="f-30" id="hour<%=gorevli("gorevli_id") %>-<%=IsID %>">00</span>
                                                    <span class="d-block font-size-base">saat</span>
                                                </div>
                                                <div class="timer-dots mx-1 f-27">:</div>
                                                <div class="timer-number font-weight-light">
                                                    <span class="f-30" id="minute<%=gorevli("gorevli_id") %>-<%=IsID %>">00</span>
                                                    <span class="d-block font-size-base">dakika</span>
                                                </div>
                                                <div class="timer-dots mx-1 f-27">:</div>
                                                <div class="timer-number font-weight-light">
                                                    <span class="f-30" id="second<%=gorevli("gorevli_id") %>-<%=IsID %>">00</span>
                                                    <span class="d-block font-size-base">saniye</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-footer bg-light border-top p-2 pl-3">
                                            <i class="fa fa-play-circle f-27 mr-1 cursor-pointer startButton" id="TaskStartButton<%=IsID %>-<%=gorevli("gorevli_id") %>" tamamlanmaid="<%=gorevli("id") %>" user_id="<%=gorevli("gorevli_id")%>" is_id="<%=IsID %>" data-toggle="tooltip" data-placement="top" title="Başlat" onclick="is_timer_start_kaydi('<%=IsID %>', '<%=gorevli("id") %>', '<%=gorevli("gorevli_id") %>');"></i>

                                            <i class="fa fa-pause-circle f-27 mr-1 cursor-pointer pauseButton" style="display:none" id="TaskPauseButton<%=IsID %>-<%=gorevli("gorevli_id") %>" tamamlanmaid="<%=gorevli("id") %>" user_id="<%=gorevli("gorevli_id")%>" baslik="<%=gorevli("adi") %>" aciklama="<%=gorevli("adi") %> adlı işte ilerleme kaydedildi." is_id="<%=IsID %>" data-toggle="tooltip" data-placement="top" title="Duraklat" onclick="is_timer_pause_kaydi('<%=IsID %>', '<%=gorevli("id") %>', '<%=gorevli("gorevli_id") %>');"></i>

                                            <i class="fa fa-stop-circle f-27 mr-1 cursor-pointer stopButton" style="display:none" id="TaskStopButton<%=IsID %>-<%=gorevli("gorevli_id") %>" tamamlanmaid="<%=gorevli("id") %>" baslik="<%=gorevli("adi") %>" aciklama="<%=gorevli("adi") %> adlı işte ilerleme kaydedildi." user_id="<%=gorevli("gorevli_id")%>" is_id="<%=IsID %>" b data-toggle="tooltip" data-placement="top" title="Tamamla" onclick="is_timer_stop_kaydi('<%=IsID %>', '<%=gorevli("id") %>', '<%=gorevli("gorevli_id") %>');"></i>
                                        </div>
                                    </div>
                                </div>
                                    <%end if %>
                                <%end if %>
                            </div>
						</h6>
					</div>

					<div class="card-body p-1">
						<div class="col-md-12 p-0" id="calisma_kayitlari<%=IsID %>-<%=gorevli("gorevli_id") %>">
                            <script>
                                is_listesi_calisma_kaydi('<%=IsID %>', '<%=gorevli("gorevli_id") %>');
                            </script>
                        </div>
					</div>
				</div>
                <%
                        else
                %>
                <div class="card-group-control card-group-control-right" id="accordion-control-right">
					<div class="card mb-0">
						<div class="card-header p-0">
							<h6 class="card-title">
								<a data-toggle="collapse" class="collapsed" href="#accordion-control-right-group<%=IsID %>-<%=gorevli("gorevli_id") %>" aria-expanded="false">
                                    <div class="row m-0 border-top border-bottom">
                                        <div class="col-lg-3 col-xs-12 p-2">
                                            <ul class="media-list display-inline-block">
                                                <li class="media">
                                                    <div class="mr-3 align-self-center">
                                                        <img class="img-50 round" src="<%=gorevli("personel_resim") %>" />
                                                    </div>
                                                    <div class="media-body">
                                                        <div class="f-15 font-weight-bold"><%=gorevli("personel_adsoyad") %></div>
                                                        <ul class="list-inline list-inline-dotted list-inline-condensed font-size-sm text-muted mt-1 font-weight-normal">
                                                            <li class="list-inline-item f-13"><%=gorevli("yetki") %></li>
                                                        </ul>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="col-lg-2 col-xs-6 p-2 mt-1">
                                            <ul class="media-list display-inline-block">
                                                <li class="media">
                                                    <div class="media-body">
                                                        <div class="f-13 font-weight-bold">Planlanan Süre</div>
                                                        <ul class="list-inline list-inline-dotted list-inline-condensed font-size-sm text-muted mt-1 font-weight-normal">
                                                            <li class="list-inline-item f-15"><i class="fa fa-clock-o mr-1"></i><%=gorevli("toplam_sure") %></li>
                                                        </ul>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="col-lg-2 col-xs-6 p-2 mt-1">
                                            <ul class="media-list display-inline-block">
                                                <li class="media">
                                                    <div class="media-body">
                                                        <div class="f-13 font-weight-bold">Harcanan Süre</div>
                                                        <ul class="list-inline list-inline-dotted list-inline-condensed font-size-sm text-muted mt-1 font-weight-normal">
                                                            <li class="list-inline-item f-15">
                                                                <i class="fa fa-clock-o mr-1"></i> <%=gorevli("harcanan_sure") %>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="col-lg-2 col-xs-12 p-2 mt-1 mb-2">
                                            <ul class="media-list">
                                                <li class="media">
                                                    <div class="media-body">
                                                        <div class="f-13 font-weight-bold">Tamamlama Oranı</div>
                                                        <span class="mr-1 mt-1 font-weight-normal float-left"><%=gorevli("tamamlanmorani") %>%</span>
                                                        <div class="progress mb-0 round text-align mt-1">
                                                            <div class="progress-bar" role="progressbar" style="width: <%=gorevli("tamamlanmorani") %>%;" aria-valuenow="<%=gorevli("tamamlanmorani") %>" aria-valuemin="0" aria-valuemax="100"></div>
                                                        </div>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
								</a>
							</h6>
						</div>

						<div id="accordion-control-right-group<%=IsID %>-<%=gorevli("gorevli_id") %>" class="collapse" data-parent="#accordion-control-right">
							<div class="card-body p-1">
								<div class="col-md-12 p-0" id="calisma_kayitlari<%=IsID %>-<%=gorevli("gorevli_id") %>">
                                    <script type="text/javascript">
                                        is_listesi_calisma_kaydi('<%=IsID %>', '<%=gorevli("gorevli_id") %>');
                                    </script>
                                </div>
							</div>
						</div>
					</div>
				</div>
                <%
                        end if
                    gorevli.movenext
                    loop
                %>
            </div>
            <div class="tab-pane fade p-2" id="nav-contact<%=detay("id") %>" role="tabpanel" aria-labelledby="nav-contact-tab">
                Hazırlanıyor
            </div>
        </div>
    </div>
</div>
<%
    elseif trn(request("islem")) = "ProjeGelirOngorulenEkle" then
        projeID = trn(request("projeID"))
        durum = trn(request("durum"))
%>
<style type="text/css">
    .select2-container--default .select2-selection--single .select2-selection__rendered {
        color: #444;
        padding: 8px 25px 8px 10px;
    }

    .select2-container .select2-selection--single {
        cursor: pointer;
        height: 31px !important;
    }
</style>
<div class="modal-header">
    <%=LNG("Öngörülen Gelir Ekle")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="yeni_gelir_form" class="smart-form validateform" novalidate="novalidate">
    <div class="modal-body">
        <div class="col-md-12 p-0">
            <label class="col-form-label"><%=LNG("Gelir Adı")%></label>
            <div class="form-group">
                <input type="text" class="form-control required" required name="gelir_adi" id="gelir_adi" />
            </div>
        </div>
        <div class="row d-none">
            <label class="col-sm-12 col-form-label"><%=LNG("Durum")%></label>
            <div class="col-sm-12">
                <select class="select2" onchange="proje_gelir_odendimi(this.value);" name="gelir_durum" id="gelir_durum">
                    <option value="Bekliyor"><%=LNG("Bekliyor")%></option>
                    <option value="Ödendi"><%=LNG("Ödendi")%></option>
                    <!--<option value="Ertelendi"><%=LNG("Ertelendi")%></option>-->
                </select>
            </div>
        </div>
        <div class="row">
            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Tutar")%></label>
            <div class="col-sm-9 col-lg-9">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-money"></i>
                    </span>
                    <input type="text" class="validate[required] paraonly form-control" id="odeme_tutar" name="odeme_tutar" required value="0.00" />
                </div>
            </div>
            <div class="col-sm-3 col-lg-3">
                <select id="odeme_pb" name="odeme_pb" class="select2">
                    <option value="TL">TL</option>
                    <option value="USD">USD</option>
                    <option value="EUR">EUR</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-form-label">Tarih</label>
            <select class="form-control form-control-sm select2" id="tarih">
                <%
                        j = 0
                        for i = 1 to 12
                        j = j + 1
                            value = MONTHNAME(i) & " " & YEAR(date)
                            if i < 10 then 
                                i = "0" & i
                            end if
                            insertValue = "01." & i & "." & YEAR(date)
                %>
                <option <%if j = Month(date) then  %> selected="selected" <%end if %> value="<%=insertValue %>"><%=value %></option>
                <%
                        next
                %>
            </select>
        </div>
        <div class="row gelir_odendi" style="display: none;">
            <label class="col-sm-12 col-form-label"><%=LNG("Ödeme Tarihi")%></label>
            <div class="col-sm-12">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-calendar"></i>
                    </span>
                    <input type="text" class="form-control takvimyap required" required name="odeme_tarih" id="odeme_tarih" />
                </div>
            </div>
        </div>
        <div class="row">
            <label class="col-sm-12 col-form-label"><%=LNG("Açıklama")%></label>
            <div class="col-sm-12">
                <div class="form-group">
                    <textarea id="odeme_aciklama" name="odeme_aciklama" class="required form-control" style="width: 93%; padding-left: 5px; padding-top: 6px;" required></textarea>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            autosize($("#odeme_aciklama"));
            $('.paraonly:not(.yapilan)').addClass("yapilan").maskMoney({ thousands: '.', decimal: ',', allowZero: true, suffix: '' });
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#gelir_durum, #odeme_pb").select2({
                dropdownParent: $("#modal_div")
            });
        });
    </script>
    <div class="modal-footer">
        <input type="button" onclick="proje_gelir_kaydet(this, '<%=projeID %>', '<%=durum %>');" class="btn btn-primary btn-sm" value="<%=LNG("Kaydet")%>" />
    </div>
</form>
<%
    elseif trn(request("islem")) = "ProjeGelirGerceklesenEkle" then
        projeID = trn(request("projeID"))
        durum = trn(request("durum"))
        FirmaID = Request.Cookies("kullanici")("firma_id")
%>
<style type="text/css">
    .select2-container--default .select2-selection--single .select2-selection__rendered {
        color: #444;
        padding: 8px 25px 8px 10px;
    }

    .select2-container .select2-selection--single {
        cursor: pointer;
        height: 31px !important;
    }
</style>
<div class="modal-header">
    <%=LNG("Öngörülen Gelir Ekle")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="yeni_gelir_form" class="smart-form validateform" novalidate="novalidate">
    <div class="modal-body">
        <div class="col-md-12 p-0">
            <div class="form-group">
                <label class="col-form-label"><%=LNG("Öngörülen Gelir")%></label>
                <select class="form-control form-control-sm select2" id="ongorulen_id">
                    <%
                        SQL = "select * from ahtapot_proje_gelir_listesi where durum = 'true' and cop = 'false' and gelir_durum = 'ongorulen' and proje_id = '"& projeID &"' and firma_id = '"& FirmaID &"'"
                        set ongorulen = baglanti.execute(SQL)

                        if not ongorulen.eof then
                        do while not ongorulen.eof
                    %>
                        <option value="<%=ongorulen("id") %>"><%=ongorulen("gelir_adi") %></option>
                    <%
                        ongorulen.movenext
                        loop
                        end if
                    %>
                </select>
            </div>
            <div class="form-group">
                <label class="col-form-label">Gelir Adı</label>
                <input type="text" class="form-control required" required name="gelir_adi" id="gelir_adi" />
            </div>
        </div>
        <div class="row d-none">
            <label class="col-sm-12 col-form-label"><%=LNG("Durum")%></label>
            <div class="col-sm-12">
                <select class="select2" onchange="proje_gelir_odendimi(this.value);" name="gelir_durum" id="gelir_durum">
                    <option value="Bekliyor"><%=LNG("Bekliyor")%></option>
                    <option value="Ödendi"><%=LNG("Ödendi")%></option>
                    <!--<option value="Ertelendi"><%=LNG("Ertelendi")%></option>-->
                </select>
            </div>
        </div>
        <div class="row">
            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Tutar")%></label>
            <div class="col-sm-9 col-lg-9">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-money"></i>
                    </span>
                    <input type="text" class="validate[required] paraonly form-control" id="odeme_tutar" name="odeme_tutar" required value="0.00" />
                </div>
            </div>
            <div class="col-sm-3 col-lg-3">
                <select id="odeme_pb" name="odeme_pb" class="select2">
                    <option value="TL">TL</option>
                    <option value="USD">USD</option>
                    <option value="EUR">EUR</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-form-label">Tarih</label>
            <select class="form-control form-control-sm select2" id="tarih">
                <%
                        j = 0
                        for i = 1 to 12
                        j = j + 1
                            value = MONTHNAME(i) & " " & YEAR(date)
                            if i < 10 then 
                                i = "0" & i
                            end if
                            insertValue = "01." & i & "." & YEAR(date)
                %>
                <option <%if j = Month(date) then  %> selected="selected" <%end if %> value="<%=insertValue %>"><%=value %></option>
                <%
                        next
                %>
            </select>
        </div>
        <div class="row gelir_odendi" style="display: none;">
            <label class="col-sm-12 col-form-label"><%=LNG("Ödeme Tarihi")%></label>
            <div class="col-sm-12">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-calendar"></i>
                    </span>
                    <input type="text" class="form-control takvimyap required" required name="odeme_tarih" id="odeme_tarih" />
                </div>
            </div>
        </div>
        <div class="row">
            <label class="col-sm-12 col-form-label"><%=LNG("Açıklama")%></label>
            <div class="col-sm-12">
                <div class="form-group">
                    <textarea id="odeme_aciklama" name="odeme_aciklama" class="required form-control" style="width: 93%; padding-left: 5px; padding-top: 6px;" required></textarea>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            autosize($("#odeme_aciklama"));
            $('.paraonly:not(.yapilan)').addClass("yapilan").maskMoney({ thousands: '.', decimal: ',', allowZero: true, suffix: '' });
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#gelir_durum, #odeme_pb, #gelir_id, #tarih").select2({
                dropdownParent: $("#modal_div")
            });
        });
    </script>
    <div class="modal-footer">
        <input type="button" onclick="proje_gelir_kaydet(this, '<%=projeID %>', '<%=durum %>');" class="btn btn-primary btn-sm" value="<%=LNG("Kaydet")%>" />
    </div>
</form>
<%
    elseif trn(request("islem")) = "ProjeGerceklesenGelirKaydiDuzenle" then
        projeID = trn(request("projeID"))
        gelirID = trn(request("gelirID"))
        durum = trn(request("gelirID"))

        SQL="select * from ahtapot_proje_gelir_listesi where id = '"& gelirID &"' and firma_id = '"& FirmaID &"'"
        set gelir = baglanti.execute(SQL)
%>
<div class="modal-header">
        <%=LNG("Öngörülen Gelir Düzenle")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="yeni_gelir_form" class="smart-form validateform" novalidate="novalidate">
    <div class="modal-body">
        <div class="col-md-12 p-0">
            <label class="col-form-label"><%=LNG("Gelir Adı")%></label>
            <div class="form-group">
                <input type="text" class="form-control required" required name="gelir_adi" id="gelir_adi" value="<%=gelir("gelir_adi") %>" />
            </div>
        </div>
        <div class="row">
            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Tutar")%></label>
            <div class="col-sm-9 col-lg-9">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-money"></i>
                    </span>
                    <input type="text" class="validate[required] paraonly form-control" id="odeme_tutar" name="odeme_tutar" required value="<%=formatnumber(gelir("odeme_tutar"),2) %>" />
                </div>
            </div>
            <div class="col-sm-3 col-lg-3">
                <select id="odeme_pb" name="odeme_pb" class="select2">
                    <option <% if trim(gelir("odeme_pb"))="TL" then %> selected="selected" <% end if %> value="TL">TL</option>
                    <option <% if trim(gelir("odeme_pb"))="USD" then %> selected="selected" <% end if %> value="USD">USD</option>
                    <option <% if trim(gelir("odeme_pb"))="EUR" then %> selected="selected" <% end if %> value="EUR">EUR</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-form-label">Tarih</label>
            <select class="form-control form-control-sm select2" id="tarih">
                <%
                        j = 0
                        for i = 1 to 12
                        j = j + 1
                            value = MONTHNAME(i) & " " & YEAR(date)
                            if i < 10 then 
                                i = "0" & i
                            end if
                            insertValue = "01." & i & "." & YEAR(date)
                %>
                <option <%if j = Month(date) then  %> selected="selected" <%end if %> value="<%=insertValue %>"><%=value %></option>
                <%
                        next
                %>
            </select>
        </div>
        <div class="row">
            <label class="col-sm-12 col-form-label"><%=LNG("Açıklama")%></label>
            <div class="col-sm-12">
                <div class="form-group">
                    <textarea id="odeme_aciklama" name="odeme_aciklama" class="required form-control" style="width: 93%; padding-left: 5px; padding-top: 6px;" required><%=gelir("odeme_aciklama") %></textarea>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            autosize($("#odeme_aciklama"));
            $('.paraonly:not(.yapilan)').addClass("yapilan").maskMoney({ thousands: '.', decimal: ',', allowZero: true, suffix: '' });
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#gelir_durum, #odeme_pb").select2({
                dropdownParent: $("#modal_div")
            });
        });
    </script>
    <div class="modal-footer">
        <input type="button" onclick="proje_gelir_guncelle(this, '<%=projeID %>', '<%=gelirID %>', 'ongorulen');" class="btn btn-primary btn-sm" value="<%=LNG("Güncelle")%>" />
    </div>
</form>
<%
    elseif trn(request("islem")) = "ProjeOngorulenGelirKaydiDuzenle" then
        projeID = trn(request("projeID"))
        gelirID = trn(request("gelirID"))
        ongorulenID = trn(request("ongorulenID"))
        durum = trn(request("gelirID"))
        FirmaID = Request.Cookies("kullanici")("firma_id")

        SQL="select * from ahtapot_proje_gelir_listesi where id = '"& gelirID &"' and firma_id = '"& FirmaID &"'"
        set gelir = baglanti.execute(SQL)
%>
<div class="modal-header">
        <%=LNG("Gerçekleşen Gelir Düzenle")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="yeni_gelir_form" class="smart-form validateform" novalidate="novalidate">
    <div class="modal-body">
        <div class="col-md-12 p-0">
            <div class="form-group">
                <label class="col-form-label"><%=LNG("Gelir Adı")%></label>
                <select class="form-control form-control-sm select2" id="ongorulen_id">
                    <%
                        SQL = "select * from ahtapot_proje_gelir_listesi where durum = 'true' and cop = 'false' and gelir_durum = 'ongorulen' and proje_id = '"& projeID &"' and firma_id = '"& FirmaID &"'"
                        set ongorulen = baglanti.execute(SQL)

                        if not ongorulen.eof then
                        do while not ongorulen.eof
                    %>
                        <option value="<%=ongorulen("id") %>" <%if ongorulen("id") = ongorulenID then %> selected="selected" <%end if %>><%=ongorulen("gelir_adi") %></option>
                    <%
                        ongorulen.movenext
                        loop
                        end if
                    %>
                </select>
            </div>
            <div class="form-group">
                <label class="col-form-label"><%=LNG("Gelir Adı")%></label>
                <input type="text" class="form-control required" required name="gelir_adi" id="gelir_adi" value="<%=gelir("gelir_adi") %>" />
            </div>
        </div>
        <div class="row">
            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Tutar")%></label>
            <div class="col-sm-9 col-lg-9">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-money"></i>
                    </span>
                    <input type="text" class="validate[required] paraonly form-control" id="odeme_tutar" name="odeme_tutar" required value="<%=formatnumber(gelir("odeme_tutar"),2) %>" />
                </div>
            </div>
            <div class="col-sm-3 col-lg-3">
                <select id="odeme_pb" name="odeme_pb" class="select2">
                    <option <% if trim(gelir("odeme_pb"))="TL" then %> selected="selected" <% end if %> value="TL">TL</option>
                    <option <% if trim(gelir("odeme_pb"))="USD" then %> selected="selected" <% end if %> value="USD">USD</option>
                    <option <% if trim(gelir("odeme_pb"))="EUR" then %> selected="selected" <% end if %> value="EUR">EUR</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-form-label">Tarih</label>
            <select class="form-control form-control-sm select2" id="tarih">
                <%
                        j = 0
                        for i = 1 to 12
                        j = j + 1
                            value = MONTHNAME(i) & " " & YEAR(date)
                            if i < 10 then 
                                i = "0" & i
                            end if
                            insertValue = "01." & i & "." & YEAR(date)
                %>
                <option <%if j = Month(date) then  %> selected="selected" <%end if %> value="<%=insertValue %>"><%=value %></option>
                <%
                        next
                %>
            </select>
        </div>
        <div class="row">
            <label class="col-sm-12 col-form-label"><%=LNG("Açıklama")%></label>
            <div class="col-sm-12">
                <div class="form-group">
                    <textarea id="odeme_aciklama" name="odeme_aciklama" class="required form-control" style="width: 93%; padding-left: 5px; padding-top: 6px;" required><%=gelir("odeme_aciklama") %></textarea>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            autosize($("#odeme_aciklama"));
            $('.paraonly:not(.yapilan)').addClass("yapilan").maskMoney({ thousands: '.', decimal: ',', allowZero: true, suffix: '' });
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#gelir_durum, #odeme_pb").select2({
                dropdownParent: $("#modal_div")
            });
        });
    </script>
    <div class="modal-footer">
        <input type="button" onclick="proje_gelir_guncelle(this, '<%=projeID %>', '<%=gelirID %>', 'gerceklesen');" class="btn btn-primary btn-sm" value="<%=LNG("Güncelle")%>" />
    </div>
</form>
<%end if %>

<script type="text/javascript">
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
    })
    $(".takvimyap").datepicker({});
</script>
