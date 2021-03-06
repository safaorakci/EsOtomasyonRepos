﻿
function yeni_satinalma_kaydi_ekle(proje_id) {

    var data = "islem=yeni_satinalma_kaydi_ekle";
    data += "&proje_id=" + proje_id;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request3/", data: data }, function () {
        sayfa_yuklenince();
    });

}

function tanimlama_yasakli_getir() {

    var data = "islem=YasakliGunEkle";
    data = encodeURI(data);
    $("#yasakli_izin_listesi").loadHTML({ url: "/ajax_request6/", data: data }, function () {
    });

}

function YasakliGunEkle() {

    var baslangic_tarihi = $("#baslangic_tarihi").val();
    var bitis_tarihi = $("#bitis_tarihi").val();

    var data = "islem=YasakliGunEkle&islem2=ekle";
    data += "&baslangic_tarihi=" + baslangic_tarihi;
    data += "&bitis_tarihi=" + bitis_tarihi;
    data = encodeURI(data);
    $("#yasakli_izin_listesi").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        mesaj_ver("Yasaklı İzin Günleri", "Kayıt Başarıyla Eklendi", "success");
    });

}

function tanimlama_yasakli_sil(kayit_id) {

    var r = confirm("Kaydı Silmek İstediğinize Emin misiniz?");
    if (r) {
        var data = "islem=YasakliGunEkle&islem2=sil";
        data += "&kayit_id=" + kayit_id;
        data = encodeURI(data);
        $("#yasakli_izin_listesi").loadHTML({ url: "/ajax_request6/", data: data }, function () {
            mesaj_ver("Yasaklı İzin Günleri", "Kayıt Başarıyla Silindi", "success");
        });
    }

}

function proje_satinalma_planlamami(deger) {
    if (deger == "Planlandı") {
        $(".planlama_girisi").hide();
    } else {
        $(".planlama_girisi").show();
    }
}

function is_timer_start_kaydi_getir(is_id) {

    var data = "islem=is_timer_start_kaydi";
    data += "&is_id=" + is_id;
    data = encodeURI(data);
    $("#is_timer_list" + is_id).loadHTML({ url: "/ajax_request5/", data: data, loading: false }, function () {
        timer.start();
    });
}

function is_listesi_calisma_kaydi(is_id, gorevli_id) {

    var data = "islem=is_timer_start_kaydi";
    data += "&is_id=" + is_id;
    data += "&gorevli_id=" + gorevli_id;
    data = encodeURI(data);
    $("#calisma_kayitlari" + is_id + "-" + gorevli_id).loadHTML({ url: "/ajax_request5/", data: data, loading: false }, function () {
        datatableyap();
    });
}

function is_timer_start_kaydi(is_id, TamamlanmaID, user_id) {

    $("#TaskStartButton" + is_id + "-" + user_id).hide();
    $("#TaskPauseButton" + is_id + "-" + user_id).show();
    $("#TaskStopButton" + is_id + "-" + user_id).show();

    var data = "islem=is_timer_start_kaydi&islem2=baslat";
    data += "&is_id=" + is_id;
    data += "&TamamlanmaID=" + TamamlanmaID;
    data += "&userId=" + user_id;
    data = encodeURI(data);
    $("#calisma_kayitlari" + is_id + "-" + user_id).loadHTML({ url: "/ajax_request5/", data: data, loading: false }, function () {
        datatableyap();
    });
}


function is_timer_pause_kaydi(is_id, TamamlanmaID, gorevli_id) {

    var baslangic_tarihi = $("#sonacikkayit" + is_id).attr("baslangic_tarihi");
    var baslama_saati = $("#sonacikkayit" + is_id).attr("baslangic_saati");

    var baslik = $("#TaskPauseButton" + is_id + "-" + gorevli_id).attr("baslik");
    var aciklama = $("#TaskPauseButton" + is_id + "-" + gorevli_id).attr("aciklama");

    $("#TaskPauseButton" + is_id + "-" + gorevli_id).hide();
    $("#TaskStartButton" + is_id + "-" + gorevli_id).show();

    var data = "islem=is_timer_start_kaydi&islem2=pause";
    data += "&is_id=" + is_id;
    data += "&TamamlanmaID=" + TamamlanmaID;
    data += "&gorevli_id=" + gorevli_id;

    timer.stop();

    data += "&tamamlanma_orani=" + 10;
    data += "&onceki_oran=" + 0;
    data += "&baslama_saati=" + baslama_saati;
    data += "&bitirme_saati=" + "";
    data += "&baslama_tarihi=" + baslangic_tarihi;
    data += "&bitirme_tarihi=" + "";
    data += "&ajanda_baslik=" + baslik;
    data += "&ajanda_aciklama=" + aciklama;
    data = encodeURI(data);
    $("#calisma_kayitlari" + is_id + "-" + gorevli_id).loadHTML({ url: "/ajax_request5/", data: data, loading: false }, function () {
        datatableyap();
        is_ilerleme_ajanda_senkronizasyon_kaydet2(is_id, TamamlanmaID, 10, 0, baslama_saati, '', baslangic_tarihi, '', baslik, aciklama);
    });

}

function is_timer_stop_kaydi(is_id, TamamlanmaID, gorevli_id) {

    var r = confirm("Kaydı Tamamlamak İstiyormusunuz. ?");
    if (r) {
        var baslangic_tarihi = $("#sonacikkayit" + is_id).attr("baslangic_tarihi");
        var baslama_saati = $("#sonacikkayit" + is_id).attr("baslangic_saati");

        var baslik = $("#TaskStopButton" + is_id + "-" + gorevli_id).attr("baslik");
        var aciklama = $("#TaskStopButton" + is_id + "-" + gorevli_id).attr("aciklama");

        timer.stop();

        $("#TaskTimer" + is_id + "-" + gorevli_id).hide();
        $("#Progres" + is_id + "-" + gorevli_id).css('width', '100%');
        $("#ProgresTEXT" + is_id + "-" + gorevli_id).html("100%");

        $("#taskProgress" + is_id).css('width', '100%');
        $("#taskProgressTEXT" + is_id).html("100%");

        var data = "islem=is_timer_start_kaydi&islem2=stop";
        data += "&is_id=" + is_id;
        data += "&TamamlanmaID=" + TamamlanmaID;
        data += "&gorevli_id=" + gorevli_id;

        data += "&tamamlanma_orani=" + 100;
        data += "&onceki_oran=" + 0;
        data += "&baslama_saati=" + baslama_saati;
        data += "&bitirme_saati=" + "";
        data += "&baslama_tarihi=" + baslangic_tarihi;
        data += "&bitirme_tarihi=" + "";
        data += "&ajanda_baslik=" + baslik;
        data += "&ajanda_aciklama=" + aciklama;
        data = encodeURI(data);
        $("#calisma_kayitlari" + is_id + "-" + gorevli_id).loadHTML({ url: "/ajax_request5/", data: data, loading: false }, function () {
            datatableyap();
            is_ilerleme_ajanda_senkronizasyon_kaydet2(is_id, TamamlanmaID, 100, 0, baslama_saati, '', baslangic_tarihi, '', baslik, aciklama);
            manuel_isi_bitir2(TamamlanmaID, 100, is_id);
        });
    }
                //setTimeout(function () {
            //    var data = "islem=is_detay_goster";
            //    data += "&is_id=" + is_id;
            //    data = encodeURI(data);
            //    $("#detay_row" + is_id).loadHTML({ url: "/ajax_request5/", data: data }, function () {
            //        /*  if ($("#visualization").length>0) {
            //              timeline.setSelection([$(tr).attr("id")], {
            //                  focus: true
            //              });
            //          }*/
            //        $(".easyPieChartlar").knob({
            //            draw: function () {
            //                // "tron" case
            //                if (this.$.data('skin') == 'tron') {
            //                    this.cursorExt = 0.3;
            //                    var a = this.arc(this.cv) // Arc
            //                        ,
            //                        pa // Previous arc
            //                        , r = 1;
            //                    this.g.lineWidth = this.lineWidth;
            //                    if (this.o.displayPrevious) {
            //                        pa = this.arc(this.v);
            //                        this.g.beginPath();
            //                        this.g.strokeStyle = this.pColor;
            //                        this.g.arc(this.xy, this.xy, this.radius - this.lineWidth, pa.s, pa.e, pa.d);
            //                        this.g.stroke();
            //                    }
            //                    this.g.beginPath();
            //                    this.g.strokeStyle = r ? this.o.fgColor : this.fgColor;
            //                    this.g.arc(this.xy, this.xy, this.radius - this.lineWidth, a.s, a.e, a.d);
            //                    this.g.stroke();
            //                    this.g.lineWidth = 2;
            //                    this.g.beginPath();
            //                    this.g.strokeStyle = this.o.fgColor;
            //                    this.g.arc(this.xy, this.xy, this.radius - this.lineWidth + 1 + this.lineWidth * 2 / 3, 0, 2 * Math.PI, false);
            //                    this.g.stroke();
            //                    return false;
            //                }
            //            }
            //        });
            //        is_timer_start_kaydi_getir(is_id);

            //        $('.pauseButton').attr("disabled", "disabled");
            //        $('.stopButton').attr("disabled", "disabled");

            //        timer = new easytimer.Timer();
            //        var Id;

            //        $('.startButton').click(function () {
            //            $(this).attr("disabled", "disabled");
            //            $('.pauseButton').removeAttr("disabled");
            //            $('.stopButton').removeAttr("disabled");
            //            timer.start();
            //            var is_id = $(this).attr("is_id");
            //            var TamamlanmaID = $(this).attr("tamamlanmaid");
            //            var userId = $(this).attr("tamamlanmaid");
            //            is_timer_start_kaydi(is_id, TamamlanmaID, userId, timer.getTimeValues());
            //            Id = $(this).attr("user_id");
            //        });
            //        $('.pauseButton').click(function () {
            //            $('.startButton').removeAttr("disabled");
            //            var baslik = $(this).attr("baslik");
            //            var aciklama = $(this).attr("aciklama");
            //            var is_id = $(this).attr("is_id");
            //            var TamamlanmaID = $(this).attr("tamamlanmaid");
            //            var userId = $(this).attr("tamamlanmaid");
            //            timer.pause();
            //            is_timer_pause_kaydi(is_id, TamamlanmaID, userId, timer.getTimeValues(), baslik, aciklama);
            //            Id = $(this).attr("user_id");
            //        });
            //        $('.stopButton').click(function () {
            //            timer.stop();
            //            var is_id = $(this).attr("is_id");
            //            var TamamlanmaID = $(this).attr("tamamlanmaid");
            //            var baslik = $('.pauseButton').attr("baslik");
            //            var aciklama = $('.pauseButton').attr("aciklama");
            //            var userId = $(this).attr("tamamlanmaid");
            //            is_timer_stop_kaydi(is_id, TamamlanmaID, userId, timer.getTimeValues(), baslik, aciklama);
            //            Id = $(this).attr("user_id");
            //        });

            //        timer.addEventListener('secondsUpdated', function (e) {
            //            $('#basicUsage').html(timer.getTimeValues().toString());
            //        });
            //        timer.addEventListener('started', function (e) {
            //            $('#basicUsage').html(timer.getTimeValues().toString());
            //        });


            //        $(".yeni_slider").each(function () {

            //            var $slider = $(this);
            //            var olcu = $(this).width();

            //            $(this).noUiSlider({
            //                range: [0, 100],
            //                start: $(this).attr("start"),
            //                handles: 1,
            //                connect: true,
            //                slide: function () {

            //                    var asd = $(this);

            //                    clearTimeout(slider_timer);
            //                    slider_timer = setTimeout(function () {

            //                        var oran = parseInt(asd.find(".noUi-connect").css("left"));
            //                        oran = Math.round(100 - ((olcu - oran) / olcu * 100));
            //                        var newVal = oran;

            //                        if (parseFloat(newVal) > 97) {
            //                            newVal = 100;
            //                        }

            //                        var onceki_oran = $("#easyPieChart" + $slider.attr("TamamlanmaID")).val();

            //                        $("#easyPieChart" + $slider.attr("TamamlanmaID")).val(newVal);



            //                        $("#easyPieChart" + $slider.attr("TamamlanmaID")).knob({
            //                            draw: function () {
            //                                // "tron" case
            //                                if (this.$.data('skin') == 'tron') {
            //                                    this.cursorExt = 0.3;
            //                                    var a = this.arc(this.cv) // Arc
            //                                        ,
            //                                        pa // Previous arc
            //                                        , r = 1;
            //                                    this.g.lineWidth = this.lineWidth;
            //                                    if (this.o.displayPrevious) {
            //                                        pa = this.arc(this.v);
            //                                        this.g.beginPath();
            //                                        this.g.strokeStyle = this.pColor;
            //                                        this.g.arc(this.xy, this.xy, this.radius - this.lineWidth, pa.s, pa.e, pa.d);
            //                                        this.g.stroke();
            //                                    }
            //                                    this.g.beginPath();
            //                                    this.g.strokeStyle = r ? this.o.fgColor : this.fgColor;
            //                                    this.g.arc(this.xy, this.xy, this.radius - this.lineWidth, a.s, a.e, a.d);
            //                                    this.g.stroke();
            //                                    this.g.lineWidth = 2;
            //                                    this.g.beginPath();
            //                                    this.g.strokeStyle = this.o.fgColor;
            //                                    this.g.arc(this.xy, this.xy, this.radius - this.lineWidth + 1 + this.lineWidth * 2 / 3, 0, 2 * Math.PI, false);
            //                                    this.g.stroke();
            //                                    return false;
            //                                }
            //                            }
            //                        });


            //                        /*
            //                         * 
            //                        var data = "TamamlanmaID=" + $slider.attr("TamamlanmaID");
            //                        data += "&tamamlanma_orani=" + newVal;
            //                        data += "&IsID=" + $slider.attr("IsID");
            //                        var IsID = $slider.attr("IsID");
            //                        $.ajax({
            //                            type: "POST",
            //                            url: "/System_Root/ajax/islem1.aspx/IsDurumGuncelle",
            //                            data: JSON.stringify(QueryStringToJSON(data)),
            //                            contentType: "application/json; charset=utf-8",
            //                            dataType: "json",
            //                            success: function (response) {
            //                                if (response.d == "0") {
            //                                    $.bigBox({
            //                                        title: "Uyarı",
            //                                        content: "Hata Oluştu",
            //                                        color: "#C46A69",
            //                                        icon: "fa fa-warning shake animated",
            //                                        number: "1",
            //                                        timeout: 6000
            //                                    });
            //                                } else {
            //                                    $("#is_chart" + IsID).css('width', response.d + '%').attr('aria-valuenow', response.d).attr("data-progressbar-value", response.d);
            //                                    mesaj_ver("Görevler", "Kayıt Başarıyla Güncellendi", "success");
            //                                }
            //                            }, failure: function (response) {

            //                                $.bigBox({
            //                                    title: "Uyarı",
            //                                    content: "Hata Oluştu",
            //                                    color: "#C46A69",
            //                                    icon: "fa fa-warning shake animated",
            //                                    number: "1",
            //                                    timeout: 6000
            //                                });
            //                            }
            //                        });

            //                        */

            //                        is_ilerleme_ajanda_senkronizasyon($slider.attr("TamamlanmaID"), newVal, $slider.attr("IsID"), onceki_oran);

            //                    }, 300);
            //                }
            //            });

            //        });

            //        fileyap();

            //        setTimeout(function () {
            //            $(".file").attr("placeholder", "Yeni Dosya Yükle").css("height", "25px").css("margin-top", "5px;");
            //        }, 1000);
            //    });
            //}, 500);
}



function proje_ic_liste_getir(deger, ustId) {

    var data = "islem=proje_ic_liste_getir";
    data += "&durum_id=" + deger;
    data += "&ustId=" + ustId;
    data = encodeURI(data);
    $("#accoric" + deger).loadHTML({ url: "/ajax_request4/", data: data }, function () {
        datatableyap2();
    });

}


function personel_performans_raporu_getir() {

    var baslangic_tarihi = $("#baslangic_tarihi").val();
    var bitis_tarihi = $("#bitis_tarihi").val();
    var rapor_personel_id = $("#rapor_personel_id").val();
    var etiketler = $("#etiketler").val();
    var yeni_is_yuku_proje_id = $("#yeni_is_yuku_proje_id").val();

    var data = "islem=personel_performans_raporu_getir";
    data += "&baslangic_tarihi=" + baslangic_tarihi;
    data += "&bitis_tarihi=" + bitis_tarihi;
    data += "&rapor_personel_id=" + rapor_personel_id;
    data += "&etiketler=" + etiketler;
    data += "&yeni_is_yuku_proje_id=" + yeni_is_yuku_proje_id;
    data = encodeURI(data);
    $("#personel_performans_donus").loadHTML({ url: "/ajax_request4/", data: data }, function () {

    });

}

function proje_adam_saat_getir_rapor() {

    var rapor_personel_id = $("#rapor_personel_id").val();
    var etiketler = $("#etiketler").val();
    var yeni_is_yuku_proje_id = $("#yeni_is_yuku_proje_id").val();
    var baslangic = $("#is_yuku_donem option:selected").attr("dongu_baslangic");
    var bitis = $("#is_yuku_donem option:selected").attr("dongu_bitis");

    var data = "islem=proje_adam_saat_getir_rapor";
    data += "&rapor_personel_id=" + rapor_personel_id;
    data += "&etiketler=" + etiketler;
    data += "&yeni_is_yuku_proje_id=" + yeni_is_yuku_proje_id;
    data += "&baslangic=" + baslangic;
    data += "&bitis=" + bitis;
    data = encodeURI(data);
    $("#proje_adam_saat_donus").loadHTML({ url: "/ajax_request4/", data: data }, function () {

    });
}

function personel_giris_cikis_getir_rapor() {

    var personel_id = $("#rapor_personel_id").val();
    var baslangic = $("#personel_giris_cikis_saati_donem option:selected").attr("dongu_baslangic");
    var bitis = $("#personel_giris_cikis_saati_donem option:selected").attr("dongu_bitis");

    var data = "islem=personel_giris_cikis_getir_rapor";
    data += "&personel_id=" + personel_id;
    data += "&baslangic=" + baslangic;
    data += "&bitis=" + bitis;
    data = encodeURI(data);
    $("#personel_giris_cikis_donus").loadHTML({ url: "/ajax_request4/", data: data }, function () {

    });
}

function personel_giris_cikis_mesai_getir_rapor() {

    var personel_id = $("#rapor_personel_id").val();
    var baslangic = $("#personel_giris_cikis_saati_donem option:selected").attr("dongu_baslangic");
    var bitis = $("#personel_giris_cikis_saati_donem option:selected").attr("dongu_bitis");

    var data = "islem=personel_giris_cikis_mesai_getir_rapor";
    data += "&personel_id=" + personel_id;
    data += "&baslangic=" + baslangic;
    data += "&bitis=" + bitis;
    data = encodeURI(data);
    $("#personel_giris_cikis_donus").loadHTML({ url: "/ajax_request4/", data: data }, function () {

    });
}

function rapor_is_yuku_gosterim_proje_sectim_verimlilik(baslangic, bitis) {

    var gosterim_tipi = $("#yeni_is_yuku_gosterim_tipi").val();
    var proje_id = $("#yeni_is_yuku_proje_id").val();
    var donem = $("#rapor_is_yuku_donem").val();

    baslangic = $("#rapor_is_yuku_donem option:selected").attr("dongu_baslangic");
    bitis = $("#rapor_is_yuku_donem option:selected").attr("dongu_bitis");

    var data = "islem=rapor_is_yuku_gosterim_proje_sectim_verimlilik";
    data += "&proje_id=" + proje_id;
    data += "&baslangic=" + baslangic;
    data += "&bitis=" + bitis;
    data += "&gosterim_tipi=" + gosterim_tipi;
    data += "&donem=" + donem;
    data = encodeURI(data);
    $("#is_yuku_donus2").loadHTML({ url: "/ajax_request4/", data: data }, function () {

    });

}


function proje_satinalma_ongorulen_kopyala() {

    $("#gerceklesen_tutar").val($("#ongorulen_tutar").val());
    $("#gerceklesen_pb").val($("#ongorulen_pb").val()).trigger('change');;

}

function destek_listesi_getir() {
    var data = "islem=destek_listesi_getir";
    data = encodeURI(data);
    $("#beta_liste_donus").loadHTML({ url: "/ajax_request3/", data: data }, function () {

    });
}

function sinirlama_gorunum_degis() {
    if ($("#sinirlama_varmi").attr("checkeds") == "checkeds") {

        $(".dortlu").attr("class", "col-sm-6 dortlu");
        $(".uclu").attr("class", "col-sm-6 uclu");
        $(".takvimyap_yeni").css("max-width", "");
        $(".timepicker").css("max-width", "");
        $(".sinirlama_yeri").hide();
        $("#sinirlama_varmi").removeAttr("checkeds");
    } else {
        $("#sinirlama_varmi").attr("checkeds", "checkeds");
        $(".dortlu").attr("class", "col-sm-4 dortlu");
        $(".uclu").attr("class", "col-sm-3 uclu");
        $(".takvimyap_yeni").css("max-width", "110px");
        $(".timepicker").css("max-width", "55px");
        $(".sinirlama_yeri").show();

    }
}



function dsinirlama_gorunum_degis() {

    if ($("#dsinirlama_varmi").attr("checkeds") == "checkeds") {

        $(".dortlu").attr("class", "col-sm-6 dortlu");
        $(".uclu").attr("class", "col-sm-6 uclu");
        $(".takvimyap_yeni").css("max-width", "");
        $(".timepicker").css("max-width", "");
        $(".sinirlama_yeri").hide();
        $("#dsinirlama_varmi").removeAttr("checkeds");
    } else {
        $("#dsinirlama_varmi").attr("checkeds", "checkeds");
        $(".dortlu").attr("class", "col-sm-4 dortlu");
        $(".uclu").attr("class", "col-sm-3 uclu");
        $(".takvimyap_yeni").css("max-width", "110px");
        $(".timepicker").css("max-width", "55px");
        $(".sinirlama_yeri").show();
    }
}

function sistem_tema_degistir(deger) {

    switch (deger) {
        case "1":
            $('.pcoded-navbar').attr("navbar-theme", "themelight1");
            $('.pcoded-header').attr("header-theme", "themelight5");
            break;
        case "2":
            $('.pcoded-header').attr("header-theme", "theme1");
            $('.pcoded-navbar').attr("navbar-theme", "theme1");

            break;
        case "3":
            $('.pcoded-navbar').attr("navbar-theme", "themelight1");
            $('.pcoded-header').attr("header-theme", "theme1");
            break;
        case "4":
            $('.pcoded-navbar').attr("navbar-theme", "themelight1");
            $('.pcoded-header').attr("header-theme", "theme2");
            break;
        case "5":
            $('.pcoded-navbar').attr("navbar-theme", "themelight1");
            $('.pcoded-header').attr("header-theme", "themelight3");
            break;
        case "6":
            $('.pcoded-navbar').attr("navbar-theme", "themelight1");
            $('.pcoded-header').attr("header-theme", "theme4");
            break;
        case "7":
            $('.pcoded-navbar').attr("navbar-theme", "themelight1");
            $('.pcoded-header').attr("header-theme", "theme5");
            break;
        case "8":
            $('.pcoded-navbar').attr("navbar-theme", "themelight1");
            $('.pcoded-header').attr("header-theme", "theme6");
            break;
        case "9":
            $('.pcoded-navbar').attr("navbar-theme", "themelight1");
            $('.pcoded-header').attr("header-theme", "themelight1");
            break;
        case "10":
            $('.pcoded-navbar').attr("navbar-theme", "themelight1");
            $('.pcoded-header').attr("header-theme", "themelight2");
            break;
        case "11":
            $('.pcoded-navbar').attr("navbar-theme", "themelight1");
            $('.pcoded-header').attr("header-theme", "themelight3");
            break;
        case "12":
            $('.pcoded-navbar').attr("navbar-theme", "themelight1");
            $('.pcoded-header').attr("header-theme", "themelight4");
            break;
        case "13":
            $('.pcoded-navbar').attr("navbar-theme", "themelight1");
            $('.pcoded-header').attr("header-theme", "themelight6");
            break;
    }


}

function proje_satinalma_kaydet(nesne, proje_id) {

    if ($("#yeni_satinalma_form input:not(input[type=button])").valid("valid")) {

        var satinalma_adi = $("#satinalma_adi").val();
        var butce_hesabi = $("#butce_hesabi").val();
        var satinalma_durum = $("#satinalma_durum").val();
        var ongorulen_tutar = $("#ongorulen_tutar").val();
        var ongorulen_pb = $("#ongorulen_pb").val();
        var gerceklesen_tutar = $("#gerceklesen_tutar").val();
        var gerceklesen_pb = $("#gerceklesen_pb").val();
        var odeme_tarihi = $("#odeme_tarihi").val();
        //var tedarikci_id = $("#tedarikci_id").val();
        var satinalma_aciklama = $("#satinalma_aciklama").val();
        var tarih = $("#tarih").val();

        var data = "islem=proje_butce_listesi_getir&islem2=satinalmaekle";
        data += "&proje_id=" + proje_id;
        data += "&satinalma_adi=" + satinalma_adi;
        data += "&butce_hesabi=" + butce_hesabi;
        data += "&satinalma_durum=" + satinalma_durum;
        data += "&ongorulen_tutar=" + ongorulen_tutar;
        data += "&ongorulen_pb=" + ongorulen_pb;
        data += "&gerceklesen_tutar=" + gerceklesen_tutar;
        data += "&gerceklesen_pb=" + gerceklesen_pb;
        data += "&odeme_tarihi=" + odeme_tarihi;
        //data += "&tedarikci_id=" + tedarikci_id;
        data += "&satinalma_aciklama=" + satinalma_aciklama;
        data += "&tarih=" + tarih;
        data = encodeURI(data);
        //$(nesne).attr("disabled", "disabled").val("İşlem Yapılıyor...");
        $("#proje_butce_yeri").loadHTML({ url: "/ajax_request2/", data: data }, function () {
            $(".close").click();
            mesaj_ver("Proje Giderleri", "Kayıt Başarıyla Eklendi", "success");
            datatableyap();
            proje_butce_listesi_getir(proje_id);
        });
    }
}

function proje_gelir_getir2(proje_id) {

    var data = "islem=proje_gelir_listesi";
    data += "&proje_id=" + proje_id;
    data = encodeURI(data);
    $("#proje_gelir_listesi").loadHTML({ url: "/ajax_request3/", data: data }, function () {
        datatableyap();
    });

}

function proje_gelir_guncelle(nesne, proje_id, kayit_id, durum) {

    if ($("#yeni_gelir_form input:not(input[type=button])").valid("valid")) {

        var gelir_adi = $("#gelir_adi").val();
        var odeme_tutar = $("#odeme_tutar").val();
        var odeme_pb = $("#odeme_pb").val();
        var odeme_aciklama = $("#odeme_aciklama").val();
        var ongorulen_id = $("#ongorulen_id").val();
        var tarih = $("#tarih").val();

        var data = "islem=proje_gelir_listesi&islem2=guncelle";
        data += "&proje_id=" + proje_id;
        data += "&kayit_id=" + kayit_id;
        data += "&ongorulen_id=" + ongorulen_id;
        data += "&gelir_adi=" + gelir_adi;
        data += "&odeme_tutar=" + odeme_tutar;
        data += "&odeme_pb=" + odeme_pb;
        data += "&odeme_aciklama=" + odeme_aciklama;
        data += "&tarih=" + tarih;
        data += "&durum=" + durum;
        data = encodeURI(data);
        $(nesne).attr("disabled", "disabled").val("İşlem Yapılıyor...");
        $("#proje_gelir_listesi").loadHTML({ url: "/ajax_request3/", data: data }, function () {
            $(".close").click();
            mesaj_ver("Proje Gelirleri", "Kayıt Başarıyla Güncellendi", "success");
        });
    }

}

function proje_gelir_kaydi_duzenle(proje_id, kayit_id, ongorulen_id, yer) {

    var data = "islem=proje_gelir_kaydi_duzenle";
    data += "&proje_id=" + proje_id;
    data += "&kayit_id=" + kayit_id;
    data += "&yer=" + yer;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request3/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function proje_gelir_kaydi_sil(proje_id, kayit_id) {

    var r = confirm("Kaydı Silmek istediğinize Eminmisiniz.. ?");
    if (r) {
        var data = "islem=proje_gelir_listesi&islem2=sil";
        data += "&proje_id=" + proje_id;
        data += "&kayit_id=" + kayit_id;
        data = encodeURI(data);
        $("#proje_gelir_listesi").loadHTML({ url: "/ajax_request3/", data: data }, function () {
            mesaj_ver("Proje Gelirleri", "Kayıt Başarıyla Silindi", "success");
            sayfa_yuklenince();
        });
    }

    //$.confirm({
    //    title: 'Uyarı !',
    //    content: 'Kaydı Silmek istediğinize Eminmisiniz.. ?',
    //    icon: 'fa fa-warning',
    //    type: 'orange',
    //    bgOpacity: 0.7,
    //    theme: 'material',
    //    animation: 'zoom',
    //    scrollToPreviousElement: false,
    //    buttons: {
    //        confirm: {
    //            text: 'Evet',
    //            btnClass: 'btn-blue',
    //            keys: ['enter'],
    //            action: function () {
    //                var data = "islem=proje_gelir_listesi&islem2=sil";
    //                data += "&proje_id=" + proje_id;
    //                data += "&kayit_id=" + kayit_id;
    //                data = encodeURI(data);
    //                $("#proje_gelir_listesi").loadHTML({ url: "/ajax_request3/", data: data }, function () {
    //                    mesaj_ver("Proje Gelirleri", "Kayıt Başarıyla Silindi", "success");
    //                });
    //            }
    //        },
    //        cancel: {
    //            text: 'Hayır',
    //            keys: ['esc']
    //        }
    //    }
    //});
}

function proje_gelir_kaydet(nesne, proje_id, durum) {

    if ($("#yeni_gelir_form input:not(input[type=button])").valid("valid")) {

        var gelir_adi = $("#gelir_adi").val();
        var ongorulen_id = $("#ongorulen_id").val();
        var odeme_tutar = $("#odeme_tutar").val();
        var odeme_pb = $("#odeme_pb").val();
        var tarih = $("#tarih").val();
        var odeme_aciklama = $("#odeme_aciklama").val();

        var data = "islem=proje_gelir_listesi&islem2=ekle";
        data += "&proje_id=" + proje_id;
        data += "&gelir_adi=" + gelir_adi;
        data += "&ongorulen_id=" + ongorulen_id;
        data += "&odeme_tutar=" + odeme_tutar;
        data += "&odeme_pb=" + odeme_pb;
        data += "&tarih=" + tarih;
        data += "&odeme_aciklama=" + odeme_aciklama;
        data += "&durum=" + durum;
        data = encodeURI(data);
        $(nesne).attr("disabled", "disabled").val("İşlem Yapılıyor...");
        $("#proje_gelir_listesi").loadHTML({ url: "/ajax_request3/", data: data }, function () {
            $(".close").click();
            mesaj_ver("Proje Gelirleri", "Kayıt Başarıyla Eklendi", "success");
            sayfa_yuklenince();
        });
    }
}

function proje_gelir_odendimi(deger) {
    if (deger == "Ödendi") {
        $(".gelir_odendi").show();
    } else {
        $(".gelir_odendi").hide();
    }
}

function proje_gelir_ekle(proje_id) {

    var data = "islem=proje_gelir_ekle";
    data += "&proje_id=" + proje_id;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request3/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function proje_satinalma_guncelle(nesne, proje_id, kayit_id) {

    if ($("#dyeni_satinalma_form input:not(input[type=button])").valid("valid")) {

        var satinalma_adi = $("#satinalma_adi").val();
        var butce_hesabi = $("#butce_hesabi").val();
        var satinalma_durum = $("#satinalma_durum").val();
        var ongorulen_tutar = $("#ongorulen_tutar").val();
        var ongorulen_pb = $("#ongorulen_pb").val();
        var gerceklesen_tutar = $("#gerceklesen_tutar").val();
        var gerceklesen_pb = $("#gerceklesen_pb").val();
        var satinalma_aciklama = $("#satinalma_aciklama").val();
        var tarih = $("#tarih").val();
        var odeme_tarihi = $("#odeme_tarihi").val();


        var data = "islem=proje_butce_listesi_getir&islem2=satinalmaguncelle";
        data += "&proje_id=" + proje_id;
        data += "&kayit_id=" + kayit_id;
        data += "&satinalma_adi=" + satinalma_adi;
        data += "&butce_hesabi=" + butce_hesabi;
        data += "&satinalma_durum=" + satinalma_durum;
        data += "&ongorulen_tutar=" + ongorulen_tutar;
        data += "&ongorulen_pb=" + ongorulen_pb;
        data += "&gerceklesen_tutar=" + gerceklesen_tutar;
        data += "&gerceklesen_pb=" + gerceklesen_pb;
        data += "&satinalma_aciklama=" + satinalma_aciklama;
        data += "&tarih=" + tarih;
        data += "&odeme_tarihi=" + odeme_tarihi;
        data = encodeURI(data);
        //$(nesne).attr("disabled", "disabled").val("İşlem Yapılıyor...");
        $("#proje_butce_yeri").loadHTML({ url: "/ajax_request2/", data: data }, function () {
            $(".close").click();
            mesaj_ver("Proje Giderleri", "Kayıt Başarıyla Güncellendi", "success");
            proje_butce_listesi_getir(proje_id);
        });
    }

}



function proje_satinalma_kayit_duzenle(proje_id, kayit_id) {

    var data = "islem=proje_satinalma_kayit_duzenle";
    data += "&proje_id=" + proje_id;
    data += "&kayit_id=" + kayit_id;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request3/", data: data }, function () {
        sayfa_yuklenince();
    });

}

function proje_maliyet_raporu_getir() {

    var yeni_is_yuku_proje_id = $("#yeni_is_yuku_proje_id").val();
    var baslangic_tarihi = $("#baslangic_tarihi").val();
    var bitis_tarihi = $("#bitis_tarihi").val();

    var data = "islem=proje_maliyet_raporu_getir";
    data += "&yeni_is_yuku_proje_id=" + yeni_is_yuku_proje_id;
    data += "&baslangic_tarihi=" + baslangic_tarihi;
    data += "&bitis_tarihi=" + bitis_tarihi;
    data = encodeURI(data);
    $("#maliyet_raporu_donus").loadHTML({ url: "/ajax_request4/", data: data }, function () {
    });

}

function nakit_akis_takvim_getir() {

    var baslangic_tarihi = $("#baslangic_tarihi").val();
    var bitis_tarihi = $("#bitis_tarihi").val();

    var data = "islem=nakit_akis_takvim_getir";
    data += "&baslangic_tarihi=" + baslangic_tarihi;
    data += "&bitis_tarihi=" + bitis_tarihi;
    data = encodeURI(data);
    $("#nakit_akis1_donus").loadHTML({ url: "/ajax_request4/", data: data }, function () {

    });
}

function personel_adam_saat_rapor_getir() {

    var rapor_personel_id = $("#rapor_personel_id").val();
    var baslangic = $("#is_yuku_donem option:selected").attr("dongu_baslangic");
    var bitis = $("#is_yuku_donem option:selected").attr("dongu_bitis");
    var is_yuku_gosterim_tipi = $("#is_yuku_gosterim_tipi").val();
    var etiketler = $("#etiketler").val();
    var yeni_is_yuku_proje_id = $("#yeni_is_yuku_proje_id").val();

    var data = "islem=personel_adam_saat_rapor_getir";
    data += "&rapor_personel_id=" + rapor_personel_id;
    data += "&baslangic=" + baslangic;
    data += "&bitis=" + bitis;
    data += "&is_yuku_gosterim_tipi=" + is_yuku_gosterim_tipi;
    data += "&etiketler=" + etiketler;
    data += "&yeni_is_yuku_proje_id=" + yeni_is_yuku_proje_id;
    data = encodeURI(data);
    $("#personel_rapor_donus").loadHTML({ url: "/ajax_request4/", data: data }, function () {


    });
}



jQuery.fn.DataTable.ext.type.search.string = function (sVal) {
    var letters = { "İ": "i", "I": "ı", "i": "İ", "ı": "I" };
    return sVal.replace(/(([İI]))/g, function (letter) { return letters[letter]; });
};

function grubu_sil(kayit_id) {
    var r = confirm("Silmek İstediğinize Emin misiniz?");
    if (r) {
        var data = "islem=urun_grup_listesi&islem2=sil";
        data += "&kayit_id=" + kayit_id;
        data = encodeURI(data);
        $("#urun_agac_listesi").loadHTML({ url: "/ajax_request6/", data: data }, function () {
            mesaj_ver("Ürün Grupları", "Kayıt Başarıyla Silindi", "success");
        });
    }
}

function urun_gruplarini_getir() {

    var data = "islem=urun_grup_listesi";
    data = encodeURI(data);
    $("#urun_agac_listesi").loadHTML({ url: "/ajax_request6/", data: data }, function () {

    });

}


function grup_detay_getir(grup_id) {

    var data = "islem=grup_detay_getir";
    data += "&grup_id=" + grup_id;
    data = encodeURI(data);
    $("#grup_detay_donus" + grup_id).loadHTML({ url: "/ajax_request6/", data: data }, function () {

    });

}

function urun_grubu_ekle() {

    var grup_adi = $("#grup_adi").val();

    var data = "islem=urun_grup_listesi&islem2=ekle";
    data += "&grup_adi=" + grup_adi;
    data = encodeURI(data);
    $("#urun_agac_listesi").loadHTML({ url: "/ajax_request6/", data: data }, function () {

    });

}

function gruba_parca_kayit(grup_id) {

    var grup_adi = $("#dgrup_adi").val();
    var parcalar = $("#parcalar").val();

    var data = "islem=urun_grup_listesi&islem2=guncelle";
    data += "&grup_id=" + grup_id;
    data += "&grup_adi=" + grup_adi;
    data += "&parcalar=" + parcalar;
    data = encodeURI(data);
    $("#urun_agac_listesi").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        $(".close").click();
        mesaj_ver("Ürün Ağacı", "Kayıt Başarıyla Güncellendi", "success");
    });
}

function adet_kaydi_guncelle(grup_id, count) {
    var parcaId = "";
    var data = "islem=urun_grup_listesi&islem2=agacgrubuguncelle";
    data += "&grup_id=" + grup_id;
    data += "&adet=";
    for (var i = 1; i <= count; i++) {
        $("#count" + grup_id +""+ i).each(function () {
            var Adet = $(this).val();
            if (Adet !== "") {
                if (i === 1) {
                    parcaId = $(this).attr("parca_id");
                    data += Adet;
                }
                else {
                    parcaId += "," + $(this).attr("parca_id");
                    data += "," + Adet;
                }
            }
        });
    }
    data += "&parca_id=" + parcaId;
    data = encodeURI(data);
    $("#urun_agac_listesi").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        mesaj_ver("Ürün Ağacı", "Kayıtlarlar Başarıyla Güncellendi", "success");
        //grup_detay_getir(grup_id).click();
    });
}

function gruba_parca_ekle(grup_id) {

    var data = "islem=gruba_parca_ekle";
    data += "&grup_id=" + grup_id;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        sayfa_yuklenince();
    });

}

function ModalParcaEkle() {

    var data = "islem=ModalParcaEkle";
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request5/", data: data }, function () {
        sayfa_yuklenince();
    });


}


function satinalmayenisatirsil(i) {
    $("#satinalmasatir" + i).remove();
}

function satinalmayenisatirekle() {

    var j = parseInt($("#satinalma_parcalistesi tr .parcalar").last().attr("i")) + 1;

    $("#parcasayisi").val(j);

    var str = '<tr id="satinalmasatir' + j + '"><td><input type="text" name="parcalar" id="parcalar' + j + '" i="' + j + '" data="0" class="form-control parcalar required" required /> </td> <td> <div class="row"> <div class="col-sm-6" style="text-align: right; padding-right: 0;"> <input type="text" class="form-control maliyetler required" required name="maliyet" id="maliyet' + j + '" onkeyup="satinalmasiparishesapkitap();" style="height: 38px;" /> </div> <div class="col-sm-6" style="padding-left: 15px; text-align: left;"> <select onchange="satinalmasiparishesapkitap();" class="form-control yapilan paralar" name="paralar" id="paralar' + j + '"> <option value="TL">TL</option> <option value="USD">USD</option> <option value="EUR">EUR</option> </select> </div> </div> </td> <td style="padding-left: 15px;"> <input type="text" class="form-control adetler required" required onkeyup="satinalmasiparishesapkitap();" name="adet" id="adet' + j + '" style="height: 38px;" /></td> <th style="width: 25px; padding-left: 10px;"><a href="javascript:void(0);" onclick="satinalmayenisatirsil(' + j + ');"> <img src="/img/abort.png" /></a></th> </tr>';

    $("#satinalma_parcalistesi").append(str);
    parcalar_autocomplete_calistir();
}

function parcalar_autocomplete_calistir() {
    $(".parcalar:not(.yapilan)").addClass("yapilan").each(function () {

        var IsId = $(this).attr("isid");
        var marka = "Marka girilmedi";
        var aciklama = "Açıklama girilmedi";
        var kodu = "Ürün Kodu Girilmedi";
        var bildirim = "Kayıt Bulunamadı";

        $(this).autocomplete({
            source: "/ajax_request6/?jsid=4559&islem=parcalar_auto",
            minLength: 2,
            select: function (event, ui) {
                var inpuu = $(this);
                setTimeout(function () {
                    $(inpuu).val(ui.item.kodu + " " + ui.item.marka + " " + ui.item.aciklama).attr("data", ui.item.id);
                    console.log($(inpuu).attr("i"));
                    $("#maliyet" + $(inpuu).attr("i")).val(ui.item.maliyet);
                }, 100);
            }
        }).autocomplete().data("uiAutocomplete")._renderItem = function (ul, item) {

            if (item.kodu !== "") {
                kodu = item.kodu;
            }
            else {
                kodu = "Parça Kodu Girilmedi !";
            }
            if (item.marka !== "") {
                marka = item.marka;
            }
            else {
                marka = "Marka Girilmedi !";
            }
            if (item.aciklama !== "") {
                aciklama = item.aciklama;
            }
            else {
                aciklama = "Açıklama Boş !";
            }

            if (item.parcaadi === undefined && item.marka === undefined && item.aciklama === undefined && item.kodu === undefined) {
                return $("<p style='Display:none'>").append("<a>" + bildirim + "</a>").appendTo(ul);
            }
            else {
                return $("<li>").append("<a>" + kodu + " - " + marka + " - " + aciklama + "</a>").appendTo(ul);
            }
        };
    });

}

function parcalar_autocomplete_calistir2() {

    $(".parcalar:not(.yapilan)").addClass("yapilan").each(function () {

        var IsId = $(this).attr("isid");
        var marka = "Marka girilmedi";
        var aciklama = "Açıklama girilmedi";
        var kodu = "Ürün Kodu Girilmedi";
        var bildirim = "Kayıt Bulunamadı";

        $(this).autocomplete({
            source: "/ajax_request6/?jsid=4559&islem=parcalar_auto",
            minLength: 2,
            select: function (event, ui) {
                var inpuu = $(this);
                setTimeout(function () {
                    //$(inpuu).val(ui.item.kodu + " " + ui.item.marka + " " + ui.item.aciklama).attr("data", ui.item.id);
                    var adet = $("#parca_adeti").val();
                    var durum = 0;
                    var pathname = window.location.origin;

                    $.ajax({
                        type: 'POST',
                        contentType: 'application/json; charset=utf-8',
                        url: pathname + "/System_Root/ajax/islem1.aspx/CalculateParca",
                        data: JSON.stringify({ ParcaID: ui.item.id, GirilenMiktar: adet, parcaDurum: durum }),
                        dataType: "JSON",
                        error: function (xhr) {
                            console.log(xhr);
                        },
                        success: function (data) {
                            var result = jQuery.parseJSON(data.d);
                            if (result.Durum == 1) {
                                SiparisPopup(IsId, ui.item.id, result.Sayi, adet, durum, result.Parca);
                            }
                            if (result.Durum == 0) {
                                is_detay_parca_sectim(IsId, ui.item.id, 0, adet);
                            }
                        }
                    });

                }, 100);
            }
        }).autocomplete().data("uiAutocomplete")._renderItem = function (ul, item) {

            if (item.kodu !== "") {
                kodu = item.kodu;
            }
            else {
                kodu = "Parça Kodu Girilmedi !";
            }
            if (item.marka !== "") {
                marka = item.marka;
            }
            else {
                marka = "Marka Girilmedi !";
            }
            if (item.aciklama !== "") {
                aciklama = item.aciklama;
            }
            else {
                aciklama = "Açıklama Boş !";
            }

            if (item.parcaadi === undefined && item.marka === undefined && item.aciklama === undefined && item.kodu === undefined) {
                return $("<p style='Display:none'>").append("<a>" + bildirim + "</a>").appendTo(ul);
            }
            else {
                return $("<li>").append("<a>" + kodu + " - " + marka + " - " + aciklama + "</a>").appendTo(ul);
            }

        };
    });


    $(".aparcalar:not(.yapilan)").addClass("yapilan").each(function () {

        var IsId = $(this).attr("isid");

        $(this).autocomplete({
            source: "/ajax_request6/?jsid=4559&islem=parcalar_auto2",
            minLength: 2,
            select: function (event, ui) {
                var inpuu = $(this);
                setTimeout(function () {
                    //$(inpuu).val(ui.item.kodu + " " + ui.item.marka).attr("data", ui.item.id);
                    var pathname = window.location.origin;
                    var durum = 1;
                    var adet = 0;
                    //is_detay_parca_agaci_sectim(IsId, ui.item.id);
                    $.ajax({
                        type: 'POST',
                        contentType: 'application/json; charset=utf-8',
                        url: pathname + "/System_Root/ajax/islem1.aspx/CalculateParca",
                        data: JSON.stringify({ ParcaID: ui.item.id, GirilenMiktar: adet, parcaDurum: durum }),
                        dataType: "JSON",
                        error: function (xhr) {
                            console.log(xhr);
                        },
                        success: function (data) {
                            var result = jQuery.parseJSON(data.d);
                            if (result.Durum === 1) {
                                SiparisPopup(IsId, ui.item.id, result.Sayi, adet, durum, result.Parca);
                            }
                            if (result.Durum === 0) {
                                is_detay_parca_agaci_sectim(IsId, ui.item.id);
                            }
                        }
                    });
                }, 100);
            }
        }).autocomplete().data("uiAutocomplete")._renderItem = function (ul, item) {
            if (item.agacadi === undefined) {
                return $("<li style='display:none'>").append("<a> </a>").appendTo(ul);
            } else {
                return $("<li>").append("<a>" + item.agacadi + "</a>").appendTo(ul);
            }
        };
    });
}

var SPparcaListesi = [];
var SPadet = [];

var STparcaListesi = [];
var STadet = [];
function parcalar_autocomplete_calistir3() { // Servis Forum Parça Ekleme

    $(".parcalar:not(.yapilan)").addClass("yapilan").each(function () {

        var IsId = "0";
        var marka = "Marka girilmedi";
        var aciklama = "Açıklama girilmedi";
        var kodu = "Ürün Kodu Girilmedi";
        var bildirim = "Kayıt Bulunamadı";
        var durum = "servis";
        var v = 0;

        $(this).autocomplete({
            source: "/ajax_request6/?jsid=4559&islem=parcalar_auto",
            minLength: 2,
            select: function (event, ui) {
                var inpuu = $(this);
                setTimeout(function () {
                    SPparcaListesi.push(ui.item.id);
                    SPadet.push($("#musteriparcaadeti").val());
                    //STparcaListesi.push(ui.item.id);
                    //STadet.push($("#musteriparcaadeti").val());
                    $(inpuu).val(ui.item.kodu + " " + ui.item.marka + " " + ui.item.aciklama).attr("data", SPparcaListesi).attr("adet", SPadet);

                    $(inpuu).val("");

                    var pathname = window.location.origin;
                    var sayi = $("#musteriparcaadeti").val();

                    //parcalarId

                    if ($("#parcalarId").attr("parcaid") != "") {
                        $("#parcalarId").attr("parcaid", $("#parcalarId").attr("parcaId") + "," + ui.item.id);
                        $("#parcalarId").attr("adet", $("#parcalarId").attr("adet") + "," + $("#musteriparcaadeti").val());
                        $("#parcalarId").attr("sayi", "birdenfazla").attr("index", "ekleme");
                    }
                    else { $("#parcalarId").attr("parcaId", SPparcaListesi); $("#parcalarId").attr("adet", SPadet); $("#parcalarId").attr("sayi", "tek").attr("index", "ekleme"); }

                    if ($("#parcalarId").attr("sonradaneklenenparca") != "") {
                        $("#parcalarId").attr("sonradaneklenenparca", $("#parcalarId").attr("sonradaneklenenparca") + "," + ui.item.id).attr("sonradaneklenenadet", $("#parcalarId").attr("sonradaneklenenadet") + "," + $("#musteriparcaadeti").val()).attr("sonradaneklenensayi", "birdenfazla");
                    }
                    else { $("#parcalarId").attr("sonradaneklenenparca", ui.item.id).attr("sonradaneklenenadet", + $("#musteriparcaadeti").val()).attr("sonradaneklenensayi", "tek"); }

                    if ($("#servisparca").attr("parcaid") != "") {
                        $("#servisparca").attr("parcaid", $("#servisparca").attr("parcaid") + "," + ui.item.id);
                        $("#servisparca").attr("adet", $("#servisparca").attr("adet") + "," + $("#musteriparcaadeti").val());
                        $("#servisparca").attr("sayi", "birdenfazla");
                    }
                    else { $("#servisparca").attr("parcaId", SPparcaListesi); $("#servisparca").attr("adet", SPadet); $("#servisparca").attr("sayi", "tek"); }

                    //+ "<td  style='width:170px'>" + "<span class='label label-success' style='font-size: 100%; padding: 5px; display: inline;'> Stoktan Kullanıldı </span>" + "</td>"

                    var price = parseFloat(ui.item.maliyet.replace(",", ".") * parseFloat($("#musteriparcaadeti").val()));
                    var birimPB = "TL";
                    if (ui.item.birim_pb != "") {
                        birimPB = ui.item.birim_pb;
                        if (birimPB == "EURO") {
                            birimPB = "EUR";
                        }
                    }

                    $("#stoklist").prepend("<tr id='parca" + ui.item.id + "'> <td>" + ui.item.marka + " - " + ui.item.kodu + "</td>" + "<td>" + $("#musteriparcaadeti").val() + "</td>" + "<td class='price'>" + price + " " + birimPB + "</td>" + "<td>" + ui.item.aciklama + "<td>" + "<button class='btn btn-danger btn-mini' onclick='ParcaSil(" + ui.item.id + ");'>Sil</button>" + "</td> </tr>");

                    sumPrice();

                    //$.ajax({
                    //    type: 'POST',
                    //    contentType: 'application/json; charset=utf-8',
                    //    url: pathname + "/System_Root/ajax/islem1.aspx/CalculateParca",
                    //    data: JSON.stringify({ ParcaID: ui.item.id, GirilenMiktar: sayi }),
                    //    dataType: "JSON",
                    //    error: function (xhr) {
                    //        console.log(xhr);
                    //    },
                    //    success: function (data) {
                    //        var result = jQuery.parseJSON(data.d);
                    //        if (result > 0) {
                    //            SiparisPopup(IsId, ui.item.id, result, parcaAdet, durum, ui.item.kodu, ui.item.marka, ui.item.aciklama);
                    //        }
                    //        if (result == 0) {
                    //            var parcaAdet = $("#musteriparcaadeti").val();
                    //            $("#stoklist").append("<tr id='" + ui.item.id + "'> <td>" + ui.item.kodu + " " + ui.item.marka + "</td>" + "<td>" + $("#musteriparcaadeti").val() + "</td>" + "<td  style='width:170px'>" + "<span class='label label-success' style='font-size: 100%; padding: 5px; display: inline;'> Stoktan Kullanıldı </span>" + "</td>" + "<td>" + ui.item.aciklama + "<td>" + "<button class='btn btn-danger btn-mini' onclick='ParcaSil(" + ui.item.id + ", "+ v +");'>Sil</button>" + "</td> </tr>");

                    //            //servis_formu_parca_sectim(ui.item.id, adet);

                    //            if ($("#siparisformu").attr("stokparcaid") != "") {
                    //                $("#siparisformu").attr("stokparcaid", $("#siparisformu").attr("stokparcaid") + "," + ui.item.id);
                    //                $("#siparisformu").attr("stokadet", $("#siparisformu").attr("stokadet") + "," + $("#musteriparcaadeti").val());
                    //            }
                    //            else { $("#siparisformu").attr("stokparcaid", ui.item.id); $("#siparisformu").attr("stokadet", parcaAdet); }

                    //        }
                    //    }
                    //});

                }, 100);
            }
        }).autocomplete().data("uiAutocomplete")._renderItem = function (ul, item) {

            if (item.kodu !== "") {
                kodu = item.kodu;
            }
            else {
                kodu = "Parça Kodu Girilmedi !";
            }
            if (item.marka !== "") {
                marka = item.marka;
            }
            else {
                marka = "Marka Girilmedi !";
            }
            if (item.aciklama !== "") {
                aciklama = item.aciklama;
            }
            else {
                aciklama = "Açıklama Boş !";
            }

            if (item.parcaadi === undefined && item.marka === undefined && item.aciklama === undefined && item.kodu === undefined) {
                return $("<p style='Display:none'>").append("<a>" + bildirim + "</a>").appendTo(ul);
            }
            else {
                return $("<li>").append("<a>" + kodu + " - " + marka + " - " + aciklama + "</a>").appendTo(ul);
            }

        };
    });


    $(".aparcalar:not(.yapilan)").addClass("yapilan").each(function () {

        var IsId = $(this).attr("isid");

        $(this).autocomplete({
            source: "/ajax_request6/?jsid=4559&islem=parcalar_auto2",
            minLength: 2,
            select: function (event, ui) {
                var inpuu = $(this);
                setTimeout(function () {
                    //$(inpuu).val(ui.item.kodu + " " + ui.item.marka).attr("data", ui.item.id);
                    is_detay_parca_agaci_sectim(IsId, ui.item.id);
                }, 100);
            }
        }).autocomplete().data("uiAutocomplete")._renderItem = function (ul, item) {
            if (item.agacadi === undefined) {
                return $("<li style='display:none'>").append("<a> </a>").appendTo(ul);
            } else {
                return $("<li>").append("<a>" + item.agacadi + "</a>").appendTo(ul);
            }
        };
    });

    SPparcaListesi = [];
    SPadet = [];

    //STparcaListesi = [];
    //STadet = [];
}

function ParcaSil(id, durum) {

    $("#parca" + id).remove();

    if ($("#servisparca").attr("parcaid") !== undefined) {
        var servisparca = $("#servisparca").attr("parcaid").split(",");
        var servisadet = $("#servisparca").attr("adet").split(",");
        var index1 = servisparca.indexOf(id.toString());
        if (index1 !== -1) {

            servisparca.splice(index1, 1);
            servisadet.splice(index1, 1);
            SPparcaListesi.splice(index, 1);
            SPadet.splice(index, 1);
            $("#servisparca").attr("parcaid", servisparca).attr("adet", servisadet);

            if ($("#servisparca").attr("parcaid").indexOf(",") === -1) {
                $("#servisparca").attr("sayi", "tek");
            }

            if ($("#servisparca").attr("parcaid") === "") {
                $("#servisparca").attr("sayi", "");
            }
        }
    }

    if ($("#parcalarId").attr("parcaid") !== undefined) {

        var parcalarId = $("#parcalarId").attr("parcaid").split(",");
        var adet = $("#parcalarId").attr("adet").split(",");

        var index = parcalarId.indexOf(id.toString());
        if (index !== -1) {
            parcalarId.splice(index, 1);
            adet.splice(index, 1);

            $("#parcalarId").attr("parcaid", parcalarId);
            $("#parcalarId").attr("adet", adet);

            var sonradanEklenenParca = $("#parcalarId").attr("sonradaneklenenparca").split(",");
            var sonradanEklenenAdet = $("#parcalarId").attr("sonradaneklenenadet").split(",");
            index2 = sonradanEklenenParca.indexOf(id.toString());
            if (index2 !== -1) {
                sonradanEklenenParca.splice(index2, 1);
                sonradanEklenenAdet.splice(index2, 1);

                $("#parcalarId").attr("sonradaneklenenparca", sonradanEklenenParca);
                $("#parcalarId").attr("sonradaneklenenadet", sonradanEklenenAdet);

                if ($("#parcalarId").attr("sonradaneklenenparca").indexOf(",") === -1) {
                    $("#parcalarId").attr("sonradaneklenensayi", "tek");
                }
            }
           
            if ($("#parcalarId").attr("sonradaneklenenparca") === "") {
                $("#parcalarId").attr("sayi", "");
                $("#parcalarId").attr("index", "");
            }
        }
    }

    //var index3 = STparcaListesi.indexOf(id);
    //if (index3 !== -1) {
    //    STparcaListesi.splice(index3, 1);
    //    STadet.splice(index3, 1);
    //    $("#siparisformu").attr("stokparcaid", STparcaListesi).attr("stokadet", STadet);
    //}
    sumPrice();
}

function is_detay_parca_sectim(IsID, ParcaId, adet, toplamAdet) {

    var data = "islem=is_detay_parca_sectim&islem2=ekle";
    data += "&IsID=" + IsID;
    data += "&ParcaId=" + ParcaId;
    data += "&Adet=" + adet;
    data += "&ToplamAdet=" + toplamAdet;
    //data += "&servis=" + durum;
    data = encodeURI(data);
    $("#kullanilan_parcalar" + IsID).loadHTML({ url: "/ajax_request5/", data: data }, function () {
        mesaj_ver("Parçalar / Cihazlar", "Kayıt Başarıyla Eklendi", "success");
    });
}

function servis_formu_stok() {
    var data = "islem=servis_bakim_stok&islem2=kontrol";
    data += "&ParcaId=" + $("#servisparca").attr("ParcaId");
    data += "&Adet=" + $("#servisparca").attr("Adet");
    data = encodeURI(data);
    $("#servisformParcalar").loadHTML({ url: "/ajax_request5/", data: data }, function () {
        mesaj_ver("Servis Bakım Formu", "Kayıt Başarıyla Eklendi", "success");
    });
}

function servis_formu_parca_sectim(ParcaId, toplamAdet) {

    var data = "islem=servis_bakim_parca_ekle&islem2=ekle";
    data += "&ParcaId=" + ParcaId;
    data += "&Adet=" + toplamAdet;
    data = encodeURI(data);
    $("#servisformParcalar").loadHTML({ url: "/ajax_request5/", data: data }, function () {
        mesaj_ver("Servis Bakım Formu", "Kayıt Başarıyla Eklendi", "success");
    });
}

function is_detay_parca_agaci_sectim(IsID, AgacId) {

    var data = "islem=is_detay_parca_sectim&islem2=agacekle";
    data += "&IsID=" + IsID;
    data += "&AgacId=" + AgacId;
    data = encodeURI(data);
    $("#kullanilan_parcalar" + IsID).loadHTML({ url: "/ajax_request5/", data: data }, function () {
        mesaj_ver("Parçalar / Cihazlar", "Kayıt Başarıyla Eklendi", "success");
    });

}


function is_detay_kullanilan_parca_getir(IsID) {

    var data = "islem=is_detay_parca_sectim";
    data += "&IsID=" + IsID;
    data = encodeURI(data);
    $("#kullanilan_parcalar" + IsID).loadHTML({ url: "/ajax_request5/", data: data }, function () {

    });
}

function KullanilanParcaListesiGuncelle(IsID) {

    var data = "islem=is_detay_parca_sectim&islem2=guncelle";
    data += "&IsID=" + IsID;
    data += "&guncellenecekler=";
    $(".ictekiparcalar" + IsID).each(function () {
        var kayitId = $(this).attr("kayitId");
        var Adet = $(this).val();
        data += kayitId + "-" + Adet + "|";
    });
    data = encodeURI(data);
    $("#kullanilan_parcalar" + IsID).loadHTML({ url: "/ajax_request5/", data: data }, function () {
        mesaj_ver("Parçalar / Cihazlar", "Kayıtlar Başarıyla Güncellendi", "success");
    });

}

function KullanilanParcaSil(IsID, KayitID) {

    var r = confirm("Kaydı Silmek İstediğinize Emin misinz?");
    if (r) {
        var data = "islem=is_detay_parca_sectim&islem2=sil";
        data += "&IsID=" + IsID;
        data += "&KayitID=" + KayitID;
        data = encodeURI(data);
        $("#kullanilan_parcalar" + IsID).loadHTML({ url: "/ajax_request5/", data: data }, function () {
            mesaj_ver("Parçalar / Cihazlar", "Kayıt Başarıyla Silindi", "success");
        });
    }
}

function IsParcaListesiListeTemizle(IsID) {
    var r = confirm("Listeyi Temizlemek istediğinize eminmisiniz. ?");
    if (r) {
        var data = "islem=is_detay_parca_sectim&islem2=listetemizle";
        data += "&IsID=" + IsID;
        data = encodeURI(data);
        $("#kullanilan_parcalar" + IsID).loadHTML({ url: "/ajax_request5/", data: data }, function () {
            mesaj_ver("Parçalar / Cihazlar", "Kayıt Başarıyla Silindi", "success");
        });
    }
}

function satinalmasiparishesapkitap() {

    var toplamtl = 0;
    var toplamusd = 0;
    var toplameur = 0;

    $(".parcalar").each(function () {
        var i = $(this).attr("i");
        var parcaID = $(this).attr("data");
        if (parseFloat(parcaID) > 0) {
            var maliyet = NumericYap($("#maliyet" + i).val().replace(",", "."));
            var paralar = $("#paralar" + i).val().replace(",", ".");
            var adet = NumericYap($("#adet" + i).val().replace(",", "."));
            if (paralar === "TL") {
                toplamtl += parseFloat(maliyet) * parseFloat(adet);
            } else if (paralar === "USD") {
                toplamusd += parseFloat(maliyet) * parseFloat(adet);
            } else if (paralar === "EUR") {
                toplameur += parseFloat(maliyet) * parseFloat(adet);
            }
        }
    });

    $("#satinalma_alttoplamtl").val(new NumberFormat(toplamtl).toFormatted());
    $("#satinalma_alttoplamusd").val(new NumberFormat(toplamusd).toFormatted());
    $("#satinalma_alttoplameur").val(new NumberFormat(toplameur).toFormatted());

}

function NumericYap(deger) {
    if (!IsNumeric(deger)) {
        deger = 0;
    }
    return deger;
}


function ModalSatinalmaEkle() {

    var data = "islem=ModalSatinalmaEkle";
    data = encodeURI(data);
    $("#modal_butonum3").click();
    $("#modal_div3").loadHTML({ url: "/ajax_request5/", data: data }, function () {
        sayfa_yuklenince();
    });

}

function ModalTalepEkle() {

    var data = "islem=ModalTalepEkle";
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request5/", data: data }, function () {
        sayfa_yuklenince();
        fileyap();
    });

}

function satinalma_listesi_getir() {

    var data = "islem=satinalma_siparisleri";
    $("#satinalma_listesi").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        datatableyap();
    });

}

function satinalma_kayitsil(kayit_id) {

    var r = confirm("Silmek İstediğinize Emin misiniz?");

    if (r) {

        var data = "islem=satinalma_siparisleri&islem2=sil";
        data += "&kayit_id=" + kayit_id;
        data = encodeURI(data);
        $("#satinalma_listesi").loadHTML({ url: "/ajax_request6/", data: data }, function () {
            mesaj_ver("Satınalma Talepleri", "Kayıt Başarıyla Eklendi", "success");
        });

    }

}

$(document).ready(function () {

});

function SatinalmaSiparisGuncelle(kayit_id, is_id) {

    var baslik = $("#satinalma_baslik").val();
    var siparis_tarihi = $("#siparis_tarihi").val();
    var oncelik = $("#satinalma_oncelik").val();
    var tedarikci_id = $("#satinalma_tedarikci_id").val();
    var alttoplam = $("#satinalma_alttoplam").val();
    var aciklama = $("#satinalma_aciklama").val();
    var durum = $("#satinalma_durum").val();


    var toplamtl = NumericYap($("#satinalma_alttoplamtl").val().replace(",", "."));
    var toplamusd = NumericYap($("#satinalma_alttoplamusd").val().replace(",", "."));
    var toplameur = NumericYap($("#satinalma_alttoplameur").val().replace(",", "."));

    var data = "islem=satinalma_siparisleri&islem2=guncelle";
    data += "&kayit_id=" + kayit_id;
    data += "&is_id=" + is_id;
    data += "&baslik=" + baslik;
    data += "&siparis_tarihi=" + siparis_tarihi;
    data += "&oncelik=" + oncelik;
    data += "&tedarikci_id=" + tedarikci_id;
    data += "&alttoplam=" + alttoplam;
    data += "&aciklama=" + aciklama;
    data += "&toplamtl=" + toplamtl;
    data += "&toplamusd=" + toplamusd;
    data += "&toplameur=" + toplameur;
    data += "&durum=" + durum;
    data += "&parcalar=";

    $(".parcalar").each(function () {
        var i = $(this).attr("i");
        var parcaID = $(this).attr("data");
        if (parseFloat(parcaID) > 0) {
            var maliyet = NumericYap($("#maliyet" + i).val().replace(",", "."));
            var paralar = $("#paralar" + i).val().replace(",", ".");
            var adet = NumericYap($("#adet" + i).val().replace(",", "."));
            data += maliyet + "~" + paralar + "~" + adet + "~" + parcaID + "|";
        }
    });
    data = encodeURI(data);
    if ($("#satinalmasiparisi input:not(input[type=button])").valid("valid")) {
        $("#satinalma_listesi").loadHTML({ url: "/ajax_request6/", data: data }, function () {
            datatableyap();
            $(".close").click();
            mesaj_ver("Satınalma Talepleri", "Kayıt Başarıyla Güncellendi", "success");
        });
    }
}

function SatinalmaSiparisKaydet() {

    var baslik = $("#satinalma_baslik").val();
    var siparis_tarihi = $("#siparis_tarihi").val();
    var oncelik = $("#satinalma_oncelik").val();
    var tedarikci_id = $("#satinalma_tedarikci_id").val();
    var proje_id = $("#satinalma_proje_id").val();
    var alttoplam = $("#satinalma_alttoplam").val();
    var aciklama = $("#satinalma_aciklama").val();
    var durum = $("#satinalma_durum").val();
    var selectValue = $(".yetmislik").val();

    var toplamtl = NumericYap($("#satinalma_alttoplamtl").val().replace(",", "."));
    var toplamusd = NumericYap($("#satinalma_alttoplamusd").val().replace(",", "."));
    var toplameur = NumericYap($("#satinalma_alttoplameur").val().replace(",", "."));

    var data = "islem=satinalma_siparisleri&islem2=ekle";
    data += "&baslik=" + baslik;
    data += "&siparis_tarihi=" + siparis_tarihi;
    data += "&oncelik=" + oncelik;
    data += "&tedarikci_id=" + tedarikci_id;
    data += "&proje_id=" + proje_id;
    data += "&alttoplam=" + alttoplam;
    data += "&aciklama=" + aciklama;
    data += "&toplamtl=" + toplamtl;
    data += "&toplamusd=" + toplamusd;
    data += "&toplameur=" + toplameur;
    data += "&durum=" + durum;
    data += "&parcalar=";
    $(".parcalar").each(function () {
        var i = $(this).attr("i");
        var parcaID = $(this).attr("data");
        if (parseFloat(parcaID) > 0) {

            var maliyet = NumericYap($("#maliyet" + i).val().replace(",", "."));
            var paralar = $("#paralar" + i).val().replace(",", ".");
            var adet = NumericYap($("#adet" + i).val().replace(",", "."));

            data += maliyet + "~" + paralar + "~" + adet + "~" + parcaID + "|";
        }
    });
    data = encodeURI(data);

    if ($("#satinalmasiparisi input:not(input[type=button])").valid("valid")) {
        $("#satinalma_listesi").loadHTML({ url: "/ajax_request6/", data: data }, function () {
            datatableyap();
            $(".close").click();
            $(".yetmislik option[value=" + selectValue + "]").attr('selected', 'selected');
            $(".yetmislik").trigger("change");
            mesaj_ver("Satınalma Talepleri", "Kayıt Başarıyla Eklendi", "success");
        });
    }

}


function satinalma_kayitduzenle(kayit_id, is_id, parca_id) {

    var data = "islem=satinalma_kayitduzenle";
    data += "&kayit_id=" + kayit_id;
    data += "&is_id=" + is_id;
    data += "&parca_id=" + parca_id;
    data = encodeURI(data);
    $("#modal_butonum3").click();
    $("#modal_div3").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        sayfa_yuklenince();
        datatableyap();
    });
}


function UretimSablonDetayGetir(Id) {

    $(".accoricler").html("");
    var data = "islem=UretimSablonDetayGetir";
    data += "&Id=" + Id;
    data = encodeURI(data);
    $("#accoric" + Id).loadHTML({ url: "/ajax_request6/", data: data }, function () {

    });

}

function UretimSablonlariGetir() {

    var data = "islem=uretim_sablonlari";
    data = encodeURI(data);

    $("#uretim_sablonlari").loadHTML({ url: "/ajax_request6/", data: data }, function () {

        var icons = {
            header: "zmdi zmdi-chevron-down",
            activeHeader: "zmdi zmdi-chevron-up"
        };
        $("#color-accordion").accordion({
            heightStyle: "content",
            icons: icons,
            active: 50,
            collapsible: true
        });

    });

}

function UretimSablonuKayit() {

    var sablon_adi = $("#sablon_adi").val();

    var data = "islem=uretim_sablonlari&islem2=ekle";
    data += "&sablon_adi=" + sablon_adi;
    data = encodeURI(data);

    if ($("#uretimsablonuekle input:not(input[type=button])").valid("valid")) {
        $("#uretim_sablonlari").loadHTML({ url: "/ajax_request6/", data: data }, function () {

            mesaj_ver("Üretim Şablonları", "Kayıt Başarıyla Eklendi", "success");
            $(".close").click();

            var icons = {
                header: "zmdi zmdi-chevron-down",
                activeHeader: "zmdi zmdi-chevron-up"
            };

            $("#color-accordion").accordion({
                heightStyle: "content",
                icons: icons,
                active: 50,
                collapsible: true
            });

        });
    }

}

function sablon_sil(id) {

    var sor = confirm("Şablonu silmek istediğine eminmisiniz?");
    if (sor) {
        var data = "islem=uretim_sablonlari&islem2=sil";
        data += "&sablon_id=" + id;
        data = encodeURI(data);
        $("#uretim_sablonlari").loadHTML({ url: "/ajax_request6/", data: data }, function () {

            mesaj_ver("Şablonlar", "Kayıt Başarıyla Silindi", "success");
            $(".close").click();

            var icons = {
                header: "zmdi zmdi-chevron-down",
                activeHeader: "zmdi zmdi-chevron-up"
            };

            $("#color-accordion").accordion({
                heightStyle: "content",
                icons: icons,
                active: 50,
                collapsible: true
            });

        });
    }
}

function proje_sablonlara_kayit(proje_id) {

    var sablon_adi = $("#sablon_adi").val();

    var data = "islem=proje_sablonlara_kayit";
    data += "&proje_id=" + proje_id;
    data += "&sablon_adi=" + sablon_adi;
    data = encodeURI(data);
    $("#koftiden").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        $(".close").click();
        mesaj_ver("Üretim Şablonları", "Kayıt Başarıyla Eklendi", "success");
    });

}

function yeni_uretim_sablonu_ekle() {

    var data = "islem=yeni_uretim_sablonu_ekle";
    data = encodeURI(data);
    $("#modal_butonum3").click();
    $("#modal_div3").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        sayfa_yuklenince();
    });

}

function proje_sablonlara_kaydet(proje_id) {

    var data = "islem=proje_sablonlara_kaydet&proje_id=" + proje_id;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        sayfa_yuklenince();
    });

}


function uretim_sablonlarindan_secim_yap(proje_id) {


    var data = "islem=proje_plan_kopyala";
    data += "&proje_id=" + proje_id;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request5/", data: data }, function () {
        sayfa_yuklenince();
    });

}



function proje_sablon_kopyalama_baslat(nesne, proje_id) {

    var uretim_sablonu_id = $("#uretim_sablonu_id").val();
    var islem_tipi = $("#islem_tipi").val();

    $(nesne).attr("disabled", "disabled").val("İşlem Yapılıyor...");

    var data = "islem=proje_sablon_kopyalama_baslat";
    data += "&proje_id=" + proje_id;
    data += "&uretim_sablonu_id=" + uretim_sablonu_id;
    data += "&islem_tipi=" + islem_tipi;
    data = encodeURI(data);
    $("#kopyalama_donus").loadHTML({ url: "/ajax_request5/", data: data }, function () {
        mesaj_ver("Proje Planlama", "Kayıt Başarıyla Eklendi", "success");
        $(".close").click();
    });
    console.log($("a[href=#planlama_tab]"));
    var projeID = $("#planlamaTab").attr("projeID");
    proje_planlama_getir(projeID, 'planlama', $("#planlamaTab"));
}

function ProjeBakimKaydiSil(ProjeID, BakimID, Tum) {
    var r = confirm("Kaydı Silmek İstediğinize Emin misiniz?");
    if (r) {
        var data = "islem=ProjeBakimKaydiEkle&islem2=sil";
        data += "&ProjeId=" + ProjeID;
        data += "&BakimID=" + BakimID;
        data += "&Tum=" + Tum;
        data = encodeURI(data);
        $("#servis_kayit_donus").loadHTML({ url: "/ajax_request5/", data: data }, function () {
            datatableyap();
        });
    }
}


function proje_bakim_kayitlarini_getir(ProjeId, Tum) {

    var data = "islem=ProjeBakimKaydiEkle";
    data += "&ProjeId=" + ProjeId;
    data += "&Tum=" + Tum;
    data = encodeURI(data);
    $("#servis_kayit_donus").loadHTML({ url: "/ajax_request5/", data: data }, function () {
        datatableyap();
    });

}


function servis_bakim_kayitlarini_getir() {

    var data = "islem=YeniServisBakimKaydiEkle";
    data = encodeURI(data);
    $("#servis_kayit").loadHTML({ url: "/ajax_request5/", data: data }, function () {

    });
}


function ModalBakimAramaYap(ProjeId, Tum) {

    ProjeId = $("#proje_id").val();
    Tum = "true";

    var baslangic_tarihi = $("#baslangic_tarihi").val();
    var bitis_tarihi = $("#bitis_tarihi").val();
    var bakim_durum = $("#bakim_durum").val();

    var data = "islem=ProjeBakimKaydiEkle&islem2=arama";
    data += "&ProjeId=" + ProjeId;
    data += "&Tum=" + Tum;
    data += "&baslangic_tarihi=" + baslangic_tarihi;
    data += "&bitis_tarihi=" + bitis_tarihi;
    data += "&bakim_durum=" + bakim_durum;
    data = encodeURI(data);
    $("#servis_kayit_donus").loadHTML({ url: "/ajax_request5/", data: data }, function () {
        datatableyap();
    });

}


function ProjeBakimKaydiEkle(ProjeId, Tum) {

    if (ProjeId === 0) {
        ProjeId = $("#proje_id").val();
    }

    var data = "islem=ProjeBakimKaydiEkle&islem2=ekle";
    data += "&ProjeId=" + ProjeId;
    data += "&Tum=" + Tum;

    var yineleme_donemi;
    if ($("#yineleme_donemi1").attr("checkeds") == "checkeds") {
        yineleme_donemi = "gunluk";
    } else if ($("#yineleme_donemi2").attr("checkeds") == "checkeds") {
        yineleme_donemi = "haftalik";
    } else if ($("#yineleme_donemi3").attr("checkeds") == "checkeds") {
        yineleme_donemi = "aylik";
    }
    data += "&yineleme_donemi=" + yineleme_donemi;
    if (yineleme_donemi == "gunluk") {
        var gunluk_yineleme_secim;
        if ($("#gunluk_yineleme_secim1").attr("checkeds") == "checkeds") {
            gunluk_yineleme_secim = "gunluk";
        } else if ($("#gunluk_yineleme_secim2").attr("checkeds") == "checkeds") {
            gunluk_yineleme_secim = "is_gunu";
        }
        data += "&gunluk_yineleme_secim=" + gunluk_yineleme_secim;
        if (gunluk_yineleme_secim == "gunluk") {
            var gunluk_yineleme_gun_aralik = $("#gunluk_yineleme_gun_aralik1").val();
            data += "&gunluk_yineleme_gun_aralik=" + gunluk_yineleme_gun_aralik;
        }
    } else if (yineleme_donemi == "haftalik") {
        var haftalik_yineleme_sikligi = $("#haftalik_yineleme_sikligi").val();
        var gunler = "";
        $(".dhaftalik_gunler").each(function () {
            var clickCheckbox = document.querySelector("#" + $(this).attr("id"));
            if (clickCheckbox.checked == true) {
                gunler += $(this).val() + ",";
            }
        });
        data += "&haftalik_yineleme_sikligi=" + haftalik_yineleme_sikligi;
        data += "&gunler=" + gunler;
    } else if (yineleme_donemi == "aylik") {
        var aylik_yenileme_tipi;
        if ($("#aylik_yenileme_tipi1").attr("checkeds") == "checkeds") {
            aylik_yenileme_tipi = "1";
        } else if ($("#aylik_yenileme_tipi2").attr("checkeds") == "checkeds") {
            aylik_yenileme_tipi = "2";
        }
        data += "&aylik_yenileme_tipi=" + aylik_yenileme_tipi;
        if (aylik_yenileme_tipi == "1") {
            var aylik_gun = $("#aylik_gun").val();
            var aylik_aralik = $("#aylik_aralik").val();
            data += "&aylik_gun=" + aylik_gun;
            data += "&aylik_aralik=" + aylik_aralik;
        } else if (aylik_yenileme_tipi == "2") {
            var aylik_yineleme1 = $("#aylik_yineleme1").val();
            var aylik_yineleme2 = $("#aylik_yineleme2").val();
            var aylik_yineleme3 = $("#aylik_yineleme3").val();
            data += "&aylik_yineleme1=" + aylik_yineleme1;
            data += "&aylik_yineleme2=" + aylik_yineleme2;
            data += "&aylik_yineleme3=" + aylik_yineleme3;
        }
    }
    var yineleme_baslangic = $("#yineleme_baslangic").val();
    var yineleme_bitis = $("#yineleme_bitis").val();

    data += "&yineleme_baslangic=" + yineleme_baslangic;
    data += "&yineleme_bitis=" + yineleme_bitis;
    data = encodeURI(data);
    $("#servis_kayit_donus").loadHTML({ url: "/ajax_request5/", data: data }, function () {
        mesaj_ver("Bakım Ayarları", "Kayıt Başarıyla Güncellendi", "success");
        datatableyap();
    });

}


function bakim_kaydini_onayla(ProjeID, BakimID, Tum) {

    var data = "islem=ProjeBakimKaydiEkle&islem2=onay";
    data += "&ProjeId=" + ProjeID;
    data += "&BakimID=" + BakimID;
    data += "&Tum=" + Tum;
    data = encodeURI(data);
    $("#servis_kayit_donus").loadHTML({ url: "/ajax_request5/", data: data }, function () {
        datatableyap();
    });

}

function parcalar_ve_iscilik_getir(IsID) {

    var data = "islem=parcalar_ve_iscilik_getir";
    data += "&IsID=" + IsID;
    data = encodeURI(data);
    $("#parcalar_iscilik_donus_yeri" + IsID).loadHTML({ url: "/ajax_request5/", data: data }, function () {

    });

}

function ParcadanIsListesiBul(parcaId, Stok) {

    var data = "islem=ParcadanIsListesiBul";
    data += "&parcaId=" + parcaId;
    data += "&stok=" + Stok;
    data = encodeURI(data);
    $("#modal_butonum2").click();
    $("#modal_div2").loadHTML({ url: "/ajax_request5/", data: data }, function () {
        sayfa_yuklenince();
    });

}



function SatinalmaSiparisAramaYap() {

    var baslik = $("#satinalma_baslik").val();
    var siparis_tarihi = $("#siparis_tarihi").val();
    var oncelik = $("#satinalma_oncelik").val();
    var tedarikci_id = $("#satinalma_tedarikci_id").val();
    var aciklama = $("#satinalma_aciklama").val();
    var durum = $("#satinalma_durum").val();
    var selectValue = $(".yetmislik").val();

    var data = "islem=satinalma_siparisleri&islem2=arama";
    data += "&baslik=" + baslik;
    data += "&siparis_tarihi=" + siparis_tarihi;
    data += "&oncelik=" + oncelik;
    data += "&tedarikci_id=" + tedarikci_id;
    data += "&aciklama=" + aciklama;
    data += "&durum=" + durum;
    data = encodeURI(data);
    $("#satinalma_listesi").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        datatableyap();
        $(".close").click();
        $(".yetmislik option[value=" + selectValue + "]").attr('selected', 'selected');
        $(".yetmislik").trigger("change");

    });

}

