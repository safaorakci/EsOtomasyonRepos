var timer;

function santiye_durum_listesi() {
    var data = "islem=santiye_durum";
    data = encodeURI(data);
    $("#santiye_durum_listesi").loadHTML({ url: "islem1", data: data }, function () {
        datatableyap();
    });
}

function beta_bildirim_yap() {

    var bildirim_tipi = $("#bildirim_tipi").val();
    var baslik = $("#baslik").val();
    var dosya_eki = $("#dosya_eki").val();
    var beta_aciklama = $("#beta_aciklama").val();

    if ($("#beta_form input:not(input[type=button])").valid("valid")) {
        var data = "islem=beta_bildirim_yap";
        data += "&bildirim_tipi=" + bildirim_tipi;
        data += "&baslik=" + baslik;
        data += "&dosya_eki=" + dosya_eki;
        data += "&beta_aciklama=" + beta_aciklama;
        data = encodeURI(data);
        $("#beta_donus").loadHTML({ url: "/ajax_request/", data: data }, function () {
            mesaj_ver("Destek", "Kayıt Başarıyla Eklendi", "success");
            destek_listesi_getir();
        });
    }
}

function OpenOrDownloadFile(File) {
    window.open(File);
}

function gantt_liste_gorunumu(proje_id, tip) {

    setTimeout(function () {
        var data = "islem=gantt_liste_gorunumu";
        data += "&proje_id=" + proje_id;
        data += "&tip=" + tip;
        data = encodeURI(data);
        $("#modal_butonum2").click();
        $("#modal_div2").loadHTML({ url: "/ajax_request2/", data: data }, function () {
            sayfa_yuklenince();
        });
    }, 500);

}

function is_yuku_cizelgesi_ac(start, end) {

    var data = "islem=is_yuku_cizelgesi_ac";
    data += "&start=" + start;
    data += "&end=" + end;
    data = encodeURI(data);
    $("#modal_butonum2").click();
    $("#modal_div2").loadHTML({ url: "/kaynak_is_yuku_cizelgesi/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function santiye_durum_ekle() {

    var durum_adi = $("#durum_adi").val();
    var selectValue = $(".yetmislik").val();

    var data = "islem=santiye_durum&islem2=ekle";
    data += "&durum_adi=" + encodeURIComponent(durum_adi);
    data = encodeURI(data);
    if ($("#santiye_durum_ekle_form input:not(input[type=button])").valid("valid")) {
        $("#santiye_durum_listesi").loadHTML({ url: "islem1", data: data }, function () {
            datatableyap();

            $(".yetmislik option[value=" + selectValue + "]").attr('selected', 'selected');
            $(".yetmislik").trigger("change");
            mesaj_ver("Proje Durumları", "Kayıt Başarıyla Eklendi", "success");
        });
    }
}



function departman_duzenle(departman_id) {

    var data = "islem=departman_duzenle";
    data += "&departman_id=" + departman_id;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "islem1", data: data }, function () {
        sayfa_yuklenince();
    });

}


function durum_guncelleme_calistir(tablo, id) {

    $.ajax({
        type: "POST",
        url: "/System_Root/ajax/islem1.aspx/DurumGuncelle",
        data: "{'tablo':'" + tablo + "', 'id':'" + id + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            if (msg.d == "true") {
                mesaj_ver("Durum", "Kayıt Başarıyla Güncellendi", "success");
            } else {
                mesaj_ver("Durum", "Kayıt Güncellenemedi", "warning");
            }
        },
        fail: function () {
            mesaj_ver("Durum", "Kayıt Güncellenemedi", "warning");
        }
    });
}

function proje_kodu_durum(tablo, id) {
    $.ajax({
        type: "POST",
        url: "/System_Root/ajax/islem1.aspx/ProjeKoduDurumGuncelle",
        data: "{'tablo':'" + tablo + "', 'id':'" + id + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function (msg) {
            console.log(msg);
            if (msg.d == "true") {
                mesaj_ver("Durum", "Kayıt Başarıyla Güncellendi", "success");
            } else {
                mesaj_ver("Durum", "Kayıt Güncellenemedi", "warning");
            }
        },
        fail: function () {
            mesaj_ver("Durum", "Kayıt Güncellenemedi", "warning");
        }
    });
}

function SiparisPopup(IsID, ParcaId, adet, toplamAdet, durum, parcaBilgisi) {

    var stParca = "";
    var arrParca = parcaBilgisi.split(',');
    var arrAdet = adet.toString().split(',');

    for (var i = 0; i < arrParca.length; i++) {
        stParca += " " + arrParca[i] + " " + arrAdet[i] + " Adet | ";
    }

    $.fn.toHtml = function () {
        return $(this).html("<span class='label label-danger'>" + stParca + "</span>" + " " + "Sipariş verilecek. Siparişi Onaylıyor Musunuz ?");
    };

    swal({
        title: "Satınalma Formu",
        text: stParca + " " + "Sipariş verilecek. Siparişi Onaylıyor Musunuz?",
        type: "warning",
        showCancelButton: true,
        confirmButtonClass: "btn-danger",
        cancelButtonText: "Vazgeç",
        confirmButtonText: "Evet, Sipariş Ver.!",
        closeOnConfirm: true,
        closeOnCancel: true
    },
        function (isConfirm) {
            if (isConfirm) {
                //var data = "tablo=" + tablo;
                //data += "&id=" + id;
                //data = encodeURI(data);
                //$("#koftiden").loadWebMethod({ url: "", data: data }, function () {
                //    mesaj_ver("", mesaj, "success");
                //    if ($.isFunction(fonksiyon)) {
                //        fonksiyon(kod);
                //    }
                //});
                if (durum === "servis") {

                    $("#siparisformu").attr("siparisdurumu", "var");
                    if ($("#siparisformu").attr("siparisparcaid") != "") {
                        $("#siparisformu").attr("siparisparcaid", $("#siparisformu").attr("siparisparcaid") + "," + ParcaId);
                        $("#siparisformu").attr("siparisadet", $("#siparisformu").attr("siparisadet") + "," + $("#musteriparcaadeti").val());
                    }
                    else { $("#siparisformu").attr("siparisparcaid", ParcaId); $("#siparisformu").attr("siparisadet", $("#musteriparcaadeti").val()); }

                    if ($("#parcalarId").val() !== null) {
                        $("#parcalarId").val($("#parcalarId").val() + "," + ParcaId);
                        $("#parcalarId").attr("adet", $("#parcalarId").attr("adet") + "," + $("#musteriparcaadeti").val());
                    }
                    else { $("#parcalarId").val(parcaListesi); }

                    var v = 1;
                    $("#stoklist").append("<tr id='" + ParcaId + "'> <td>" + parcaKod + " " + parcaMakra + "</td>" + "<td>" + $("#musteriparcaadeti").val() + "</td>" + "<td style='width:170px'>" + "<span class='label label-success' style='font-size: 100%; padding: 5px; display: inline;'> " + adet + " Adet Sipariş Verildi</span>" + "</td>" + "<td>" + parcaAciklama + "<td>" + "<button class='btn btn-danger btn-mini' onclick='ParcaSil(" + ParcaId + ", " + v + ");'>Sil</button>" + "</td> </tr>");

                    //<span class="label label-warning" style="font-size: 100%; padding: 5px; display: inline;">Islem Bekliyor</span>

                }
                if (durum == 1) { is_detay_parca_agaci_sectim(IsID, ParcaId); }
                if (durum == 0) { is_detay_parca_sectim(IsID, ParcaId, adet, toplamAdet); }
                //var data = "islem=is_detay_parca_sectim&islem2=ekle";
                //data += "&IsID=" + IsID;
                //data += "&ParcaId=" + ParcaId;
                //data += "&Adet=" + adet;
                //data = encodeURI(data);
                //$("#kullanilan_parcalar" + IsID).loadHTML({ url: "/ajax_request5/", data: data }, function () {
                //    mesaj_ver("Parçalar / Cihazlar", "Kayıt Başarıyla Eklendi", "success");
                //});
            }
        });

    $("button.confirm").focus();
}

function kayit_sil(tablo, id, baslik, mesaj, fonksiyon, kod) {
    swal({
        title: "Emin misiniz?",
        text: "Bu işlemi geri Alamayacaksınız, Kaydı Silmek İstediğinize Emin misiniz?",
        type: "warning",
        showCancelButton: true,
        confirmButtonClass: "btn-danger",
        cancelButtonText: "Vazgeç",
        confirmButtonText: "Evet, kaydı sil!",
        closeOnConfirm: true,
        closeOnCancel: true
    },
        function (isConfirm) {
            if (isConfirm) {
                var data = "tablo=" + tablo;
                data += "&id=" + id;
                data = encodeURI(data);
                $("#koftiden").loadWebMethod({ url: "/System_Root/ajax/islem1.aspx/KayitSil", data: data }, function () {
                    mesaj_ver(baslik, mesaj, "success");
                    if ($.isFunction(fonksiyon)) {
                        fonksiyon(kod);
                    }
                });
            }
        });
    $("button.confirm").focus();
}

var timeline;
var vis_items;

var start_tarih = new Date(2017, 0, 1, 0, 0, 0, 0);

var vis_options = {
    stack: true,
    tooltip: {
        followMouse: true,
        overflowMethod: 'cap'
    },
    align: 'auto',
    zoomKey: 'ctrlKey',
    orientation: { item: "top", axis: "top" },
    start: start_tarih,
    horizontalScroll: true,
    showTooltips: true,
    tooltipOnItemUpdateTime: true,
    clickToUse: true,
    maxHeight: 400,
    height: 250,
    zoomMin: 1000 * 60 * 60 * 24,
    zoomMax: 1000 * 60 * 60 * 24 * 31 * 3,
    editable: {
        add: false,
        updateTime: true,
        updateGroup: false,
        remove: true
    },
    showCurrentTime: true,
    margin: {
        item: 5,
        axis: 10
    },
    onRemove: function (item, callback) {
        var r = confirm("İş Kaydını İptal Etmek İstediğinize Eminmisiniz?");
        if (r) {
            var data = "IsID=" + item.id;
            $("#koftiden").loadWebMethod({ url: "/System_Root/ajax/islem1.aspx/IsiIptalEt", data: data }, function () {
                //is_listesi();
                $("#" + item.id).remove();
                mesaj_ver("İşler", "Kayıt Başarıyla Güncellendi", "success");
                callback(item);
            });
        } else {
            callback(null);
        }
    }
};

function is_listesi_timeline_calistir(baslangic_tarihi, bitis_tarihi) {
    vis_items = new vis.DataSet();
    var groups = new vis.DataSet([
        { id: 1, content: 'İş Listesi' }
    ]);



    var yukseklik = (groups.length) * 75;
    if (yukseklik < 250) {
        yukseklik = 250;
    }
    if (yukseklik > 400) {
        yukseklik = 400;
    }


    var container = document.getElementById('visualization');

    $("#visualization").attr("baslangic_tarihi", baslangic_tarihi);
    $("#visualization").attr("bitis_tarihi", bitis_tarihi);

    timeline = new vis.Timeline(container, null, vis_options);
    timeline.setOptions({
        start: baslangic_tarihi,
        end: bitis_tarihi,
    });

    timeline.setItems(vis_items);

    $(".visualizationmenu").show();

    $("#zoomIn").on("click", function () {
        timeline.zoomIn(0.2);
    });

    $("#zoomOut").on("click", function () {
        timeline.zoomOut(0.2);
    });

    $("#moveLeft").on("click", function () {
        move(0.2);
    });

    $("#moveRight").on("click", function () {
        move(-0.2);
    });

    $("#toggleRollingMode").on("click", function () {
        timeline.toggleRollingMode();
    });

    $("#toggleZoomMode").on("click", function () {
        var eldeki = $("#toggleZoomMode").val();
        var hedef = 550;
        if (eldeki == 550) {
            hedef = 250;
        }
        if (hedef == 550) {
            timeline.setOptions({ orientation: { axis: "both" } });
            timeline.setOptions({ height: hedef, maxHeight: hedef });
        } else {
            timeline.setOptions({ orientation: { axis: "top" } });
            timeline.setOptions({ height: hedef, maxHeight: hedef });
        }

        $("#toggleZoomMode").val(hedef);
    });






    timeline.on('doubleClick', function (properties) {
        table.search(properties.item).draw();
        $("#" + properties.item).find("td.details-control").click();
        var sayi = 380 + parseInt($("#toggleZoomMode").val());
        $("html,body").stop().animate({ scrollTop: sayi }, 700);
    });

    function move(percentage) {
        var range = timeline.getWindow();
        var interval = range.end - range.start;
        timeline.setWindow({
            start: range.start.valueOf() - interval * percentage,
            end: range.end.valueOf() - interval * percentage
        });
    }
    setTimeout(function () {
        timeline.setOptions({
            locale: "tr"
        });
        timeline.zoomIn(0.8);
    }, 200);


}

function is_listesi_timeline_calistir2(baslangic_tarihi, bitis_tarihi) {

    vis_items = new vis.DataSet();
    $(function () {

        var className = ['primarykutu', 'inversekutu', 'dangerkutu', 'infokutu', 'warningkutu', 'successkutu'];


        var order = 0;
        $("lineer").each(function () {

            var baslangic_tarihi = $(this).attr("baslangic_tarihi");
            var baslangic_saati = $(this).attr("baslangic_saati");
            var bitis_tarihi = $(this).attr("bitis_tarihi");
            var bitis_saati = $(this).attr("bitis_saati");

            var yil = baslangic_tarihi.substr(6, 4);
            var ay = parseInt(baslangic_tarihi.substr(3, 2)) - 1;
            var gun = baslangic_tarihi.substr(0, 2);
            var saat = baslangic_saati.substr(0, 2);
            var dakika = baslangic_saati.substr(3, 2);


            var yil2 = bitis_tarihi.substr(6, 4);
            var ay2 = parseInt(bitis_tarihi.substr(3, 2)) - 1;
            var gun2 = bitis_tarihi.substr(0, 2);
            var saat2 = bitis_saati.substr(0, 2);
            var dakika2 = bitis_saati.substr(3, 2);

            var start = new Date(yil, ay, gun, saat, dakika, 0, 0);
            var end = new Date(yil2, ay2, gun2, saat2, dakika2, 0, 0);


            var title = '<div class="panel panel-danger" style="border-color:#FF5370;">\
                            <div class="panel-heading bg-danger"><div style="font-size:12px;"  class="liner_toltip_baslik"><i style="font-size:12px;" class="fa fa-info-circle"></i> ' + $(this).attr("adi").substring(0, 100) + '...</div>\
                               </div>\
<div class="panel-body" style="padding:10px;">\
<p><table class="linertoltip" style="font-size:12px;">\
<tr>\
<td style="width:100px;"><i class="icofont icofont-hand-right text-danger"></i> Başlangıç</td>\
<td style="width:10px;">:</td>\
<td id="tooltip_baslangic'+ $(this).attr("id") + '">' + baslangic_tarihi + ' ' + baslangic_saati + '</td>\
<td style="padding-left:10px;"><i class="icofont icofont-hand-right text-danger"></i> Bitiş</td>\
<td>:</td>\
<td id="tooltip_bitis'+ $(this).attr("id") + '">' + bitis_tarihi + ' ' + bitis_saati + '</td>\
</tr>\
<tr>\
<td><i class="icofont icofont-hand-right text-danger"></i> Ekleyen</td>\
<td>:</td>\
<td colspan="4">' + $(this).attr("ekleyen") + '</td>\
</tr>\
<tr>\
<td><i class="icofont icofont-hand-right text-danger"></i> Etiketler</td>\
<td>:</td>\
<td colspan="4">' + $(this).attr("etiketler").replace(/\<br>/g, ", ") + '</td>\
</tr>\
</table></p>\
</div>\
<div class="panel-footer text-info">\
<i style="font-size:12px;" class="fa fa-info-circle"></i> İlgili kayda ulaşmak için çift tıklayın...\
</div>\
</div>';



            order++;
            var kutu = className[1];
            if (order % 11 == 0) {
                kutu = className[1];
            }

            if (order % 10 == 0) {
                kutu = className[2];
            }

            if (order % 9 == 0) {
                kutu = className[3];
            }
            if (order % 8 == 0) {
                kutu = className[4];
            }
            if (order % 7 == 0) {
                kutu = className[5];
            }
            if (order % 6 == 0) {
                kutu = className[1];
            }
            if (order % 5 == 0) {
                kutu = className[2];
            }
            if (order % 4 == 0) {
                kutu = className[3];
            }
            if (order % 3 == 0) {
                kutu = className[4];
            }
            if (order % 2 == 0) {
                kutu = className[5];
            }


            if ($(this).attr("renk") == "rgb(231, 76, 60)") {
                kutu = "kuturenk1";
            } else if ($(this).attr("renk") == "rgb(26, 188, 156)") {
                kutu = "kuturenk2";
            } else if ($(this).attr("renk") == "rgb(46, 204, 113)") {
                kutu = "kuturenk3";
            } else if ($(this).attr("renk") == "rgb(52, 152, 219)") {
                kutu = "kuturenk4";
            } else if ($(this).attr("renk") == "rgb(241, 196, 15)") {
                kutu = "kuturenk5";
            } else if ($(this).attr("renk") == "rgb(52, 73, 94)") {
                kutu = "kuturenk6";
            } else {
                kutu = "kuturenk4";
            }

            vis_items.add({
                id: $(this).attr("ID"),
                //group: 1,
                start: start,
                end: end,
                type: 'range',
                content: $(this).attr("adi"),
                title: title,
                editable: true,
                stack: true,
                //stackSubgroups: true,
                className: kutu //  'primarykutu', 'inversekutu', 'dangerkutu', 'infokutu', 'warningkutu', 'successkutu'
            });
        });

        timeline.setItems(vis_items);



        vis_items.on('*', function (event, properties) {
            if ("update" == event) {

                var id = properties.data[0].id;

                if (id != null) {
                    var baslangic = properties.data[0].start;
                    var bitis = properties.data[0].end;

                    baslangic = tarih_saat_formatla(baslangic);
                    bitis = tarih_saat_formatla(bitis);

                    console.log(baslangic);
                    console.log(bitis);


                    $("tr[id=" + id + "]").find(".tablo_baslangic").find("div").html(baslangic.replace(" ", "<br>"));
                    $("tr[id=" + id + "]").find(".tablo_bitis").find("div").html(bitis.replace(" ", "<br>"));

                    var data = "islem=is_listesi_tarih_saat_update";
                    data += "&id=" + id;
                    data += "&baslangic=" + baslangic;
                    data += "&bitis=" + bitis;
                    data = encodeURI(data);
                    $("#koftiden").loadHTML({ url: "/ajax_request2/", data: data }, function () {
                        mesaj_ver("İş Listesi", "Kayıt Başarıyla Güncellendi", "success");
                    });

                }

            }
        });



    });

}


function vis_element_guncelle() {

    if ($("#visualization").length > 0) {

        var sontimelineid = 0;
        $(".guncel_lineer").each(function () {

            vis_items.remove($(this).attr("IDd"));

            var baslangic_tarihi = $(this).attr("baslangic_tarihi");
            var baslangic_saati = $(this).attr("baslangic_saati");
            var bitis_tarihi = $(this).attr("bitis_tarihi");
            var bitis_saati = $(this).attr("bitis_saati");

            var yil = baslangic_tarihi.substr(6, 4);
            var ay = parseInt(baslangic_tarihi.substr(3, 2)) - 1;
            var gun = baslangic_tarihi.substr(0, 2);
            var saat = baslangic_saati.substr(0, 2);
            var dakika = baslangic_saati.substr(3, 2);

            var yil2 = bitis_tarihi.substr(6, 4);
            var ay2 = parseInt(bitis_tarihi.substr(3, 2)) - 1;
            var gun2 = bitis_tarihi.substr(0, 2);
            var saat2 = bitis_saati.substr(0, 2);
            var dakika2 = bitis_saati.substr(3, 2);

            var start = new Date(yil, ay, gun, saat, dakika, 0, 0);
            var end = new Date(yil2, ay2, gun2, saat2, dakika2, 0, 0);



            var title = '<div class="panel panel-danger" style="border-color:#FF5370;">\
                            <div class="panel-heading bg-danger"><div class="liner_toltip_baslik"><i style="font-size:12px;" class="fa fa-info-circle"></i> ' + $(this).attr("adi").substring(0, 100) + '...</div>\
                               </div>\
<div class="panel-body" style="padding:10px;">\
<p><table class="linertoltip">\
<tr>\
<td style="width:100px;"><i class="icofont icofont-hand-right text-danger"></i> Başlangıç</td>\
<td style="width:10px;">:</td>\
<td id="tooltip_baslangic'+ $(this).attr("id") + '">' + baslangic_tarihi + ' ' + baslangic_saati + '</td>\
<td style="padding-left:10px;"><i class="icofont icofont-hand-right text-danger"></i> Bitiş</td>\
<td>:</td>\
<td id="tooltip_bitis'+ $(this).attr("id") + '">' + bitis_tarihi + ' ' + bitis_saati + '</td>\
</tr>\
<tr>\
<td><i class="icofont icofont-hand-right text-danger"></i> Ekleyen</td>\
<td>:</td>\
<td colspan="4">' + $(this).attr("ekleyen") + '</td>\
</tr>\
<tr>\
<td><i class="icofont icofont-hand-right text-danger"></i> Etiketler</td>\
<td>:</td>\
<td colspan="4">' + $(this).attr("etiketler").replace(/\<br>/g, ", ") + '</td>\
</tr>\
</table></p>\
</div>\
<div class="panel-footer text-info">\
<i style="font-size:12px;" class="fa fa-info-circle"></i> İlgili kayda ulaşmak için çift tıklayın...\
</div>\
</div>';

            if ($(this).attr("renk") == "rgb(231, 76, 60)") {
                kutu = "kuturenk1";
            } else if ($(this).attr("renk") == "rgb(26, 188, 156)") {
                kutu = "kuturenk2";
            } else if ($(this).attr("renk") == "rgb(46, 204, 113)") {
                kutu = "kuturenk3";
            } else if ($(this).attr("renk") == "rgb(52, 152, 219)") {
                kutu = "kuturenk4";
            } else if ($(this).attr("renk") == "rgb(241, 196, 15)") {
                kutu = "kuturenk5";
            } else if ($(this).attr("renk") == "rgb(52, 73, 94)") {
                kutu = "kuturenk6";
            } else {
                kutu = "kuturenk4";
            }

            sontimelineid = $(this).attr("IDd");

            vis_items.add({
                id: $(this).attr("IDd"),
                start: start,
                end: end,
                type: 'range',
                content: $(this).attr("adi"),
                title: title,
                editable: true,
                stack: true,
                className: kutu //  'primarykutu', 'inversekutu', 'dangerkutu', 'infokutu', 'warningkutu', 'successkutu'
            });
        });
    }
}

Date.prototype.addDays = function (days) {
    var date = new Date(this.valueOf());
    date.setDate(date.getDate() + days);
    return date;
}




function tarih_saat_formatla(today) {

    var dd = today.getDate();
    var mm = today.getMonth() + 1; //January is 0!

    var yyyy = today.getFullYear();
    var hh = today.getHours();
    var dakika = today.getMinutes();


    if (dd < 10) {
        dd = '0' + dd;
    }
    if (mm < 10) {
        mm = '0' + mm;
    }


    if (hh < 10) {
        hh = '0' + hh;
    }
    if (dakika < 10) {
        dakika = '0' + dakika;
    }

    var today = dd + '.' + mm + '.' + yyyy + ' ' + hh + ':' + dakika;
    return today;

}

function departman_ekle() {

    var departman_adi = $("#departman_adi").val();
    var departman_tipi = $("#departman_tipi").val();
    var selectValue = $(".yetmislik").val();

    var data = "islem=departmanlar&islem2=ekle";
    data += "&departman_adi=" + encodeURIComponent(departman_adi);
    data += "&departman_tipi=" + encodeURIComponent(departman_tipi);
    data += "&ust_id=" + 0;
    data = encodeURI(data);
    //if ($("#departman_ekle_form input:not(input[type=button])").valid("valid")) {
    $("#departman_listesi").loadHTML({ url: "islem1", data: data }, function () {
        datatableyap();

        $(".yetmislik option[value=" + selectValue + "]").attr('selected', 'selected');
        $(".yetmislik").trigger("change");
        mesaj_ver("Departmanlar", "Kayıt Başarıyla Eklendi", "success");
    });
    //}
}



function departman_listesi() {
    var data = "islem=departmanlar";
    data = encodeURI(data);
    $("#departman_listesi").loadHTML({ url: "islem1", data: data }, function () {
        datatableyap();
    });
}



function santiye_durum_duzenle(durum_id) {
    var data = "islem=santiye_durum_duzenle";
    data += "&durum_id=" + durum_id;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "islem1", data: data }, function () {
        sayfa_yuklenince();
    });
}


function santiye_durum_guncelle(durum_id) {
    var durum_adi = $("#ddurum_adi").val();
    var data = "durum_id=" + durum_id;
    data += "&durum_adi=" + encodeURIComponent(durum_adi);
    data = encodeURI(data);
    if ($("#santiye_durum_duzenle_form input:not(input[type=button])").valid("valid")) {
        $("#koftiden").loadWebMethod({ url: "/System_Root/ajax/islem1.aspx/SantiyeDurumGuncelle", data: data }, function () {
            santiye_durum_listesi();
            mesaj_ver("Proje Durumları", "Kayıt Başarıyla Güncellendi", "success");
            $(".close").click();
        });
    }
}



function departman_guncelle(departman_id) {

    var departman_adi = $("#ddepartman_adi").val();
    var departman_tipi = $("#ddepartman_tipi").val();

    var data = "departman_id=" + departman_id;
    data += "&departman_adi=" + encodeURIComponent(departman_adi);
    data += "&departman_tipi=" + encodeURIComponent(departman_tipi);
    data = encodeURI(data);
    if ($("#departman_duzenle_form input:not(input[type=button])").valid("valid")) {
        $("#koftiden").loadWebMethod({ url: "/System_Root/ajax/islem1.aspx/DepartmanGuncelle", data: data }, function () {
            departman_listesi();
            mesaj_ver("Departmanlar", "Kayıt Başarıyla Güncellendi", "success");
            $(".close").click();
        });
    }

}

function ul_secim(deger, nesne) {
    if (nesne.checked) {
        $(nesne).attr("checked", "checked");
        $(".ul" + deger + "_" + $(nesne).attr("kayit_id")).each(function () {
            if ($(this).attr("checked") != "checked") {
                $(this).click();
                $(this).attr("checked", "checked");
            }
        })
    } else {
        $(nesne).removeAttr("checked");
        $(".ul" + deger + "_" + $(nesne).attr("kayit_id")).each(function () {
            if ($(this).attr("checked") == "checked") {
                $(this).click();
                $(this).removeAttr("checked");
            }
        })
    }
}


function gorev_duzenle(gorev_id) {
    var data = "islem=gorev_duzenle";
    data += "&gorev_id=" + gorev_id;
    data = encodeURI(data);
    $("#modal_butonum3").click();
    $("#modal_div3").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        sayfa_yuklenince();
    });
}


function bildirimleri_getir(nesne) {
    var data = "islem=bildirimleri_getir";
    $("#bildirim_listesi").loadHTML({ url: "/ajax_bildirim/", data: data, loading: false }, function () {
        $(nesne).find(".show-notification").slideToggle(500);
        $(nesne).toggleClass('active');
    });
}
var bildirim_cek;
var birkere = false;

function bildirimleri_almaya_basla() {

    if (birkere == false) {
        birkere = true;
        birkere_calistir();
    }

    clearTimeout(bildirim_cek);

    $.ajax({
        url: "/ajax_bildirim/", success: function (result) {
            $("#koftiden").html(result);
        }
    });
    bildirim_cek = setTimeout(function () {
        bildirimleri_almaya_basla();
    }, 5000);
}

function birkere_calistir() {

    var data = "islem=temaal";
    data = encodeURI(data);
    $("#koftiden").loadHTML({ url: "/ajax_request3/", data: data }, function () { });

    $(window).blur(function () {
        clearTimeout(bildirim_cek);
    });
    $(window).focus(function () {
        bildirimleri_almaya_basla();
    });
}

function bildirim_kontrol(id, user_id) {
    var data = {
        id: id,
        user_id: user_id
    };

    $.ajax({
        type: 'POST',
        contentType: 'application/json; charset=utf-8',
        url: "/system_root/ajax/islem1.aspx/bildirim_kontrol",
        data: JSON.stringify(data),
        datatype: 'json',
        error: function (xhr) { },
        success: function (data) { }
    });
}

function tum_bildirimler_okundu(user_id) {
    var r = confirm("Tüm Bildirimleri Okundu Olarak işaretlemek istiyormusunuz. ?");
    if (r) {
        var data = {
            user_id: user_id
        };

        $.ajax({
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            url: "/system_root/ajax/islem1.aspx/tum_bildirimler_okundu",
            data: JSON.stringify(data),
            datatype: 'json',
            error: function (xhr) { },
            success: function (data) { }
        });
    }
}

function gorev_guncelle(gorev_id) {

    var yetkili_sayfalar = "";
    var ustId = "";
    var yetki = "";
    var _yetki = "";
    $(".checksecim").each(function () {
        if (yetkili_sayfalar === "") yetkili_sayfalar = $(this).attr("kayit_id");
        else yetkili_sayfalar += "," + $(this).attr("kayit_id");

        if (ustId === "") ustId = $(this).attr("ust-id");
        else ustId += "," + $(this).attr("ust-id");

        if (_yetki === "") _yetki = $(this).attr("yetki");
        else _yetki += "," + $(this).attr("yetki");

        if ($(this).is(":checked")) {
            if (yetki === "") { yetki = "1"; }
            else { yetki += "," + "1"; }
        }
        else {
            if (yetki === "") { yetki = "0"; }
            else { yetki += "," + "0"; }
        }
    });

    var gorev_adi = $("#dgorev_adi").val();
    var data = "gorev_id=" + gorev_id;
    data += "&gorev_adi=" + encodeURIComponent(gorev_adi);
    data += "&yetkili_sayfalar=" + yetkili_sayfalar;
    data += "&ustId=" + ustId;
    data += "&yetki=" + yetki;
    data += "&_yetki=" + _yetki;
    data = encodeURI(data);
    if ($("#gorev_duzenle_form input:not(input[type=button])").valid("valid")) {
        $("#koftiden").loadWebMethod({ url: "/System_Root/ajax/islem1.aspx/GorevGuncelle", data: data }, function () {
            gorev_listesi();
            mesaj_ver("Görevler", "Kayıt Başarıyla Güncellendi", "success");
            $(".close").click();
        });
    }
}


function gorev_ekle() {

    var gorev_adi = $("#gorev_adi").val();
    var selectValue = $(".yetmislik").val();

    var data = "islem=gorevler&islem2=ekle";
    data += "&gorev_adi=" + encodeURIComponent(gorev_adi);
    data = encodeURI(data);
    if ($("#gorev_ekle_form input:not(input[type=button])").valid("valid")) {
        $("#gorev_listesi").loadHTML({ url: "islem1", data: data }, function () {
            datatableyap();

            $(".yetmislik option[value=" + selectValue + "]").attr('selected', 'selected');
            $(".yetmislik").trigger("change");

            mesaj_ver("Görevler", "Kayıt Başarıyla Eklendi", "success");
        });
    }
}

function gorev_listesi() {
    var data = "islem=gorevler";
    data = encodeURI(data);
    $("#gorev_listesi").loadHTML({ url: "islem1", data: data }, function () {
        datatableyap();
    });
}




function taseron_listesi() {
    var data = "islem=taseron_listesi";
    data = encodeURI(data);
    $("#taseron_listesi").loadHTML({ url: "/ajax_request/", data: data }, function () {
        datatableyap();
    });
}

function personel_listesi(ustId) {
    var data = "islem=personeller";
    data += "&ustId=" + ustId;
    data = encodeURI(data);
    $("#personel_listesi").loadHTML({ url: "islem1", data: data }, function () {
        datatableyap();
    });
}



function personel_ekle() {

    var personel_resim = $("#personel_resim").attr("filePath");
    var personel_ad = $("#personel_ad").val();
    var personel_soyad = $("#personel_soyad").val();
    var personel_dtarih = $("#personel_dtarih").val();
    var personel_cinsiyet = $("#personel_cinsiyet").val();
    var personel_eposta = $("#personel_eposta").val();
    var personel_telefon = $("#personel_telefon").val();
    var departmanlar = $("#departmanlar").val();
    var gorevler = $("#gorevler").val();
    var personel_parola = $("#personel_parola").val();
    var personel_tcno = $("#personel_tcno").val();
    var selectValue = $(".yetmislik").val();

    var data = "islem=personeller&islem2=ekle";
    data += "&personel_resim=" + encodeURIComponent(personel_resim);
    data += "&personel_ad=" + encodeURIComponent(personel_ad);
    data += "&personel_soyad=" + encodeURIComponent(personel_soyad);
    data += "&personel_dtarih=" + encodeURIComponent(personel_dtarih);
    data += "&personel_cinsiyet=" + encodeURIComponent(personel_cinsiyet);
    data += "&personel_eposta=" + personel_eposta;
    data += "&personel_telefon=" + encodeURIComponent(personel_telefon);
    data += "&departmanlar=" + encodeURIComponent(departmanlar);
    data += "&gorevler=" + encodeURIComponent(gorevler);
    data += "&personel_parola=" + encodeURIComponent(personel_parola);
    data += "&personel_tcno=" + encodeURIComponent(personel_tcno);
    data += "&today=" + new Date().toLocaleDateString();
    data = encodeURI(data);

    if ($("#personel_ekle_form  input:not(input[type=button])").valid("valid")) {
        $("#koftiden").loadHTML({ url: "/ajax_request6/", data: data }, function () {
            if ($("#koftiden").html() === "ok") {
                $("#personel_listesi").loadHTML({ url: "islem1", data: data }, function () {
                    datatableyap();
                    mesaj_ver("Personeller", "Kayıt Başarıyla Eklendi", "success");

                    $(".yetmislik option[value=" + selectValue + "]").attr('selected', 'selected');
                    $(".yetmislik").trigger("change");
                });
            } else {
                mesaj_ver("Personeller", "Girdiğiniz Bilgilerle daha önce personel tanımlanmış. Lütfen Kontrol Ediniz.", "danger");
            }
        });



    }
}

function departman_degistim_sayac_getir() {

    var departman_id = $("#sayac_departman").val();
    var tip = $("#sayac_departman option:selected").attr("tip");

    var data = "islem=departman_degistim_sayac_getir";
    data += "&departman_id=" + departman_id.replace(tip, "");
    data += "&tip=" + tip;
    data = encodeURI(data);

    if (departman_id != "0") {
        $("#departman_donus_yeri").loadHTML({ url: "islem1", data: data, loading: false }, function () {
            $(".ustunegelince").hover(function () {
                $(this).addClass("ustunegelince2");
            }, function () {
                $(this).removeClass("ustunegelince2");
            })
        });
    } else {
        $(".ustunegelince").hover(function () {
            $(this).addClass("ustunegelince2");
        }, function () {
            $(this).removeClass("ustunegelince2");
        })
    }

}







function stringifyObject(object) {
    if (!object) return;
    var replacer = function (key, value) {
        if (value && value.tagName) {
            return "DOM Element";
        } else {
            return value;
        }
    }
    return JSON.stringify(object, replacer)
}


var slider_timer;
var table;

function is_tablo_islemler(durum) {

    //  $(".once_kapali").show();


    if ($("#is_listesi").length > 0) {

        var eldeki_sayi = $("body").width() - ($(".card").width() + ($("#tablo_customize").val().length * 107) + 300);
        if (eldeki_sayi < 200) {
            eldeki_sayi = 200;
        }
        if ($("body").width() < 500) {
            $(".tablo_is_adi").css("width", "150px");
        } else {
            $(".tablo_is_adi").css("width", eldeki_sayi);
        }
    }
    else {

        if ($(window).width() <= 500) {
            //console.log("if'e girdi");
            $(".tablo_is_adi").css("width", "150px");
            //console.log("div genişliği : " + $(".tablo_is_adi").width());
        }
        else {
            //console.log("else girdi");
            //console.log($("#tablo_customize").val());
            var eldeki_sayi1 = $("body").width() - ($(".card").width() + ($("#tablo_customize").val().length * 107) + 600);
            if (eldeki_sayi1 < 200) {
                eldeki_sayi1 = 200;
            }
            $(".tablo_is_adi").css("width", eldeki_sayi1);
        }
    }

    $('#tablo_customize').change(function () {

        var is_tablo_gorunum = JSON.stringify($(this).multipleSelect('getSelects'));

        var data = "islem=tablo_customize";
        data += "&is_tablo_gorunum=" + encodeURIComponent(is_tablo_gorunum);
        data = encodeURI(data);
        $("#koftiden").html($("#yeni_style_yeri").html());
        $("#yeni_style_yeri").loadHTML({ url: "islem1", data: data }, function () {
            $("#koftiden").html("");
        });

    }).multipleSelect({
        width: '100%'
    });


    function format(d) {
        // `d` is the original data object for the row
        /*
        return '<div class="col-sm-12 col-md-6 col-lg-4"><br><table cellpadding="5" cellspacing="0" border="0" class="table table-hover table-condensed">' +
            '<tr>' +
            '<td style="width:100px">Yapılacak İş:</td>' +
            '<td>' + d.name + '</td>' +
            '</tr>' +
            '<tr>' +
            '<td>Kalan Zaman:</td>' +
            '<td>' + d.ends + '</td>' +
            '</tr>' +
            '<tr>' +
            '<td>Açıklama:</td>' +
            '<td>And any further details here (images etc)...</td>' +
            '</tr>' +
            '<tr>' +
            '<td>Görevliler:</td>' +
            '<td>' + d.comments + '</td>' +
            '</tr>' +
            '<tr>' +
            '<td>Son İşlem:</td>' +
            '<td>' + d.action + '</td>' +
            '</tr>' +
            '</table></div><div class="col-sm-12 col-md-6 col-lg-8"><br>İşin Tamamlanma Durumu : <input type="text" class="slider slider-primary" id="g1" value=""  data-slider-max="100" data-slider-value="50" data-slider-selection="before" data-slider-handle="round" ><br><div class="widget-body"><div class="tabs-top"><ul class="nav nav-tabs " id="demo-pill-nav" ><li class="active"><a href="#tab-r1" data-toggle="tab">Notlar</a></li><li><a href="#tab-r2" data-toggle="tab">Eklentiler</a></li><li><a href="#tab-r3" data-toggle="tab">Bildirimler</a></li></ul ><div class="tab-content padding-10" style="background-color:white;"><div class="tab-pane active" id="tab-r1">asdasd</div><div class="tab-pane " id="tab-r2">Dosya Yükleme</div><div class="tab-pane " id="tab-r3">Sms Bildirim<br>Mail Bildirim</div></div></div></div></div>';
        */

        return '<div id="detay_row' + d + '" class="detay_row" style="background-color:#fff!important; display:flow-root; padding:10px;"></div>';
    }

    // clears the variable if left blank

    var toplam = 0;
    $(".birimler").keyup(function () {
        $(".birimler").each(function () {
            toplam += parseFloat($(this).val());
        });
    });




    $(".lineer_yeni").each(function () {
        $("#lineer_kopyalanan").append($(this).html());
        $(this).remove();
    });


    if ($("#is_listesi").length > 0) {

        if ($("#is_kayit_yok").attr("varmi") != "yok") {
            table = $('#example').DataTable({
                "ordering": true,
                "bDestroy": true,
                "responsive": true,
                "lengthMenu": [[10, 25, 50], [10, 25, 50]],
                "pageLength": parseInt($("#tablo_customize").attr("is_tablo_sayi")),
                "fnDrawCallback": function (oSettings) {
                    runAllCharts()
                },
                "sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6'f><'col-sm-6 col-xs-12 hidden-xs'l>r>" +
                    "t" +
                    "<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
                "autoWidth": true,
                /*
                "preDrawCallback": function () {
    
                    var table = $(this);
                    if (!responsiveHelper_dt_basic) {
                        responsiveHelper_dt_basic = new ResponsiveDatatablesHelper(table, breakpointDefinition);
                    }
    
                },
                "rowCallback": function (nRow) {
                    responsiveHelper_dt_basic.createExpandIcon(nRow);
                },
                "drawCallback": function (oSettings) {
                    responsiveHelper_dt_basic.respond();
                }*/
            });
        }

    }
    else {
        var reg = /(<([^>]+)>)/ig;
        var iii = 0;

        if ($("#is_kayit_yok").attr("varmi") != "yok") {
            table = $('#example').DataTable({
                "ordering": true,
                "autoWidth": false,
                "bSortCellsTop": true,
                "bVisible": false,
                "responsive": false,
                "lengthMenu": [[10, 25, 50], [10, 25, 50]],
                initComplete: function () {

                    this.api().columns().every(function () {
                        iii++;
                        if (iii > 2) {
                            var column = this;
                            //var select = $('<select class="filtre_secimleri"><option tumu="true" selected value="">TÜMÜ</option></select>')
                            var select = $('<select class="filtre_secimleri"><option tumu="true" selected value="">TÜMÜ</option></select>')
                                .appendTo($(column.header()).empty())


                            column.data().unique().sort().each(function (d, j) {
                                if ($("<div>" + d + "</div>").find(".hiddenspan").length > 0) {
                                    $("<div>" + d + "</div>").find(".hiddenspan").each(function () {
                                        var varmi = false;
                                        var optionname = $(this).html();
                                        $(select).find("option").each(function () {
                                            if ($(this).html() == optionname) {
                                                varmi = true;
                                            }
                                        });
                                        if (!varmi) {
                                            select.append('<option value="' + $(this).html() + '">' + $(this).html() + '</option>')
                                        }
                                    });
                                }
                            });


                            select.change(function () {
                                var girdimi = 0;
                                var aranacaklar = "";
                                var deger = $(this).multipleSelect('getSelects');

                                /*
                                if (deger.length < 2) {
                                    if (deger.length==1) {
                                        //$(this).multipleSelect('setSelects', [deger]);
                                    } else {
                                        $(this).multipleSelect('setSelects', [""]);
                                    }
                                } else if (deger.length == 2) {

                                    var array = deger;
                                    var index = array.indexOf("");
                                    if (index > -1) {
                                        array.splice(index, 1);
                                    }
                                    $(this).multipleSelect('setSelects', array);
                                }*/



                                var kelime;
                                for (var i = 0; i < deger.length; i++) {
                                    var val = $.fn.dataTable.util.escapeRegex(
                                        deger[i]
                                    );

                                    var kelime = val.trim();
                                    kelime = kelime.replace("\\", "").replace("\\", "").replace("\\", "").replace("\\", "").replace("\\", "");
                                    aranacaklar += kelime.replace("(", "").replace(")", "") + "~"

                                    girdimi = 1;
                                }

                                aranacaklar = aranacaklar.substr(0, aranacaklar.length - 1);
                                if (girdimi == 1) {
                                    var keywords = aranacaklar.split('~'), filter = '';
                                    for (var i = 0; i < keywords.length; i++) {
                                        filter = (filter !== '') ? filter + '.*' + keywords[i] : keywords[i];
                                    }
                                    column.search(filter, true, false, false).draw();
                                }

                            }).multipleSelect({
                                width: '100%',
                                selectAll: false,
                                filter: true
                            });



                        }
                    });
                    $("#" + durum + "_isler_loading").hide();
                    $("#" + durum + "_isler").show();
                },



                "bDestroy": true,
                "pageLength": parseInt($("#tablo_customize").attr("is_tablo_sayi")),
                "fnDrawCallback": function (oSettings) {
                    runAllCharts()
                },



                "sDom": "<'dt-toolbar'<'col-sm-6 col-xs-12 hidden-xs'l><'col-xs-12 col-sm-6'f>r>" +
                    "t" +
                    "<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
                "autoWidth": true,
                /*
                "preDrawCallback": function () {
    
                    var table = $(this);
                    if (!responsiveHelper_dt_basic) {
                        responsiveHelper_dt_basic = new ResponsiveDatatablesHelper(table, breakpointDefinition);
                    }
    
                },
                
                "rowCallback": function (nRow) {
                    responsiveHelper_dt_basic.createExpandIcon(nRow);
                },
                */
                "drawCallback": function (oSettings) {
                    $("#" + durum + "_isler_loading").hide();
                    $("#" + durum + "_isler").show();
                    //responsiveHelper_dt_basic.respond();
                }


            });


        }
    }

    $("#" + durum + "_isler_loading").hide();
    $("#" + durum + "_isler").show();



    // Add event listener for opening and closing details

    if ($("#is_kayit_yok").attr("varmi") != "yok") {
        $('#example tbody').on('click', 'td.details-control, .details-control-tr td', function () {

            $(".details-control-tr").removeClass("shown");

            var tr = $(this).closest('tr');
            var row = table.row(tr);

            if (row.child.isShown()) {
                // This row is already open - close it
                table.search('').draw();
                row.child.hide();
                tr.removeClass('shown');
            }
            else {
                // Open this row

                $(".detay_row").hide();
                $(".detay_row").each(function () {
                    $(this).parent().parent().remove();
                    $(this).parent().remove();
                    $(this).remove();
                })
                $(".detay_row").remove();
                row.child(format($(tr).attr("id"))).show();
                tr.addClass('shown');
                var data = "islem=is_detay_goster";
                data += "&is_id=" + $(tr).attr("id");
                data = encodeURI(data);
                $("#detay_row" + $(tr).attr("id")).loadHTML({ url: "/ajax_request5/", data: data }, function () {
                    /*  if ($("#visualization").length>0) {
                          timeline.setSelection([$(tr).attr("id")], {
                              focus: true
                          });
                      }*/


                    $(".easyPieChartlar").knob({
                        draw: function () {
                            // "tron" case
                            if (this.$.data('skin') == 'tron') {
                                this.cursorExt = 0.3;
                                var a = this.arc(this.cv) // Arc
                                    ,
                                    pa // Previous arc
                                    , r = 1;
                                this.g.lineWidth = this.lineWidth;
                                if (this.o.displayPrevious) {
                                    pa = this.arc(this.v);
                                    this.g.beginPath();
                                    this.g.strokeStyle = this.pColor;
                                    this.g.arc(this.xy, this.xy, this.radius - this.lineWidth, pa.s, pa.e, pa.d);
                                    this.g.stroke();
                                }
                                this.g.beginPath();
                                this.g.strokeStyle = r ? this.o.fgColor : this.fgColor;
                                this.g.arc(this.xy, this.xy, this.radius - this.lineWidth, a.s, a.e, a.d);
                                this.g.stroke();
                                this.g.lineWidth = 2;
                                this.g.beginPath();
                                this.g.strokeStyle = this.o.fgColor;
                                this.g.arc(this.xy, this.xy, this.radius - this.lineWidth + 1 + this.lineWidth * 2 / 3, 0, 2 * Math.PI, false);
                                this.g.stroke();
                                return false;
                            }
                        }
                    });
                    is_timer_start_kaydi_getir($(tr).attr("id"));

                    $('.pauseButton').hide();
                    $('.stopButton').hide();

                    timer = new easytimer.Timer();

                    var Id;

                    $('.startButton').click(function () {
                        $(this).hide();
                        $('.pauseButton').show();
                        $('.stopButton').show();
                        timer.start();
                        var is_id = $(this).attr("is_id");
                        var TamamlanmaID = $(this).attr("tamamlanmaid");
                        is_timer_start_kaydi(is_id, TamamlanmaID, timer.getTimeValues());
                        Id = $(this).attr("user_id");
                    });
                    $('.pauseButton').click(function () {
                        $(this).hide();
                        $('.startButton').show();
                        var baslik = $(this).attr("baslik");
                        var aciklama = $(this).attr("aciklama");
                        var is_id = $(this).attr("is_id");
                        var TamamlanmaID = $(this).attr("tamamlanmaid");
                        timer.pause();
                        is_timer_pause_kaydi(is_id, TamamlanmaID, timer.getTimeValues(), baslik, aciklama);
                        Id = $(this).attr("user_id");
                    });
                    $('.stopButton').click(function () {
                        var r = confirm("Kaydı tamamlamak istiyormusunuz. ?");
                        if (r) {
                            timer.stop();
                            var is_id = $(this).attr("is_id");
                            var TamamlanmaID = $(this).attr("tamamlanmaid");
                            var baslik = $('.pauseButton').attr("baslik");
                            var aciklama = $('.pauseButton').attr("aciklama");
                            is_timer_stop_kaydi(is_id, TamamlanmaID, timer.getTimeValues(), baslik, aciklama);
                            Id = $(this).attr("user_id");
                        }
                    });

                    timer.addEventListener('secondsUpdated', function (e) {
                        $('#basicUsage').html(timer.getTimeValues().toString());
                    });
                    timer.addEventListener('started', function (e) {
                        $('#basicUsage').html(timer.getTimeValues().toString());
                    });


                    $(".yeni_slider").each(function () {

                        var $slider = $(this);
                        var olcu = $(this).width();

                        $(this).noUiSlider({
                            range: [0, 100],
                            start: $(this).attr("start"),
                            handles: 1,
                            connect: true,
                            slide: function () {

                                var asd = $(this);

                                clearTimeout(slider_timer);
                                slider_timer = setTimeout(function () {

                                    var oran = parseInt(asd.find(".noUi-connect").css("left"));
                                    oran = Math.round(100 - ((olcu - oran) / olcu * 100));
                                    var newVal = oran;

                                    if (parseFloat(newVal) > 97) {
                                        newVal = 100;
                                    }

                                    var onceki_oran = $("#easyPieChart" + $slider.attr("TamamlanmaID")).val();

                                    $("#easyPieChart" + $slider.attr("TamamlanmaID")).val(newVal);



                                    $("#easyPieChart" + $slider.attr("TamamlanmaID")).knob({
                                        draw: function () {
                                            // "tron" case
                                            if (this.$.data('skin') == 'tron') {
                                                this.cursorExt = 0.3;
                                                var a = this.arc(this.cv) // Arc
                                                    ,
                                                    pa // Previous arc
                                                    , r = 1;
                                                this.g.lineWidth = this.lineWidth;
                                                if (this.o.displayPrevious) {
                                                    pa = this.arc(this.v);
                                                    this.g.beginPath();
                                                    this.g.strokeStyle = this.pColor;
                                                    this.g.arc(this.xy, this.xy, this.radius - this.lineWidth, pa.s, pa.e, pa.d);
                                                    this.g.stroke();
                                                }
                                                this.g.beginPath();
                                                this.g.strokeStyle = r ? this.o.fgColor : this.fgColor;
                                                this.g.arc(this.xy, this.xy, this.radius - this.lineWidth, a.s, a.e, a.d);
                                                this.g.stroke();
                                                this.g.lineWidth = 2;
                                                this.g.beginPath();
                                                this.g.strokeStyle = this.o.fgColor;
                                                this.g.arc(this.xy, this.xy, this.radius - this.lineWidth + 1 + this.lineWidth * 2 / 3, 0, 2 * Math.PI, false);
                                                this.g.stroke();
                                                return false;
                                            }
                                        }
                                    });


                                    /*
                                     * 
                                    var data = "TamamlanmaID=" + $slider.attr("TamamlanmaID");
                                    data += "&tamamlanma_orani=" + newVal;
                                    data += "&IsID=" + $slider.attr("IsID");
                                    var IsID = $slider.attr("IsID");
                                    $.ajax({
                                        type: "POST",
                                        url: "/System_Root/ajax/islem1.aspx/IsDurumGuncelle",
                                        data: JSON.stringify(QueryStringToJSON(data)),
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        success: function (response) {
                                            if (response.d == "0") {
                                                $.bigBox({
                                                    title: "Uyarı",
                                                    content: "Hata Oluştu",
                                                    color: "#C46A69",
                                                    icon: "fa fa-warning shake animated",
                                                    number: "1",
                                                    timeout: 6000
                                                });
                                            } else {
                                                $("#is_chart" + IsID).css('width', response.d + '%').attr('aria-valuenow', response.d).attr("data-progressbar-value", response.d);
                                                mesaj_ver("Görevler", "Kayıt Başarıyla Güncellendi", "success");
                                            }
                                        }, failure: function (response) {

                                            $.bigBox({
                                                title: "Uyarı",
                                                content: "Hata Oluştu",
                                                color: "#C46A69",
                                                icon: "fa fa-warning shake animated",
                                                number: "1",
                                                timeout: 6000
                                            });
                                        }
                                    });

                                    */

                                    is_ilerleme_ajanda_senkronizasyon($slider.attr("TamamlanmaID"), newVal, $slider.attr("IsID"), onceki_oran);
                                }, 300);
                            }
                        });
                    });

                    fileyap();

                    setTimeout(function () {
                        $(".file").attr("placeholder", "Yeni Dosya Yükle").css("height", "25px").css("margin-top", "5px;");
                    }, 1000);
                });
            }
        });
    }
    /*
    setTimeout(function () {
        $("select[name=example_length]").val(100).change();
    }, 500);*/


    setTimeout(function () {
        if ($("#is_listesi").length > 0) {
            var eldeki_sayi = $("body").width() - ($(".card").width() + ($("#tablo_customize").val().length * 107) + 300);
            if (eldeki_sayi < 500) {
                eldeki_sayi = 500;
            }
            if ($(window).width() > 500) {
                $(".tablo_is_adi").css("width", eldeki_sayi);
            } else {
                $(".tablo_is_adi").css("width", 150);
            }

        } else {

            if ($("body").width() < 500) {
                $(".tablo_is_adi").css("width", 150);
            } else {
                var eldeki_sayi = $("body").width() - ($(".card").width() + ($("#tablo_customize").val().length * 107) + 600);
                if (eldeki_sayi < 500) {
                    eldeki_sayi = 500;
                }
                $(".tablo_is_adi").css("width", eldeki_sayi);
            }
        }
    }, 100);


    if ($("#is_kayit_yok").attr("varmi") != "yok") {

        $("#example").resize(function () {
            if (!ilkmi) {
                ilkmi = true;
            } else {
                setTimeout(function () {
                    if ($("#is_listesi").length > 0) {
                        var eldeki_sayi = $("body").width() - ($(".card").width() + ($("#tablo_customize").val().length * 107) + 300);
                        if (eldeki_sayi < 500) {
                            eldeki_sayi = 500;
                        }
                        if ($(window).width() > 500) {
                            $(".tablo_is_adi").css("width", eldeki_sayi);
                        }
                        else {
                            $(".tablo_is_adi").css("width", 150);
                        }
                    } else {

                        if ($("body").width() < 500) {
                            $(".tablo_is_adi").css("width", 150);
                        } else {
                            var eldeki_sayi = $("body").width() - ($(".card").width() + ($("#tablo_customize").val().length * 107) + 600);
                            if (eldeki_sayi < 500) {
                                eldeki_sayi = 500;
                            }
                            if ($(window).width() > 500) {
                                $(".tablo_is_adi").css("width", eldeki_sayi);
                            }
                            else {
                                $(".tablo_is_adi").css("width", 150);
                            }
                        }
                    }
                }, 100);
            }
        });

        $(".sortyeri2").each(function () {
            $(this).click(function () {
                $(".sortyeri2").removeClass("sorting_asc");
                $(this).addClass("sorting_asc");
                $(".sortyeri[sira=" + $(this).attr("sira") + "]").click();
            });
        });

        $(".sortyeri2").removeClass("sorting_asc");

        /*
        $(".sortyeri").each(function () {
            var sira = $(this).attr("sira");
            var temp_deger = $(this).html();
            $(this).html($(".sortyeri2[sira=" + sira + "]").html());
            $(".sortyeri2[sira=" + sira + "]").html(temp_deger);
    
        });*/

        $('#example').on('length.dt', function (e, settings, len) {
            var data = "islem=is_tablo_sayi_guncelle";
            data += "&is_tablo_sayi=" + len;
            data = encodeURI(data);
            $("#koftiden").loadWebMethod({ url: "/System_Root/ajax/islem1.aspx/is_tablo_sayi_guncelle", data: data }, function () {

            });
        })
    } else {
        $(".mobil_hide").hide();
        $("#birnumara").remove();
    }
}

var ilkmi = false;

function is_listesi(durum) {

    if ($("#is_listesi").length > 0) {

        var proje_id = $("#hproje_id").val();
        var departman_id = $("#hdepartman_id").val();
        var tab_id = $("#htab_id").val();

        var data = "islem=is_listesi";
        data += "&durum=";
        data += "&tip=santiye";
        data += "&proje_id=" + proje_id;
        data += "&departman_id=" + departman_id;
        data += "&tab_id=" + tab_id;
        $("#is_listesi").loadHTML({ url: "islem1", data: data }, function () {

            sayfa_yuklenince();
            is_tablo_islemler();
        });


    } else {

        if (durum == undefined) {
            durum = "tum";
        }
        var data = "islem=is_listesi";
        data += "&durum=" + durum;

        $("#tum_isler").html("");
        $("#geciken_isler").html("");
        $("#bekleyen_isler").html("");
        $("#devameden_isler").html("");
        $("#biten_isler").html("");

        $("#" + durum + "_isler").hide();
        $("#" + durum + "_isler_loading").show();

        $("#" + durum + "_isler").loadHTML({ url: "islem1", data: data }, function () {
            sayfa_yuklenince();
            is_tablo_islemler(durum);
        });
    }
}

function AllTask(durum) {

    if (durum == undefined) {
        durum = "tum";
    }
    var data = "islem=AllTask";
    data += "&durum=" + durum;

    $(".tasks").empty();
    $("#" + durum).loadHTML({ url: "islem1", data: data }, function () {
        sayfa_yuklenince();
    });
}









function sirket_sehir_sectim_bolge_getir(sehir_id) {

    var data = "islem=sirket_sehir_sectim_bolge_getir";
    data += "&sehir_id=" + sehir_id;
    data = encodeURI(data);
    $("#ilce_yeri").loadHTML({ url: "/ajax_request/", data: data }, function () {

    });

}


function is_ekle_yeni_takvim_calistir() {


    $("#yeni_is_baslangic_tarihi").datepicker({
        firstDay: 1,
        minDate: 0,
        onSelect: function (dateText, inst) {

            setTimeout(function () {

                var tarih = $("#yeni_is_baslangic_tarihi").datepicker("getDate");
                var eldeki_date = $("#yeni_is_baslangic_tarihi").datepicker("getDate");
                eldeki_date.setDate(eldeki_date.getDate());
                tarih.setDate(tarih.getDate());

                ay = parseFloat(tarih.getMonth()) + 1;
                if (ay < 10) {
                    ay = "0" + ay;
                }

                gun = parseFloat(tarih.getDate());
                if (gun < 10) {
                    gun = "0" + gun;
                }

                var yeni_tarih = gun + "." + ay + "." + tarih.getFullYear();

                $("#yeni_is_bitis_tarihi").val(yeni_tarih);

                $("#yeni_is_bitis_tarihi").datepicker('option', 'minDate', eldeki_date).focus();

                yeni_is_ekle_sure_hesap();

            }, 500);


        }
    }).mask("99.99.9999");

    $("#yeni_is_bitis_tarihi").datepicker({
        firstDay: 1,
        minDate: 0,
        disableTouchKeyboard: true,
        onSelect: function (dateText, inst) {

            yeni_is_ekle_sure_hesap();
            IzinliPersonelKontrol();


        }
    }).mask("99.99.9999");
}

function IzinliPersonelKontrol() {
    var pathname = window.location.origin;
    var yeni_is_bitis_tarihi = $("#yeni_is_bitis_tarihi").val();
    var yeni_is_baslangic_tarihi = $("#yeni_is_baslangic_tarihi").val();
    console.log(yeni_is_bitis_tarihi + " " + yeni_is_baslangic_tarihi);
    var data = "islem=personel_izin_kontrol";
    data += "&yeni_is_baslangic_tarihi=" + yeni_is_baslangic_tarihi;
    data += "&yeni_is_bitis_tarihi=" + yeni_is_bitis_tarihi;


    //$.post('system_root/ajax/islem1.aspx/personel_izin_kontrol',{ baslangicTarihi: '27-10-2019', bitisTarihi: '30-10-2019' },
    //    function (returnedData) {
    //        console.log(returnedData);
    //    });

    $.ajax({
        type: 'POST',
        contentType: 'application/json; charset=utf-8',
        url: pathname + "/system_root/ajax/islem1.aspx/personel_izin_kontrol",
        data: JSON.stringify({
            baslangicTarihi: yeni_is_baslangic_tarihi,
            bitisTarihi: yeni_is_bitis_tarihi
        }),
        datatype: 'JSON',
        error: function (xhr) {
            console.log(xhr);
        },
        success: function (data) {

            var asd = jQuery.parseJSON(data.d);
            var personelID = [];
            $(asd).each(function (i, val) {
                $.each(val, function (k, v) {
                    personelID.push(v);
                });
            });
            //console.log(personelID);

            for (var i = 0; i < personelID.length; i++) {
                $("#yeni_is_gorevliler option[value=" + personelID[i] + "]").remove();
            }

        }
    });
}

function dis_ekle_yeni_takvim_calistir() {

    setTimeout(function () {

        $("#dyeni_is_baslangic_tarihi").datepicker({
            firstDay: 1,
            minDate: 0,
            onSelect: function (dateText, inst) {

                setTimeout(function () {

                    var tarih = $("#dyeni_is_baslangic_tarihi").datepicker("getDate");
                    var eldeki_date = $("#dyeni_is_baslangic_tarihi").datepicker("getDate");
                    eldeki_date.setDate(eldeki_date.getDate());
                    tarih.setDate(tarih.getDate());

                    ay = parseFloat(tarih.getMonth()) + 1;
                    if (ay < 10) {
                        ay = "0" + ay;
                    }

                    gun = parseFloat(tarih.getDate());
                    if (gun < 10) {
                        gun = "0" + gun;
                    }

                    var yeni_tarih = gun + "." + ay + "." + tarih.getFullYear();

                    $("#dyeni_is_bitis_tarihi").val(yeni_tarih);

                    $("#dyeni_is_bitis_tarihi").datepicker('option', 'minDate', eldeki_date).focus();

                    dyeni_is_ekle_sure_hesap();

                }, 500);
            }
        }).mask("99.99.9999");

        $("#dyeni_is_bitis_tarihi").datepicker({
            firstDay: 1,
            minDate: 0,
            disableTouchKeyboard: true,
            onSelect: function (dateText, inst) {
                dyeni_is_ekle_sure_hesap();
            }
        }).mask("99.99.9999");
    }, 500);
}


function diff(start, end) {
    start = start.split(":");
    end = end.split(":");
    var startDate = new Date(0, 0, 0, start[0], start[1], 0);
    var endDate = new Date(0, 0, 0, end[0], end[1], 0);
    var diff = endDate.getTime() - startDate.getTime();
    var hours = Math.floor(diff / 1000 / 60 / 60);
    diff -= hours * 1000 * 60 * 60;
    var minutes = Math.floor(diff / 1000 / 60);

    return (hours < 10 ? "0" : "") + hours + ":" + (minutes < 9 ? "0" : "") + minutes;
}

var sure;

function yeni_is_ekle_sure_hesap() {

    var tarih2 = $("#yeni_is_bitis_tarihi").val();
    var tarih = $("#yeni_is_baslangic_tarihi").val();
    console.log(Date.gunfark(tarih2, tarih) + 1);

    clearTimeout(sure);
    sure = setTimeout(function () {
        //var tarih2 = $("#yeni_is_bitis_tarihi").val();
        //var tarih = $("#yeni_is_baslangic_tarihi").val();
        if (tarih2.length == 10 && tarih.length == 10) {
            var fark = Date.gunfark(tarih2, tarih) + 1;
            var yeni_is_gunluk_ortalama_calisma = $("#yeni_is_gunluk_ortalama_calisma").val();
            yeni_is_gunluk_ortalama_calisma = yeni_is_gunluk_ortalama_calisma.replace(",", ".");
            if (IsNumeric(fark)) {
                if (IsNumeric(yeni_is_gunluk_ortalama_calisma)) {

                    $("#gunluk_gun_hesap_yeri").html(fark + " gün");

                    var gun_sayisi = fark;
                    var toplam_saat = parseFloat(yeni_is_gunluk_ortalama_calisma) * parseFloat(gun_sayisi);
                    if (toplam_saat === isNaN) {
                        toplam_saat = 0;
                    }

                    toplam_saat = parseFloat(Math.round(toplam_saat * 100) / 100).toFixed(2);
                    $("#yeni_is_toplam_calisma").val(toplam_saat);

                    if (parseInt(fark) == 1) {

                        if ($("#yeni_is_baslangic_saati").val().length == 5 && $("#yeni_is_bitis_saati").val().length == 5) {

                            if (diff($("#yeni_is_baslangic_saati").val(), $("#yeni_is_bitis_saati").val()).length == 5) {

                                var saat = diff($("#yeni_is_baslangic_saati").val(), $("#yeni_is_bitis_saati").val()).split(":")[0];
                                var dakika = diff($("#yeni_is_baslangic_saati").val(), $("#yeni_is_bitis_saati").val()).split(":")[1];

                                var oran = parseFloat(parseFloat(dakika) / 60);
                                var birkere = false;
                                if (parseFloat(parseFloat(saat) + parseFloat(oran)).toFixed(2) !== $("#yeni_is_gunluk_ortalama_calisma").val()) {
                                    birkere = true;
                                }
                                $("#yeni_is_gunluk_ortalama_calisma").val(parseFloat(parseFloat(saat) + parseFloat(oran)).toFixed(2));
                                if (birkere === true) {
                                    yeni_is_ekle_sure_hesap();
                                }
                            }
                        }
                    }
                }
            }
        }
    }, 500);

    //DateDiffFunc();
}

function append(dl, dtTxt, ddTxt) {
    var dt = document.createElement("dt");
    var dd = document.createElement("dd");
    dt.textContent = dtTxt;
    dd.textContent = ddTxt;
    dl.appendChild(dt);
    dl.appendChild(dd);
}

function DateDiffFunc() {

    var date1 = $('#yeni_is_baslangic_tarihi').val();
    var date2 = $('#yeni_is_bitis_tarihi').val();
    var parts1 = date1.split(/[.]/);
    var parts2 = date2.split(/[.]/);
    var wanted1 = parts1[1] + '-' + parts1[0] + '-' + parts1[2];
    var wanted2 = parts2[1] + '-' + parts2[0] + '-' + parts2[2];

    $('#yeni_is_baslangic_tarihi, #yeni_is_bitis_tarihi, #yeni_is_baslangic_saati, #yeni_is_bitis_saati').on('change', function (ev) {

        var today = new Date(wanted1 + " " + $("#yeni_is_baslangic_saati").val());
        var Christmas = new Date(wanted2 + " " + $("#yeni_is_bitis_saati").val());
        var diffMs = (Christmas.getTime() - today.getTime()); // milliseconds between now & Christmas
        var diffMins = Math.floor(diffMs / 60000); // minutes
        var diffHrs = Math.floor(diffMins / 60); // hours

        diffMins = diffMins % 60;
        alert(diffHrs + ":" + diffMins);
    });
}



function duzenle_is_ekle_sure_hesap() {

    clearTimeout(sure);
    sure = setTimeout(function () {
        var tarih2 = $("#dyeni_is_bitis_tarihi").val().replace("-", ".");
        var tarih = $("#dyeni_is_baslangic_tarihi").val().replace("-", ".");
        if (tarih2.length == 10 && tarih.length == 10) {
            var fark = Date.gunfark(tarih2, tarih) + 1;
            var yeni_is_gunluk_ortalama_calisma = $("#dyeni_is_gunluk_ortalama_calisma").val();
            yeni_is_gunluk_ortalama_calisma = yeni_is_gunluk_ortalama_calisma.replace(",", ".");
            if (IsNumeric(fark)) {
                if (IsNumeric(yeni_is_gunluk_ortalama_calisma)) {

                    $("#dgunluk_gun_hesap_yeri").html(fark + " gün");

                    var gun_sayisi = fark;
                    var toplam_saat = parseFloat(yeni_is_gunluk_ortalama_calisma) * parseFloat(gun_sayisi);
                    if (toplam_saat == NaN) {
                        toplam_saat = 0;
                    }

                    toplam_saat = parseFloat(Math.round(toplam_saat * 100) / 100).toFixed(2);
                    $("#dyeni_is_toplam_calisma").val(toplam_saat);

                    if (parseInt(fark) == 1) {

                        if ($("#dyeni_is_baslangic_saati").val().length == 5 && $("#dyeni_is_bitis_saati").val().length == 5) {

                            if (diff($("#dyeni_is_baslangic_saati").val(), $("#dyeni_is_bitis_saati").val()).length == 5) {

                                var saat = diff($("#dyeni_is_baslangic_saati").val(), $("#dyeni_is_bitis_saati").val()).split(":")[0];
                                var dakika = diff($("#dyeni_is_baslangic_saati").val(), $("#dyeni_is_bitis_saati").val()).split(":")[1];

                                var oran = parseFloat(parseFloat(dakika) / 60);
                                var birkere = false;
                                if (parseFloat(parseFloat(saat) + parseFloat(oran)).toFixed(2) != $("#yeni_is_gunluk_ortalama_calisma").val()) {
                                    birkere = true;
                                }
                                $("#dyeni_is_gunluk_ortalama_calisma").val(parseFloat(parseFloat(saat) + parseFloat(oran)).toFixed(2));
                                if (birkere == true) {
                                    duzenle_is_ekle_sure_hesap();
                                }
                            }
                        }
                    }
                }
            }
        }
    }, 500);
}



//$(document).ready(function () {


//    $("#yeni_is_bitis_tarihi").datepicker({
//        firstDay: 1,
//        minDate: 0,
//        onSelect: function () {
//            alert(123);
//            setTimeout(function () {

//                var tarih = $("#yeni_is_baslangic_tarihi").datepicker("getDate");
//                var eldeki_date = $("#yeni_is_baslangic_tarihi").datepicker("getDate");
//                eldeki_date.setDate(eldeki_date.getDate());
//                tarih.setDate(tarih.getDate());

//                ay = parseFloat(tarih.getMonth()) + 1;
//                if (ay < 10) {
//                    ay = "0" + ay;
//                }

//                gun = parseFloat(tarih.getDate());
//                if (gun < 10) {
//                    gun = "0" + gun;
//                }

//                var yeni_tarih = gun + "." + ay + "." + tarih.getFullYear();

//                $("#yeni_is_bitis_tarihi").val(yeni_tarih);

//                $("#yeni_is_bitis_tarihi").datepicker('option', 'minDate', eldeki_date).focus();

//                alert("Tarih Değişti");
//                var yeni_is_bitis_tarihi = $("#yeni_is_bitis_tarihi").val();
//                var yeni_is_baslangic_tarihi = $("#yeni_is_baslangic_tarihi").val();
//                var data = "islem=yeni_is_ekle";
//                data += "&baslangic_tarihi=" + yeni_is_baslangic_tarihi;
//                data += "&bitis_tarihi=" + yeni_is_bitis_tarihi;

//                console.log(data);

//                $("#koftiden").loadHTML({ url: "/System_Root/ajax/islem1.aspx/yeni_is_ekle", data: data }, function () {
//                    mesaj_ver("İşler", "sorgu çalıştı", "success");
//                });

//            }, 500);


//        }
//    }).mask("99.99.9999");

//    //$("#yeni_is_bitis_tarihi").change(function () {
//    //    alert(123);
//    //    var yeni_is_bitis_tarihi = $("#yeni_is_bitis_tarihi").val();
//    //    var yeni_is_baslangic_tarihi = $("#yeni_is_baslangic_tarihi").val();
//    //    var data = "islem=yeni_is_ekle";
//    //    data += "&baslangic_tarihi=" + yeni_is_baslangic_tarihi;
//    //    data += "&bitis_tarihi=" + yeni_is_bitis_tarihi;

//    //    console.log(data);

//    //    $("#koftiden").loadHTML({ url: "/System_Root/ajax/islem1.aspx/yeni_is_ekle", data: data }, function () {
//    //        mesaj_ver("İşler", "sorgu çalıştı", "success");
//    //    });
//    //});


//    //var data = "islem=yeni_is_ekle";
//    //data += "&baslangic_tarihi=" + yeni_is_baslangic_tarihi;
//    //data += "&bitis_tarihi=" + yeni_is_bitis_tarihi;

//    //console.log(data);


//    //$("#koftiden").loadHTML({ url: "/System_Root/ajax/islem1.aspx/yeni_is_ekle", data: data }, function () {
//    //    mesaj_ver("İşler", "sorgu çalıştı", "success");
//    //});
//});


function yeni_is_sorgula() {


    var data = "islem=yeni_is_ekle";
    data += "&baslangic_tarihi=" + $("#yeni_is_baslangic_tarihi").val();
    data += "&bitis_tarihi=" + $("#yeni_is_bitis_tarihi").val();

    $("#koftiden").loadHTML({ url: "/System_Root/ajax/islem1.aspx/yeni_is_ekle", data: data }, function () {
        mesaj_ver("İşler", "sorgu çalıştı", "success");
    });
}


function dyeni_is_ekle_sure_hesap() {

    clearTimeout(sure);
    sure = setTimeout(function () {
        var tarih2 = $("#dyeni_is_bitis_tarihi").val();
        var tarih = $("#dyeni_is_baslangic_tarihi").val();
        if (tarih2.length == 10 && tarih.length == 10) {
            var fark = Date.gunfark(tarih2, tarih) + 1;
            var yeni_is_gunluk_ortalama_calisma = $("#dyeni_is_gunluk_ortalama_calisma").val();
            yeni_is_gunluk_ortalama_calisma = yeni_is_gunluk_ortalama_calisma.replace(",", ".");
            if (IsNumeric(fark)) {
                if (IsNumeric(yeni_is_gunluk_ortalama_calisma)) {
                    $("#dgunluk_gun_hesap_yeri").html(fark + " gün");
                    var gun_sayisi = fark;
                    var toplam_saat = parseFloat(yeni_is_gunluk_ortalama_calisma) * parseFloat(gun_sayisi);
                    if (toplam_saat == NaN) {
                        toplam_saat = 0;
                    }
                    toplam_saat = parseFloat(Math.round(toplam_saat * 100) / 100).toFixed(2);
                    $("#dyeni_is_toplam_calisma").val(toplam_saat);
                }
            }
        }
    }, 500);

}


function dyeni_is_ekle_sure_hesap2() {

    clearTimeout(sure);
    sure = setTimeout(function () {
        var tarih2 = $("#dyeni_is_bitis_tarihi").val();
        var tarih = $("#dyeni_is_baslangic_tarihi").val();
        if (tarih2.length == 10 && tarih.length == 10) {
            var fark = Date.gunfark(tarih2, tarih) + 1;
            var yeni_is_gunluk_ortalama_calisma = $("#dyeni_is_gunluk_ortalama_calisma").val();
            yeni_is_gunluk_ortalama_calisma = yeni_is_gunluk_ortalama_calisma.replace(",", ".");
            if (IsNumeric(fark)) {
                if (IsNumeric(yeni_is_gunluk_ortalama_calisma)) {
                    var gun_sayisi = fark;
                    var gunluk_saat = parseFloat($("#dyeni_is_toplam_calisma").val()) / parseFloat(gun_sayisi);
                    if (gunluk_saat == NaN) {
                        gunluk_saat = 0;
                    }
                    gunluk_saat = parseFloat(Math.round(gunluk_saat * 100) / 100).toFixed(2);
                    $("#dyeni_is_gunluk_ortalama_calisma").val(gunluk_saat);
                }
            }
        }
    }, 500);
}



function yeni_is_ekle_sure_hesap2() {

    clearTimeout(sure);
    sure = setTimeout(function () {
        var tarih2 = $("#yeni_is_bitis_tarihi").val();
        var tarih = $("#yeni_is_baslangic_tarihi").val();
        if (tarih2.length == 10 && tarih.length == 10) {
            var fark = Date.gunfark(tarih2, tarih) + 1;
            var yeni_is_gunluk_ortalama_calisma = $("#yeni_is_gunluk_ortalama_calisma").val();
            yeni_is_gunluk_ortalama_calisma = yeni_is_gunluk_ortalama_calisma.replace(",", ".");
            if (IsNumeric(fark)) {
                if (IsNumeric(yeni_is_gunluk_ortalama_calisma)) {

                    var gun_sayisi = fark;
                    var gunluk_saat = parseFloat($("#yeni_is_toplam_calisma").val()) / parseFloat(gun_sayisi);
                    if (gunluk_saat == NaN) {
                        gunluk_saat = 0;
                    }
                    gunluk_saat = parseFloat(Math.round(gunluk_saat * 100) / 100).toFixed(2);
                    $("#yeni_is_gunluk_ortalama_calisma").val(gunluk_saat);

                }
            }
        }
    }, 500);
}

function IsNumeric(strString) {
    var strValidChars = "0123456789.-";
    var strChar;
    var blnResult = true;

    if (strString.length == 0) return false;
    //  test strString consists of valid characters listed above
    for (i = 0; i < strString.length && blnResult == true; i++) {
        strChar = strString.charAt(i);
        if (strValidChars.indexOf(strChar) == -1) {
            blnResult = false;
        }
    }
    return blnResult;
}


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

Date.gunfark = function (s1, s2) {
    var t = s1.split(/\D+/);
    var z = s2.split(/\D+/);
    var d1 = new Date(t[2] * 1, t[1] - 1, t[0] * 1);
    var d2 = new Date(z[2] * 1, z[1] - 1, z[0] * 1);
    var birgun = 24 * 60 * 60 * 1000;
    var f = Math.floor((d1 - d2) / birgun);
    return f;
}


function firma_bilgilerimi_guncelle() {

    if ($("#sirket_bilgileri_form input:not(input[type=button])").valid("valid")) {

        var firma_logo = $("#firma_logo").attr("filePath");
        var firma_adi = $("#firma_adi").val();
        var firma_yetkili = $("#firma_yetkili").val();
        //var firma_sehir = $("#firma_sehir").val();
        //var firma_ilce = $("#firma_ilce").val();
        var firma_adres = $("#firma_adres").val();
        var firma_telefon = $("#firma_telefon").val();
        var firma_gsm = $("#firma_gsm").val();
        var firma_vergi_daire = $("#firma_vergi_daire").val();
        var firma_vergi_no = $("#firma_vergi_no").val();
        var firma_tema = $("#firma_tema").val();

        var haftaici_baslangic = $("#haftaici_baslangic").val();
        var haftaici_bitis = $("#haftaici_bitis").val();

        var cumartesi_baslangic = $("#cumartesi_baslangic").val();
        var cumartes_bitis = $("#cumartes_bitis").val();

        var pazar_baslangic = $("#pazar_baslangic").val();
        var pazar_bitis = $("#pazar_bitis").val();


        var data = "islem=firma_bilgilerimi_guncelle";
        data += "&firma_tema=" + firma_tema;
        data += "&firma_logo=" + firma_logo;
        data += "&firma_adi=" + firma_adi;
        data += "&firma_yetkili=" + firma_yetkili;
        //data += "&firma_sehir=" + firma_sehir;
        //data += "&firma_ilce=" + firma_ilce;
        data += "&firma_adres=" + firma_adres;
        data += "&firma_telefon=" + firma_telefon;
        data += "&firma_gsm=" + firma_gsm;
        data += "&firma_vergi_daire=" + firma_vergi_daire;
        data += "&firma_vergi_no=" + firma_vergi_no;

        data += "&haftaici_baslangic=" + haftaici_baslangic;
        data += "&haftaici_bitis=" + haftaici_bitis;
        data += "&cumartesi_baslangic=" + cumartesi_baslangic;
        data += "&cumartes_bitis=" + cumartes_bitis;
        data += "&pazar_baslangic=" + pazar_baslangic;
        data += "&pazar_bitis=" + pazar_bitis;

        data = encodeURI(data);
        $("#koftiden").loadHTML({ url: "/ajax_request/", data: data }, function () {
            mesaj_ver("Firma Bilgileri", "Kayıt Başarıyla Güncellendi", "success");
        });

    }

}

function toplanti_tipi_sectim(toplanti_tipi) {
    $(".toplanti_tipi").hide();
    $("." + toplanti_tipi).show();
}


function is_ajandada_goster_secim2() {

    if ($("#is_ajandada_goster2").attr("checkeds") == "checkeds") {
        $("#is_ajandada_goster2").removeAttr("checkeds");
    } else {
        $("#is_ajandada_goster2").attr("checkeds", "checkeds");
    }

}


function is_ajandada_goster_secim() {
    if ($("#is_ajandada_goster").attr("checkeds") == "checkeds") {
        $("#is_ajandada_goster").removeAttr("checkeds");
    } else {
        $("#is_ajandada_goster").attr("checkeds", "checkeds");
    }

}

function radio_tikle(nesne) {
    $("input[name=" + $(nesne).attr("name") + "]").removeAttr("checkeds");
    $(nesne).attr("checkeds", "checkeds");
}

function tahsilat_tipi_sectim(nesne) {
    $(".tahsilat_tipi").removeAttr("checked");
    $(nesne).attr("checked", "checked");
    var deger = $(nesne).val();
    if (deger == "Çek") {
        $(".vade_tarihi_yeri").show();
    } else {
        $(".vade_tarihi_yeri").hide();
    }
}

function odeme_tipi_sectim(nesne) {
    $(".tahsilat_tipi").removeAttr("checked");
    $(nesne).attr("checked", "checked");
    var deger = $(nesne).val();
    if (deger == "Çek") {
        $(".vade_tarihi_yeri").show();
    } else {
        $(".vade_tarihi_yeri").hide();
    }
}

function toplanti_ekle_yineleme_donemi(nesne) {

    setTimeout(function () {
        $(".yineleme_donemi").removeAttr("checkeds");
        $(nesne).attr("checkeds", "checkeds");
    }, 500);

    var deger = $(nesne).val();
    $(".yineleme_yerleri").hide();
    $("." + deger + "_yineleme").show();

}


function toplanti_ekle_yineleme_donemi2(deger2) {

    var nesne = $("#" + deger2);
    $(".yineleme_donemi").removeAttr("checkeds");
    $(nesne).attr("checkeds", "checkeds");
    var deger = $(nesne).val();
    $(".yineleme_yerleri").hide();
    $("." + deger + "_yineleme").show();

}

function calisma_gunu_sectim(kacinci) {

    if ($("#gun" + kacinci).attr("checked") == "checked") {
        $("#gun" + kacinci).removeAttr("checked");
    } else {
        $("#gun" + kacinci).attr("checked", "checked");
    }
    if ($("#gun" + kacinci).attr("checked") == "checked") {
        $("#gun" + kacinci + "_saat1").removeAttr("disabled").attr("required", "required");
        $("#gun" + kacinci + "_saat2").removeAttr("disabled").attr("required", "required");
    } else {
        $("#gun" + kacinci + "_saat1").attr("disabled", "disabled").removeAttr("required");
        $("#gun" + kacinci + "_saat2").attr("disabled", "disabled").removeAttr("required");
    }

}

function personel_giris_cikis_kaydi_sil(personel_id, kayit_id) {

    var r = confirm("Kaydı Silmek İstediğinize Emin misiniz?");
    if (r) {
        var data = "islem=personel_giris_cikis_kayitlarini_getir&islem2=sil";
        data += "&personel_id=" + personel_id;
        data += "&kayit_id=" + kayit_id;
        data = encodeURI(data);
        $("#giris_cikis_kayitlari").loadHTML({ url: "/ajax_request2/", data: data }, function () {
            mesaj_ver("Personel Yönetimi", "Giriş Çıkış Kaydı Silindi", "success");
            var d = new Date();
            var n = d.getFullYear();
            personel_yillik_takvimi_getir(personel_id, n);
        });
    }
}

function personel_giris_cikis_guncelle(nesne, personel_id, kayit_id) {

    if ($("#yeni_personel_giris_form input[type=text],textarea").valid("valid")) {

        var saat_tipi = $("#saat_tipi").val();
        var giris_cikis_saati = $("#giris_cikis_saati").val();
        var giris_cikis_tarihi = $("#giris_cikis_tarihi").val();

        var data = "islem=personel_giris_cikis_kayitlarini_getir&islem2=guncelle";
        data += "&personel_id=" + personel_id;
        data += "&kayit_id=" + kayit_id;
        data += "&saat_tipi=" + saat_tipi;
        data += "&giris_cikis_saati=" + giris_cikis_saati;
        data += "&giris_cikis_tarihi=" + giris_cikis_tarihi;
        data = encodeURI(data);
        $(nesne).attr("disabled", "disabled").val("İşlem Yapılıyor...");
        $("#giris_cikis_kayitlari").loadHTML({ url: "/ajax_request2/", data: data }, function () {
            mesaj_ver("Personel Yönetimi", "Giriş Çıkış Kaydı Başarıyla Güncellendi", "success");
            $(".close").click();
            var d = new Date();
            var n = d.getFullYear();
            personel_yillik_takvimi_getir(personel_id, n);
        });

    }
}

function personel_yillik_takvimi_getir(personel_id, yil) {
    var data = "islem=personel_yillik_takvimi_getir";
    data += "&personel_id=" + personel_id;
    data += "&yil=" + yil;
    data = encodeURI(data);
    $("#yillik_takvim_yeri").loadHTML({ url: "/ajax_request2/", data: data }, function () {

    });
}



function profil_personel_yillik_takvimi_getir(personel_id, yil) {
    var data = "islem=profil_personel_yillik_takvimi_getir";
    data += "&personel_id=" + personel_id;
    data += "&yil=" + yil;
    data = encodeURI(data);
    $("#yillik_takvim_yeri").loadHTML({ url: "/ajax_request6/", data: data }, function () {

    });
}


function personel_yillik_takvimi_getir_izin(personel_id, yil) {

    var data = "islem=personel_yillik_takvimi_getir_izin";
    data += "&personel_id=" + personel_id;
    data += "&yil=" + yil;
    data = encodeURI(data);
    $("#yillik_takvim_yeri_izin").loadHTML({ url: "/ajax_request6/", data: data }, function () {

    });

}



function personel_yillik_takvimi_getir_mesai(personel_id, yil) {

    var data = "islem=personel_yillik_takvimi_getir_mesai";
    data += "&personel_id=" + personel_id;
    data += "&yil=" + yil;
    data = encodeURI(data);
    $("#yillik_takvim_yeri_mesai").loadHTML({ url: "/ajax_request6/", data: data }, function () {

    });

}




function personel_izin_kayit(nesne, personel_id) {

    if ($("#yeni_personel_giris_form input[type=text],textarea").valid("valid")) {

        var saat_tipi = $("#saat_tipi").val();
        var giris_cikis_tarihi = $("#izin_tarihi").val();

        var data = "islem=personel_giris_cikis_kayitlarini_getir&islem2=ekle";
        data += "&personel_id=" + personel_id;
        data += "&saat_tipi=" + saat_tipi;
        data += "&giris_cikis_saati=" + "00:00";
        data += "&giris_cikis_tarihi=" + giris_cikis_tarihi;
        data = encodeURI(data);
        $("#giris_cikis_kayitlari").loadHTML({ url: "/ajax_request2/", data: data }, function () {
            mesaj_ver("Personel Yönetimi", "Giriş Çıkış Kaydı Başarıyla Eklendi", "success");
            var d = new Date();
            var n = d.getFullYear();
            personel_yillik_takvimi_getir(personel_id, n);
        });
    }
}

function personel_giris_cikis_kayit(nesne, personel_id) {

    if ($("#yeni_personel_giris_form input[type=text]").valid("valid")) {

        var saat_tipi = $("#saat_tipi").val();
        var giris_cikis_saati = $("#giris_cikis_saati").val();
        var giris_cikis_tarihi = $("#giris_cikis_tarihi").val();

        var data = "islem=personel_giris_cikis_kayitlarini_getir&islem2=ekle";
        data += "&personel_id=" + personel_id;
        data += "&saat_tipi=" + saat_tipi;
        data += "&giris_cikis_saati=" + giris_cikis_saati;
        data += "&giris_cikis_tarihi=" + giris_cikis_tarihi;
        data = encodeURI(data);
        $("#giris_cikis_kayitlari").loadHTML({ url: "/ajax_request2/", data: data }, function () {
            mesaj_ver("Personel Yönetimi", "Giriş Çıkış Kaydı Başarıyla Eklendi", "success");
            var d = new Date();
            var n = d.getFullYear();
            personel_yillik_takvimi_getir(personel_id, n);
            $(".close").click();
        });
    }
    else {
        mesaj_ver("Personel Yönetimi", "Saat Alanını Boş Geçmeyiniz !", "danger");
    }
}

function personel_giris_cikis_kayitlarini_getir(personel_id) {

    var data = "islem=personel_giris_cikis_kayitlarini_getir";
    data += "&personel_id=" + personel_id;
    data = encodeURI(data);
    $("#giris_cikis_kayitlari").loadHTML({ url: "/ajax_request2/", data: data }, function () {

    });
}


function profil_personel_giris_cikis_kayitlarini_getir(personel_id) {

    var data = "islem=profil_personel_giris_cikis_kayitlarini_getir";
    data += "&personel_id=" + personel_id;
    data = encodeURI(data);
    $("#giris_cikis_kayitlari").loadHTML({ url: "/ajax_request6/", data: data }, function () {

    });
}


function profil_personel_bordro_getir(personel_id, nesne) {

    $(".personel_tablar").html("");
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");
    setTimeout(function () {
        var data = "islem=profil_personel_bordro_getir";
        data += "&personel_id=" + personel_id;
        data = encodeURI(data);
        $("#bordrolar").loadHTML({ url: "/ajax_request6/", data: data }, function () {
            $(".timepicker").mask("99:99");
        });
    }, 200);

}

function izin_talebi_sil(personel_id, kayit_id) {


    var r = confirm("Kaydı Silmek İstediğinize Emin misiniz?");
    if (r) {
        var data = "islem=profil_personel_izin_kayitlarini_getir&islem2=sil";
        data += "&personel_id=" + personel_id;
        data += "&kayit_id=" + kayit_id;
        data = encodeURI(data);
        $("#izin_kayitlari").loadHTML({ url: "/ajax_request6/", data: data }, function () {

        });

    }
}

function profil_personel_izin_kayitlarini_getir(personel_id) {

    var data = "islem=profil_personel_izin_kayitlarini_getir";
    data += "&personel_id=" + personel_id;
    data = encodeURI(data);
    $("#izin_kayitlari").loadHTML({ url: "/ajax_request6/", data: data }, function () {

    });
}




function profil_personel_mesai_kayitlarini_getir(personel_id) {

    var data = "islem=profil_personel_mesai_kayitlarini_getir";
    data += "&personel_id=" + personel_id;
    data = encodeURI(data);
    $("#mesai_kayitlari").loadHTML({ url: "/ajax_request6/", data: data }, function () {

    });
}




function personel_calisma_form_kaydet(personel_id) {
    if ($("#personel_calisma_form input[type=text]").valid("valid")) {
        var gun1 = "false";
        if ($("#gun1").attr("checked") == "checked") {
            gun1 = "true";
        }
        var gun2 = "false";
        if ($("#gun2").attr("checked") == "checked") {
            gun2 = "true";
        }
        var gun3 = "false";
        if ($("#gun3").attr("checked") == "checked") {
            gun3 = "true";
        }
        var gun4 = "false";
        if ($("#gun4").attr("checked") == "checked") {
            gun4 = "true";
        }
        var gun5 = "false";
        if ($("#gun5").attr("checked") == "checked") {
            gun5 = "true";
        }
        var gun6 = "false";
        if ($("#gun6").attr("checked") == "checked") {
            gun6 = "true";
        }
        var gun7 = "false";
        if ($("#gun7").attr("checked") == "checked") {
            gun7 = "true";
        }
        var gun1_saat1 = $("#gun1_saat1").val();
        var gun1_saat2 = $("#gun1_saat2").val();
        var gun2_saat1 = $("#gun2_saat1").val();
        var gun2_saat2 = $("#gun2_saat2").val();
        var gun3_saat1 = $("#gun3_saat1").val();
        var gun3_saat2 = $("#gun3_saat2").val();
        var gun4_saat1 = $("#gun4_saat1").val();
        var gun4_saat2 = $("#gun4_saat2").val();
        var gun5_saat1 = $("#gun5_saat1").val();
        var gun5_saat2 = $("#gun5_saat2").val();
        var gun6_saat1 = $("#gun6_saat1").val();
        var gun6_saat2 = $("#gun6_saat2").val();
        var gun7_saat1 = $("#gun7_saat1").val();
        var gun7_saat2 = $("#gun7_saat2").val();
        var data = "islem=personel_calisma_form_kaydet";
        data += "&personel_id=" + personel_id;
        data += "&gun1=" + gun1;
        data += "&gun2=" + gun2;
        data += "&gun3=" + gun3;
        data += "&gun4=" + gun4;
        data += "&gun5=" + gun5;
        data += "&gun6=" + gun6;
        data += "&gun7=" + gun7;
        data += "&gun1_saat1=" + gun1_saat1;
        data += "&gun1_saat2=" + gun1_saat2;
        data += "&gun2_saat1=" + gun2_saat1;
        data += "&gun2_saat2=" + gun2_saat2;
        data += "&gun3_saat1=" + gun3_saat1;
        data += "&gun3_saat2=" + gun3_saat2;
        data += "&gun4_saat1=" + gun4_saat1;
        data += "&gun4_saat2=" + gun4_saat2;
        data += "&gun5_saat1=" + gun5_saat1;
        data += "&gun5_saat2=" + gun5_saat2;
        data += "&gun6_saat1=" + gun6_saat1;
        data += "&gun6_saat2=" + gun6_saat2;
        data += "&gun7_saat1=" + gun7_saat1;
        data += "&gun7_saat2=" + gun7_saat2;
        data = encodeURI(data);
        $("#koftiden").loadHTML({ url: "/ajax_request2/", data: data }, function () {
            mesaj_ver("Personel Yönetimi", "Kayıt Başarıyla Güncellendi", "success");
            var d = new Date();
            var n = d.getFullYear();
            personel_yillik_takvimi_getir(personel_id, n);
        });
    }
}



function toplanti_guncelle(buton, toplanti_id) {
    if ($("#yeni_toplanti_form input[type=text],textarea").valid("valid")) {
        var toplanti_adi = $("#toplanti_adi").val();
        var toplanti_tipi = $("#toplanti_tipi").val();
        var etiketler = $("#etiketler").val();
        var data = "j=1&islem=toplanti_listesi&islem2=guncelle";
        data += "&toplanti_id=" + toplanti_id;
        data += "&toplanti_adi=" + toplanti_adi;
        data += "&toplanti_tipi=" + toplanti_tipi;
        data += "&etiketler=" + etiketler;
        if ("rutin" == toplanti_tipi) {
            var yineleme_donemi;
            if ($("#yineleme_donemi1").attr("checked") == "checked") {
                yineleme_donemi = "gunluk";
            } else if ($("#yineleme_donemi2").attr("checked") == "checked") {
                yineleme_donemi = "haftalik";
            } else if ($("#yineleme_donemi3").attr("checked") == "checked") {
                yineleme_donemi = "aylik";
            }
            data += "&yineleme_donemi=" + yineleme_donemi;
            if (yineleme_donemi == "gunluk") {
                var gunluk_yineleme_secim;
                if ($("#gunluk_yineleme_secim1").attr("checked") == "checked") {
                    gunluk_yineleme_secim = "gunluk";
                } else if ($("#gunluk_yineleme_secim2").attr("checked") == "checked") {
                    gunluk_yineleme_secim = "is_gunu";
                }
                data += "&gunluk_yineleme_secim=" + gunluk_yineleme_secim;
                if (gunluk_yineleme_secim = "gunluk") {
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
                if ($("#aylik_yenileme_tipi1").attr("checked") == "checked") {
                    aylik_yenileme_tipi = "1";
                } else if ($("#aylik_yenileme_tipi2").attr("checked") == "checked") {
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
        } else if ("gundeme_ozel" == toplanti_tipi) {
            var toplanti_tarihi = $("#toplanti_tarihi").val();
            data += "&toplanti_tarihi=" + toplanti_tarihi;
        }
        var toplanti_saati = $("#toplanti_saati").val();
        var katilimcilar = $("#katilimcilar").val();
        var toplanti_suresi = $("#toplanti_suresi").val();
        var gundem = $("#gundem").val();
        data += "&toplanti_saati=" + toplanti_saati;
        data += "&katilimcilar=" + katilimcilar;
        data += "&toplanti_suresi=" + toplanti_suresi;
        data += "&gundem=" + gundem;
        data += "&ay=" + $("#toplanti_baslik").attr("ay");
        data += "&yil=" + $("#toplanti_baslik").attr("yil");
        data = encodeURI(data);
        $(buton).attr("disabled", "disabled").val("Kaydediliyor...");
        $("#toplanti_listesi").loadHTML({ url: "/ajax_request/", data: data, type: "POST" }, function () {
            mesaj_ver("Toplantı", "Kayıt Başarıyla Eklendi");
            $(".close").click();
        });
    }
}




function toplanti_gundem_listesi(toplanti_id, nesne) {

    $("#gundem_tab").html("");
    $("#notlar_tab").html("");
    $("#kararlar_tab").html("");
    $("#is_listesi_tab").html("");

    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");

    setTimeout(function () {
        var data = "islem=toplanti_gundem_listesi";
        data += "&toplanti_id=" + toplanti_id;
        data = encodeURI(data);
        $("#gundem_tab").loadHTML({ url: "/ajax_request/", data: data }, function () {

        });

    }, 200);


}


function toplanti_not_listesi(toplanti_id, nesne) {

    $("#gundem_tab").html("");
    $("#notlar_tab").html("");
    $("#kararlar_tab").html("");
    $("#is_listesi_tab").html("");

    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");
    setTimeout(function () {
        var data = "islem=toplanti_not_listesi";
        data += "&toplanti_id=" + toplanti_id;
        data = encodeURI(data);
        $("#notlar_tab").loadHTML({ url: "/ajax_request/", data: data }, function () { });
    }, 200);

}

function toplanti_karar_listesi(toplanti_id, nesne) {

    $("#gundem_tab").html("");
    $("#notlar_tab").html("");
    $("#kararlar_tab").html("");
    $("#is_listesi_tab").html("");

    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");

    setTimeout(function () {
        var data = "islem=toplanti_karar_listesi";
        data += "&toplanti_id=" + toplanti_id;
        data = encodeURI(data);
        $("#kararlar_tab").loadHTML({ url: "/ajax_request/", data: data }, function () {

        });
    }, 200);
}

function toplanti_is_listesi(toplanti_id, nesne) {

    $("#gundem_tab").html("");
    $("#notlar_tab").html("");
    $("#kararlar_tab").html("");
    $("#is_listesi_tab").html("");

    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");

    setTimeout(function () {
        var data = "islem=toplanti_is_listesi";
        data += "&toplanti_id=" + toplanti_id;
        data = encodeURI(data);
        $("#is_listesi_tab").loadHTML({ url: "/ajax_request/", data: data }, function () {
            is_listesi_etiket("toplanti", toplanti_id);
        });
    }, 200);
}

function toplanti_ekle(buton) {

    if ($("#yeni_toplanti_form input[type=text],textarea").valid("valid")) {

        var toplanti_adi = $("#toplanti_adi").val();
        var toplanti_tipi = $("#toplanti_tipi").val();
        var etiketler = $("#etiketler").val();

        var data = "j=1&islem=toplanti_listesi&islem2=ekle";
        data += "&toplanti_adi=" + toplanti_adi;
        data += "&toplanti_tipi=" + toplanti_tipi;
        data += "&etiketler=" + etiketler;

        if ("rutin" == toplanti_tipi) {

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
                if (gunluk_yineleme_secim = "gunluk") {
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


        } else if ("gundeme_ozel" == toplanti_tipi) {

            var toplanti_tarihi = $("#toplanti_tarihi").val();
            data += "&toplanti_tarihi=" + toplanti_tarihi;


        }
        var toplanti_saati = $("#toplanti_saati").val();
        var katilimcilar = $("#katilimcilar").val();
        var toplanti_suresi = $("#toplanti_suresi").val();
        var gundem = $("#gundem").val();

        data += "&toplanti_saati=" + toplanti_saati;
        data += "&katilimcilar=" + katilimcilar;
        data += "&toplanti_suresi=" + toplanti_suresi;
        data += "&gundem=" + gundem;
        data += "&ay=" + $("#toplanti_baslik").attr("ay");
        data += "&yil=" + $("#toplanti_baslik").attr("yil");
        data = encodeURI(data);



        $(buton).attr("disabled", "disabled").val("Kaydediliyor...");
        $("#toplanti_listesi").loadHTML({ url: "/ajax_request/", data: data, type: "POST" }, function () {
            mesaj_ver("Toplantı", "Kayıt Başarıyla Eklendi");
            $(".close").click();
        });

    }
}


function toplanti_sil(toplanti_id) {
    var r = confirm("Kaydı Silmek İstediğinize Emin misiniz?");
    if (r) {
        var data = "islem=toplanti_listesi&islem2=sil";
        data += "&toplanti_id=" + toplanti_id;
        data += "&ay=" + $("#toplanti_baslik").attr("ay");
        data += "&yil=" + $("#toplanti_baslik").attr("yil");
        data = encodeURI(data);
        $("#toplanti_listesi").loadHTML({ url: "/ajax_request/", data: data, type: "POST" }, function () {
            mesaj_ver("Toplantı", "Kayıt başarıyla silindi.");
        });
    }
}


function toplanti_iptal_et(toplanti_id) {
    var r = confirm("Kaydı İptal Etmek İstediğinize Emin misiniz?");
    if (r) {
        var data = "islem=toplanti_listesi&islem2=iptal";
        data += "&toplanti_id=" + toplanti_id;
        data += "&ay=" + $("#toplanti_baslik").attr("ay");
        data += "&yil=" + $("#toplanti_baslik").attr("yil");
        data = encodeURI(data);
        $("#toplanti_listesi").loadHTML({ url: "/ajax_request/", data: data, type: "POST" }, function () {
            mesaj_ver("Toplantı", "Kayıt İptali Gerçekleştirildi");
        });
    }
}

function check_tikle(deger) {

    setTimeout(function () {
        if ($("#" + deger).attr("checked") == "checked") {
            $("#" + deger).removeAttr("checked");
        } else {
            $("#" + deger).attr("checked", "checked");
        }
    }, 500);


}

function toplantilari_getir(ay, yil) {
    var data = "islem=toplanti_listesi";
    data += "&ay=" + ay;
    data += "&yil=" + yil;
    data = encodeURI(data);
    $("#toplanti_listesi").loadHTML({ url: "/ajax_request/", data: data }, function () { });
}

function personel_giris_cikis_saat_tipi_sectim(deger) {
    if (deger == "1") {
        $("#giris_cikis_tarih_text").html("Giriş Tarihi");
        $("#giris_cikis_text").html("Giriş Saati");
    } else if (deger == "0") {
        $("#giris_cikis_tarih_text").html("Çıkış Tarihi");
        $("#giris_cikis_text").html("Çıkış Saati");
    }
}


function izin_talebi_gonder(personel_id) {

    var baslangic_tarihi = $("#izin_baslangic_tarihi").val();
    var baslangic_saati = $("#izin_baslangic_saati").val();
    var bitis_tarihi = $("#izin_bitis_tarihi").val();
    var bitis_saati = $("#izin_bitis_saati").val();
    var nedeni = $("#izin_nedeni").val();
    var turu = $("#izin_turu").val();
    var aciklama = $("#izin_aciklama").val();
    var personel_adina = $("#personel_adina").val();

    var data = "islem=profil_personel_izin_kayitlarini_getir&islem2=talep_ekle";
    data += "&personel_id=" + personel_id;
    data += "&personel_adina=" + personel_adina;
    data += "&baslangic_tarihi=" + baslangic_tarihi;
    data += "&baslangic_saati=" + baslangic_saati;
    data += "&bitis_tarihi=" + bitis_tarihi;
    data += "&bitis_saati=" + bitis_saati;
    data += "&nedeni=" + nedeni;
    data += "&turu=" + turu;
    data += "&aciklama=" + aciklama;
    data = encodeURI(data);

    if ($("#izin_baslangic_saati").is(":visible") === true && $("#izin_bitis_saati").is(":visible") === true) {
        if ($("#izin_baslangic_saati").val().length > 0 && $("#izin_bitis_saati").val().length > 0) {
            $("#koftiden").loadHTML({ url: "/ajax_request5/", data: data }, function () {
                if ($("#koftiden").html() === "ok") {
                    $(".close").click();
                    $("#izin_kayitlari").loadHTML({ url: "/ajax_request6/", data: data }, function () {
                        mesaj_ver("İzin Talepleri", "Kayıt Başarıyla Eklendi", "success");
                    });
                }
            });
        }
        else {
            mesaj_ver("İzin Talebi", "İzin başlangıç saati ve bitiş saati'ni boş geçmeyin!", "danger");
        }
    }
    else {
        $("#koftiden").loadHTML({ url: "/ajax_request5/", data: data }, function () {
            if ($("#koftiden").html() === "ok") {
                $(".close").click();
                $("#izin_kayitlari").loadHTML({ url: "/ajax_request6/", data: data }, function () {
                    mesaj_ver("İzin Talepleri", "Kayıt Başarıyla Eklendi", "success");
                });
            }
        });
    }
}

function servis_formu_ac(is_id) {

    $(window).off('beforeunload');
    location.href = "/ajax_request6/?jsid=4559&islem=servis_formu&is_id=" + is_id;

}

function modal_mesai_bildirimi_yap(personel_id, durum) {

    var data = "islem=mdoal_mesai_bildirimi_yap";
    data += "&personel_id=" + personel_id;
    data += "&durum=" + durum;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        $(".takvimyap").datepicker({}).mask("99.99.9999");
        $(".timepicker").mask("99:99");
        $('.regexonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter({ format: 'custom', pattern: '[^0-9\,.]' });
        $('.numericonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter('numeric');
    });


}

function yeni_izin_talebi_modal(personel_id) {

    var data = "islem=yeni_izin_talebi_modal";
    data += "&personel_id=" + personel_id;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        $(".takvimyap").datepicker({}).mask("99.99.9999");
        $(".timepicker").mask("99:99");
        $('.regexonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter({ format: 'custom', pattern: '[^0-9\,.]' });
        $('.numericonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter('numeric');
    });

}

function personel_giris_cikis_kaydi_duzenle(personel_id, kayit_id) {

    var data = "islem=personel_giris_cikis_kaydi_duzenle";
    data += "&personel_id=" + personel_id;
    data += "&kayit_id=" + kayit_id;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        $(".takvimyap").datepicker({}).mask("99.99.9999");
        $(".timepicker").mask("99:99");
        $('.regexonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter({ format: 'custom', pattern: '[^0-9\,.]' });
        $('.numericonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter('numeric');
    });
}

function mesai_bildirim_sil(personel_id, mesai_id) {

    var r = confirm("Kaydı Silmek İstediğinize Emin misiniz?");
    if (r) {
        var data = "islem=profil_personel_mesai_kayitlarini_getir&islem2=sil";
        data += "&personel_id=" + personel_id;
        data += "&kayit_id=" + mesai_id;
        data = encodeURI(data);
        $("#mesai_kayitlari").loadHTML({ url: "/ajax_request6/", data: data }, function () {
            mesaj_ver("Personel", "Mesai Bildirim Kaydı Silindi", "success");
        });
    }
}


function mesai_bildirim_kaydet(personel_id, durum) {

    if ($("#mesai_bildirim_form input[type=text],textarea").valid("valid")) {

        var baslangic_tarihi = $("#mesai_baslangic_tarihi").val();
        var baslangic_saati = $("#mesai_baslangic_saati").val();
        var bitis_tarihi = $("#mesai_bitis_tarihi").val();
        var bitis_saati = $("#mesai_bitis_saati").val();
        var aciklama = $("#mesai_aciklama").val();
        var mesai_personel_adina = $("#mesai_personel_adina").val();

        var data = "islem=profil_personel_mesai_kayitlarini_getir&islem2=ekle";
        data += "&personel_id=" + personel_id;
        data += "&mesai_personel_adina=" + mesai_personel_adina;
        data += "&baslangic_tarihi=" + baslangic_tarihi;
        data += "&baslangic_saati=" + baslangic_saati;
        data += "&bitis_tarihi=" + bitis_tarihi;
        data += "&bitis_saati=" + bitis_saati;
        data += "&aciklama=" + aciklama;
        data += "&durum=" + durum;
        data = encodeURI(data);
        $("#mesai_kayitlari").loadHTML({ url: "/ajax_request6/", data: data }, function () {
            mesaj_ver("Personel", "Mesai Bildirim Kaydı Eklendi", "success");
            $(".close").click();
            $("#mesai_buton").click();
            personel_mesai_getir(personel_id);
        });

    }
}

function personel_zimmet_kaydet(nesne, etiket, etiket_id) {

    if ($("#personel_zimmet_form input[type=text],textarea").valid("valid")) {

        var zimmet_edilen = $("#zimmet_edilen").val();

        var data = "islem=zimmet_kayitlarini_getir&islem2=ekle";
        data += "&etiket=" + etiket;
        data += "&etiket_id=" + etiket_id;
        data += "&zimmet_edilen=" + zimmet_edilen;
        data = encodeURI(data);
        $(nesne).attr("disabled", "disabled").val("İşlem Yapılıyor...");
        $("#zimmet_kayit_listesi").loadHTML({ url: "/ajax_request2/", data: data }, function () {
            mesaj_ver("Personel", "Zimmet Kaydı Eklendi", "success");
            $(".close").click();
        });

    }

}


function personel_zimmet_guncelle(nesne, etiket, etiket_id, kayit_id) {

    if ($("#personel_zimmet_form input[type=text],textarea").valid("valid")) {

        var zimmet_edilen = $("#zimmet_edilen").val();

        var data = "islem=zimmet_kayitlarini_getir&islem2=guncelle";
        data += "&etiket=" + etiket;
        data += "&etiket_id=" + etiket_id;
        data += "&kayit_id=" + kayit_id;
        data += "&zimmet_edilen=" + zimmet_edilen;
        data = encodeURI(data);
        $(nesne).attr("disabled", "disabled").val("İşlem Yapılıyor...");
        $("#zimmet_kayit_listesi").loadHTML({ url: "/ajax_request2/", data: data }, function () {
            mesaj_ver("Personel", "Zimmet Kaydı Güncellendi", "success");
            $(".close").click();
        });

    }

}


function zimmet_kaydi_duzenle(etiket, etiket_id, kayit_id) {

    var data = "islem=zimmet_kaydi_duzenle";
    data += "&etiket=" + etiket;
    data += "&etiket_id=" + etiket_id;
    data += "&kayit_id=" + kayit_id;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        $(".takvimyap").datepicker({}).mask("99.99.9999");
        $(".timepicker").mask("99:99");
        $('.regexonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter({ format: 'custom', pattern: '[^0-9\,.]' });
        $('.numericonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter('numeric');
    });

}

function personel_zimmet_kaydi_ekle(etiket, etiket_id) {

    var data = "islem=personel_zimmet_kaydi_ekle";
    data += "&etiket=" + etiket;
    data += "&etiket_id=" + etiket_id;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        $(".takvimyap").datepicker({}).mask("99.99.9999");
        $(".timepicker").mask("99:99");
        $('.regexonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter({ format: 'custom', pattern: '[^0-9\,.]' });
        $('.numericonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter('numeric');
    });
}

function zimmet_kayitlarini_getir(etiket, etiket_id) {

    var data = "islem=zimmet_kayitlarini_getir";
    data += "&etiket=" + etiket;
    data += "&etiket_id=" + etiket_id;
    data = encodeURI(data);
    $("#zimmet_kayit_listesi").loadHTML({ url: "/ajax_request2/", data: data }, function () {

    });

}

function giris_cikis_izin_ekle(personel_id, tarih) {
    var data = "islem=giris_cikis_izin_ekle";
    data += "&personel_id=" + personel_id;
    data += "&tarih=" + tarih;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        $(".takvimyap").datepicker({}).mask("99.99.9999");
        $(".timepicker").mask("99:99");
        $('.regexonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter({ format: 'custom', pattern: '[^0-9\,.]' });
        $('.numericonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter('numeric');
    });
}


function giris_cikis_kaydi_ekle(personel_id, tarih) {
    var data = "islem=giris_cikis_kaydi_ekle";
    data += "&personel_id=" + personel_id;
    data += "&tarih=" + tarih;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        $(".takvimyap").datepicker({}).mask("99.99.9999");
        $(".timepicker").mask("99:99");
        $('.regexonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter({ format: 'custom', pattern: '[^0-9\,.]' });
        $('.numericonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter('numeric');
    });
}

function gundem_duzenle(toplanti_id, gundem_id) {

    var data = "islem=toplanti_gundem_duzenle";
    data += "&toplanti_id=" + toplanti_id;
    data += "&gundem_id=" + gundem_id;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request/", data: data }, function () {
        $(".takvimyap").datepicker({}).mask("99.99.9999");
        $(".timepicker").mask("99:99");
        $('.regexonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter({ format: 'custom', pattern: '[^0-9\,.]' });
        $('.numericonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter('numeric');
    });

}




function toplanti_karar_ekle(toplanti_id) {
    var data = "islem=toplanti_karar_ekle";
    data += "&toplanti_id=" + toplanti_id;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request/", data: data }, function () {
        $(".takvimyap").datepicker({}).mask("99.99.9999");
        $(".timepicker").mask("99:99");
        $('.regexonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter({ format: 'custom', pattern: '[^0-9\,.]' });
        $('.numericonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter('numeric');
    });
}


function toplanti_gundem_ekle(toplanti_id) {

    var data = "islem=toplanti_gundem_ekle";
    data += "&toplanti_id=" + toplanti_id;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request/", data: data }, function () {
        $(".takvimyap").datepicker({}).mask("99.99.9999");
        $(".timepicker").mask("99:99");
        $('.regexonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter({ format: 'custom', pattern: '[^0-9\,.]' });
        $('.numericonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter('numeric');
    });

}

function toplanti_gundem_listesi_getir(toplanti_id) {

    var data = "islem=gundem_ekle";
    data += "&toplanti_id=" + toplanti_id;
    data = encodeURI(data);
    $("#gundem_listesi").loadHTML({ url: "/ajax_request/", data: data }, function () {

    });

}



function zimmet_kaydi_sil(etiket, etiket_id, kayit_id) {

    var r = confirm("Kaydı Silmek İstediğinize Emin misiniz?");
    if (r) {

        var data = "islem=zimmet_kayitlarini_getir&islem2=sil";
        data += "&etiket=" + etiket;
        data += "&etiket_id=" + etiket_id;
        data += "&kayit_id=" + kayit_id;
        data = encodeURI(data);
        $("#zimmet_kayit_listesi").loadHTML({ url: "/ajax_request2/", data: data }, function () {
            mesaj_ver("Personel", "Kayıt Başarıyla Silindi");
        });
    }
}
function gundem_sil(toplanti_id, gundem_id) {

    var r = confirm("Gündemi Silmek İstediğinize Emin misiniz?");
    if (r) {

        var data = "islem=gundem_ekle&islem2=sil";
        data += "&toplanti_id=" + toplanti_id;
        data += "&gundem_id=" + gundem_id;
        data = encodeURI(data);
        $("#gundem_listesi").loadHTML({ url: "/ajax_request/", data: data }, function () {
            mesaj_ver("Toplantı", "Gündem Başarıyla Silindi");
        });
    }
}


function gundem_iptal_et(toplanti_id, gundem_id, durum) {
    var uyari = "Gündemi İptal Etmek İstediğinize Emin misiniz?";
    if (durum == "false") {
        uyari = "Gündemi Aktif Etmek İstediğinize Emin misiniz?";
    }
    var r = confirm(uyari);
    if (r) {
        var data = "islem=gundem_ekle&islem2=iptal";
        data += "&toplanti_id=" + toplanti_id;
        data += "&gundem_id=" + gundem_id;
        data = encodeURI(data);
        $("#gundem_listesi").loadHTML({ url: "/ajax_request/", data: data }, function () {
            mesaj_ver("Toplantı", "Gündem İptal Edildi");
        });
    }
}

function toplanti_karar_listesi_getir(toplanti_id) {
    var data = "islem=toplanti_karar_listesi2";
    data += "&toplanti_id=" + toplanti_id;
    data = encodeURI(data);
    $("#karar_listesi").loadHTML({ url: "/ajax_request/", data: data }, function () {

    });
}

function cari_hareket_kaydi_duzenle(cari_id, tip, kayit_id, islem_tipi, yer) {

    var data = "islem=cari_hareket_kaydi_duzenle";
    data += "&cari_id=" + cari_id;
    data += "&tip=" + tip;
    data += "&kayit_id=" + kayit_id;
    data += "&islem_tipi=" + islem_tipi;
    data += "&yer=" + yer;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request/", data: data }, function () {
        $(".takvimyap").datepicker({}).mask("99.99.9999");
        $(".timepicker").mask("99:99");
        $('.regexonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter({ format: 'custom', pattern: '[^0-9\,.]' });
        $('.numericonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter('numeric');
    });

}

function toplanti_karar_duzenle(toplanti_id, karar_id) {

    var data = "islem=toplanti_karar_duzenle";
    data += "&toplanti_id=" + toplanti_id;
    data += "&karar_id=" + karar_id;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request/", data: data }, function () {
        $(".takvimyap").datepicker({}).mask("99.99.9999");
        $(".timepicker").mask("99:99");
        $('.regexonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter({ format: 'custom', pattern: '[^0-9\,.]' });
        $('.numericonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter('numeric');
    });
}


function personel_bilgileri_getir(personel_id, nesne) {
    $(".personel_tablar").html("");
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");
    setTimeout(function () {
        var data = "islem=personel_bilgileri_getir";
        data += "&personel_id=" + personel_id;
        data = encodeURI(data);
        $("#personel_bilgileri_cek").loadHTML({ url: "/ajax_request/", data: data }, function () {
            sayfa_yuklenince();
            $('.paraonly:not(.yapilan)').addClass("yapilan").maskMoney({ thousands: '.', decimal: ',', allowZero: true, suffix: ' ₺' });
        });
    }, 200);
}



function profil_personel_bilgileri_getir(personel_id, nesne) {
    $(".personel_tablar").html("");
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");
    setTimeout(function () {
        var data = "islem=profil_personel_bilgileri_getir";
        data += "&personel_id=" + personel_id;
        data = encodeURI(data);
        $("#personel_bilgileri").loadHTML({ url: "/ajax_request6/", data: data }, function () {
            $(".timepicker").mask("99:99");
            fileyap();
        });
    }, 200);
}



function profil_personel_giris_cikis_getir(personel_id, nesne) {
    $(".personel_tablar").html("");
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");
    setTimeout(function () {
        var data = "islem=profil_personel_giris_cikis_getir";
        data += "&personel_id=" + personel_id;
        data = encodeURI(data);
        $("#giris_cikis").loadHTML({ url: "/ajax_request6/", data: data }, function () {
            $(".timepicker").mask("99:99");
        });
    }, 200);
}



function profil_personel_izin_getir(personel_id, nesne) {
    $(".personel_tablar").html("");
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");
    setTimeout(function () {
        var data = "islem=profil_personel_izin_getir";
        data += "&personel_id=" + personel_id;
        data = encodeURI(data);
        $("#izin_bilgileri").loadHTML({ url: "/ajax_request6/", data: data }, function () {
            $(".timepicker").mask("99:99");
        });
    }, 200);
}


function personel_bordro_getir(personel_id, nesne) {
    $(".personel_tablar").html("");
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");
    setTimeout(function () {
        var data = "islem=personel_bordro_getir";
        data += "&personel_id=" + personel_id;
        data = encodeURI(data);
        $("#bordro_section").loadHTML({ url: "/ajax_request6/", data: data }, function () {
            $(".timepicker").mask("99:99");
        });
    }, 200);
}



function profil_personel_mesai_getir(personel_id, nesne) {
    $(".personel_tablar").html("");
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");
    setTimeout(function () {
        var data = "islem=profil_personel_mesai_getir";
        data += "&personel_id=" + personel_id;
        data = encodeURI(data);
        $("#mesai_bilgileri").loadHTML({ url: "/ajax_request6/", data: data }, function () {
            $(".timepicker").mask("99:99");
        });
    }, 200);
}

function profil_personel_dosya_getir(personel_id, nesne) {
    $(".personel_tablar").html("");
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");

    setTimeout(function () {
        file_depo_getir("dosyalar", "personel", personel_id);
    }, 200);
}

function personel_izin_talep_onayla(personel_id, kayit_id, durum) {

    var data = "islem=personel_izin_talep_onayla";
    data += "&personel_id=" + personel_id;
    data += "&kayit_id=" + kayit_id;
    data += "&durum=" + durum;
    data = encodeURI(data);
    $("#koftiden").loadHTML({ url: "/ajax_request6/", data: data, status }, function () {
        if (status == "") {
            mesaj_ver("İzin Talepleri", "Kayıt Başarıyla Güncellendi", "success");
            personel_giris_cikis_getir(personel_id);
        }
        if (status == "error")
            mesaj_ver("İzin Talepleri", "Kendi İzin Talebinizi Onaylayamazsınız. !", "danger");
    });
}

function personel_mesai_talep_onayla(personel_id, kayit_id, durum) {

    var data = "islem=personel_mesai_talep_onayla";
    data += "&personel_id=" + personel_id;
    data += "&kayit_id=" + kayit_id;
    data += "&durum=" + durum;
    data = encodeURI(data);
    $("#koftiden").loadHTML({ url: "/ajax_request6/", data: data, status }, function () {
        if (status == "success")
            mesaj_ver("İzin Talepleri", "Kayıt Başarıyla Güncellendi", "success");
        if (status == "error")
            mesaj_ver("İzin Talepleri", "Kendi İzin Talebinizi Onaylayamazsınız. !", "danger");
    });
}
function mesai_bildirim_onayla(personel_id, kayit_id) {

    var data = "islem=mesai_bildirim_onayla";
    data += "&personel_id=" + personel_id;
    data += "&kayit_id=" + kayit_id;
    data = encodeURI(data);
    $("#koftiden").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        if (status == "success")
            mesaj_ver("Mesai Bildirimleri", "Kayıt Başarıyla Güncellendi", "success");
        if (status == "error")
            mesaj_ver("Mesai Bildirimleri", "Kendi Mesai Talebinizi Onaylayamazsınız. !", "danger");

        $("#mesai_buton").click();
    });
}

function personel_mesai_getir(personel_id, nesne) {
    $(".personel_tablar").html("");
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");
    setTimeout(function () {
        var data = "islem=personel_mesai_getir";
        data += "&personel_id=" + personel_id;
        data = encodeURI(data);
        $("#mesai_section").loadHTML({ url: "/ajax_request6/", data: data }, function () {
            $(".timepicker").mask("99:99");
        });
    }, 200);
}

function izin_talep_formu(personel_id, izin_id) {


    data += "&personel_id=" + personel_id;
    data += "&izin_id=" + izin_id;

    popUp('/izin_talep_formu/?jsid=4559&personel_id=' + personel_id + '&izin_id=' + izin_id, 750, 850);

}

function personel_giris_cikis_getir(personel_id, nesne) {


    //$(nesne).parent("li").addClass("tab-current");
    setTimeout(function () {
        var data = "islem=personel_giris_cikis_getir";
        data += "&personel_id=" + personel_id;
        data = encodeURI(data);
        $("#giris_cikis").loadHTML({ url: "/ajax_request/", data: data }, function () {
            $(".timepicker").mask("99:99");
        });
    }, 200);

}

function zimmet_getir(etiket, etiket_id, nesne) {
    $(".personel_tablar").html("");
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");

    setTimeout(function () {
        var data = "islem=zimmet_getir";
        data += "&etiket=" + etiket;
        data += "&etiket_id=" + etiket_id;
        data = encodeURI(data);
        $("#zimmet").loadHTML({ url: "/ajax_request/", data: data }, function () {

        });
    }, 200);
}

function firma_zimmet_getir(etiket, etiket_id, nesne) {
    $(".musteri_tablari").html("");
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");

    setTimeout(function () {

        var data = "islem=zimmet_getir";
        data += "&etiket=" + etiket;
        data += "&etiket_id=" + etiket_id;
        data = encodeURI(data);
        $("#zimmet").loadHTML({ url: "/ajax_request/", data: data }, function () {

        });
    }, 200);



}

function personel_cari_getir(personel_id, nesne) {
    $(".personel_tablar").html("");
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");

    setTimeout(function () {

        var data = "islem=personel_cari_getir";
        data += "&personel_id=" + personel_id;
        data = encodeURI(data);
        $("#cari_hareketler").loadHTML({ url: "/ajax_request/", data: data }, function () {

        });


    }, 200);

}


function bordro_indir(dosya_yolu) {

    $(window).off('beforeunload');
    window.location.href = "/ajax_request6/?jsid=4559&islem=bordro_indir&dosya_yolu=" + encodeURI(dosya_yolu);


}

function bordro_gönder(dosya_yolu) {

    $(window).off('beforeunload');
    window.location.href = "/ajax_request6/?jsid=4559&islem=bordro_gonder&dosya_yolu=" + encodeURI(dosya_yolu);

}

function depo_dosya_indir(etiket, kayit_id, dosya_id) {
    $(window).off('beforeunload');
    window.location.href = "/dosya_indir/" + dosya_id;
}

function depo_dosya_ac(etiket, kayit_id, dosya_id) {
    window.open("/dosya_ac/" + dosya_id);
}

function depo_dosya_sil(etiket, kayit_id, dosya_id) {

    var r = confirm("Kaydı Silmek İstediğinize Emin misiniz?");

    if (r) {
        var data = "islem=depo_dosyalari_getir&islem2=sil";
        data += "&etiket=" + etiket;
        data += "&kayit_id=" + kayit_id;
        data += "&dosya_id=" + dosya_id;
        data = encodeURI(data);
        $("#depo_dosya_listesi").loadHTML({ url: "/ajax_request2/", data: data }, function () {
            mesaj_ver("Dosya Deposu", "Kayıt Başarıyla Silindi", "success");
            zorunlu_dosyalar(etiket, kayit_id);
        });
    }
}


function depo_dosya_yukle(etiket, kayit_id) {

    //if ($("#dosya_yukleme_form input[type=text]").valid("valid")) {

    if ($("#dosyalarSelect").val().length > 0) {
        if ($("#depo_dosya_yolu").val().length > 0) {
            var depo_dosya_yolu = $("#depo_dosya_yolu").attr("filepath");
            var aciklama = $("#aciklama").val();
            var dosyaAdi = $("#dosyalarSelect option:selected").html();
            var dosyaId = $("#dosyalarSelect").val();

            var data = "islem=depo_dosyalari_getir&islem2=ekle";
            data += "&etiket=" + etiket;
            data += "&kayit_id=" + kayit_id;
            data += "&depo_dosya_yolu=" + depo_dosya_yolu;
            data += "&aciklama=" + aciklama;
            data += "&depo_dosya_adi=" + dosyaAdi;
            data += "&depo_dosya_id=" + dosyaId;
            data = encodeURI(data);
            $("#depo_dosya_listesi").loadHTML({ url: "/ajax_request2/", data: data }, function () {
                mesaj_ver("Dosya Deposu", "", "Kayıt Başarıyla Eklendi");
                zorunlu_dosyalar(etiket, kayit_id);
            });
        }
        else
            mesaj_ver("Dosyalar", "Dosya Zorunludur !", "danger");
    }
    else
        mesaj_ver("Dosyalar", "Dosya Tipi Zorunludur !", "danger");
    //}
}

function proje_depo_dosya_yukle(etiket, kayit_id) {

    if ($("#dosya_yukleme_form input[type=text]").valid("valid")) {

        var depo_dosya_yolu = $("#depo_dosya_yolu").attr("filepath");
        var depo_dosya_adi = $("#depo_dosya_adi").val();

        var data = "islem=proje_depo_dosyalari_getir&islem2=ekle";
        data += "&etiket=" + etiket;
        data += "&kayit_id=" + kayit_id;
        data += "&depo_dosya_yolu=" + depo_dosya_yolu;
        data += "&depo_dosya_adi=" + depo_dosya_adi;
        data = encodeURI(data);
        $("#depo_dosya_listesi").loadHTML({ url: "/ajax_request2/", data: data }, function () {
            mesaj_ver("Dosya Deposu", "", "Kayıt Başarıyla Eklendi");
        });
    }
}

function proje_depo_dosyalari_getir(etiket, kayit_id) {

    var data = "islem=proje_depo_dosyalari_getir";
    data += "&etiket=" + etiket;
    data += "&kayit_id=" + kayit_id;
    data = encodeURI(data);
    $("#depo_dosya_listesi").loadHTML({ url: "/ajax_request2/", data: data }, function () {

    });
}

function depo_dosyalari_getir(etiket, kayit_id) {

    var data = "islem=depo_dosyalari_getir";
    data += "&etiket=" + etiket;
    data += "&kayit_id=" + kayit_id;
    data = encodeURI(data);
    $("#depo_dosya_listesi").loadHTML({ url: "/ajax_request2/", data: data }, function () {

    });
}

function onbellekten_proje_is_listesi_getir(proje_id, nesne) {
    eldeki_function = 7;
    eldeki_proje_id = proje_id;
    eldeki_nesne = nesne;
}


function proje_is_listesi_getir(proje_id, nesne) {

    $(".proje_usttab").find("section").each(function () {
        $(this).html("");
    });
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");

    setTimeout(function () {
        var data = "islem=proje_is_listesi_getir";
        data += "&proje_id=" + proje_id;
        data = encodeURI(data);
        $("#is_listesi_tab").show().loadHTML({ url: "/ajax_request/", data: data }, function () {
            is_listesi_etiket("proje", proje_id, "", "proje");
        });
    }, 200);
}

var eldeki_departman_id;

function onbellekten_proje_olaylar_getir(proje_id, departman_id, nesne) {

    eldeki_proje_id = proje_id;
    eldeki_departman_id = departman_id;
    eldeki_nesne = nesne;
    eldeki_function = 1;


}


function proje_olaylar_getir(proje_id, departman_id, nesne) {

    $(".proje_usttab").find("section").each(function () {
        $(this).html("");
    });
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");

    setTimeout(function () {
        var data = "islem=proje_olaylar_getir";
        data += "&id=" + proje_id;
        data += "&departman_id=" + departman_id;
        data = encodeURI(data);
        $("#olaylar_tab").show().loadHTML({ url: "/santiyeler_ic_detay/", data: data }, function () {

        });
    }, 200);



}

var eldeki_tip;
function onbellekten_proje_planlama_getir(proje_id, tip, nesne) {

    eldeki_proje_id = proje_id;
    eldeki_tip = tip;
    eldeki_nesne = nesne;
    eldeki_function = 2;

}


function proje_planlama_getir(proje_id, tip, nesne) {

    $(".proje_usttab").find("section").each(function () {
        $(this).html("");
    });
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");

    setTimeout(function () {

        var data = "islem=proje_planlama_getir";
        data += "&proje_id=" + proje_id;
        data += "&tip=" + tip;
        data = encodeURI(data);
        $("#" + tip + "_tab").show().loadHTML({ url: "/ajax_request2/", data: data }, function () {

        });

    }, 200);


}

function onbellekten_proje_satinalma_getir(proje_id, nesne) {

    eldeki_proje_id = proje_id;
    eldeki_nesne = nesne;
    eldeki_function = 3;

}

function proje_satinalma_getir(proje_id, nesne) {

    $(".proje_usttab").find("section").each(function () {
        $(this).html("");
    });
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");

    setTimeout(function () {

        var data = "islem=proje_satinalma_getir";
        data += "&proje_id=" + proje_id;
        data = encodeURI(data);
        $("#satinalma_tab").show().loadHTML({ url: "/ajax_request2/", data: data }, function () {
            datatableyap();
        });
    }, 200);
}

function onbellekten_proje_gelir_getir(proje_id, nesne) {

    eldeki_proje_id = proje_id;
    eldeki_nesne = nesne;
    eldeki_function = 4;

}


function proje_gelir_getir(proje_id, nesne) {

    $(".proje_usttab").find("section").each(function () {
        $(this).html("");
    });
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");

    setTimeout(function () {

        var data = "islem=proje_gelir_getir";
        data += "&proje_id=" + proje_id;
        data = encodeURI(data);
        $("#gelir_tab").show().loadHTML({ url: "/ajax_request2/", data: data }, function () {

        });

    }, 200);

}


function anasayfa_proje_durum_bilgisi_getir(proje_id) {

    var data = "islem=anasayfa_proje_durum_bilgisi_getir";
    data += "&proje_id=" + proje_id;
    data = encodeURI(data);
    $("#proje_durum_yeri").loadHTML({ url: "/ajax_request/", data: data }, function () {

    });

}

function onbellekten_santiye_rapor_getir(proje_id, nesne) {

    eldeki_function = 9;
    eldeki_proje_id = proje_id;
    eldeki_nesne = nesne;


}

function santiye_rapor_getir(proje_id, nesne) {

    $(".proje_usttab").find("section").each(function () {
        $(this).html("");
    });
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");

    setTimeout(function () {
        var data = "islem=santiye_rapor_getir";
        data += "&proje_id=" + proje_id;
        data = encodeURI(data);
        $("#raporlar_tab").loadHTML({ url: "/ajax_request2/", data: data }, function () {
            $("#raporlar_tab").show();
        });
    }, 200);

}



function servis_getir(proje_id, nesne) {

    $(".proje_usttab").find("section").each(function () {
        $(this).html("");
    });
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");

    setTimeout(function () {

        var data = "islem=servis_getir";
        data += "&proje_id=" + proje_id;
        data = encodeURI(data);
        $("#servis_tab").show().loadHTML({ url: "/ajax_request5/", data: data }, function () {
            $(".takvimyap").datepicker({}).mask("99.99.9999");
            /*
            if ($('.datatableyaps').length > 0) {
                $('#servis_tab').find(".datatableyaps").dataTable({
                    "sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6'f><'col-sm-6 col-xs-12 hidden-xs'l>r>" +
                        "t" +
                        "<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
                    "autoWidth": true,
                    "preDrawCallback": function () {
                        var table = $(this);
                        if (!responsiveHelper_dt_basic) {
                            responsiveHelper_dt_basic = new ResponsiveDatatablesHelper(table, breakpointDefinition);
                        }
                    },
                    "rowCallback": function (nRow) {
                        responsiveHelper_dt_basic.createExpandIcon(nRow);
                    },
                    "drawCallback": function (oSettings) {
                        responsiveHelper_dt_basic.respond();
                    }
                });
            }*/
        });
    }, 200);

}



function onbellekten_servis_getir(proje_id, nesne) {
    /*
        eldeki_function = 15;
        eldeki_proje_id = proje_id;
        eldeki_nesne = nesne;
    */

    eldeki_function = 10;
    eldeki_proje_id = proje_id;
    eldeki_nesne = nesne;

    /*
    setTimeout(function () {
        $("#servis_tab").html($("#servis_ici").html()).show();
        if ($('.datatableyaps').length > 0) {
            $('#servis_tab').find(".datatableyaps").dataTable({
                "sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6'f><'col-sm-6 col-xs-12 hidden-xs'l>r>" +
                    "t" +
                    "<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
                "autoWidth": true,
                "preDrawCallback": function () {
                    var table = $(this);
                    if (!responsiveHelper_dt_basic) {
                        responsiveHelper_dt_basic = new ResponsiveDatatablesHelper(table, breakpointDefinition);
                    }
                },
                "rowCallback": function (nRow) {
                    responsiveHelper_dt_basic.createExpandIcon(nRow);
                },
                "drawCallback": function (oSettings) {
                    responsiveHelper_dt_basic.respond();
                }
            });
        }
    }, 500);

    */
}



function onbellekten_santiye_adam_saat_getir(proje_id, nesne) {

    eldeki_function = 8;
    eldeki_proje_id = proje_id;
    eldeki_nesne = nesne;

}

function santiye_adam_saat_getir(proje_id, nesne) {


    $(".proje_usttab").find("section").each(function () {
        $(this).html("");
    });
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");

    setTimeout(function () {

        var data = "islem=santiye_adam_saat_getir";
        data += "&proje_id=" + proje_id;
        data = encodeURI(data);
        $("#adam_saat_tab").show().loadHTML({ url: "/ajax_request2/", data: data }, function () {

        });

    }, 200);
}

function departman_adam_saat_getir() {

    var etiketler = $("#etiketler").val();
    var rapor_personel_id = $("#rapor_personel_id").val();
    var yeni_is_yuku_proje_id = $("#yeni_is_yuku_proje_id").val();
    var baslangic = $("#is_yuku_donem option:selected").attr("dongu_baslangic");
    var bitis = $("#is_yuku_donem option:selected").attr("dongu_bitis");

    var data = "islem=departman_adam_saat_getir";
    data += "&etiketler=" + etiketler;
    data += "&rapor_personel_id=" + rapor_personel_id;
    data += "&yeni_is_yuku_proje_id=" + yeni_is_yuku_proje_id;
    data += "&baslangic=" + baslangic;
    data += "&bitis=" + bitis;
    data = encodeURI(data);
    $("#adam_saat_tab").loadHTML({ url: "/ajax_request4/", data: data }, function () {

    });

}


function onbellekten_proje_ajanda_getir(proje_id, nesne) {

    eldeki_proje_id = proje_id;
    eldeki_nesne = nesne;
    eldeki_function = 5;

}

function proje_ajanda_getir(proje_id, nesne) {

    $(".proje_usttab").find("section").each(function () {
        $(this).html("");
    });
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");

    setTimeout(function () {
        var data = "islem=proje_ajanda_getir";
        data += "&proje_id=" + proje_id;
        data = encodeURI(data);
        $("#ajanda_tab").show().loadHTML({ url: "/ajax_request2/", data: data }, function () {
            ajanda_calistir();
        });


    }, 200);

}


function proje_satinalma_kayit_sil(proje_id, satis_id) {
    var r = confirm("Kaydı Silmek istediğinize Eminmisiniz.. ?");
    if (r) {
        var data = "islem=proje_butce_listesi_getir&islem2=satinalmasil";
        data += "&proje_id=" + proje_id;
        data += "&satis_id=" + satis_id;
        data = encodeURI(data);
        $("#proje_butce_yeri").loadHTML({ url: "/ajax_request2/", data: data }, function () {
            mesaj_ver("Proje Bütçeler", "Kayıt Başarıyla Silindi", "success");
            datatableyap();
            proje_butce_listesi_getir(proje_id);
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
    //                var data = "islem=proje_butce_listesi_getir&islem2=satinalmasil";
    //                data += "&proje_id=" + proje_id;
    //                data += "&satis_id=" + satis_id;
    //                data = encodeURI(data);
    //                $("#proje_butce_yeri").loadHTML({ url: "/ajax_request2/", data: data }, function () {
    //                    mesaj_ver("Proje Bütçeler", "Kayıt Başarıyla Silindi", "success");
    //                    datatableyap();
    //                    proje_butce_listesi_getir(proje_id);
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


function proje_butce_listesi_getir(proje_id) {
    var data = "islem=proje_butce_listesi_getir";
    data += "&proje_id=" + proje_id;
    data = encodeURI(data);
    $("#proje_butce_yeri").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        datatableyap();
    });
    ProjeGiderListesi(proje_id);
}

function proje_gelir_cek(proje_id) {
    var data = "islem=proje_gelir_getir";
    data += "&proje_id=" + proje_id;
    data = encodeURI(data);
    $("#proje_gelir_yer").show().loadHTML({ url: "/ajax_request2/", data: data }, function () {
        datatableyap();
    });
}

function ProjeGiderListesi(proje_id) {
    var data = "islem=ProjeGiderleri";
    data += "&projeID=" + proje_id;
    data = encodeURI(data);
    $("#proje_gider_yeri").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        datatableyap();
    });
}

function proje_satinalma_listesi(proje_id) {
    var data = "islem=proje_satinalma_listesi";
    data += "&proje_id=" + proje_id;
    data = encodeURI(data);
    $("#proje_satinalma_listesi").loadHTML({ url: "/ajax_request2/", data: data }, function () {

    });
}

var eldeki_proje_id;
var eldeki_nesne;
var eldeki_function = 0;

function onbellekten_proje_dosyalari_getir(proje_id, nesne) {

    eldeki_proje_id = proje_id;
    eldeki_nesne = nesne;
    eldeki_function = 6;

}

function proje_dosyalari_getir(proje_id, nesne) {


    $(".proje_usttab").find("section").each(function () {
        $(this).html("");
    });
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");

    setTimeout(function () {
        $("#dosyalar_tab").show();
        file_depo_getir("dosyalar_tab", "proje", proje_id);
    }, 200);

}

function bordro_kaydet(personel_id) {

    var bordro_dosya_yolu = $("#bordro_dosya_yolu").attr("filePath");
    var bordro_donem = $("#bordro_donem").val();
    var bordro_aciklama = $("#bordro_aciklama").val();

    var data = "islem=bordro_kaydet";
    data += "&personel_id=" + personel_id;
    data += "&bordro_dosya_yolu=" + bordro_dosya_yolu;
    data += "&bordro_donem=" + bordro_donem;
    data += "&bordro_aciklama=" + bordro_aciklama;
    data = encodeURI(data);

    $("#koftiden").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        mesaj_ver("Bordrolar", "Kayıt Başarıyla Eklendi", "success");
        $("#bordro_buton").click();
        personel_bordro_getir(personel_id);
    });

}

function kategori_ekle() {

    var kategori_adi = $("#kategori_adi").val();

    var data = "islem=kategori_listesi&islem2=ekle";
    data += "&kategori_adi=" + kategori_adi;
    data = encodeURI(data);
    $("#kategori_listesi").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        mesaj_ver("Kategori", "Kayıt Başarıyla Eklendi", "success");
    });

}

function tanimlama_kategori_getir() {

    var data = "islem=kategori_listesi"
    data = encodeURI(data);
    $("#kategori_listesi").loadHTML({ url: "/ajax_request6/", data: data }, function () {
    });

}

function tanimlama_kategori_sil(kayit_id) {

    var r = confirm("Kaydı Silmek İstediğinize Emin misiniz?");
    if (r) {

        var data = "islem=kategori_listesi&islem2=sil";
        data += "&kayit_id=" + kayit_id;
        data = encodeURI(data);
        $("#kategori_listesi").loadHTML({ url: "/ajax_request6/", data: data }, function () {
            mesaj_ver("Kategori", "Kayıt Başarıyla Silindi", "success");
        });

    }
}

function parca_sil(kayit_id) {

    var r = confirm("Silmek İstediğinize Emin misiniz?");
    if (r) {
        var data = "islem=parca_listesi&islem2=sil";
        data += "&kayit_id=" + kayit_id;
        data = encodeURI(data);
        $("#parca_listesi").loadHTML({ url: "/ajax_request6/", data: data }, function () {
            mesaj_ver("Parçalar", "Kayıt Başarıyla Silindi", "success");
        });
    }

}

function ModalParcaArama() {

    var data = "islem=ModalParcaArama";
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request5/", data: data }, function () {
        sayfa_yuklenince();
    });

}

function ModalExcellUpload() {

    var data = "islem=ModalExcellUpload";
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request5/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function ModalYetkiliEkle() {

    var data = "islem=ModalYetkiliEkle";
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "islem1", data: data }, function () {
        sayfa_yuklenince();
    });

    //var data = "islem=ModalYetkiliEkle";
    //$("#firma_listesi").loadHTML({ url: "islem1", data: data }, function () {
    //    datatableyap();

    //    $(".yetmislik option[value=" + selectValue + "]").attr('selected', 'selected');
    //    $(".yetmislik").trigger("change");
    //    mesaj_ver("Firmalar", "Kayıt Başarıyla Eklendi", "success");
    //});

    //var data = "islem=ModalYetkiliEkle";
    //data = encodeURI(data);
    //$("#modal_butonum").click();
    //$("#modal_div").loadHTML({ url: "/ajax_request5/", data: data }, function () {
    //    sayfa_yuklenince();
    //});
}

function YöneticilerEkle() {

    var yetkili2_adi = $("#yetkili2_adi").val();
    var yetkili2_telefon = $("#yetkili2_telefon").val();
    var yetkili2_mail = $("#yetkili2_mail").val();

    var yetkili3_adi = $("#yetkili3_adi").val();
    var yetkili3_telefon = $("#yetkili3_telefon").val();
    var yetkili3_mail = $("#yetkili3_mail").val();

    var yetkili4_adi = $("#yetkili4_adi").val();
    var yetkili4_telefon = $("#yetkili4_telefon").val();
    var yetkili4_mail = $("#yetkili4_mail").val();

    var data = "yetkili2_adi" + yetkili2_adi;
    var data = "&yetkili2_telefon" + yetkili2_telefon;
    var data = "&yetkili2_mail" + yetkili2_mail;

    var data = "&yetkili3_adi" + yetkili3_adi;
    var data = "&yetkili3_telefon" + yetkili3_telefon;
    var data = "&yetkili3_mail" + yetkili3_mail;

    var data = "&yetkili4_adi" + yetkili4_adi;
    var data = "&yetkili4_telefon" + yetkili4_telefon;
    var data = "&yetkili4_mail" + yetkili4_mail;
    var data = "islem=YöneticilerEkle";
    data = encodeURI(data);
    $(".close").click();
    $("#ManagersDatas").attr("yetkili2_adi", yetkili2_adi).attr("yetkili2_telefon", yetkili2_telefon).attr("yetkili2_mail", yetkili2_mail);
    $("#ManagersDatas").attr("yetkili3_adi", yetkili3_adi).attr("yetkili3_telefon", yetkili3_telefon).attr("yetkili3_mail", yetkili3_mail);
    $("#ManagersDatas").attr("yetkili4_adi", yetkili4_adi).attr("yetkili4_telefon", yetkili4_telefon).attr("yetkili4_mail", yetkili4_mail);
}

function StokListesiTemizle() {

    var r = confirm("Bütün Tabloyu Silmek İstediğinize Eminmisiniz ?");
    if (r) {
        var data = "islem=StokListesiTemizle";
        data = encodeURI(data);
        $("#parca_listesi").loadHTML({ url: "/ajax_request5/", data: data }, function () {
            mesaj_ver("Stok Listesi", "Bütün Kayıtlar Silindi !", "success");
            parcalari_getir();
            sayfa_yuklenince();
        });
    }
}

function ModalSatinalmaArama() {

    var data = "islem=ModalSatinalmaArama";
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request5/", data: data }, function () {
        sayfa_yuklenince();
    });

}

function ModalBakimArama() {

    var data = "islem=ModalBakimArama";
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request5/", data: data }, function () {
        sayfa_yuklenince();
    });

}


function Modaldan_parca_ara() {

    var marka = $("#marka").val();
    var parca_adi = $("#parca_adi").val();
    var kategori = $("#kategori").val();
    var aciklama = $("#aciklama").val();
    var barcode = $("#barcode").val();
    var kodu = $("#kodu").val();

    var data = "islem=parca_listesi&islem2=arama";
    data += "&marka=" + marka;
    data += "&parca_adi=" + parca_adi;
    data += "&kategori=" + kategori;
    data += "&aciklama=" + aciklama;
    data += "&barcode=" + barcode;
    data += "&kodu=" + kodu;
    data = encodeURI(data);
    $("#parca_listesi").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        sayfa_yuklenince();
    });

}

function parcalari_getir(sayfa) {

    var data = "islem=parca_listesi";
    data += "&sayfa=" + sayfa;
    data = encodeURI(data);
    $("#parca_listesi").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        sayfa_yuklenince();
    });

}

function parca_duzenle(kayit_id) {

    var data = "islem=parca_duzenle";
    data += "&kayit_id=" + kayit_id;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request5/", data: data }, function () {
        sayfa_yuklenince();
    });

}


function parca_guncelle(kayit_id) {

    var parca_resmi = $("#parca_resmi").val();
    var marka = $("#marka").val();
    var parca_adi = $("#parca_adi").val();
    var kategori = $("#kategori").val();
    var aciklama = $("#aciklama").val();
    var birim_maliyet = $("#birim_maliyet").val();
    var birim_pb = $("#birim_pb").val();
    var birim = $("#birim").val();
    var miktar = $("#miktar").val();
    var minumum_miktar = $("#minumum_miktar").val();
    var barcode = $("#barcode").val();
    var kodu = $("#kodu").val();

    var data = "islem=parca_listesi&islem2=guncelle";
    data += "&kayit_id=" + kayit_id;
    data += "&parca_resmi=" + parca_resmi;
    data += "&marka=" + marka;
    data += "&parca_adi=" + parca_adi;
    data += "&kategori=" + kategori;
    data += "&aciklama=" + aciklama;
    data += "&birim_maliyet=" + birim_maliyet;
    data += "&birim_pb=" + birim_pb;
    data += "&birim=" + birim;
    data += "&miktar=" + miktar;
    data += "&minumum_miktar=" + minumum_miktar;
    data += "&barcode=" + barcode;
    data += "&kodu=" + kodu;
    data = encodeURI(data);
    $("#parca_listesi").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        $(".close").click();
        mesaj_ver("Parçalar", "Kayıt Başarıyla Güncellendi", "success");
    });

}

function yeni_parca_ekle() {

    var parca_resmi = $("#parca_resmi").val();
    var marka = $("#marka").val();
    var parca_adi = $("#parca_adi").val();
    var kategori = $("#kategori").val();
    var aciklama = $("#aciklama").val();
    var birim_maliyet = $("#birim_maliyet").val();
    var birim_pb = $("#birim_pb").val();
    var birim = $("#birim").val();
    var miktar = $("#miktar").val();
    var minumum_miktar = $("#minumum_miktar").val();
    var barcode = $("#barcode").val();
    var kodu = $("#kodu").val();

    var data = "islem=parca_listesi&islem2=ekle";
    data += "&parca_resmi=" + parca_resmi;
    data += "&marka=" + marka;
    data += "&parca_adi=" + parca_adi;
    data += "&kategori=" + kategori;
    data += "&aciklama=" + aciklama;
    data += "&birim_maliyet=" + birim_maliyet;
    data += "&birim_pb=" + birim_pb;
    data += "&birim=" + birim;
    data += "&miktar=" + miktar;
    data += "&minumum_miktar=" + minumum_miktar;
    data += "&barcode=" + barcode;
    data += "&kodu=" + kodu;
    data = encodeURI(data);
    $("#parca_listesi").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        mesaj_ver("Parçalar", "Kayıt Başarıyla Eklendi", "success");
        $(".close").click();
        sayfa_yuklenince();
    });

}

function bordro_sil(kayit_id) {

    var data = "islem=bordro_sil";
    data += "&kayit_id=" + kayit_id;
    data = encodeURI(data);
    $("#koftiden").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        mesaj_ver("Bordrolar", "Kayıt Başarıyla Silindi", "success");
        $("#bordro_buton").click();
    });

}

function personel_dosyalari_getir(personel_id, nesne, loc) {
    $(".personel_tablar").html("");
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");

    setTimeout(function () {
        file_depo_getir("dosyalar", "personel", personel_id, loc);
    }, 200);
}


function file_depo_getir(divID, etiket, kayit_id, loc) {
    var data;
    if (loc === "personel")
        data = "islem=file_depo_getir";
    else
        data = "islem=proje_file_depo_getir";

    data += "&etiket=" + etiket;
    data += "&kayit_id=" + kayit_id;
    data = encodeURI(data);
    $("#" + divID).loadHTML({ url: "/ajax_request/", data: data }, function () {
        fileyap();
    });
}

function is_listesi_lineer_takvim_getir() {

    var data = "islem=is_listesi_lineer_takvim_getir";
    data = encodeURI(data);
    $("#is_listesi_takvim_yeri").loadHTML({ url: "/ajax_request2/", data: data, loading: false }, function () {

    });

}


function datediff(first, second) {
    // Take the difference between the dates and divide by milliseconds per day.
    // Round to nearest whole number to deal with DST.
    return Math.round((second - first) / (1000 * 60 * 60 * 24));
}

function personel_ajandasi_getir(personel_id, nesne) {
    $(".personel_tablar").html("");
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");

    setTimeout(function () {
        var data = "islem=personel_ajandasi_getir";
        data += "&personel_id=" + personel_id;
        data = encodeURI(data);
        $("#personel_ajanda").loadHTML({ url: "/ajax_request/", data: data }, function () {
            ajanda_calistir();
        });
    }, 200);
}


function personel_is_listesi_getir(personel_id, nesne) {
    $(".personel_tablar").html("");
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");

    setTimeout(function () {
        var data = "islem=personel_is_listesi_getir";
        data += "&personel_id=" + personel_id;
        data = encodeURI(data);
        $("#is_listesi_panel").loadHTML({ url: "/ajax_request/", data: data }, function () {
            is_listesi_etiket("personel", personel_id, "", "personelIsleri");
        });
    }, 200);
}

function is_listesi_etiket(etiket_tip, etiket, stok, yer) {

    var adi = "";
    var durum = "0";
    var gorevliler = "0";
    var firmalar = "0";
    var santiyeler = "0";
    var departmanlar = "0";
    var baslangic_tarihi = "";
    var bitis_tarihi = "";
    var is_baslangic_tarihi = "";
    var is_bitis_tarihi = "";
    var toplantilar = "";
    var parcalar = "";

    if (etiket_tip == "personel") {
        gorevliler = etiket;
    }

    if (etiket_tip == "firma") {
        firmalar = etiket;
    }


    if (etiket_tip == "proje") {
        santiyeler = etiket;
    }


    if (etiket_tip == "toplanti") {
        toplantilar = etiket;
    }

    if (etiket_tip == "parca") {
        parcalar = etiket;
    }


    var data = "islem=AllTask";
    data += "&stok=" + stok;
    data += "&yer=" + yer;
    data += "&parcaId=" + etiket;
    data += "&projeId=" + etiket;
    data += "&personelId=" + etiket;
    data += "&durum=";
    data += "&tip=";
    data += "&adi=" + adi;
    data += "&is_durum=" + durum;
    data += "&gorevliler=" + gorevliler;
    data += "&firmalar=" + firmalar;
    data += "&santiyeler=" + santiyeler;
    data += "&departmanlar=" + departmanlar;
    data += "&baslangic_tarihi=" + baslangic_tarihi;
    data += "&bitis_tarihi=" + bitis_tarihi;
    data += "&is_baslangic_tarihi=" + is_baslangic_tarihi;
    data += "&is_bitis_tarihi=" + is_bitis_tarihi;
    data += "&toplantilar=" + toplantilar;
    data += "&parcalar=" + parcalar;

    $("#tum_isler").loadHTML({ url: "islem1", data: data }, function () {
        sayfa_yuklenince();
        //is_tablo_islemler();
    });

}


function taseron_adam_saat_gosterim_tarih_sectim(firma_id) {

    var is_yuku_donem = $("#is_yuku_donem").val();
    var is_yuku_gosterim_tipi = $("#is_yuku_gosterim_tipi").val();
    var is_yuku_proje_id = $("#is_yuku_proje_id").val();

    var ay = is_yuku_donem.split("-")[0];
    var yil = is_yuku_donem.split("-")[1];

    var data = "islem=taseron_adamsaat_getir";
    data += "&firma_id=" + firma_id;
    data += "&gosterim_tipi=" + is_yuku_gosterim_tipi;
    data += "&ay=" + ay;
    data += "&yil=" + yil;
    data += "&proje_id=" + is_yuku_proje_id;
    data = encodeURI(data);
    $("#adamsaat").loadHTML({ url: "/ajax_request/", data: data }, function () { });

}


function proje_rapor_adam_saat_gosterim_tarih_sectim(personel_id) {

    var rapor_is_yuku_donem = $("#rapor_is_yuku_donem").val();
    var rapor_is_yuku_gosterim_tipi = $("#rapor_is_yuku_gosterim_tipi").val();
    var rapor_is_yuku_proje_id = $("#rapor_is_yuku_proje_id").val();

    var ay = rapor_is_yuku_donem.split("-")[0];
    var yil = rapor_is_yuku_donem.split("-")[1];

    var data = "islem=santiye_rapor_getir";
    data += "&personel_id=" + personel_id;
    data += "&gosterim_tipi=" + rapor_is_yuku_gosterim_tipi;
    data += "&ay=" + ay;
    data += "&yil=" + yil;
    data += "&proje_id=" + rapor_is_yuku_proje_id;
    data = encodeURI(data);
    $("#raporlar_tab").loadHTML({ url: "/ajax_request2/", data: data }, function () { });

}


function personel_adam_saat_gosterim_tarih_sectim(personel_id) {

    var is_yuku_donem = $("#is_yuku_donem").val();
    var is_yuku_gosterim_tipi = $("#is_yuku_gosterim_tipi").val();
    var is_yuku_proje_id = $("#is_yuku_proje_id").val();

    var ay = is_yuku_donem.split("-")[0];
    var yil = is_yuku_donem.split("-")[1];

    var data = "islem=personel_adamsaat_getir";
    data += "&personel_id=" + personel_id;
    data += "&gosterim_tipi=" + is_yuku_gosterim_tipi;
    data += "&ay=" + ay;
    data += "&yil=" + yil;
    data += "&proje_id=" + is_yuku_proje_id;
    data = encodeURI(data);
    $("#adam_saat_cetveli").loadHTML({ url: "/ajax_request/", data: data }, function () { });

}

function personel_adamsaat_getir(personel_id, nesne, ay, yil) {
    $(".personel_tablar").html("");
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");

    setTimeout(function () {
        var data = "islem=personel_adamsaat_getir";
        data += "&personel_id=" + personel_id;
        data += "&ay=" + ay;
        data += "&yil=" + yil;
        data = encodeURI(data);
        $("#adam_saat_cetveli").loadHTML({ url: "/ajax_request/", data: data }, function () { });
    }, 200);

}



function taseron_adamsaat_getir(firma_id, nesne, ay, yil) {
    $(".musteri_tablari").html("");
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");

    setTimeout(function () {
        var data = "islem=taseron_adamsaat_getir";
        data += "&firma_id=" + firma_id;
        data += "&ay=" + ay;
        data += "&yil=" + yil;
        data = encodeURI(data);
        $("#adamsaat").loadHTML({ url: "/ajax_request/", data: data }, function () { });
    }, 200);

}



function personel_raporlarini_getir(personel_id, nesne, coklumu) {
    $(".personel_tablar").html("");
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");

    if (coklumu == undefined) {
        coklumu = "";
    }

    setTimeout(function () {
        var data = "islem=personel_raporlarini_getir";
        data += "&personel_id=" + personel_id;
        data += "&coklumu=" + coklumu;
        data = encodeURI(data);
        $("#raporlar").loadHTML({ url: "/ajax_request/", data: data }, function () { });
    }, 200);

}

function musteri_dosyalari_getir(firma_id, nesne) {

    $(".musteri_tablari").html("");
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");

    setTimeout(function () {
        file_depo_getir("dosyalar", "firma", firma_id);
    }, 200);

}

function cari_detay_tabela_getir(cari_id, tip) {

    var data = "islem=cari_detay_tabela_getir";
    data += "&cari_id=" + cari_id;
    data += "&tip=" + tip;
    data = encodeURI(data);
    $("#tabela_yeri").loadHTML({ url: "/ajax_request2/", data: data }, function () {

    });

}



function musteri_bilgilerini_getir(firma_id, nesne) {

    $(".musteri_tablari").html("");
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");

    setTimeout(function () {

        var data = "islem=musteri_bilgilerini_getir";
        data += "&firma_id=" + firma_id;
        data = encodeURI(data);
        $("#musteri_bilgileri").loadHTML({ url: "/ajax_request/", data: data }, function () {
            sayfa_yuklenince();
            $('.paraonly:not(.yapilan)').addClass("yapilan").maskMoney({ thousands: '.', decimal: ',', allowZero: true, suffix: ' ₺' });
        });

    }, 200);


}

function musteri_cari_hareketleri_getir(firma_id, nesne) {

    $(".musteri_tablari").html("");
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");

    setTimeout(function () {

        var data = "islem=musteri_cari_hareketleri_getir";
        data += "&firma_id=" + firma_id;
        data = encodeURI(data);
        $("#cari_hareketler").loadHTML({ url: "/ajax_request/", data: data }, function () {

        });
    }, 200);

}

function musteri_ajanda_getir(firma_id, nesne) {

    $(".musteri_tablari").html("");
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");

    setTimeout(function () {
        var data = "islem=musteri_ajanda_getir";
        data += "&firma_id=" + firma_id;
        data = encodeURI(data);
        $("#ajanda").loadHTML({ url: "/ajax_request/", data: data }, function () {
            ajanda_calistir();
        });

    }, 200);


}

function musteri_raporlarini_getir(firma_id, nesne) {

    $(".musteri_tablari").html("");
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");

    setTimeout(function () {
        var data = "islem=musteri_raporlarini_getir";
        data += "&firma_id=" + firma_id;
        data = encodeURI(data);
        $("#raporlar").loadHTML({ url: "/ajax_request/", data: data }, function () {

        });

    }, 200);


}

function musteri_is_listesi_getir(firma_id, nesne) {
    $(".musteri_tablari").html("");
    $(".nav-link_yeni").removeClass("tab-current");
    $(nesne).parent("li").addClass("tab-current");
    setTimeout(function () {
        var data = "islem=musteri_is_listesi_getir";
        data += "&firma_id=" + firma_id;
        data = encodeURI(data);
        $("#is_listesi_panel").loadHTML({ url: "/ajax_request/", data: data }, function () {
            is_listesi_etiket("firma", firma_id);
        });
    }, 200);
}


function cari_hareket_listesi_getir(cari_id, tip, yer) {
    var data = "islem=cari_hareket_listesi";
    data += "&cari_id=" + cari_id;
    data += "&tip=" + tip;
    data += "&yer=" + yer;
    data = encodeURI(data);
    $("#cari_hareket_listesi").loadHTML({ url: "/ajax_request/", data: data }, function () {

    });
}


function cari_hareket_kaydi_sil(cari_id, tip, kayit_id, islem_tipi, yer) {
    var r = confirm("Kaydı Silmek İstediğinize Emin misiniz?");
    if (r) {
        var data = "islem=cari_hareket_listesi&islem2=sil";
        data += "&cari_id=" + cari_id;
        data += "&tip=" + tip;
        data += "&kayit_id=" + kayit_id;
        data += "&islem_tipi=" + islem_tipi;
        data += "&yer=" + yer;
        data = encodeURI(data);
        $("#cari_hareket_listesi").loadHTML({ url: "/ajax_request/", data: data }, function () {
            cari_detay_tabela_getir(cari_id, tip);
        });
    }
}

function kendi_personel_bilgilerini_guncelle() {



    if ($("#personel_guncelleme_form input[type=text]").valid("valid")) {

        var personel_resim = $("#personel_resim").attr("filePath");
        var personel_ad = $("#personel_ad").val();
        var personel_soyad = $("#personel_soyad").val();
        var personel_dtarih = $("#personel_dtarih").val();
        var personel_cinsiyet = $("#personel_cinsiyet").val();
        var personel_eposta = $("#personel_eposta").val();
        var personel_telefon = $("#personel_telefon").val();
        var personel_parola = $("#personel_parola").val();
        var personel_tcno = $("#personel_tcno").val();

        var data = "islem=kendi_personel_bilgilerini_guncelle";
        data += "&personel_resim=" + personel_resim;
        data += "&personel_ad=" + personel_ad;
        data += "&personel_soyad=" + personel_soyad;
        data += "&personel_dtarih=" + personel_dtarih;
        data += "&personel_cinsiyet=" + personel_cinsiyet;
        data += "&personel_eposta=" + personel_eposta;
        data += "&personel_telefon=" + personel_telefon;
        data += "&personel_parola=" + personel_parola;
        data += "&personel_tcno=" + personel_tcno;
        data = encodeURI(data);
        $("#koftiden").loadHTML({ url: "/ajax_request/", data: data }, function () {
            mesaj_ver("Personel Detayları", "Kayıt Başarıyla Güncellendi", "success");
        });
    }
}


function personel_bilgilerini_guncelle(personel_id) {

    if ($("#personel_guncelleme_form input[type=text]").valid("valid")) {

        var personel_resim = $("#personel_resim").attr("filePath");
        var personel_ad = $("#personel_ad").val();
        var personel_soyad = $("#personel_soyad").val();
        var personel_dtarih = $("#personel_dtarih").val();
        var personel_cinsiyet = $("#personel_cinsiyet").val();
        var personel_eposta = $("#personel_eposta").val();
        var personel_telefon = $("#personel_telefon").val();
        var departmanlar = $("#departmanlar").val();
        var gorevler = $("#gorevler").val();
        var personel_parola = $("#personel_parola").val();
        var personel_saatlik_maliyet = $("#personel_saatlik_maliyet").val().replace("₺", "").replace(" ", "");
        var personel_maliyet_pb = $("#personel_maliyet_pb").val();
        var personel_tcno = $("#personel_tcno").val();
        var personel_yillik_izin = $("#personel_yillik_izin").val();
        var yonetici_yetkisi = $("#yonetici_yetkisi").val();
        var personel_yillik_izin_hakedis = $("#personel_yillik_izin_hakedis").val();
        var parmak_id = $("#parmak_id").val();


        var data = "islem=personel_bilgilerini_guncelle";
        data += "&personel_id=" + personel_id;
        data += "&personel_resim=" + personel_resim;
        data += "&personel_ad=" + personel_ad;
        data += "&personel_soyad=" + personel_soyad;
        data += "&personel_dtarih=" + personel_dtarih;
        data += "&personel_cinsiyet=" + personel_cinsiyet;
        data += "&personel_eposta=" + personel_eposta;
        data += "&personel_telefon=" + personel_telefon;
        data += "&departmanlar=" + departmanlar;
        data += "&gorevler=" + gorevler;
        data += "&personel_parola=" + personel_parola;
        data += "&personel_saatlik_maliyet=" + personel_saatlik_maliyet;
        data += "&personel_maliyet_pb=" + personel_maliyet_pb;
        data += "&personel_tcno=" + personel_tcno;
        data += "&personel_yillik_izin=" + personel_yillik_izin;
        data += "&yonetici_yetkisi=" + yonetici_yetkisi;
        data += "&personel_yillik_izin_hakedis=" + personel_yillik_izin_hakedis;
        data += "&parmak_id=" + parmak_id;
        data = encodeURI(data);
        $("#koftiden").loadHTML({ url: "/ajax_request/", data: data }, function () {
            mesaj_ver("Personel Detayları", "Kayıt Başarıyla Güncellendi", "success");
        })
    }

}



function odeme_kaydi_guncelle(nesne, cari_id, tip, yer, kayit_id) {
    if ($("#yeni_tahsilat_form input[type=text],textarea").valid("valid")) {
        var odeme_tipi = "Nakit";
        if ($("#odeme_tipi2").attr("checked") == "checked") {
            odeme_tipi = "Çek";
        }
        var islem_tarihi = $("#islem_tarihi").val();
        var vade_tarihi = $("#vade_tarihi").val();
        var meblag = $("#meblag").val();
        var parabirimi = $("#parabirimi").val();
        var aciklama = $("#aciklama").val();
        var data = "islem=cari_hareket_listesi&islem2=odeme_guncelle";
        data += "&cari_id=" + cari_id;
        data += "&tip=" + tip;
        data += "&yer=" + yer;
        data += "&kayit_id=" + kayit_id;
        data += "&odeme_tipi=" + odeme_tipi;
        data += "&islem_tarihi=" + islem_tarihi;
        data += "&vade_tarihi=" + vade_tarihi;
        data += "&meblag=" + meblag;
        data += "&parabirimi=" + parabirimi;
        data += "&aciklama=" + aciklama;
        data = encodeURI(data);
        $(nesne).attr("disabled", "disabled").val("İşlem Yapılıyor...");
        $("#cari_hareket_listesi").loadHTML({ url: "/ajax_request/", data: data }, function () {
            mesaj_ver("Finansman", "Kayıt Başarıyla Eklendi");
            cari_detay_tabela_getir(cari_id, tip);
            $(".close").click();
        });
    }
}





function cari_hareket_makbuz_goster(kayit_id) {
    var URL = "/cari_makbuz/?t=m&kid=" + kayit_id;
    day = new Date();
    id = day.getTime();
    eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=0,width=500,height=420,left=600,top=250');");
}


function tahsilat_kaydi_guncelle(nesne, cari_id, tip, yer, kayit_id) {
    if ($("#yeni_odeme_form input[type=text],textarea").valid("valid")) {
        var tahsilat_tipi = "Nakit";
        if ($("#tahsilat_tipi2").attr("checked") == "checked") {
            tahsilat_tipi = "Çek";
        }
        var islem_tarihi = $("#islem_tarihi").val();
        var vade_tarihi = $("#vade_tarihi").val();
        var meblag = $("#meblag").val();
        var parabirimi = $("#parabirimi").val();
        var aciklama = $("#aciklama").val();
        var data = "islem=cari_hareket_listesi&islem2=tahsilat_guncelle";
        data += "&cari_id=" + cari_id;
        data += "&tip=" + tip;
        data += "&yer=" + yer;
        data += "&kayit_id=" + kayit_id;
        data += "&tahsilat_tipi=" + tahsilat_tipi;
        data += "&islem_tarihi=" + islem_tarihi;
        data += "&vade_tarihi=" + vade_tarihi;
        data += "&meblag=" + meblag;
        data += "&parabirimi=" + parabirimi;
        data += "&aciklama=" + aciklama;
        data = encodeURI(data);
        $(nesne).attr("disabled", "disabled").val("İşlem Yapılıyor...");
        $("#cari_hareket_listesi").loadHTML({ url: "/ajax_request/", data: data }, function () {
            mesaj_ver("Finansman", "Kayıt Başarıyla Eklendi");
            cari_detay_tabela_getir(cari_id, tip);
            $(".close").click();
        });
    }
}



function tahsilat_kaydet(nesne, cari_id, tip, yer) {

    if ($("#yeni_tahsilat_form input[type=text],textarea").valid("valid")) {

        var tahsilat_tipi = "Nakit";
        if ($("#tahsilat_tipi2").attr("checked") == "checked") {
            tahsilat_tipi = "Çek";
        }
        var islem_tarihi = $("#islem_tarihi").val();
        var vade_tarihi = $("#vade_tarihi").val();
        var meblag = $("#meblag").val();
        var parabirimi = $("#parabirimi").val();
        var aciklama = $("#aciklama").val();

        var data = "islem=cari_hareket_listesi&islem2=tahsilat_ekle";
        data += "&cari_id=" + cari_id;
        data += "&tip=" + tip;
        data += "&yer=" + yer;
        data += "&tahsilat_tipi=" + tahsilat_tipi;
        data += "&islem_tarihi=" + islem_tarihi;
        data += "&vade_tarihi=" + vade_tarihi;
        data += "&meblag=" + meblag;
        data += "&parabirimi=" + parabirimi;
        data += "&aciklama=" + aciklama;
        data = encodeURI(data);
        $(nesne).attr("disabled", "disabled").val("İşlem Yapılıyor...");
        $("#cari_hareket_listesi").loadHTML({ url: "/ajax_request/", data: data }, function () {
            mesaj_ver("Finansman", "Kayıt Başarıyla Eklendi");
            $(".close").click();
            cari_detay_tabela_getir(cari_id, tip);
        });

    }

}


function odeme_kaydet(nesne, cari_id, tip, yer) {

    if ($("#yeni_odeme_form input[type=text],textarea").valid("valid")) {

        var odeme_tipi = "Nakit";
        if ($("#odeme_tipi2").attr("checked") == "checked") {
            odeme_tipi = "Çek";
        }
        var islem_tarihi = $("#islem_tarihi").val();
        var vade_tarihi = $("#vade_tarihi").val();
        var meblag = $("#meblag").val();
        var parabirimi = $("#parabirimi").val();
        var aciklama = $("#aciklama").val();

        var data = "islem=cari_hareket_listesi&islem2=odeme_ekle";
        data += "&cari_id=" + cari_id;
        data += "&tip=" + tip;
        data += "&yer=" + yer;
        data += "&odeme_tipi=" + odeme_tipi;
        data += "&islem_tarihi=" + islem_tarihi;
        data += "&vade_tarihi=" + vade_tarihi;
        data += "&meblag=" + meblag;
        data += "&parabirimi=" + parabirimi;
        data += "&aciklama=" + aciklama;
        data = encodeURI(data);
        $(nesne).attr("disabled", "disabled").val("İşlem Yapılıyor...");
        $("#cari_hareket_listesi").loadHTML({ url: "/ajax_request/", data: data }, function () {
            mesaj_ver("Finansman", "Kayıt Başarıyla Eklendi");
            cari_detay_tabela_getir(cari_id, tip);
            $(".close").click();
        });

    }

}

function toplanti_karar_guncelle(nesne, toplanti_id, karar_id) {
    if ($("#yeni_karar_form input[type=text],textarea").valid("valid")) {

        var etiketler = $("#etiketler").val();
        var karar = $("#karar").val();
        var data = "islem=toplanti_karar_listesi2&islem2=guncelle";
        data += "&toplanti_id=" + toplanti_id;
        data += "&karar_id=" + karar_id;
        data += "&etiketler=" + etiketler;
        data += "&karar=" + encodeURIComponent(karar);
        data = encodeURI(data);
        $(nesne).attr("disabled", "disabled").val("İşlem Yapılıyor...");
        $("#karar_listesi").loadHTML({ url: "/ajax_request/", data: data }, function () {
            mesaj_ver("Toplantı", "Karar Başarıyla Güncellendi");
            $(".close").click();
        });

    }
}

function toplanti_karar_sil(toplanti_id, karar_id) {

    var r = confirm("Kaydı Silmek İstediğinize Emin misiniz?");
    if (r) {
        var data = "islem=toplanti_karar_listesi2&islem2=sil";
        data += "&toplanti_id=" + toplanti_id;
        data += "&karar_id=" + karar_id;
        data = encodeURI(data);
        $("#karar_listesi").loadHTML({ url: "/ajax_request/", data: data }, function () {
            mesaj_ver("Toplantı", "Karar Kaydı Silindi");
        });
    }
}

function toplanti_karar_ekle2(nesne, toplanti_id) {

    if ($("#yeni_karar_form input[type=text],textarea").valid("valid")) {

        var etiketler = $("#etiketler").val();
        var karar = $("#karar").val();
        var data = "islem=toplanti_karar_listesi2&islem2=ekle";
        data += "&toplanti_id=" + toplanti_id;
        data += "&etiketler=" + etiketler;
        data += "&karar=" + encodeURIComponent(karar);
        data = encodeURI(data);
        $(nesne).attr("disabled", "disabled").val("İşlem Yapılıyor...");
        $("#karar_listesi").loadHTML({ url: "/ajax_request/", data: data }, function () {
            mesaj_ver("Toplantı", "Karar Başarıyla Eklendi");
            $(".close").click();
        });

    }

}

function gundem_guncelle(nesne, toplanti_id, gundem_id) {

    if ($("#yeni_gundem_form input[type=text],textarea").valid("valid")) {

        var gundem = $("#gundem").val();
        var data = "islem=gundem_ekle&islem2=guncelle";
        data += "&toplanti_id=" + toplanti_id;
        data += "&gundem_id=" + gundem_id;
        data += "&gundem=" + gundem;
        data = encodeURI(data);
        $(nesne).attr("disabled", "disabled").val("İşlem Yapılıyor...");
        $("#gundem_listesi").loadHTML({ url: "/ajax_request/", data: data }, function () {
            mesaj_ver("Toplantı", "Gündem Başarıyla Güncellendi");
            $(".close").click();
        });

    }

}

function gundem_ekle(nesne, toplanti_id) {

    if ($("#yeni_gundem_form input[type=text],textarea").valid("valid")) {

        var gundem = $("#gundem").val();
        var data = "islem=gundem_ekle&islem2=ekle";
        data += "&toplanti_id=" + toplanti_id;
        data += "&gundem=" + gundem;
        data = encodeURI(data);
        $(nesne).attr("disabled", "disabled").val("İşlem Yapılıyor...");
        $("#gundem_listesi").loadHTML({ url: "/ajax_request/", data: data }, function () {
            mesaj_ver("Toplantı", "Gündem Başarıyla Eklendi");
            $(".close").click();
        });

    }

}

function toplanti_duzenle(toplanti_id) {

    var data = "islem=toplanti_duzenle";
    data += "&toplanti_id=" + toplanti_id;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request/", data: data }, function () {
        $(".takvimyap").datepicker({}).mask("99.99.9999");
        $(".timepicker").mask("99:99");
        var elem = Array.prototype.slice.call(document.querySelectorAll('.js-switch:not(.yapilan)'));
        elem.forEach(function (html) {
            var switchery = new Switchery(html, { color: '#4099ff', jackColor: '#fff', size: 'small' });
        });
        $(".js-switch").addClass("yapilan");
        $('.regexonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter({ format: 'custom', pattern: '[^0-9\,.]' });
        $('.numericonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter('numeric');
    });

}

function yeni_toplanti_planla() {

    var data = "islem=yeni_toplanti_planla";
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request/", data: data }, function () {
        /*sayfa_yuklenince();
        pageSetUp();*/

        $(".takvimyap").datepicker({}).mask("99.99.9999");
        $(".timepicker").mask("99:99");

        var elem = Array.prototype.slice.call(document.querySelectorAll('.js-switch:not(.yapilan)'));
        elem.forEach(function (html) {
            var switchery = new Switchery(html, { color: '#4099ff', jackColor: '#fff', size: 'small' });
        });

        $(".js-switch").addClass("yapilan");

        $('.regexonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter({ format: 'custom', pattern: '[^0-9\,.]' });
        $('.numericonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter('numeric');

    });


}


function firma_listesi(yetki_kodu) {
    var data = "islem=firmalar";
    data += "&yetki_kodu=" + yetki_kodu;
    data = encodeURI(data);
    $("#firma_listesi").loadHTML({ url: "islem1", data: data }, function () {
        datatableyap();
    });
}


function yeni_firma_ekle(yetki_kodu) {

    var firma_logo = $("#firma_logo").attr("filePath");
    var firma_adi = $("#firma_adi").val();
    var firma_yetkili = $("#firma_yetkili").val();
    var firma_telefon = $("#firma_telefon").val();
    var firma_mail = $("#firma_mail").val();
    var firma_supervisor_id = $("#firma_supervisor_id").val();


    var data = "islem=yeni_firma_ekle";
    data += "&yetki_kodu=" + yetki_kodu;
    data += "&firma_logo=" + (firma_logo);
    data += "&firma_adi=" + (firma_adi);
    data += "&firma_yetkili=" + (firma_yetkili);
    data += "&firma_telefon=" + (firma_telefon);
    data += "&firma_mail=" + (firma_mail);
    data += "&firma_supervisor_id=" + (firma_supervisor_id);
    data = encodeURI(data);
    if ($("#firma_ekle_form  input:not(input[type=button])").valid("valid")) {
        $("#firma_listesi").loadHTML({ url: "/ajax_request4/", data: data }, function () {

            if ($("#firma_listesi").html() == "ok") {
                mesaj_ver("Demo Hesaplar", "Kayıt Başarıyla Oluşturuldu", "success");
            } else {
                mesaj_ver("Demo Hesaplar", "Hata Oluştu", "warning");
            }
            firma_listesi(yetki_kodu);
        });
    }
}



function firma_ekle(yetki_kodu) {

    var firma_logo = $("#firma_logo").attr("filePath");
    var firma_adi = $("#firma_adi").val();
    var firma_yetkili = $("#firma_yetkili").val();
    var firma_telefon = $("#firma_telefon").val();
    var firma_mail = $("#firma_mail").val();
    var firma_supervisor_id = $("#firma_supervisor_id").val();
    var selectValue = $(".yetmislik").val();
    var yetkili1_telefon = $("#yetkili_telefon").val();
    var yetkili1_mail = $("#yetkili_mail").val();

    var yetkili2_adi = $("#ManagersDatas").attr("yetkili2_adi");
    var yetkili2_telefon = $("#ManagersDatas").attr("yetkili2_telefon");
    var yetkili2_mail = $("#ManagersDatas").attr("yetkili2_mail");

    var yetkili3_adi = $("#ManagersDatas").attr("yetkili3_adi");
    var yetkili3_telefon = $("#ManagersDatas").attr("yetkili3_telefon");
    var yetkili3_mail = $("#ManagersDatas").attr("yetkili3_mail");

    var yetkili4_adi = $("#ManagersDatas").attr("yetkili4_adi");
    var yetkili4_telefon = $("#ManagersDatas").attr("yetkili4_telefon");
    var yetkili4_mail = $("#ManagersDatas").attr("yetkili4_mail");

    var data = "islem=firmalar&islem2=ekle";
    data += "&yetki_kodu=" + yetki_kodu;
    data += "&firma_logo=" + encodeURIComponent(firma_logo);
    data += "&firma_adi=" + encodeURIComponent(firma_adi);
    data += "&firma_yetkili=" + encodeURIComponent(firma_yetkili);
    data += "&firma_telefon=" + encodeURIComponent(firma_telefon);
    data += "&yetkili1_telefon=" + encodeURIComponent(yetkili1_telefon);
    data += "&yetkili1_mail=" + encodeURIComponent(yetkili1_mail);

    data += "&yetkili2_adi=" + encodeURIComponent(yetkili2_adi);
    data += "&yetkili2_telefon=" + encodeURIComponent(yetkili2_telefon);
    data += "&yetkili2_mail=" + encodeURIComponent(yetkili2_mail);

    data += "&yetkili3_adi=" + encodeURIComponent(yetkili3_adi);
    data += "&yetkili3_telefon=" + encodeURIComponent(yetkili3_telefon);
    data += "&yetkili3_mail=" + encodeURIComponent(yetkili3_mail);

    data += "&yetkili4_adi=" + encodeURIComponent(yetkili4_adi);
    data += "&yetkili4_telefon=" + encodeURIComponent(yetkili4_telefon);
    data += "&yetkili4_mail=" + encodeURIComponent(yetkili4_mail);

    data += "&firma_mail=" + encodeURIComponent(firma_mail);
    data += "&firma_supervisor_id=" + encodeURIComponent(firma_supervisor_id);
    data = encodeURI(data);
    if ($("#firma_ekle_form  input:not(input[type=button])").valid("valid")) {
        $("#firma_listesi").loadHTML({ url: "islem1", data: data }, function () {
            datatableyap();

            $(".yetmislik option[value=" + selectValue + "]").attr('selected', 'selected');
            $(".yetmislik").trigger("change");
            mesaj_ver("Firmalar", "Kayıt Başarıyla Eklendi", "success");
        });
    }
}

function runAllCharts() {
    if ($.fn.sparkline) {
        var a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, _, ab, bb, cb, db, eb, fb, gb, hb, ib, jb, kb, lb, mb, nb, ob, pb, qb, rb, sb;
        $(".sparkline:not(:has(>canvas))").each(function () {
            var tb = $(this),
                ub = tb.data("sparkline-type") || "bar";
            if ("bar" == ub && (a = tb.data("sparkline-bar-color") || tb.css("color") || "#0000f0", b = tb.data("sparkline-height") || "26px", c = tb.data("sparkline-barwidth") || 5, d = tb.data("sparkline-barspacing") || 2, e = tb.data("sparkline-negbar-color") || "#A90329", f = tb.data("sparkline-barstacked-color") || ["#A90329", "#0099c6", "#98AA56", "#da532c", "#4490B1", "#6E9461", "#990099", "#B4CAD3"], tb.sparkline("html", {
                "barColor": a,
                "type": ub,
                "height": b,
                "barWidth": c,
                "barSpacing": d,
                "stackedBarColor": f,
                "negBarColor": e,
                "zeroAxis": "false"
            }), tb = null), "line" == ub && (b = tb.data("sparkline-height") || "20px", ab = tb.data("sparkline-width") || "90px", g = tb.data("sparkline-line-color") || tb.css("color") || "#0000f0", h = tb.data("sparkline-line-width") || 1, i = tb.data("fill-color") || "#c0d0f0", j = tb.data("sparkline-spot-color") || "#f08000", k = tb.data("sparkline-minspot-color") || "#ed1c24", l = tb.data("sparkline-maxspot-color") || "#f08000", m = tb.data("sparkline-highlightspot-color") || "#50f050", n = tb.data("sparkline-highlightline-color") || "f02020", o = tb.data("sparkline-spotradius") || 1.5, thisChartMinYRange = tb.data("sparkline-min-y") || "undefined", thisChartMaxYRange = tb.data("sparkline-max-y") || "undefined", thisChartMinXRange = tb.data("sparkline-min-x") || "undefined", thisChartMaxXRange = tb.data("sparkline-max-x") || "undefined", thisMinNormValue = tb.data("min-val") || "undefined", thisMaxNormValue = tb.data("max-val") || "undefined", thisNormColor = tb.data("norm-color") || "#c0c0c0", thisDrawNormalOnTop = tb.data("draw-normal") || !1, tb.sparkline("html", {
                "type": "line",
                "width": ab,
                "height": b,
                "lineWidth": h,
                "lineColor": g,
                "fillColor": i,
                "spotColor": j,
                "minSpotColor": k,
                "maxSpotColor": l,
                "highlightSpotColor": m,
                "highlightLineColor": n,
                "spotRadius": o,
                "chartRangeMin": thisChartMinYRange,
                "chartRangeMax": thisChartMaxYRange,
                "chartRangeMinX": thisChartMinXRange,
                "chartRangeMaxX": thisChartMaxXRange,
                "normalRangeMin": thisMinNormValue,
                "normalRangeMax": thisMaxNormValue,
                "normalRangeColor": thisNormColor,
                "drawNormalOnTop": thisDrawNormalOnTop
            }), tb = null), "pie" == ub && (p = tb.data("sparkline-piecolor") || ["#B4CAD3", "#4490B1", "#98AA56", "#da532c", "#6E9461", "#0099c6", "#990099", "#717D8A"], q = tb.data("sparkline-piesize") || 90, r = tb.data("border-color") || "#45494C", s = tb.data("sparkline-offset") || 0, tb.sparkline("html", {
                "type": "pie",
                "width": q,
                "height": q,
                "tooltipFormat": '<span style="color: {{color}}">&#9679;</span> ({{percent.1}}%)',
                "sliceColors": p,
                "borderWidth": 1,
                "offset": s,
                "borderColor": r
            }), tb = null), "box" == ub && (t = tb.data("sparkline-width") || "auto", u = tb.data("sparkline-height") || "auto", v = tb.data("sparkline-boxraw") || !1, w = tb.data("sparkline-targetval") || "undefined", x = tb.data("sparkline-min") || "undefined", y = tb.data("sparkline-max") || "undefined", z = tb.data("sparkline-showoutlier") || !0, A = tb.data("sparkline-outlier-iqr") || 1.5, B = tb.data("sparkline-spotradius") || 1.5, C = tb.css("color") || "#000000", D = tb.data("fill-color") || "#c0d0f0", E = tb.data("sparkline-whis-color") || "#000000", F = tb.data("sparkline-outline-color") || "#303030", G = tb.data("sparkline-outlinefill-color") || "#f0f0f0", H = tb.data("sparkline-outlinemedian-color") || "#f00000", I = tb.data("sparkline-outlinetarget-color") || "#40a020", tb.sparkline("html", {
                "type": "box",
                "width": t,
                "height": u,
                "raw": v,
                "target": w,
                "minValue": x,
                "maxValue": y,
                "showOutliers": z,
                "outlierIQR": A,
                "spotRadius": B,
                "boxLineColor": C,
                "boxFillColor": D,
                "whiskerColor": E,
                "outlierLineColor": F,
                "outlierFillColor": G,
                "medianColor": H,
                "targetColor": I
            }), tb = null), "bullet" == ub) {
                var vb = tb.data("sparkline-height") || "auto";
                J = tb.data("sparkline-width") || 2, K = tb.data("sparkline-bullet-color") || "#ed1c24", L = tb.data("sparkline-performance-color") || "#3030f0", M = tb.data("sparkline-bulletrange-color") || ["#d3dafe", "#a8b6ff", "#7f94ff"], tb.sparkline("html", {
                    "type": "bullet",
                    "height": vb,
                    "targetWidth": J,
                    "targetColor": K,
                    "performanceColor": L,
                    "rangeColors": M
                }), tb = null
            }
            "discrete" == ub && (N = tb.data("sparkline-height") || 26, O = tb.data("sparkline-width") || 50, P = tb.css("color"), Q = tb.data("sparkline-line-height") || 5, R = tb.data("sparkline-threshold") || "undefined", S = tb.data("sparkline-threshold-color") || "#ed1c24", tb.sparkline("html", {
                "type": "discrete",
                "width": O,
                "height": N,
                "lineColor": P,
                "lineHeight": Q,
                "thresholdValue": R,
                "thresholdColor": S
            }), tb = null), "tristate" == ub && (T = tb.data("sparkline-height") || 26, U = tb.data("sparkline-posbar-color") || "#60f060", V = tb.data("sparkline-negbar-color") || "#f04040", W = tb.data("sparkline-zerobar-color") || "#909090", X = tb.data("sparkline-barwidth") || 5, Y = tb.data("sparkline-barspacing") || 2, Z = tb.data("sparkline-zeroaxis") || !1, tb.sparkline("html", {
                "type": "tristate",
                "height": T,
                "posBarColor": _,
                "negBarColor": V,
                "zeroBarColor": W,
                "barWidth": X,
                "barSpacing": Y,
                "zeroAxis": Z
            }), tb = null), "compositebar" == ub && (b = tb.data("sparkline-height") || "20px", ab = tb.data("sparkline-width") || "100%", c = tb.data("sparkline-barwidth") || 3, h = tb.data("sparkline-line-width") || 1, g = tb.data("data-sparkline-linecolor") || "#ed1c24", _ = tb.data("data-sparkline-barcolor") || "#333333", tb.sparkline(tb.data("sparkline-bar-val"), {
                "type": "bar",
                "width": ab,
                "height": b,
                "barColor": _,
                "barWidth": c
            }), tb.sparkline(tb.data("sparkline-line-val"), {
                "width": ab,
                "height": b,
                "lineColor": g,
                "lineWidth": h,
                "composite": !0,
                "fillColor": !1
            }), tb = null), "compositeline" == ub && (b = tb.data("sparkline-height") || "20px", ab = tb.data("sparkline-width") || "90px", bb = tb.data("sparkline-bar-val"), cb = tb.data("sparkline-bar-val-spots-top") || null, db = tb.data("sparkline-bar-val-spots-bottom") || null, eb = tb.data("sparkline-line-width-top") || 1, fb = tb.data("sparkline-line-width-bottom") || 1, gb = tb.data("sparkline-color-top") || "#333333", hb = tb.data("sparkline-color-bottom") || "#ed1c24", ib = tb.data("sparkline-spotradius-top") || 1.5, jb = tb.data("sparkline-spotradius-bottom") || ib, j = tb.data("sparkline-spot-color") || "#f08000", kb = tb.data("sparkline-minspot-color-top") || "#ed1c24", lb = tb.data("sparkline-maxspot-color-top") || "#f08000", mb = tb.data("sparkline-minspot-color-bottom") || kb, nb = tb.data("sparkline-maxspot-color-bottom") || lb, ob = tb.data("sparkline-highlightspot-color-top") || "#50f050", pb = tb.data("sparkline-highlightline-color-top") || "#f02020", qb = tb.data("sparkline-highlightspot-color-bottom") || ob, thisHighlightLineColor2 = tb.data("sparkline-highlightline-color-bottom") || pb, rb = tb.data("sparkline-fillcolor-top") || "transparent", sb = tb.data("sparkline-fillcolor-bottom") || "transparent", tb.sparkline(bb, {
                "type": "line",
                "spotRadius": ib,
                "spotColor": j,
                "minSpotColor": kb,
                "maxSpotColor": lb,
                "highlightSpotColor": ob,
                "highlightLineColor": pb,
                "valueSpots": cb,
                "lineWidth": eb,
                "width": ab,
                "height": b,
                "lineColor": gb,
                "fillColor": rb
            }), tb.sparkline(tb.data("sparkline-line-val"), {
                "type": "line",
                "spotRadius": jb,
                "spotColor": j,
                "minSpotColor": mb,
                "maxSpotColor": nb,
                "highlightSpotColor": qb,
                "highlightLineColor": thisHighlightLineColor2,
                "valueSpots": db,
                "lineWidth": fb,
                "width": ab,
                "height": b,
                "lineColor": hb,
                "composite": !0,
                "fillColor": sb
            }), tb = null)
        })
    }
    $.fn.easyPieChart && $(".easy-pie-chart").each(function () {
        var a = $(this),
            b = a.css("color") || a.data("pie-color"),
            c = a.data("pie-track-color") || "rgba(0,0,0,0.04)",
            d = parseInt(a.data("pie-size")) || 25;
        a.easyPieChart({
            "barColor": b,
            "trackColor": c,
            "scaleColor": !1,
            "lineCap": "butt",
            "lineWidth": parseInt(d / 8.5),
            "animate": 1500,
            "rotate": -90,
            "size": d,
            "onStep": function (a, b, c) {
                $(this.el).find(".percent").text(Math.round(c))
            }
        }), a = null
    })
}


function is_yazisma_yeni_goster(IsID) {
    var data = "islem=is_yazisma_yeni_gonder";
    data += "&IsID=" + IsID;
    data = encodeURI(data);
    $("#ChatBody" + IsID).loadHTML({ url: "islem1", data: data, loading: false }, function () {
        gotoBottom(IsID);
        chat_yenile(IsID);
    });
}

function is_yazisma_yeni_gonder(IsID) {
    var chat_yazi = $("#chat_yazi" + IsID).val();
    if (chat_yazi != "") {
        var data = "islem=is_yazisma_yeni_gonder&islem2=yeni";
        data += "&IsID=" + IsID;
        data += "&chat_yazi=" + encodeURIComponent(chat_yazi);
        data = encodeURI(data);
        $("#ChatBody" + IsID).loadHTML({ url: "islem1", data: data, loading: false }, function () {
            $("#chat_yazi" + IsID).val("");
            gotoBottom(IsID);
        });
    }

}

function gotoBottom(IsID) {
    setTimeout(function () {
        var element = document.getElementById("ChatBody" + IsID);
        element.scrollTop = element.scrollHeight - element.clientHeight;
    }, 1);

    var $buton = $("#yazisma_gonder_button");
    $("#chat_yazi" + IsID).unbind("keyup");
    $("#chat_yazi" + IsID).keyup(function (event) {
        if (event.keyCode === 13) {
            $($buton).click();
            $("#chat_yazi" + IsID).val("");
        }
    });

}

function stopRKey(evt) {
    var evt = (evt) ? evt : ((event) ? event : null);
    var node = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement : null);
    if ((evt.keyCode == 13) && (node.type == "text")) { return false; }
}
document.onkeypress = stopRKey;

var chat_timer;
function chat_yenile(IsID) {
    clearTimeout(chat_timer);
    if ($("#ChatBody" + IsID + ":visible").length > 0) {
        chat_timer = setTimeout(function () {
            is_yazisma_yeni_goster(IsID);
        }, parseFloat(60000));
    } else {
        clearTimeout(chat_timer);
    }
}

var curSource = new Array();
var newSource = new Array();
var zamanlama;

function takvim_arama_yap(kelime) {

    clearTimeout(zamanlama);
    zamanlama = setTimeout(function () {

        newSource[0] = kelime.length > 0 ? '' : '/ajax_ajanda/?jsid=4559&gunluk=false&etiket=' + $('#calendar').attr("etiket") + '&etiket_id=' + $('#calendar').attr("etiket_id") + '&kelime=' + kelime;
        newSource[1] = kelime.length > 0 ? '/ajax_ajanda/?jsid=4559&gunluk=true&etiket=' + $('#calendar').attr("etiket") + '&etiket_id=' + $('#calendar').attr("etiket_id") + "&kelime=" + kelime : '';

        $('#calendar').fullCalendar('removeEventSource', curSource[0]);
        $('#calendar').fullCalendar('removeEventSource', curSource[1]);
        $('#calendar').fullCalendar('refetchEvents');

        $('#calendar').fullCalendar('addEventSource', newSource[0]);
        $('#calendar').fullCalendar('addEventSource', newSource[1]);
        $('#calendar').fullCalendar('refetchEvents');

        $('#calendar_gunluk').fullCalendar('removeEventSource', curSource[0]);
        $('#calendar_gunluk').fullCalendar('removeEventSource', curSource[1]);
        $('#calendar_gunluk').fullCalendar('refetchEvents');

        $('#calendar_gunluk').fullCalendar('addEventSource', newSource[0]);
        $('#calendar_gunluk').fullCalendar('addEventSource', newSource[1]);
        $('#calendar_gunluk').fullCalendar('refetchEvents');

        curSource[0] = newSource[0];
        curSource[1] = newSource[1];
    }, 750);
}



$(document).ready(function () {

    document.onkeydown = function (e) {

        if (e.keyCode === 116) {
            sayfagetir(sonsayfa, sondata, 1);
            return false;
        } else if (e.keyCode === 8) {

            var kontrol = 1;
            if (document.activeElement.tagName == "INPUT") {
                kontrol = 0;

            }
            if (document.activeElement.tagName == "TEXTAREA") {
                kontrol = 0;
            }
            if (kontrol == 1) {
                sayfa_geri();
                return false;
            }
        }
    };
});



function sayfa_geri() {
    if (indis > 1) {
        indis = parseInt(indis) - 2;
        var sayfa = tempsayfa[indis];
        var data = tempdata[indis];
        var functionid = tempfunctionid[indis];
        sayfagetir(sayfa, data, functionid);
    }
}


function GetCalendarDateRange() {
    var calendar = $('#calendar').fullCalendar('getCalendar');
    var view = calendar.view;
    var start = view.start._d;
    var end = view.end._d;
    var dates = { start: start, end: end };
    return dates;
}


function GetCalendarDateRange2() {
    var calendar = $('#calendar_gunluk').fullCalendar('getCalendar');
    var view = calendar.view;
    var start = view.start._d;
    var end = view.end._d;
    var dates = { start: start, end: end };
    return dates;
}


function icerden_ajanda_calistir(etiket, etiket_id) {
    "use strict";
    $(document).ready(function () {

        var aspectRatio = 1.35;
        if ($("#calendar").innerWidth() < 600) {
            aspectRatio = 0.6;
        } else if ($("#calendar").innerWidth() < 500) {
            aspectRatio = 0.5;
        }

        curSource[0] = '/ajax_ajanda/?jsid=4559&gunluk=false&etiket=' + $('#calendar').attr("etiket") + '&etiket_id=' + $('#calendar').attr("etiket_id") + '&kelime=';
        curSource[1] = '';

        console.log(curSource[0]);

        var calendar = $('#calendar').attr("etiket", etiket).attr("etiket_id", etiket_id).fullCalendar({
            customButtons: {
                myCustomButton: {
                    text: 'Yeni Kayıt',
                    click: function () {
                        yeni_ajanda_kayit_ekle($('#calendar').attr("etiket"), $('#calendar').attr("etiket_id"), '', '', 'true');
                    }
                }
            },
            businessHours: {
                // days of week. an array of zero-based day of week integers (0=Sunday)
                dow: [1, 2, 3, 4, 5, 6], // Monday - Thursday

                start: '07:00am', // a start time (10am in this example)
                end: '21:00pm', // an end time (6pm in this example)
            },
            displayEventEnd: true,
            aspectRatio: aspectRatio,
            defaultView: 'agendaWeek',

            eventLimit: true, // for all non-agenda views
            views: {
                month: {
                    eventLimit: 50 // adjust to 6 only for agendaWeek/agendaDay
                }
            },

            minTime: '00:00',
            maxTime: '23:59',
            timeFormat: 'HH:mm',
            slotDuration: '00:15:00',
            slotLabelFormat: 'HH:mm',
            weekNumbers: true,
            locale: 'tr',
            //contentHeight: '50%',

            editable: true,

            // events: '/ajax_ajanda/?jsid=4559&etiket=' + $('#calendar').attr("etiket") + '&etiket_id=' + $('#calendar').attr("etiket_id"),
            eventSources: [curSource[0], curSource[1]],
            firstDay: 1,
            fixedWeekCount: true,
            header: {
                left: 'prev,next, myCustomButton',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
            eventRender: function (event, element, view) {

                var endtime = moment(event.end).format('HH:mm');
                if (endtime.length != 5) {
                    endtime = "00:00";
                }
                element.find('.fc-time').append("-" + endtime);

                if (event.durum == "True") {
                    element.find('.fc-content').append('<span class="badge ytbadge"><i class="fa fa-check"></i></span>');
                }

                element.find('.fc-content').parent("a").attr("data-toggle", "tooltip");
                element.find('.fc-content').parent("a").attr("data-placement", "top");
                element.find('.fc-content').parent("a").attr("title", event.title);
                element.find('.fc-content').parent("a").attr("data-original-title", event.title);
            },
            eventAfterAllRender: function (view) {
                setTimeout(function () {
                    $('[data-toggle="tooltip"]').tooltip();
                }, 1000);
            },
            timezone: 'local',
            selectable: true,
            /*
            eventLimitClick: function (cellInfo, jsEvent) {

            },*/
            select: function (start, end) {

                var start = moment(start).format('YYYY-MM-DD') + ' ' + moment(start).format('HH:mm');
                var end = moment(end).format('YYYY-MM-DD') + ' ' + moment(end).format('HH:mm');
                var valid = moment(end).isValid();
                if (end === null || end === 'null' || valid == false)
                    end = start;
                yeni_ajanda_kayit_ekle($('#calendar').attr("etiket"), $('#calendar').attr("etiket_id"), start, end);

                $('#calendar').fullCalendar('unselect');
            },
            eventClick: function (calEvent, jsEvent, view) {
                yeni_ajanda_kayit_duzenle($('#calendar').attr("etiket"), $('#calendar').attr("etiket_id"), calEvent.id);
            },
            eventDrop: function (event, delta, revertFunc) {
                var start = moment(event.start).format('YYYY-MM-DD') + ' ' + moment(event.start).format('HH:mm');
                var end = moment(event.end).format('YYYY-MM-DD') + ' ' + moment(event.end).format('HH:mm');
                var valid = moment(event.end).isValid();
                if (event.end === null || event.end === 'null' || valid == false)
                    end = start;

                yeni_ajanda_kayit_sundur($('#calendar').attr("etiket"), $('#calendar').attr("etiket_id"), event.id, start, end);

            },
            eventResize: function (event, delta, revertFunc) {
                var start = moment(event.start).format('YYYY-MM-DD') + ' ' + moment(event.start).format('HH:mm');
                var end = moment(event.end).format('YYYY-MM-DD') + ' ' + moment(event.end).format('HH:mm');
                var valid = moment(event.end).isValid();
                if (event.end === null || event.end === 'null' || valid == false)
                    end = start;
                yeni_ajanda_kayit_sundur($('#calendar').attr("etiket"), $('#calendar').attr("etiket_id"), event.id, start, end);

            }
        });

        $('.fc-prev-button').click(function () {
            var view = $('#calendar').fullCalendar('getView');
            var ilk_ay = GetCalendarDateRange().start.getMonth();
            var son_ay = GetCalendarDateRange2().start.getMonth();
            if (son_ay != ilk_ay || view.type == "month") {
                $('#calendar_gunluk').fullCalendar('prev');
            }
        });

        $('.fc-next-button').click(function () {
            var view = $('#calendar').fullCalendar('getView');
            var ilk_ay = GetCalendarDateRange().start.getMonth();
            var son_ay = GetCalendarDateRange2().start.getMonth();

            if (son_ay != ilk_ay || view.type == "month") {
                $('#calendar_gunluk').fullCalendar('next');
            }

            /*
            $('#calendar_gunluk').fullCalendar('option', 'visibleRange', {
                start: moment(GetCalendarDateRange().start).format('YYYY-MM-DD'),
                end: moment(GetCalendarDateRange().end).format('YYYY-MM-DD')
            });*/
        });


        curSource[0] = '/ajax_ajanda/?jsid=4559&gunluk=true&etiket=' + $('#calendar').attr("etiket") + '&etiket_id=' + $('#calendar').attr("etiket_id") + '&kelime=';

        curSource[1] = '';

        $('#calendar_gunluk').attr("etiket", etiket).attr("etiket_id", etiket_id).fullCalendar({

            businessHours: {
                // days of week. an array of zero-based day of week integers (0=Sunday)
                dow: [1, 2, 3, 4, 5, 6], // Monday - Thursday

                start: '07:00am', // a start time (10am in this example)
                end: '21:00pm', // an end time (6pm in this example)
            },
            height: $(".fc-view-container").height() + 75,
            defaultView: 'listMonth',
            slotDuration: '00:15:00',

            minTime: '00:00',
            maxTime: '23:59',

            timeFormat: 'HH:mm',
            slotLabelFormat: 'HH:mm',
            customButtons: {
                myCustomButton: {
                    text: 'Yeni Kayıt',
                    click: function () {
                        yeni_ajanda_kayit_ekle($('#calendar').attr("etiket"), $('#calendar').attr("etiket_id"), '', '');
                    }
                }
            },
            locale: 'tr',
            //contentHeight: '50%',
            displayEventEnd: false,
            editable: true,
            eventLimit: true,
            //events: '/ajax_ajanda/?jsid=4559&gunluk=true&etiket=' + $('#calendar').attr("etiket") + '&etiket_id=' + $('#calendar').attr("etiket_id"),
            eventSources: [curSource[0], curSource[1]],
            firstDay: 1,
            fixedWeekCount: true,
            header: {
                left: '',
                center: 'title',
                right: 'myCustomButton'
            },
            eventRender: function (event, element, view) {

                var endtime = moment(event.end).format('HH:mm');
                if (endtime.length != 5) {
                    endtime = "00:00";
                }

                if (element.find('.fc-list-item-time')[0].innerHTML != "Tüm gün") {
                    element.find('.fc-list-item-time').append("-" + endtime);
                }


                var durum = "";
                if (event.durum == "True") {
                    durum = "checked";
                }
                //element.find('.fc-list-item-time').prepend('<span style="padding-top:5px;"><input ' + durum + ' onchange="ajanda_olay_durum_guncelle(' + event.id + ', this);" class="js-switch ajanda_olay' + event.id + '" type="checkbox" /></span>');

                element.find('.fc-list-item-time').prepend('<span><div class="checkbox-fade fade-in-primary" style="margin-right:5px;"><label style="margin:0px;"><input ' + durum + ' onchange="ajanda_olay_durum_guncelle(' + event.id + ', this);" class="ajanda_olay' + event.id + '" type="checkbox" value=""><span class="cr"><i class="cr-icon icofont icofont-ui-check txt-primary"></i></span></label></div></span>');

            },

            eventAfterAllRender: function (view) {

                //$('[data-toggle="tooltip"]').tooltip();

                // $('.fc-list-heading-main').prepend('<span style="padding-right:10px; color:#ccc; font-size:10px;">Durum</div>');
                /*
                var elem = Array.prototype.slice.call(document.querySelectorAll('.js-switch:not(.yapilan)'));
                elem.forEach(function (html) {
                    var switchery = new Switchery(html, { color: '#4099ff', jackColor: '#fff', size: 'small' });
                });
                $(".js-switch").addClass("yapilan");

                */
            },

            timezone: 'local',
            selectable: true,
            select: function (start, end) {

                var start = moment(start).format('YYYY-MM-DD') + ' ' + moment(start).format('HH:mm');
                var end = moment(end).format('YYYY-MM-DD') + ' ' + moment(end).format('HH:mm');
                var valid = moment(end).isValid();
                if (end === null || end === 'null' || valid == false)
                    end = start;
                yeni_ajanda_kayit_ekle($('#calendar').attr("etiket"), $('#calendar').attr("etiket_id"), start, end);

                $('#calendar').fullCalendar('unselect');
            },
            eventClick: function (calEvent, jsEvent, view) {
                if (jsEvent.target.localName == "td") {
                    yeni_ajanda_kayit_duzenle($('#calendar').attr("etiket"), $('#calendar').attr("etiket_id"), calEvent.id);
                }
            },
            eventDrop: function (event, delta, revertFunc) {
                var start = moment(event.start).format('YYYY-MM-DD') + ' ' + moment(event.start).format('HH:mm');
                var end = moment(event.end).format('YYYY-MM-DD') + ' ' + moment(event.end).format('HH:mm');
                var valid = moment(event.end).isValid();
                if (event.end === null || event.end === 'null' || valid == false)
                    end = start;

                yeni_ajanda_kayit_sundur($('#calendar').attr("etiket"), $('#calendar').attr("etiket_id"), event.id, start, end);

            },
            eventResize: function (event, delta, revertFunc) {
                var start = moment(event.start).format('YYYY-MM-DD') + ' ' + moment(event.start).format('HH:mm');
                var end = moment(event.end).format('YYYY-MM-DD') + ' ' + moment(event.end).format('HH:mm');
                var valid = moment(event.end).isValid();
                if (event.end === null || event.end === 'null' || valid == false)
                    end = start;
                yeni_ajanda_kayit_sundur($('#calendar').attr("etiket"), $('#calendar').attr("etiket_id"), event.id, start, end);
            }
        });
    });

    $(document).bind('reveal.facebox', function () {
        if ($('[name=EventColor]').length) { $('[name=EventColor]').colorBox(); }
    });

    function Validation(url, id) {
        var error = 0;
        var button = id.find('button');
        button.prop('disabled', true);
        $('.req', id).each(function () {
            var input = $(this).val();
            var pattern = /^(.|\n)+$/;
            if (!input || !pattern.test(input)) {
                $(this).addClass('error');
                error++;
            }
            else {
                $(this).removeClass('error');
            }
        });
        if (error === 0) {
            Save(url, id);
        } else {
            button.prop('disabled', false);
        }
        return false;
    }

    function Question(question, url) {
        $.facebox('<p>' + question + '</p><button id="yes">Yes</button><button onclick="$.facebox.close();">No</button>');
        $('#yes').on('click', function () {
            Save(url, $('#facebox .content'));
        });
        return false;
    }

    function Save(url, id) {
        var button = id.find('button');
        $.ajax({
            type: 'post',
            url: url,
            data: id.serialize(),
            dataType: 'html',
            timeout: 5000,
            cache: false,
            global: false,
            error: function (xhr) {
                button.prop('disabled', false).insertAfter('<p>' + xhr.responseText + '</p>');
            },
            success: function (data) {
                $('#facebox').css({
                    top: $(window).scrollTop() + ($(window).height() / 10),
                    left: $(window).width() / 2 - ($('#facebox .popup').outerWidth() / 2)
                });
                $('#calendar').fullCalendar('refetchEvents');
                id.html(data).delay(3000).queue(function () {
                    $.facebox.close();
                    $(this).dequeue();
                });
            }
        });
    }
}

function ajanda_olay_durum_guncelle_button(olay_id, durum) {

    var r = confirm("Kaydı tamamlamak istiyormusunuz. ?");
    if (r) {
        var data = "islem=ajanda_olay_durum_guncelle";
        data += "&olay_id=" + olay_id;
        data += "&durum=" + durum;
        data = encodeURI(data);
        $("#koftiden").loadHTML({ url: "/ajax_request2/", data: data }, function () {
            $(".close").click();
            mesaj_ver("Ajanda", "Kayıt Başarıyla Güncellendi", "success");
            $('#calendar').fullCalendar('refetchEvents');
            $('#calendar_gunluk').fullCalendar('refetchEvents');
        });
    }
}

function ajanda_olay_durum_guncelle(olay_id, nesne) {

    var r = confirm("Kaydı tamamlamak istiyormusunuz. ?");
    if (r) {
        var durum = "0";
        if ($(nesne).attr("checked") == "checked") {
            $(nesne).removeAttr("checked");
        } else {
            $(nesne).attr("checked", "checked");
            durum = "1";
        }
        var data = "islem=ajanda_olay_durum_guncelle";
        data += "&olay_id=" + olay_id;
        data += "&durum=" + durum;
        data = encodeURI(data);
        $("#koftiden").loadHTML({ url: "/ajax_request2/", data: data }, function () {
            mesaj_ver("Ajanda", "Kayıt Başarıyla Güncellendi", "success");
            $('#calendar').fullCalendar('refetchEvents');
            $('#calendar_gunluk').fullCalendar('refetchEvents');
        });
    }
}




function yeni_ajanda_calistir(etiket, etiket_id) {
    var data = "islem=ajanda_calistir";
    data += "&etiket=" + etiket;
    data += "&etiket_id=" + etiket_id;
    data = encodeURI(data);
    $("#takvim_yeri").loadHTML({ url: "/ajax_request2/", data: data }, function () {

    });
}


function firma_rapor_is_yuku_gosterim_proje_sectim2(firma_id) {

    var baslangic = $("#rapor_is_yuku_donem option:selected").attr("dongu_baslangic");
    var bitis = $("#rapor_is_yuku_donem option:selected").attr("dongu_bitis");
    var gosterim_tipi = $("#yeni_is_yuku_gosterim_tipi").val();
    var proje_id = $("#yeni_is_yuku_proje_id").val();

    var data = "islem=firma_rapor_is_yuku_gosterim_proje_sectim";
    data += "&proje_id=" + proje_id;
    data += "&firma_id=" + firma_id;
    data += "&baslangic=" + baslangic;
    data += "&bitis=" + bitis;
    data += "&gosterim_tipi=" + gosterim_tipi;
    data = encodeURI(data);
    $("#is_yuku_donus").loadHTML({ url: "/ajax_request2/", data: data }, function () {

    });

}

function firma_rapor_is_yuku_gosterim_proje_sectim(firma_id, baslangic, bitis) {

    var gosterim_tipi = $("#yeni_is_yuku_gosterim_tipi").val();
    var proje_id = $("#yeni_is_yuku_proje_id").val();

    var data = "islem=firma_rapor_is_yuku_gosterim_proje_sectim";
    data += "&proje_id=" + proje_id;
    data += "&firma_id=" + firma_id;
    data += "&baslangic=" + baslangic;
    data += "&bitis=" + bitis;
    data += "&gosterim_tipi=" + gosterim_tipi;
    data = encodeURI(data);
    $("#is_yuku_donus").loadHTML({ url: "/ajax_request2/", data: data }, function () {

    });
}


function personel_rapor_is_yuku_gosterim_proje_sectim2(personel_id) {

    var baslangic = $("#rapor_is_yuku_donem option:selected").attr("dongu_baslangic");
    var bitis = $("#rapor_is_yuku_donem option:selected").attr("dongu_bitis");
    var gosterim_tipi = $("#yeni_is_yuku_gosterim_tipi").val();
    var proje_id = $("#yeni_is_yuku_proje_id").val();

    var data = "islem=personel_rapor_is_yuku_gosterim_proje_sectim";
    data += "&proje_id=" + proje_id;
    data += "&personel_id=" + personel_id;
    data += "&baslangic=" + baslangic;
    data += "&bitis=" + bitis;
    data += "&gosterim_tipi=" + gosterim_tipi;
    data = encodeURI(data);
    $("#is_yuku_donus").loadHTML({ url: "/ajax_request2/", data: data }, function () {

    });

}

function personel_rapor_is_yuku_gosterim_proje_sectim(personel_id, baslangic, bitis) {

    var gosterim_tipi = $("#yeni_is_yuku_gosterim_tipi").val();
    var proje_id = $("#yeni_is_yuku_proje_id").val();

    var data = "islem=personel_rapor_is_yuku_gosterim_proje_sectim";
    data += "&proje_id=" + proje_id;
    data += "&personel_id=" + personel_id;
    data += "&baslangic=" + baslangic;
    data += "&bitis=" + bitis;
    data += "&gosterim_tipi=" + gosterim_tipi;
    data = encodeURI(data);
    $("#is_yuku_donus").loadHTML({ url: "/ajax_request2/", data: data }, function () {

    });
}


function aiyda(gorevli_id, tarih) {

    var data = "islem=is_listesi";
    data += "&durum=";
    data += "&tip=arama";
    data += "&adi=" + "";
    data += "&is_durum=" + "0";
    data += "&gorevliler=" + gorevli_id;
    data += "&firmalar=" + "0";
    data += "&santiyeler=" + "0";
    data += "&departmanlar=" + "0";
    data += "&baslangic_tarihi=" + "";
    data += "&bitis_tarihi=" + "";
    data += "&is_baslangic_tarihi=" + tarih;
    data += "&is_bitis_tarihi=" + "";
    data = encodeURI(data);
    $("#is_yuku_birinci_ekran").slideUp();
    $("#is_yuku_birinci_ekran2").slideDown();
    $("#is_yuku_birinci_ekran2").loadHTML({ url: "islem1", data: data }, function () {
        sayfa_yuklenince();
        is_tablo_islemler();
    });
}

function isyuku_timeline_calistir() {

    var data = "islem=isyuku_timeline_calistir";
    $("#is_yuku_birinci_ekran").slideUp();
    $("#is_yuku_birinci_ekran2").slideDown();
    $("#is_yuku_birinci_ekran2").loadHTML({ url: "/ajax_request2/", data: data }, function () {

    });

}

function rapor_pdf_indir(deger, personel_id, izin_id) {

    var data = "/ajax_request3/?jsid=4559&islem=rapor_pdf_indir";
    data += "&islem2=" + deger;

    if (deger == "personel_is_yuku") {

        var gosterim_tipi = $("#yeni_is_yuku_gosterim_tipi").val();
        var proje_id = $("#yeni_is_yuku_proje_id").val();
        var baslangic = $("#rapor_is_yuku_donem option:selected").attr("dongu_baslangic");
        var bitis = $("#rapor_is_yuku_donem option:selected").attr("dongu_bitis");

        data += "&gosterim_tipi=" + gosterim_tipi;
        data += "&proje_id=" + proje_id;
        data += "&baslangic=" + baslangic;
        data += "&bitis=" + bitis;

    }
    else if (deger == "proje_maliyet_formu") {
        data += "&proje_id=" + personel_id;
    }
    else if (deger == "teknik_servis_formu") {

        data += "&personel_id=" + personel_id;
        data += "&izin_id=" + izin_id;

    }
    else if (deger == "mesai_bildirim_formu") {

        data += "&personel_id=" + personel_id;
        data += "&izin_id=" + izin_id;

    }
    else if (deger == "izin_talep_formu") {

        data += "&personel_id=" + personel_id;
        data += "&izin_id=" + izin_id;
    }
    else if (deger == "satinalma_formu") {

        data += "&satinalma_id=" + personel_id;

    }
    else if (deger == "teklif_formu") {

        data += "&satinalma_id=" + personel_id;

    }
    else if (deger === "personel_giris_cikis_raporu") {

        var personelID = $("#rapor_personel_id").val();
        var tarihBaslangic = $("#personel_giris_cikis_saati_donem option:selected").attr("dongu_baslangic");
        var tarihBitis = $("#personel_giris_cikis_saati_donem option:selected").attr("dongu_bitis");

        data += "&personelID=" + personelID;
        data += "&tarihBaslangic=" + tarihBaslangic;
        data += "&tarihBitis=" + tarihBitis;
    }
    else if (deger === "personel_is_yuku_verimlilik") {

        var gosterim_tipi = $("#yeni_is_yuku_gosterim_tipi").val();
        var proje_id = $("#yeni_is_yuku_proje_id").val();
        var baslangic = $("#rapor_is_yuku_donem option:selected").attr("dongu_baslangic");
        var bitis = $("#rapor_is_yuku_donem option:selected").attr("dongu_bitis");

        data += "&gosterim_tipi=" + gosterim_tipi;
        data += "&proje_id=" + proje_id;
        data += "&baslangic=" + baslangic;
        data += "&bitis=" + bitis;

    }
    else if (deger == "personel_performans_raporu") {

        var rapor_personel_id = $("#rapor_personel_id").val();
        var baslangic_tarihi = $("#baslangic_tarihi").val();
        var bitis_tarihi = $("#bitis_tarihi").val();
        var etiketler = $("#etiketler").val();
        var yeni_is_yuku_proje_id = $("#yeni_is_yuku_proje_id").val();

        data += "&rapor_personel_id=" + rapor_personel_id;
        data += "&baslangic_tarihi=" + baslangic_tarihi;
        data += "&bitis_tarihi=" + bitis_tarihi;
        data += "&etiketler=" + etiketler;
        data += "&yeni_is_yuku_proje_id=" + yeni_is_yuku_proje_id;


    }
    else if (deger == "proje_adam_saat_raporu") {

        var rapor_personel_id = $("#rapor_personel_id").val();
        var etiketler = $("#etiketler").val();
        var yeni_is_yuku_proje_id = $("#yeni_is_yuku_proje_id").val();
        var baslangic = $("#is_yuku_donem option:selected").attr("dongu_baslangic");
        var bitis = $("#is_yuku_donem option:selected").attr("dongu_bitis");

        data += "&rapor_personel_id=" + rapor_personel_id;
        data += "&etiketler=" + etiketler;
        data += "&yeni_is_yuku_proje_id=" + yeni_is_yuku_proje_id;
        data += "&baslangic=" + baslangic;
        data += "&bitis=" + bitis;

    }
    else if (deger == "departman_adam_saat_raporu") {

        var etiketler = $("#etiketler").val();
        var rapor_personel_id = $("#rapor_personel_id").val();
        var yeni_is_yuku_proje_id = $("#yeni_is_yuku_proje_id").val();
        var baslangic = $("#is_yuku_donem option:selected").attr("dongu_baslangic");
        var bitis = $("#is_yuku_donem option:selected").attr("dongu_bitis");

        data += "&etiketler=" + etiketler;
        data += "&rapor_personel_id=" + rapor_personel_id;
        data += "&yeni_is_yuku_proje_id=" + yeni_is_yuku_proje_id;
        data += "&baslangic=" + baslangic;
        data += "&bitis=" + bitis;

    }
    else if (deger == "proje_maliyet_raporu") {

        var yeni_is_yuku_proje_id = $("#yeni_is_yuku_proje_id").val();

        data += "&yeni_is_yuku_proje_id=" + yeni_is_yuku_proje_id;

    }
    else if (deger == "personel_adam_saat_raporu") {

        var rapor_personel_id = $("#rapor_personel_id").val();
        var baslangic = $("#is_yuku_donem option:selected").attr("dongu_baslangic");
        var bitis = $("#is_yuku_donem option:selected").attr("dongu_bitis");
        var is_yuku_gosterim_tipi = $("#is_yuku_gosterim_tipi").val();
        var etiketler = $("#etiketler").val();
        var yeni_is_yuku_proje_id = $("#yeni_is_yuku_proje_id").val();

        data += "&rapor_personel_id=" + rapor_personel_id;
        data += "&baslangic=" + baslangic;
        data += "&bitis=" + bitis;
        data += "&is_yuku_gosterim_tipi=" + is_yuku_gosterim_tipi;
        data += "&etiketler=" + etiketler;
        data += "&yeni_is_yuku_proje_id=" + yeni_is_yuku_proje_id;

    }
    else if (deger == "nakit_akis_raporu") {

        var baslangic_tarihi = $("#baslangic_tarihi").val();
        var bitis_tarihi = $("#bitis_tarihi").val();

        data += "&baslangic_tarihi=" + baslangic_tarihi;
        data += "&bitis_tarihi=" + bitis_tarihi;

    }
    else if (deger == "gantt_liste") {

        var gantt_proje_id = $("#gantt_proje_id").val();
        var gantt_tip = $("#gantt_tip").val();

        data += "&proje_id=" + gantt_proje_id;
        data += "&tip=" + gantt_tip;

    }
    $(window).off('beforeunload');

    window.location.href = data;
    //popUp(data, 1, 1);
}

function mail_gonderim_baslat(nesne) {

    if ($("#yeni_mail_form input:not(input[type=button])").valid("valid")) {

        var ek_dosya = $("#ek_dosya").val();
        var eposta = $("#eposta").val();
        var konu = $("#konu").val();
        var mesaj = $("#mesaj").val();

        var data = "islem=mail_gonderim_baslat";
        data += "&eposta=" + eposta;
        data += "&konu=" + konu;
        data += "&mesaj=" + mesaj;
        data += "&ek_dosya=" + encodeURIComponent(ek_dosya);
        data = encodeURI(data);
        $(nesne).attr("disabled", "disabled").val("İşlem Yapılıyor...");
        $("#olusturulan_belge_yeri").loadHTML({ url: "/ajax_request3/", data: data }, function () {
        });
    }
}
function MailGonder(eposta, konu, mesaj, ekdosya) {

    var data = "islem=mail_gonderim_baslat";
    data += "&eposta=" + eposta;
    data += "&konu=" + konu;
    data += "&mesaj=" + mesaj;
    data += "&ek_dosya=" + encodeURIComponent(ekdosya);
    data = encodeURI(data);
    $(this).attr("disabled", "disabled").val("İşlem Yapılıyor...");
    $("#olusturulan_belge_yeri").loadHTML({ url: "/ajax_request3/", data: data }, function () {
    });

}

function rapor_pdf_gonder(deger, personel_id, izin_id, dosya_yolu) {



    var data = "islem=pdf_gonder";
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request3/", data: data }, function () {

        data = "islem=rapor_pdf_gonder";
        data += "&islem2=" + deger;
        data += "&islem3=yazdir"

        if (deger == "personel_is_yuku") {

            var gosterim_tipi = $("#yeni_is_yuku_gosterim_tipi").val();
            var proje_id = $("#yeni_is_yuku_proje_id").val();
            var baslangic = $("#rapor_is_yuku_donem option:selected").attr("dongu_baslangic");
            var bitis = $("#rapor_is_yuku_donem option:selected").attr("dongu_bitis");

            data += "&gosterim_tipi=" + gosterim_tipi;
            data += "&proje_id=" + proje_id;
            data += "&baslangic=" + baslangic;
            data += "&bitis=" + bitis;

        }
        else if (deger == "satinalma_formu") {

            data += "&satinalma_id=" + personel_id;

        } else if (deger == "proje_maliyet_formu") {
            data += "&proje_id=" + personel_id;
        }
        else if (deger == "izin_talep_formu") {

            data += "&personel_id=" + personel_id;
            data += "&izin_id=" + izin_id;

        } else if (deger == "mesai_bildirim_formu") {

            data += "&personel_id=" + personel_id;
            data += "&izin_id=" + izin_id;

        }
        else if (deger == "personel_is_yuku_verimlilik") {

            var gosterim_tipi = $("#yeni_is_yuku_gosterim_tipi").val();
            var proje_id = $("#yeni_is_yuku_proje_id").val();
            var baslangic = $("#rapor_is_yuku_donem option:selected").attr("dongu_baslangic");
            var bitis = $("#rapor_is_yuku_donem option:selected").attr("dongu_bitis");

            data += "&gosterim_tipi=" + gosterim_tipi;
            data += "&proje_id=" + proje_id;
            data += "&baslangic=" + baslangic;
            data += "&bitis=" + bitis;
        }
        else if (deger == "personel_performans_raporu") {

            var rapor_personel_id = $("#rapor_personel_id").val();
            var baslangic_tarihi = $("#baslangic_tarihi").val();
            var bitis_tarihi = $("#bitis_tarihi").val();
            var etiketler = $("#etiketler").val();
            var yeni_is_yuku_proje_id = $("#yeni_is_yuku_proje_id").val();

            data += "&rapor_personel_id=" + rapor_personel_id;
            data += "&baslangic_tarihi=" + baslangic_tarihi;
            data += "&bitis_tarihi=" + bitis_tarihi;
            data += "&etiketler=" + etiketler;
            data += "&yeni_is_yuku_proje_id=" + yeni_is_yuku_proje_id;


        }
        else if (deger == "proje_adam_saat_raporu") {

            var rapor_personel_id = $("#rapor_personel_id").val();
            var etiketler = $("#etiketler").val();
            var yeni_is_yuku_proje_id = $("#yeni_is_yuku_proje_id").val();
            var baslangic = $("#is_yuku_donem option:selected").attr("dongu_baslangic");
            var bitis = $("#is_yuku_donem option:selected").attr("dongu_bitis");

            data += "&rapor_personel_id=" + rapor_personel_id;
            data += "&etiketler=" + etiketler;
            data += "&yeni_is_yuku_proje_id=" + yeni_is_yuku_proje_id;
            data += "&baslangic=" + baslangic;
            data += "&bitis=" + bitis;

        }
        else if (deger == "departman_adam_saat_raporu") {

            var etiketler = $("#etiketler").val();
            var rapor_personel_id = $("#rapor_personel_id").val();
            var yeni_is_yuku_proje_id = $("#yeni_is_yuku_proje_id").val();
            var baslangic = $("#is_yuku_donem option:selected").attr("dongu_baslangic");
            var bitis = $("#is_yuku_donem option:selected").attr("dongu_bitis");

            data += "&etiketler=" + etiketler;
            data += "&rapor_personel_id=" + rapor_personel_id;
            data += "&yeni_is_yuku_proje_id=" + yeni_is_yuku_proje_id;
            data += "&baslangic=" + baslangic;
            data += "&bitis=" + bitis;

        }
        else if (deger == "proje_maliyet_raporu") {

            var yeni_is_yuku_proje_id = $("#yeni_is_yuku_proje_id").val();

            data += "&yeni_is_yuku_proje_id=" + yeni_is_yuku_proje_id;
        }
        else if (deger == "personel_adam_saat_raporu") {

            var rapor_personel_id = $("#rapor_personel_id").val();
            var baslangic = $("#is_yuku_donem option:selected").attr("dongu_baslangic");
            var bitis = $("#is_yuku_donem option:selected").attr("dongu_bitis");
            var is_yuku_gosterim_tipi = $("#is_yuku_gosterim_tipi").val();
            var etiketler = $("#etiketler").val();
            var yeni_is_yuku_proje_id = $("#yeni_is_yuku_proje_id").val();

            data += "&rapor_personel_id=" + rapor_personel_id;
            data += "&baslangic=" + baslangic;
            data += "&bitis=" + bitis;
            data += "&is_yuku_gosterim_tipi=" + is_yuku_gosterim_tipi;
            data += "&etiketler=" + etiketler;
            data += "&yeni_is_yuku_proje_id=" + yeni_is_yuku_proje_id;
        }
        else if (deger == "gantt_liste") {

            var gantt_proje_id = $("#gantt_proje_id").val();
            var gantt_tip = $("#gantt_tip").val();

            data += "&proje_id=" + gantt_proje_id;
            data += "&tip=" + gantt_tip;
        }
        else if (deger == "bordro_gonder") {

            data += "&dosya_yolu=" + dosya_yolu;
        }

        data = encodeURI(data);
        $("#olusturulan_belge_yeri").loadHTML({ url: "/ajax_request3/", data: data }, function () {
            $("#olusturuluyor").hide();
        });
    });
}


function rapor_pdf_yazdir(deger, personel_id, izin_id) {

    var data = "islem=pdf_yazdir";
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request3/", data: data }, function () {

        data = "islem=rapor_pdf_indir";
        data += "&islem2=" + deger;
        data += "&islem3=yazdir"

        if (deger == "personel_is_yuku") {

            var gosterim_tipi = $("#yeni_is_yuku_gosterim_tipi").val();
            var proje_id = $("#yeni_is_yuku_proje_id").val();
            var baslangic = $("#rapor_is_yuku_donem option:selected").attr("dongu_baslangic");
            var bitis = $("#rapor_is_yuku_donem option:selected").attr("dongu_bitis");

            data += "&gosterim_tipi=" + gosterim_tipi;
            data += "&proje_id=" + proje_id;
            data += "&baslangic=" + baslangic;
            data += "&bitis=" + bitis;

        } else if (deger == "proje_maliyet_formu") {
            data += "&proje_id=" + personel_id;
        }
        else if (deger == "izin_talep_formu") {

            data += "&personel_id=" + personel_id;
            data += "&izin_id=" + izin_id;

        } else if (deger == "satinalma_formu") {

            data += "&satinalma_id=" + personel_id;


        } else if (deger == "mesai_bildirim_formu") {

            data += "&personel_id=" + personel_id;
            data += "&izin_id=" + izin_id;

        } else if (deger == "personel_is_yuku_verimlilik") {

            var gosterim_tipi = $("#yeni_is_yuku_gosterim_tipi").val();
            var proje_id = $("#yeni_is_yuku_proje_id").val();
            var baslangic = $("#rapor_is_yuku_donem option:selected").attr("dongu_baslangic");
            var bitis = $("#rapor_is_yuku_donem option:selected").attr("dongu_bitis");

            data += "&gosterim_tipi=" + gosterim_tipi;
            data += "&proje_id=" + proje_id;
            data += "&baslangic=" + baslangic;
            data += "&bitis=" + bitis;

        } else if (deger == "personel_performans_raporu") {

            var rapor_personel_id = $("#rapor_personel_id").val();
            var baslangic_tarihi = $("#baslangic_tarihi").val();
            var bitis_tarihi = $("#bitis_tarihi").val();
            var etiketler = $("#etiketler").val();
            var yeni_is_yuku_proje_id = $("#yeni_is_yuku_proje_id").val();

            data += "&rapor_personel_id=" + rapor_personel_id;
            data += "&baslangic_tarihi=" + baslangic_tarihi;
            data += "&bitis_tarihi=" + bitis_tarihi;
            data += "&etiketler=" + etiketler;
            data += "&yeni_is_yuku_proje_id=" + yeni_is_yuku_proje_id;


        } else if (deger == "proje_adam_saat_raporu") {

            var rapor_personel_id = $("#rapor_personel_id").val();
            var etiketler = $("#etiketler").val();
            var yeni_is_yuku_proje_id = $("#yeni_is_yuku_proje_id").val();
            var baslangic = $("#is_yuku_donem option:selected").attr("dongu_baslangic");
            var bitis = $("#is_yuku_donem option:selected").attr("dongu_bitis");

            data += "&rapor_personel_id=" + rapor_personel_id;
            data += "&etiketler=" + etiketler;
            data += "&yeni_is_yuku_proje_id=" + yeni_is_yuku_proje_id;
            data += "&baslangic=" + baslangic;
            data += "&bitis=" + bitis;

        } else if (deger == "departman_adam_saat_raporu") {

            var etiketler = $("#etiketler").val();
            var rapor_personel_id = $("#rapor_personel_id").val();
            var yeni_is_yuku_proje_id = $("#yeni_is_yuku_proje_id").val();
            var baslangic = $("#is_yuku_donem option:selected").attr("dongu_baslangic");
            var bitis = $("#is_yuku_donem option:selected").attr("dongu_bitis");

            data += "&etiketler=" + etiketler;
            data += "&rapor_personel_id=" + rapor_personel_id;
            data += "&yeni_is_yuku_proje_id=" + yeni_is_yuku_proje_id;
            data += "&baslangic=" + baslangic;
            data += "&bitis=" + bitis;

        } else if (deger == "proje_maliyet_raporu") {

            var yeni_is_yuku_proje_id = $("#yeni_is_yuku_proje_id").val();

            data += "&yeni_is_yuku_proje_id=" + yeni_is_yuku_proje_id;
        } else if (deger == "personel_adam_saat_raporu") {

            var rapor_personel_id = $("#rapor_personel_id").val();
            var baslangic = $("#is_yuku_donem option:selected").attr("dongu_baslangic");
            var bitis = $("#is_yuku_donem option:selected").attr("dongu_bitis");
            var is_yuku_gosterim_tipi = $("#is_yuku_gosterim_tipi").val();
            var etiketler = $("#etiketler").val();
            var yeni_is_yuku_proje_id = $("#yeni_is_yuku_proje_id").val();

            data += "&rapor_personel_id=" + rapor_personel_id;
            data += "&baslangic=" + baslangic;
            data += "&bitis=" + bitis;
            data += "&is_yuku_gosterim_tipi=" + is_yuku_gosterim_tipi;
            data += "&etiketler=" + etiketler;
            data += "&yeni_is_yuku_proje_id=" + yeni_is_yuku_proje_id;
        } else if (deger == "gantt_liste") {

            var gantt_proje_id = $("#gantt_proje_id").val();
            var gantt_tip = $("#gantt_tip").val();

            data += "&proje_id=" + gantt_proje_id;
            data += "&tip=" + gantt_tip;
        }
        data = encodeURI(data);
        $("#olusturulan_belge_yeri").loadHTML({ url: "/ajax_request3/", data: data }, function () {
            $("#olusturuluyor").hide();
        });
    });
}

function rapor_is_yuku_gosterim_proje_sectim(baslangic, bitis) {

    var gosterim_tipi = $("#yeni_is_yuku_gosterim_tipi").val();
    var proje_id = $("#yeni_is_yuku_proje_id").val();
    var donem = $("#rapor_is_yuku_donem").val();

    baslangic = $("#rapor_is_yuku_donem option:selected").attr("dongu_baslangic");
    bitis = $("#rapor_is_yuku_donem option:selected").attr("dongu_bitis");

    var data = "islem=rapor_is_yuku_gosterim_proje_sectim";
    data += "&proje_id=" + proje_id;
    data += "&baslangic=" + baslangic;
    data += "&bitis=" + bitis;
    data += "&gosterim_tipi=" + gosterim_tipi;
    data += "&donem=" + donem;
    data = encodeURI(data);
    $("#is_yuku_donus2").loadHTML({ url: "/ajax_request3/", data: data }, function () {

    });

}

function is_yuku_gosterim_proje_sectim(baslangic, bitis) {

    var gosterim_tipi = $("#yeni_is_yuku_gosterim_tipi").val();
    var proje_id = $("#yeni_is_yuku_proje_id").val();

    var data = "islem=is_yuku_gosterim_proje_sectim";
    data += "&proje_id=" + proje_id;
    data += "&baslangic=" + baslangic;
    data += "&bitis=" + bitis;
    data += "&gosterim_tipi=" + gosterim_tipi;
    data = encodeURI(data);
    $("#is_yuku_donus2").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        //sayfa_yuklenince();
    });
}


function ajanda_olay_kaydet(nesne, etiket, etiket_id, yinelemeli) {

    var seciliEtiket = $("#etiketler").val();
    var projeVar = false;
    var departmanVar = false;
    var firmaVar = false;
    var etiketler = "";
    var isEmriEkleme = false;
    var bagimsizRenk = "";

    for (var i = 0; i < seciliEtiket.length; i++) {
        if (seciliEtiket[i].includes('departman')) {
            departmanVar = true;
            etiketler += seciliEtiket[i].toString() + ",";
            break;
        }
    }
    for (var i = 0; i < seciliEtiket.length; i++) {
        if (seciliEtiket[i].includes('firma')) {
            firmaVar = true;
            etiketler += seciliEtiket[i].toString() + ",";
            break;
        }
    }
    for (var i = 0; i < seciliEtiket.length; i++) {
        if (seciliEtiket[i].includes('proje')) {
            projeVar = true;
            etiketler += seciliEtiket[i].toString();
            break;
        }
    }

    if (!departmanVar) {
        mesaj_ver("İşler", "Lütfen Etiketler kısmında bir adet Departman seçiniz. !", "warning");
    }
    if (!projeVar && !firmaVar) {
        mesaj_ver("İşler", "Lütfen Etiketler kısmında bir adet Proje veya Firma seçiniz. !", "warning");
    }
    if (!projeVar) {
        etiketler += "proje_disi_isler-0";
    }

    if ($("#AjandaIsEmriOlursurma").is(":checked")) {
        isEmriEkleme = true;
    }
    else {
        bagimsizRenk = "rgb(139, 66, 255)";
    }

    if ($("#yeni_olay_form input:not(input[type=button])").valid("valid")) {
        if ($("#etiketler").val().length > 0) {
            if (projeVar === true && departmanVar === true || firmaVar === true && departmanVar === true) {
                var baslik = $("#baslik").val();
                var renk = $("#renk").val();
                var baslangic_tarihi = $("#baslangic_tarihi").val();
                var baslangic_saati = $("#baslangic_saati").val();
                var bitis_tarihi = $("#bitis_tarihi").val();
                var bitis_saati = $("#bitis_saati").val();
                var aciklama = $("#aciklama").val();
                //var etiketler = $("#etiketler").val();
                var kisiler = $("#kisiler").val();
                var olay_tipi = $("#olay_tipi").val();

                var data = "islem=ajanda_olay_kaydet&islem2=ekle";
                data += "&kisiler=" + kisiler;
                data += "&etiket=" + etiket;
                data += "&etiket_id=" + etiket_id;
                data += "&baslik=" + baslik;
                data += "&renk=" + renk;
                data += "&aciklama=" + aciklama;
                data += "&etiketler=" + etiketler;
                data += "&olay_tipi=" + olay_tipi;
                data += "&yinelemeli=" + yinelemeli;
                data += "&isEmriEkleme=" + isEmriEkleme;
                data += "&bagimsizRenk=" + bagimsizRenk;

                if (yinelemeli == "true") {
                    if ("rutin" == olay_tipi) {
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
                        var olay_suresi = $("#olay_suresi").val();
                        var baslangic_saati = $("#baslangic_saati").val();

                        data += "&yineleme_baslangic=" + yineleme_baslangic;
                        data += "&yineleme_bitis=" + yineleme_bitis;
                        data += "&olay_suresi=" + olay_suresi;
                        data += "&baslangic_saati=" + baslangic_saati;

                    } else {
                        data += "&baslangic_tarihi=" + baslangic_tarihi;
                        data += "&baslangic_saati=" + baslangic_saati;
                        data += "&bitis_tarihi=" + bitis_tarihi;
                        data += "&bitis_saati=" + bitis_saati;
                    }
                } else {
                    data += "&baslangic_tarihi=" + baslangic_tarihi;
                    data += "&baslangic_saati=" + baslangic_saati;
                    data += "&bitis_tarihi=" + bitis_tarihi;
                    data += "&bitis_saati=" + bitis_saati;
                }

                data = encodeURI(data);
                $("#koftiden").loadHTML({ url: "/ajax_request2/", data: data }, function () {
                    mesaj_ver("Ajanda", "Kayıt Başarıyla Eklendi", "success");
                    $('#calendar').fullCalendar('refetchEvents');
                    $('#calendar_gunluk').fullCalendar('refetchEvents');
                    $(".close").click();
                });
            }
        }
        else {
            mesaj_ver("Ajanda Kaydı", "Etiketler Alanını Boş Geçmeyiniz. !", "warning");
        }
    }
}



function ajanda_olay_komple_sil(nesne, etiket, etiket_id, ana_kayit_id) {

    var r = confirm("Kawyıtları Silmek İstediğinize Emin misiniz?");
    if (r) {
        var data = "islem=ajanda_olay_kaydet&islem2=komplesil";
        data += "&ana_kayit_id=" + ana_kayit_id;
        data += "&etiket=" + etiket;
        data += "&etiket_id=" + etiket_id;
        data = encodeURI(data);
        $("#koftiden").loadHTML({ url: "/ajax_request2/", data: data }, function () {
            mesaj_ver("Ajanda", "Kayıtlar Başarıyla Silindi", "success");
            $('#calendar').fullCalendar('refetchEvents');
            $('#calendar_gunluk').fullCalendar('refetchEvents');
            $(".close").click();
        });
    }
}

function ajanda_olay_sil(nesne, etiket, etiket_id, olay_id) {

    var r = confirm("Silmek İstediğinize Emin misiniz?");
    if (r) {
        var data = "islem=ajanda_olay_kaydet&islem2=sil";
        data += "&olay_id=" + olay_id;
        data += "&etiket=" + etiket;
        data += "&etiket_id=" + etiket_id;
        data = encodeURI(data);
        $("#koftiden").loadHTML({ url: "/ajax_request2/", data: data }, function () {
            mesaj_ver("Ajanda", "Kayıt Başarıyla Silindi", "success");
            $('#calendar').fullCalendar('refetchEvents');
            $('#calendar_gunluk').fullCalendar('refetchEvents');
            $(".close").click();
        });
    }
}

function yeni_ajanda_kayit_sundur(etiket, etiket_id, olay_id, baslangic, bitis) {

    var data = "islem=ajanda_olay_kaydet&islem2=sundur";
    data += "&olay_id=" + olay_id;
    data += "&etiket=" + etiket;
    data += "&etiket_id=" + etiket_id;
    data += "&baslangic=" + baslangic;
    data += "&bitis=" + bitis;
    data = encodeURI(data);
    $("#koftiden").loadHTML({ url: "/ajax_request2/", data: data }, function () {

    });

}

function ajanda_olay_guncelle(nesne, etiket, etiket_id, olay_id) {

    if ($("#yeni_olay_form input:not(input[type=button])").valid("valid")) {

        if ($("#baslangic_tarihi").is(":disabled") !== true && $("#bitis_tarihi").is(":disabled") !== true && $("#baslangic_saati").is(":disabled") !== true && $("#bitis_saati").is(":disabled") !== true) {
            var baslik = $("#baslik").val();
            var renk = $("#renk").val();
            var baslangic_tarihi = $("#baslangic_tarihi").val();
            var baslangic_saati = $("#baslangic_saati").val();
            var bitis_tarihi = $("#bitis_tarihi").val();
            var bitis_saati = $("#bitis_saati").val();
            var aciklama = $("#aciklama").val();
            var etiketler = $("#etiketler").val();
            var kisiler = $("#kisiler").val();

            var data = "islem=ajanda_olay_kaydet&islem2=guncelle";
            data += "&kisiler=" + kisiler;
            data += "&olay_id=" + olay_id;
            data += "&etiket=" + etiket;
            data += "&etiket_id=" + etiket_id;
            data += "&baslik=" + baslik;
            data += "&renk=" + renk;
            data += "&baslangic_tarihi=" + baslangic_tarihi;
            data += "&baslangic_saati=" + baslangic_saati;
            data += "&bitis_tarihi=" + bitis_tarihi;
            data += "&bitis_saati=" + bitis_saati;
            data += "&aciklama=" + aciklama;
            data += "&etiketler=" + etiketler;
            data = encodeURI(data);
            $("#koftiden").loadHTML({ url: "/ajax_request2/", data: data }, function () {
                mesaj_ver("Ajanda", "Kayıt Başarıyla Güncellendi", "success");
                $('#calendar').fullCalendar('refetchEvents');
                $('#calendar_gunluk').fullCalendar('refetchEvents');
                $(".close").click();
            });
        }
        else {
            mesaj_ver("Ajanda", "Ortak görevli olduğunuz Olay'da güncelleme yapamazsınız. !!", "warning");
        }
    }
}

function yeni_ajanda_kayit_duzenle(etiket, etiket_id, olay_id) {
    var data = "islem=yeni_ajanda_kayit_duzenle";
    data += "&etiket=" + etiket;
    data += "&etiket_id=" + etiket_id;
    data += "&olay_id=" + olay_id;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $(".modal-backdrop").show();
    $("#Modal-overflow").css("display", "block");
    $("#modal_div").loadHTML({ url: "/ajax_request/", data: data }, function () {
        $(".takvimyap").datepicker({}).mask("99.99.9999");
        $(".timepicker").mask("99:99");
        $('.regexonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter({ format: 'custom', pattern: '[^0-9\,.]' });
        $('.numericonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter('numeric');
    });
}

function yeni_ajanda_kayit_ekle(etiket, etiket_id, start, end, yinelemeli) {

    if (yinelemeli != "true") {
        yinelemeli = "false";
    }

    var data = "islem=yeni_ajanda_kayit_ekle";
    data += "&etiket=" + etiket;
    data += "&etiket_id=" + etiket_id;
    data += "&start=" + start;
    data += "&end=" + end;
    data += "&yinelemeli=" + yinelemeli;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request/", data: data }, function () {
        $(".takvimyap").datepicker({}).mask("99.99.9999");
        $(".timepicker").mask("99:99");
        $('.regexonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter({ format: 'custom', pattern: '[^0-9\,.]' });
        $('.numericonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter('numeric');
    });

}

function cari_hareket_listesi(cari_id, tip, yer) {

    var data = "islem=cari_hareket_listesi";
    data += "&cari_id=" + cari_id;
    data += "&tip=" + tip;
    data += "&yer=" + yer;
    data = encodeURI(data);
    $("#cari_hareket_listesi").loadHTML({ url: "/ajax_request/", data: data }, function () {

    });

}

function cari_hareket_odeme_ekle(cari_id, tip, yer) {

    var data = "islem=cari_hareket_odeme_ekle"
    data += "&cari_id=" + cari_id;
    data += "&yer=" + yer;
    data += "&tip=" + tip;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request/", data: data }, function () {
        $(".takvimyap").datepicker({}).mask("99.99.9999");
        $(".timepicker").mask("99:99");
        $('.regexonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter({ format: 'custom', pattern: '[^0-9\,.]' });
        $('.numericonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter('numeric');
    });

}

function cari_hareket_tahsilat_ekle(cari_id, tip, yer) {

    var data = "islem=cari_hareket_tahsilat_ekle";
    data += "&cari_id=" + cari_id;
    data += "&yer=" + yer;
    data += "&tip=" + tip;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request/", data: data }, function () {
        $(".takvimyap").datepicker({}).mask("99.99.9999");
        $(".timepicker").mask("99:99");
        $('.regexonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter({ format: 'custom', pattern: '[^0-9\,.]' });
        $('.numericonly:not(.yapilan)').addClass("yapilan").autotab_magic().autotab_filter('numeric');
    });
}

function firma_bilgilerini_guncelle(firma_id) {
    if ($("#musteri_guncelleme_form input:not(input[type=button])").valid("valid")) {
        var firma_logo = $("#firma_logo").attr("filePath");
        var firma_adi = $("#firma_adi").val();
        var firma_yetkili = $("#yetkili1_adi").val();
        var firma_telefon = $("#firma_telefon").val();
        var firma_mail = $("#firma_mail").val();
        var firma_supervisor_id = $("#firma_supervisor_id").val();
        var taseron_saatlik_maliyet = $("#taseron_saatlik_maliyet").val().replace("₺", "").replace(" ", "");
        var taseron_maliyet_pb = $("#taseron_maliyet_pb").val();
        var firma_adres = $("#firma_adres").val();

        var firma_vergi_no = $("#firma_vergi_no").val();
        var firma_vergi_daire = $("#firma_vergi_daire").val();

        var yetkili1_telefon = $("#yetkili1_telefon").val();
        var yetkili1_mail = $("#yetkili1_mail").val();

        var data = "islem=firma_bilgilerini_guncelle";
        data += "&firma_id=" + firma_id;
        data += "&firma_adi=" + firma_adi;
        data += "&firma_logo=" + firma_logo;
        data += "&firma_adres=" + firma_adres;

        data += "&firma_telefon=" + firma_telefon;
        data += "&firma_mail=" + firma_mail;
        data += "&firma_supervisor_id=" + firma_supervisor_id;
        data += "&taseron_saatlik_maliyet=" + taseron_saatlik_maliyet;
        data += "&taseron_maliyet_pb=" + taseron_maliyet_pb;

        data += "&firma_vergi_no=" + firma_vergi_no;
        data += "&firma_vergi_daire=" + firma_vergi_daire;

        data += "&firma_yetkili=" + firma_yetkili;
        data += "&yetkili1_telefon=" + yetkili1_telefon;
        data += "&yetkili1_mail=" + yetkili1_mail;

        data += "&yetkili2_adi=" + $("#yetkili2_adi").val();
        data += "&yetkili2_telefon=" + $("#yetkili2_telefon").val();
        data += "&yetkili2_mail=" + $("#yetkili2_mail").val();

        data += "&yetkili3_adi=" + $("#yetkili3_adi").val();
        data += "&yetkili3_telefon=" + $("#yetkili3_telefon").val();
        data += "&yetkili3_mail=" + $("#yetkili3_mail").val();

        data += "&yetkili4_adi=" + $("#yetkili4_adi").val();
        data += "&yetkili4_telefon=" + $("#yetkili4_telefon").val();
        data += "&yetkili4_mail=" + $("#yetkili4_mail").val();

        data = encodeURI(data);
        $("#koftiden").loadHTML({ url: "/ajax_request2/", data: data }, function () {
            mesaj_ver("Müşteri Bilgileri", "Kayıt Başarıyla Güncellendi", "success");
        });
    }

}


function BakimdanIsEmriOlustur(projeId, bakimId, Tum, tarih) {
    var d = new Date();
    var data = "islem=yeni_is_ekle";
    data += "&etiket=" + "proje";
    data += "&etiket_id=" + projeId;
    data += "&bakimvarmi=true";
    data += "&bakimId=" + bakimId;
    data += "&Tum=" + Tum;
    var month = 0;
    var day = 0;
    if (tarih == null) {
        if (d.getMonth() < 10) {
            month = "-" + (d.getMonth() + 1);
        }
        else {
            month = "-" + (d.getMonth() + 1);
        }
        if (d.getDate() < 10) {
            day = "0" + d.getDate();
        }
        else {
            day = d.getDate();
        }
        data += "&yeni_is_baslangic_tarihi=" + day + month + "-" + d.getFullYear();
        data += "&yeni_is_bitis_tarihi=" + day + month + "-" + d.getFullYear();
    }
    else {
        var parts = tarih.split('.');
        if (parts[1] < 10) {
            month = "-" + parts[1];
        }
        else {
            month = "-" + parts[1];
        }
        if (parts[0] < 10) {
            day = "0" + parts[0];
        }
        else {
            day = parts[0];
        }
        data += "&yeni_is_baslangic_tarihi=" + day + month + "-" + parts[2];
        data += "&yeni_is_bitis_tarihi=" + day + month + "-" + parts[2];
    }

    console.log(data);
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "islem1", data: data }, function () {
        sayfa_yuklenince();

    });
    //$("#yeni_is_baslangic_tarihi").datepicker("setValue", tarih);
    //$('#yeni_is_baslangic_tarihi').datepicker('update', '05.11.2015');
}

function TalebiIseDonustur(TalepId) {
    var d = new Date();
    var day = "";
    var month = "";
    var year = d.getFullYear();
    var data = "islem=yeni_is_ekle";
    data += "&TalepId=" + TalepId;
    data += "&TalepVarmi=true";

    if (d.getDate < 10) {
        day = "0" + d.getDate();
    }
    else {
        day = d.getDate();
    }
    if (d.getMonth < 10) {
        month = "0" + (d.getMonth() + 1);
    }
    else {
        month = (d.getMonth() + 1);
    }

    data += "&yeni_is_baslangic_tarihi=" + day + "-" + month + "-" + year;
    data += "&yeni_is_bitis_tarihi=" + day + "-" + month + "-" + year;

    data = encodeURI(data);

    var saveData = $.ajax({
        type: 'POST',
        url: "islem1",
        data: data,
        dataType: "text",
        success: function () {
            $("#modal_butonum").click();
            $("#modal_div").loadHTML({ url: "islem1", data: data }, function () {
                sayfa_yuklenince();
            });
        }
    });

    saveData.error(function () {
        mesaj_ver("Talep Fişleri", "Sadece sizden talep edilen 'Talep Fişlerini' Düzenleyebilirsiniz !", "danger");
    });

}

function gundem_baglantili_is_ekle(toplanti_kayit_id, toplanti_id, gundem_id) {
    etiketli_yeni_is_ekle("toplanti", toplanti_kayit_id);
}

function gundem_karar_ekle(toplanti_id, gundem_id) {
    toplanti_karar_ekle(toplanti_id);
}


function etiketli_yeni_is_ekle(etiket, etiket_id) {
    var data = "islem=yeni_is_ekle";
    data += "&etiket=" + etiket;
    data += "&etiket_id=" + etiket_id;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "islem1", data: data }, function () {
        sayfa_yuklenince();
    });
}

function yeni_is_ekle(proje_id, departman_id) {
    var d = new Date();
    var day = "";
    var month = "";
    var year = d.getFullYear();
    var data = "islem=yeni_is_ekle";
    data += "&proje_id=" + proje_id;
    data += "&departman_id=" + departman_id;

    if (d.getDate() < 10) {
        day = "0" + d.getDate();
    }
    else {
        day = d.getDate();
    }
    if (d.getMonth() < 10) {
        month = "0" + (d.getMonth() + 1);
    }
    else {
        month = (d.getMonth() + 1);
    }

    data += "&yeni_is_baslangic_tarihi=" + day + "-" + month + "-" + year;
    data += "&yeni_is_bitis_tarihi=" + day + "-" + month + "-" + year;

    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "islem1", data: data }, function () {
        sayfa_yuklenince();
    });
}




function ekleme_detayli_giris() {

    $("#ekleme_detay").slideToggle();

}



function millisFromHourMinute(stringHourMinutes) { //All this format are valid: "12:58" "13.75"  "63635676000" (this is already in milliseconds)
    var semiColSeparator = stringHourMinutes.indexOf(":");
    if (semiColSeparator == 0) // :30 minutes
        return millisFromHourMinuteSecond("00" + stringHourMinutes + ":00");
    else if (semiColSeparator > 0) // 1:15 hours:minutes
        return millisFromHourMinuteSecond(stringHourMinutes + ":00");
    else
        return millisFromHourMinuteSecond(stringHourMinutes);

}


function millisFromHourMinuteSecond(stringHourMinutesSeconds) { //All this format are valid: "00:12:58" "12:58:55" "13.75"  "63635676000" (this is already in milliseconds)
    var result = 0;
    stringHourMinutesSeconds.replace(",", ".");
    var semiColSeparator = stringHourMinutesSeconds.indexOf(":");
    var dotSeparator = stringHourMinutesSeconds.indexOf(".");

    if (semiColSeparator < 0 && dotSeparator < 0 && stringHourMinutesSeconds.length > 5) {
        return parseInt(stringHourMinutesSeconds, 10); //already in millis
    } else {

        if (dotSeparator > -1) {
            var d = parseFloat(stringHourMinutesSeconds);
            result = d * 3600000;
        } else {
            var hour = 0;
            var minute = 0;
            var second = 0;

            if (semiColSeparator == -1)
                hour = parseInt(stringHourMinutesSeconds, 10);
            else {

                var units = stringHourMinutesSeconds.split(":")

                hour = parseInt(units[0], 10);
                minute = parseInt(units[1], 10);
                second = parseInt(units[2], 10);
            }
            result = hour * 3600000 + minute * 60000 + second * 1000;
        }
        if (typeof (result) != "number")
            result = NaN;
        return result;
    }
}

function hizli_proje_sectim(nesne) {

    var proje_id = $("#hizli_proje_arama").val();
    var santiye_durum_id = $("#hizli_proje_arama option:selected").attr("santiye_durum_id");
    var ustId = $("#hizli_proje_arama option:selected").attr("ustid");

    sayfagetir('/santiye_detay/', 'jsid=4559&id=' + proje_id + '&departman_id=' + santiye_durum_id + '&UstId=' + ustId);
}


function yeni_is_kaydet(buton) {

    var etiket = $("#yeni_is_etiketler").val();
    var projeVar = false;
    var departmanVar = false;
    var firmaVar = false;
    var departman = "";

    for (var i = 0; i < etiket.length; i++) {
        if (etiket[i].includes('departman')) {
            departmanVar = true;
            departman += etiket[i].toString() + ",";
            break;
        }
    }

    for (var i = 0; i < etiket.length; i++) {
        if (etiket[i].includes('firma')) {
            firmaVar = true;
            departman += etiket[i].toString() + ",";
            break;
        }
    }

    for (var i = 0; i < etiket.length; i++) {
        if (etiket[i].includes('proje')) {
            projeVar = true;
            departman += etiket[i].toString();
            break;
        }
    }

    if (!departmanVar) {
        mesaj_ver("İşler", "Lütfen Etiketler kısmında bir adet Departman seçiniz. !", "warning");
    }
    if (!projeVar && !firmaVar) {
        mesaj_ver("İşler", "Lütfen Etiketler kısmında bir adet Proje veya Firma seçiniz. !", "warning");
    }
    if (!projeVar) {
        departman += "proje_disi_isler-0";
    }

    //console.log("seçilen departmanlar: " + departman);

    var adi = encodeURIComponent($("#yeni_is_adi").val());
    var aciklama = encodeURIComponent($("#yeni_is_aciklama").val());
    var gorevliler = encodeURIComponent($("#yeni_is_gorevliler").val());
    //var departmanlar = encodeURIComponent($("#yeni_is_etiketler").val());
    var oncelik = encodeURIComponent($("#yeni_is_oncelik").val());
    var kontrol_bildirim = encodeURIComponent($("#yeni_is_kontrol_bildirim").val());

    var baslangic_saati = $("#yeni_is_baslangic_saati").val();
    var bitis_saati = $("#yeni_is_bitis_saati").val();
    var renk = encodeURIComponent($("#renk").val());
    var baslangic_tarihi = $("#yeni_is_baslangic_tarihi").val();
    var bitis_tarihi = $("#yeni_is_bitis_tarihi").val();
    var gunluk_sure = $("#yeni_is_gunluk_ortalama_calisma").val();
    var toplam_sure = $("#yeni_is_toplam_calisma").val();
    var toplam_gun = parseFloat(parseFloat(Date.gunfark(bitis_tarihi, baslangic_tarihi)) + 1);
    if (toplam_sure.length == 4) {
        toplam_sure = '0' + getMillisInHoursMinutes(millisFromHourMinute(toplam_sure));
    }
    else {
        toplam_sure = getMillisInHoursMinutes(millisFromHourMinute(toplam_sure));
    }

    var is_tipi = $("#is_tipi").val();
    var sinirlama_varmi = "0";
    if ($("#sinirlama_varmi").attr("checkeds") == "checkeds") {
        sinirlama_varmi = "1";
    }
    var ajanda_gosterim = "0";
    if ($("#is_ajandada_goster").attr("checked") == "checked") {
        ajanda_gosterim = "1";
    }
    if (gorevliler === null) {
        gorevliler = "";
    }
    //if (departmanlar === null) {
    //    departmanlar = "";
    //}
    if (kontrol_bildirim === null) {
        kontrol_bildirim = "";
    }
    var data = "adi=" + adi;
    data += "&aciklama=" + aciklama;
    data += "&gorevliler=" + gorevliler;
    data += "&departmanlar=" + departman;
    data += "&oncelik=" + oncelik;
    data += "&kontrol_bildirim=" + kontrol_bildirim;
    data += "&baslangic_tarihi=" + encodeURIComponent(baslangic_tarihi);
    data += "&baslangic_saati=" + baslangic_saati;
    data += "&bitis_tarihi=" + encodeURIComponent(bitis_tarihi);
    data += "&bitis_saati=" + bitis_saati;
    data += "&renk=" + renk;
    data += "&ajanda_gosterim=" + ajanda_gosterim;
    data += "&gunluk_sure=" + gunluk_sure;
    data += "&toplam_sure=" + toplam_sure;
    data += "&toplam_gun=" + toplam_gun;
    data += "&sinirlama_varmi=" + sinirlama_varmi;
    data += "&is_tipi=" + is_tipi;
    var jsonData = JSON.stringify(QueryStringToJSON(data));

    if (baslangic_tarihi === bitis_tarihi && baslangic_saati === bitis_saati && 1 === 2) {
        mesaj_ver("Yeni İş Ekle", "Başlangıç ve Bitiş Tarihleri Eşit. Lütfen İşin Yapılacağı Zamanı Girin.", "important");
    } else {
        if ($("#yeni_is_ekle_form input:not(input[type=button])").valid("valid")) {
            if ($("#yeni_is_etiketler").val().length > 0) {
                if (projeVar === true && departmanVar === true || firmaVar === true && departmanVar === true) {
                    $(buton).val("Kaydediliyor...").attr("disabled", "disabled");
                    $.ajax({
                        type: "post",
                        url: "/System_Root/ajax/islem1.aspx/YeniIsEkle",
                        data: jsonData,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            if (response.d === "true") {
                                if ($("#toplantimi").val() === "true") {
                                    is_listesi_etiket('toplanti', $("#toplantimi").attr("toplanti_id"));
                                } else if ($("#proje_varmi").val() === "true") {
                                    is_listesi_etiket("proje", $("#proje_varmi").attr("proje_id"));
                                } else {
                                    is_listesi();
                                }
                                mesaj_ver("İşler", "Kayıt Başarıyla Eklendi", "success");
                                AllTask('tum');
                                $(".close").click();
                            } else if (response.d === "false") {
                                mesaj_ver("İşler", "Hata oluştu", "danger");
                                $(buton).val("Yeni İş Emri Ekle").removeAttr("disabled");
                            }
                        }
                    });
                }
            }
            else {
                mesaj_ver("Yeni İş Ekleme", "Etiketler Alanını Boş Geçmeyiniz!", "warning");
            }
        }
    }
}

function is_kaydini_guncelle(IsId, buton) {

    var etiket = $("#dyeni_is_departmanlar").val();
    var projeVar = false;
    var departmanVar = false;
    var firmaVar = false;
    var departman = "";

    for (var i = 0; i < etiket.length; i++) {
        if (etiket[i].includes('departman')) {
            departmanVar = true;
            departman += etiket[i].toString() + ",";
            break;
        }
    }

    for (var i = 0; i < etiket.length; i++) {
        if (etiket[i].includes('firma')) {
            firmaVar = true;
            departman += etiket[i].toString() + ",";
            break;
        }
    }

    for (var i = 0; i < etiket.length; i++) {
        if (etiket[i].includes('proje')) {
            projeVar = true;
            departman += etiket[i].toString();
            break;
        }
    }

    if (!departmanVar) {
        mesaj_ver("İşler", "Lütfen Etiketler kısmında bir adet Departman seçiniz. !", "warning");
    }
    if (!projeVar && !firmaVar) {
        mesaj_ver("İşler", "Lütfen Etiketler kısmında bir adet Proje veya Firma seçiniz. !", "warning");
    }
    if (!projeVar) {
        departman += "proje-disi-isler-0";
    }

    var adi = encodeURIComponent($("#dyeni_is_adi").val());
    var aciklama = encodeURIComponent($("#dyeni_is_aciklama").val());
    var gorevliler = $("#dyeni_is_gorevliler").val();
    var gorevliId = $("#gorevlilerId").val();
    //var departmanlar = encodeURIComponent($("#dyeni_is_departmanlar").val());
    var oncelik = encodeURIComponent($("#dyeni_is_oncelik").val());
    var kontrol_bildirim = encodeURIComponent($("#dyeni_is_kontrol_bildirim").val());
    var baslangic_tarihi = ($("#dyeni_is_baslangic_tarihi").val());
    var baslangic_saati = encodeURIComponent($("#dyeni_is_baslangic_saati").val());
    var bitis_tarihi = ($("#dyeni_is_bitis_tarihi").val());
    var bitis_saati = encodeURIComponent($("#dyeni_is_bitis_saati").val());
    var renk = encodeURIComponent($("#renk").val());
    var gunluk_sure = $("#dyeni_is_gunluk_ortalama_calisma").val();
    var toplam_sure = $("#dyeni_is_toplam_calisma").val();
    var toplam_gun = parseFloat(parseFloat(Date.gunfark(bitis_tarihi, baslangic_tarihi)) + 1);
    toplam_sure = getMillisInHoursMinutes(millisFromHourMinute(toplam_sure));

    var is_tipi = $("#dis_tipi").val();

    var ajanda_gosterim = "0";
    if ($("#is_ajandada_goster2").attr("checkeds") == "checkeds") {
        ajanda_gosterim = "1";
    }
    var sinirlama_varmi = "0";
    if ($("#dsinirlama_varmi").attr("checkeds") == "checkeds") {
        sinirlama_varmi = "1";
    }
    if (gorevliler == null) {
        gorevliler = "";
    }
    //if (departmanlar == null) {
    //    departmanlar = "";
    //}
    if (kontrol_bildirim == null) {
        kontrol_bildirim = "";
    }
    var data = "IsID=" + IsId;
    data += "&adi=" + adi;
    data += "&aciklama=" + aciklama;
    data += "&gorevliler=" + gorevliler;
    data += "&gorevliId=" + gorevliId;
    data += "&departmanlar=" + departman;
    data += "&oncelik=" + oncelik;
    data += "&kontrol_bildirim=" + kontrol_bildirim;
    data += "&baslangic_tarihi=" + encodeURIComponent(baslangic_tarihi);
    data += "&baslangic_saati=" + baslangic_saati;
    data += "&bitis_tarihi=" + encodeURIComponent(bitis_tarihi);
    data += "&bitis_saati=" + bitis_saati;
    data += "&renk=" + renk;
    data += "&ajanda_gosterim=" + ajanda_gosterim;
    data += "&gunluk_sure=" + gunluk_sure;
    data += "&toplam_sure=" + toplam_sure;
    data += "&toplam_gun=" + toplam_gun;
    data += "&sinirlama_varmi=" + sinirlama_varmi;
    data += "&is_tipi=" + is_tipi;
    var jsonData = JSON.stringify(QueryStringToJSON(data));

    if ($("#dyeni_is_ekle_form input:not(input[type=button])").valid("valid")) {
        if ($("#dyeni_is_departmanlar").val().length > 0) {
            if (projeVar === true && departmanVar === true || firmaVar === true && departmanVar === true) {
                $(buton).val("Kaydediliyor...").attr("disabled", "disabled");
                $.ajax({
                    type: "post",
                    url: "/System_Root/ajax/islem1.aspx/IsGuncelle",
                    data: jsonData,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d === "true") {
                            mesaj_ver("İşler", "Kayıt Başarıyla Güncellendi", "success");
                            $(".close").click();
                            var data = "islem=is_detay_goster";
                            data += "&is_id=" + IsId;

                            $("#detay_row" + IsId).loadHTML({ url: "/ajax_request5/", data: data }, function () {
                                var data = "islem=is_timer_start_kaydi";
                                data += "&is_id=" + IsId;
                                $("#is_timer_list" + IsId).loadHTML({ url: "/ajax_request5/", data: data }, function () {
                                    datatableyap();
                                });

                                $(".easyPieChartlar").knob({
                                    draw: function () {
                                        // "tron" case
                                        if (this.$.data('skin') == 'tron') {
                                            this.cursorExt = 0.3;
                                            var a = this.arc(this.cv) // Arc
                                                ,
                                                pa // Previous arc
                                                , r = 1;
                                            this.g.lineWidth = this.lineWidth;
                                            if (this.o.displayPrevious) {
                                                pa = this.arc(this.v);
                                                this.g.beginPath();
                                                this.g.strokeStyle = this.pColor;
                                                this.g.arc(this.xy, this.xy, this.radius - this.lineWidth, pa.s, pa.e, pa.d);
                                                this.g.stroke();
                                            }
                                            this.g.beginPath();
                                            this.g.strokeStyle = r ? this.o.fgColor : this.fgColor;
                                            this.g.arc(this.xy, this.xy, this.radius - this.lineWidth, a.s, a.e, a.d);
                                            this.g.stroke();
                                            this.g.lineWidth = 2;
                                            this.g.beginPath();
                                            this.g.strokeStyle = this.o.fgColor;
                                            this.g.arc(this.xy, this.xy, this.radius - this.lineWidth + 1 + this.lineWidth * 2 / 3, 0, 2 * Math.PI, false);
                                            this.g.stroke();
                                            return false;
                                        }
                                    }
                                });

                                $('.pauseButton').hide();
                                $('.stopButton').hide();

                                timer = new easytimer.Timer();
                                var Id;

                                $('.startButton').click(function () {
                                    $(this).attr("disabled", "disabled");
                                    $('.pauseButton').removeAttr("disabled");
                                    $('.stopButton').removeAttr("disabled");
                                    timer.start();
                                    var is_id = $(this).attr("is_id");
                                    var TamamlanmaID = $(this).attr("tamamlanmaid");
                                    var userId = $(this).attr("tamamlanmaid");
                                    is_timer_start_kaydi(is_id, TamamlanmaID, userId, timer.getTimeValues());
                                    Id = $(this).attr("user_id");
                                });
                                $('.pauseButton').click(function () {
                                    $('.pauseButton').hide();
                                    $('.startButton').show();
                                    $('.startButton').removeAttr("disabled");
                                    var baslik = $(this).attr("baslik");
                                    var aciklama = $(this).attr("aciklama");
                                    var is_id = $(this).attr("is_id");
                                    var TamamlanmaID = $(this).attr("tamamlanmaid");
                                    var userId = $(this).attr("tamamlanmaid");
                                    timer.pause();
                                    is_timer_pause_kaydi(is_id, TamamlanmaID, userId, timer.getTimeValues(), baslik, aciklama);
                                    Id = $(this).attr("user_id");
                                });
                                $('.stopButton').click(function () {
                                    var r = confirm("Kaydı Tamamlamak istiyormusunuz. ?");
                                    if (r) {
                                        timer.stop();
                                        var is_id = $(this).attr("is_id");
                                        var TamamlanmaID = $(this).attr("tamamlanmaid");
                                        var baslik = $('.pauseButton').attr("baslik");
                                        var aciklama = $('.pauseButton').attr("aciklama");
                                        var userId = $(this).attr("tamamlanmaid");
                                        is_timer_stop_kaydi(is_id, TamamlanmaID, userId, timer.getTimeValues(), baslik, aciklama);
                                        Id = $(this).attr("user_id");
                                    }
                                });

                                timer.addEventListener('secondsUpdated', function (e) {
                                    $('#basicUsage').html(timer.getTimeValues().toString());
                                });

                                timer.addEventListener('started', function (e) {
                                    $('#basicUsage').html(timer.getTimeValues().toString());
                                });

                                setTimeout(function () {
                                    $(".file").attr("placeholder", "Yeni Dosya Yükle").css("height", "25px").css("margin-top", "5px;");
                                }, 1000);
                            });
                        } else if (response.d === "false") {
                            mesaj_ver("İşler", "Hata oluştu", "danger");
                            $(buton).val("İş Kaydını Güncelle").removeAttr("disabled");
                        }
                    }
                });
            }
        }
        else {
            mesaj_ver("İş Emri Güncelleme", "Etiketler Alanını Boş Geçmeyiniz!", "warning");
        }
    }
}

$('.startButton').click(function () {
    $(this).attr("disabled", "disabled");
    $('.pauseButton').removeAttr("disabled");
    $('.stopButton').removeAttr("disabled");
    timer.start();
    var is_id = $(this).attr("is_id");
    var TamamlanmaID = $(this).attr("tamamlanmaid");
    var userId = $(this).attr("tamamlanmaid");
    is_timer_start_kaydi(is_id, TamamlanmaID, userId, timer.getTimeValues());
    Id = $(this).attr("user_id");
});
$('.pauseButton').click(function () {
    $('.startButton').removeAttr("disabled");
    var baslik = $(this).attr("baslik");
    var aciklama = $(this).attr("aciklama");
    var is_id = $(this).attr("is_id");
    var TamamlanmaID = $(this).attr("tamamlanmaid");
    var userId = $(this).attr("tamamlanmaid");
    timer.pause();
    is_timer_pause_kaydi(is_id, TamamlanmaID, userId, timer.getTimeValues(), baslik, aciklama);
    Id = $(this).attr("user_id");
});
$('.stopButton').click(function () {
    var r = confirm("Kaydı tamamalamak istiyormusunuz. ?");
    if (r) {
        timer.stop();
        var is_id = $(this).attr("is_id");
        var TamamlanmaID = $(this).attr("tamamlanmaid");
        var baslik = $('.pauseButton').attr("baslik");
        var aciklama = $('.pauseButton').attr("aciklama");
        var userId = $(this).attr("tamamlanmaid");
        is_timer_stop_kaydi(is_id, TamamlanmaID, userId, timer.getTimeValues(), baslik, aciklama);
        Id = $(this).attr("user_id");
    }
});


function isi_iptal_et(IsID) {
    var r = confirm("İşin Durumunu Değiştirmek İstediğinize Eminmisiniz?");
    if (r) {
        var data = "IsID=" + IsID;
        $("#koftiden").loadWebMethod({ url: "/System_Root/ajax/islem1.aspx/IsiIptalEt", data: data }, function () {
            // is_listesi();
            $(".detay_row").hide();
            $(".detay_row").each(function () {
                $(this).parent().parent().remove();
                $(this).parent().remove();
                $(this).remove();
            })
            $(".detay_row").remove();
            $(".details-control-tr[id=" + IsID + "]").remove();
            mesaj_ver("İşler", "Kayıt Başarıyla Güncellendi", "success");
            AllTask();
        });
    }
}


function is_kaydini_duzenle(IsID) {

    var data = "islem=is_kaydini_duzenle";
    data += "&IsID=" + IsID;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "islem1", data: data }, function () {
        sayfa_yuklenince();
    });

}


function is_personel_durt(PersonelID, IsID) {
    var data = "IsID=" + IsID;
    data += "&PersonelID=" + PersonelID;
    $("#koftiden").loadWebMethod({ url: "/System_Root/ajax/islem1.aspx/IsPersonelDurt", data: data }, function () {
        mesaj_ver("Personel", "Uyarma İşlemi Başarılı !", "success");
    });
}


function yeni_is_dosyasi_indir(dosya_id) {
    $(window).off('beforeunload');
    window.location.href = "/dosya_indir/?jsid=4559&tip=is&dosya_id=" + dosya_id;
    //window.location.href = "/ajax/dosya_indir/?jsid=4559&tip=is&dosya_id=" + dosya_id;
}

function yeni_is_dosya_ekle(IsID) {

    var dosya_yolu = $("#dosya_yolu" + IsID).attr("filepath");
    var dosya_adi = $("#dosya_adi" + IsID).val();

    var data = "islem=dosya_listesi_getir&islem2=ekle";
    data += "&IsID=" + IsID;
    data += "&dosya_yolu=" + dosya_yolu;
    data += "&dosya_adi=" + dosya_adi;
    data = encodeURI(data);
    $("#dosya_listesi" + IsID).loadHTML({ url: "islem1", data: data }, function () {
        mesaj_ver("Dosyalar", "Kayıt Başarıyla Eklendi", "success");
    });
}

function dosya_listesi_sil(dosya_id, IsID) {
    var r = confirm("Silmek İstediğinize Eminmisiniz?");
    if (r) {
        var data = "islem=dosya_listesi_getir&islem2=sil";
        data += "&IsID=" + IsID;
        data += "&dosya_id=" + dosya_id;
        data = encodeURI(data);
        $("#dosya_listesi" + IsID).loadHTML({ url: "islem1", data: data }, function () {

        });
    }
}


function dosya_listesi_getir(IsID) {
    var data = "islem=dosya_listesi_getir";
    data += "&IsID=" + IsID;
    data = encodeURI(data);
    $("#dosya_listesi" + IsID).loadHTML({ url: "islem1", data: data }, function () {

    });
}



function dosya_listesi_getir_montaj(IsID) {
    var data = "islem=dosya_listesi_getir_montaj";
    data += "&IsID=" + IsID;
    data = encodeURI(data);
    $("#dosya_listesi" + IsID).loadHTML({ url: "/ajax_request5/", data: data }, function () {

    });
}


function is_kontrol_bildirim_guncelle(IsID) {

    var is_detay_kontrol_bildirim = $("#is_detay_kontrol_bildirim" + IsID).val();

    var data = "IsID=" + IsID;
    data += "&is_detay_kontrol_bildirim=" + is_detay_kontrol_bildirim;
    data = encodeURI(data);
    $("#koftiden").loadWebMethod({ url: "/System_Root/ajax/islem1.aspx/IsBildirimGuncelle", data: data }, function () {
        mesaj_ver("İşler", "Kayıt Başarıyla Güncellendi", "success");
    });


}


function olay_duzenle(proje_id, departman_id, tab_id, olay_id, ekleyen_id) {

    if (ekleyen_id == 1) {
        mesaj_ver("Olaylar", "Bu Kaydı Düzenlemeye Yetkili Değilsiniz", "warning");
    } else {

        var data = "islem=yeni_olay_duzenle";
        data += "&proje_id=" + proje_id;
        data += "&departman_id=" + departman_id;
        data += "&tab_id=" + tab_id;
        data += "&olay_id=" + olay_id;
        data = encodeURI(data);
        $("#modal_butonum").click();
        $("#modal_div").loadHTML({ url: "islem1", data: data }, function () {
            sayfa_yuklenince();
        });

    }



}

function yeni_olay_ekle(proje_id, departman_id, tab_id) {

    var data = "islem=yeni_olay_ekle";
    data += "&proje_id=" + proje_id;
    data += "&departman_id=" + departman_id;
    data += "&tab_id=" + tab_id;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "islem1", data: data }, function () {
        sayfa_yuklenince();
    });

}

function wizard_renklendirme() {

    $(".wizard_tab").removeClass("active");
}


function santiye_detay_tab_getir(proje_id, tab_id, departman_id) {

    var data = "islem=santiye_detay_tab_getir";
    data += "&proje_id=" + proje_id;
    data += "&departman_id=" + departman_id;
    data += "&tab_id=" + tab_id;
    data = encodeURI(data);
    $(".tablar").html("");
    $("#tab" + tab_id).loadHTML({ url: "/System_Root/santiyeler/santiye_detay_tab.aspx", data: data, loading: true }, function () {

        $('.tree > ul').attr('role', 'tree').find('ul').attr('role', 'group');
        $('.tree').find('li:has(ul)').addClass('parent_li').attr('role', 'treeitem').find(' > span').attr('title', 'Collapse this branch').on('click', function (e) {
            var children = $(this).parent('li.parent_li').find(' > ul > li');
            if (children.is(':visible')) {
                children.hide('fast');
                $(this).attr('title', 'Expand this branch').find(' > i').removeClass().addClass('fa fa-lg fa-plus-circle');
            } else {
                children.show('fast');
                $(this).attr('title', 'Collapse this branch').find(' > i').removeClass().addClass('fa fa-lg fa-minus-circle');
            }
            e.stopPropagation();
        });

    });


}

function olay_kayit(proje_id, departman_id, tab_id, buton) {

    var olay = $("#olay").val();
    var olay_tarihi = $("#olay_tarihi").val();
    var olay_saati = $("#olay_saati").val();

    var data = "proje_id=" + proje_id;
    data += "&departman_id=" + departman_id;
    data += "&olay=" + encodeURIComponent(olay);
    data += "&olay_tarihi=" + olay_tarihi;
    data += "&olay_saati=" + olay_saati;
    var jsonData = JSON.stringify(QueryStringToJSON(data));

    if ($("#yeni_olay_ekle_panel_form input:not(input[type=button])").valid("valid")) {
        $(buton).val("Kaydediliyor...").attr("disabled", "disabled");
        $.ajax({
            type: "post",
            url: "/System_Root/ajax/islem1.aspx/OlayEkle",
            data: jsonData,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response.d === "true") {
                    mesaj_ver("Olaylar", "Kayıt Başarıyla Eklendi", "success");
                    santiye_detay_tab_getir(proje_id, tab_id, departman_id);
                    $(".close").click();
                } else if (response.d === "false") {
                    mesaj_ver("Olaylar", "Hata Oluştu", "danger");
                    $(buton).val("Olay Ekle").removeAttr("disabled");
                }
            }
        });
    }
}


function proje_guncelle(proje_id) {

    var firma_id = $("#firma_id").val();
    var santiye_durum_id = $("#santiye_durum_id").val();
    var proje_adi = $("#proje_adi").val();
    var enlem = $("#enlem").val();
    var boylam = $("#boylam").val();
    var firma_supervisor_id = $("#firma_supervisor_id").val();
    var proje_departmanlari = $("#proje_departmanlari").val();

    var data = "proje_id=" + proje_id;
    data += "&firma_id=" + firma_id;
    data += "&santiye_durum_id=" + santiye_durum_id;
    data += "&proje_adi=" + encodeURIComponent(proje_adi);
    data += "&enlem=" + enlem;
    data += "&boylam=" + boylam;
    data += "&firma_supervisor_id=" + firma_supervisor_id;
    data += "&proje_departmanlari=" + proje_departmanlari;
    data = encodeURI(data);
    if ($("#santiye_guncelle_form input:not(input[type=button])").valid("valid")) {
        $("#koftiden").loadWebMethod({ url: "/System_Root/ajax/islem1.aspx/ProjeGuncelle", data: data }, function () {
            mesaj_ver("Proje", "Kayıt Başarıyla Güncellendi", "success");
            //sayfagetir('/santiye_detay/', 'jsid=4559&id=' + proje_id + '&departman_id=' + santiye_durum_id);
            proje_olaylar_getir(proje_id, proje_departmanlari)
        });
    }
}





function santiye_sil(santiye_id, ustID) {

    var r = confirm("Projeyi Silmek İstediğinize Emin misiniz?");
    if (r) {
        var data = "islem=santiye_sil";
        data += "&santiye_id=" + santiye_id;
        data = encodeURI(data);
        $("#koftiden").loadWebMethod({ url: "/System_Root/ajax/islem1.aspx/SantiyeSil", data: data }, function () {
            mesaj_ver("Proje Yönetimi", "Kayıt Başarıyla Silindi", "success");
            sayfagetir('/santiyeler/', 'jsid=4559&UstId=' + ustID);
        });
    }
}


function olay_guncelle(proje_id, departman_id, tab_id, olay_id, buton) {

    var olay = $("#dolay").val();
    var olay_tarihi = $("#dolay_tarihi").val();
    var olay_saati = $("#dolay_saati").val();

    var data = "olay_id=" + olay_id;
    data += "&olay=" + encodeURIComponent(olay);
    data += "&olay_tarihi=" + olay_tarihi;
    data += "&olay_saati=" + olay_saati;
    var jsonData = JSON.stringify(QueryStringToJSON(data));


    if ($("#yeni_olay_duzenle_panel_form input:not(input[type=button])").valid("valid")) {
        $(buton).val("Kaydediliyor...").attr("disabled", "disabled");
        $.ajax({
            type: "post",
            url: "/System_Root/ajax/islem1.aspx/OlayGuncelle",
            data: jsonData,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response.d === "true") {
                    mesaj_ver("Olaylar", "Kayıt Başarıyla Güncellendi", "success");
                    santiye_detay_tab_getir(proje_id, tab_id, departman_id);
                    $(".close").click();
                } else if (response.d === "false") {
                    mesaj_ver("Olaylar", "Hata Oluştu", "danger");
                    $(buton).val("Olay Güncelle").removeAttr("disabled");
                }
            }
        });
    }
}



function olay_sil(proje_id, departman_id, tab_id, olay_id) {
    var r = confirm("Silmek İstediğinize Eminmisiniz?");
    if (r) {

        var data = "olay_id=" + olay_id;
        $("#koftiden").loadWebMethod({ url: "/System_Root/ajax/islem1.aspx/OlaySil", data: data }, function () {
            mesaj_ver("Olaylar", "Kayıt Başarıyla Silindi", "success");
            santiye_detay_tab_getir(proje_id, tab_id, departman_id);
            $(".close").click();
        });

    }
}


function yeni_santiye_ekle(ustID) {

    var data = "islem=yeni_santiye_ekle";
    data += "&UstId=" + ustID;
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "islem1", data: data }, function () {
        sayfa_yuklenince();
    });

}

function projeden_geri_don(santiye_durum_id) {
    sayfagetir('/santiyeler/', 'jsid=4559&santiye_durum_id=' + santiye_durum_id);
}



function proje_ekle(ustID) {

    var proje_firma_id = $("#firma_id").val();
    var proje_adi = $("#proje_adi").val();
    var enlem = $("#enlem").val();
    var boylam = $("#boylam").val();
    var supervisor_id = $("#firma_supervisor_id").val();
    var santiye_durum_id = $("#santiye_durum_id").val();
    var proje_departmanlari = $("#proje_departmanlari").val();
    var uretim_sablon_id = $("#uretim_sablon_id").val();

    var data = "islem=projeler&islem2=ekle";
    data += "&proje_firma_id=" + encodeURIComponent(proje_firma_id);
    data += "&proje_adi=" + encodeURIComponent(proje_adi);
    data += "&enlem=" + encodeURIComponent(enlem);
    data += "&boylam=" + encodeURIComponent(boylam);
    data += "&supervisor_id=" + encodeURIComponent(supervisor_id);
    data += "&santiye_durum_id=" + encodeURIComponent(santiye_durum_id);
    data += "&proje_departmanlari=" + encodeURIComponent(proje_departmanlari);
    data += "&uretim_sablon_id=" + encodeURIComponent(uretim_sablon_id);
    data = encodeURI(data);

    if ($("#proje_ekle_form  input:not(input[type=button])").valid("valid")) {
        sayfagetir('/santiyeler/', 'jsid=4559&ustId=' + ustID);
        $("#koftiden").loadHTML({ url: "islem1", data: data }, function () {
            $(".close").click();
            //datatableyap();
            mesaj_ver("Projeler", "Kayıt Başarıyla Eklendi", "success");
            setTimeout(function () {
                $("#acilacak_santiye" + santiye_durum_id).click();
            }, 500);
        });
    }
}


function is_arama_yap_getir() {

    var adi = encodeURIComponent($("#is_ara_adi").val());
    var durum = encodeURIComponent($("#is_ara_durum").val());
    var gorevliler = encodeURIComponent($("#is_ara_gorevliler").val());
    var firmalar = encodeURIComponent($("#is_ara_firmalar").val());
    var santiyeler = encodeURIComponent($("#is_ara_santiyeler").val());
    var departmanlar = encodeURIComponent($("#is_ara_departmanlar").val());
    var baslangic_tarihi = encodeURIComponent($("#is_ara_baslangic_tarihi").val());
    var bitis_tarihi = encodeURIComponent($("#is_ara_bitis_tarihi").val());
    var is_baslangic_tarihi = encodeURIComponent($("#is_baslangic_tarihi").val());
    var is_bitis_tarihi = encodeURIComponent($("#is_bitis_tarihi").val());

    var data = "islem=is_listesi";
    data += "&durum=";
    data += "&tip=arama";
    data += "&adi=" + adi;
    data += "&is_durum=" + durum;
    data += "&gorevliler=" + gorevliler;
    data += "&firmalar=" + firmalar;
    data += "&santiyeler=" + santiyeler;
    data += "&departmanlar=" + departmanlar;
    data += "&baslangic_tarihi=" + baslangic_tarihi;
    data += "&bitis_tarihi=" + bitis_tarihi;
    data += "&is_baslangic_tarihi=" + is_baslangic_tarihi;
    data += "&is_bitis_tarihi=" + is_bitis_tarihi;

    $(".close").click();
    $("#tum_isler").loadHTML({ url: "islem1", data: data }, function () {
        sayfa_yuklenince();
        is_tablo_islemler();
    });
}

function is_aramasi_yap() {

    var data = "islem=is_aramasi_yap";
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "islem1", data: data }, function () {
        sayfa_yuklenince();
    });


}

var sayacinterval;
function sayac_baslat() {
    window.clearInterval(sayacinterval);
    var elapsed_seconds = 0;
    sayacinterval = setInterval(function () {
        elapsed_seconds = elapsed_seconds + 1;
        $('#counter').text(get_elapsed_time_string(elapsed_seconds));
    }, 1000);

}

function pretty_time_string(num) {
    return (num < 10 ? "0" : "") + num;
}


function get_elapsed_time_string(total_seconds) {

    var hours = Math.floor(total_seconds / 3600);
    total_seconds = total_seconds % 3600;

    var minutes = Math.floor(total_seconds / 60);
    total_seconds = total_seconds % 60;

    var seconds = Math.floor(total_seconds);

    // Pad the minutes and seconds with leading zeros, if required
    hours = pretty_time_string(hours);
    minutes = pretty_time_string(minutes);
    seconds = pretty_time_string(seconds);

    // Compose the string for display
    var currentTimeString = hours + ":" + minutes + ":" + seconds;

    return currentTimeString;
}



function ajanda_calistir() {
    setTimeout(function () {
        $(".fc-month-button").click();
    }, 500);
}


function is_listesi_gosterge(tip) {

    sayfagetir('/is_listesi/', 'jsid=4559');

    setTimeout(function () {
        var etiket = $("#sayac_departman").val();
        var etiket_tip = $("#sayac_departman option:selected").attr("tip");

        var durum = "tum";
        var data = "islem=AllTask";
        data += "&durum=" + durum;
        data += "&tip=" + tip;
        //data += "&etiket=" + etiket.replace(etiket_tip, "");
        //data += "&etiket_tip=" + etiket_tip;

        $("#" + durum).loadHTML({ url: "islem1", data: data }, function () {
            sayfa_yuklenince();
        });
    }, 1000);
}



function proje_butce_hesabi_ekle(proje_id) {

    var data = "islem=proje_butce_hesabi_ekle";
    data += "&proje_id=" + proje_id;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function proje_butce_duzenle(proje_id, kayit_id) {

    var data = "islem=proje_butce_hesabi_duzenle";
    data += "&proje_id=" + proje_id;
    data += "&kayit_id=" + kayit_id;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        sayfa_yuklenince();
    });

}

function proje_butce_sil(proje_id, kayit_id) {

    var r = confirm("Kaydı Silmek istediğinize Eminmisiniz.. ?");
    if (r) {
        var data = "islem=proje_butce_listesi_getir&islem2=sil";
        data += "&proje_id=" + proje_id;
        data += "&kayit_id=" + kayit_id;
        data = encodeURI(data);
        $("#proje_butce_yeri").loadHTML({ url: "/ajax_request2/", data: data }, function () {
            mesaj_ver("Proje Bütçeler", "Kayıt Başarıyla Silindi", "success");
            proje_butce_listesi_getir(proje_id);
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
    //                var data = "islem=proje_butce_listesi_getir&islem2=sil";
    //                data += "&proje_id=" + proje_id;
    //                data += "&kayit_id=" + kayit_id;
    //                data = encodeURI(data);
    //                $("#proje_butce_yeri").loadHTML({ url: "/ajax_request2/", data: data }, function () {
    //                    mesaj_ver("Proje Bütçeler", "Kayıt Başarıyla Silindi", "success");
    //                    proje_butce_listesi_getir(proje_id);
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


function proje_butce_hesabi_kaydet(nesne, proje_id) {

    if ($("#butce_hesabi_ekleme_form input:not(input[type=button])").valid("valid")) {
        if (parseFloat($("#ongorulen_tutar").val()) > 0) {
            var butce_hesabi_adi = $("#butce_hesabi_adi").val();
            var ongorulen_tutar = $("#ongorulen_tutar").val();
            var parabirimi = $("#parabirimi").val();
            var tarih = $("#tarih").val();

            var data = "islem=proje_butce_listesi_getir&islem2=ekle";
            data += "&proje_id=" + proje_id;
            data += "&butce_hesabi_adi=" + butce_hesabi_adi;
            data += "&ongorulen_tutar=" + ongorulen_tutar;
            data += "&parabirimi=" + parabirimi;
            data += "&tarih=" + tarih;
            data = encodeURI(data);
            //$(nesne).attr("disabled", "disabled").val("İşlem Yapılıyor...");
            $("#proje_butce_yeri").loadHTML({ url: "/ajax_request2/", data: data }, function () {
                mesaj_ver("Proje Bütçeler", "Kayıt Başarıyla Eklendi", "success");
                $(".close").click();
                proje_butce_listesi_getir(proje_id);
            });
        }
        else {
            mesaj_ver("Bütçe Hesapları", "Tutar kısmını 0 eklenemez.. !", "warning");
        }
    }
}

function proje_butce_hesabi_guncelle(nesne, proje_id, kayit_id) {

    if ($("#butce_hesabi_ekleme_form input:not(input[type=button])").valid("valid")) {

        var butce_hesabi_adi = $("#butce_hesabi_adi").val();
        var ongorulen_tutar = $("#ongorulen_tutar").val();
        var parabirimi = $("#parabirimi").val();
        var tarih = $("#tarih").val();

        var data = "islem=proje_butce_listesi_getir&islem2=guncelle";
        data += "&proje_id=" + proje_id;
        data += "&kayit_id=" + kayit_id;
        data += "&butce_hesabi_adi=" + butce_hesabi_adi;
        data += "&ongorulen_tutar=" + ongorulen_tutar;
        data += "&parabirimi=" + parabirimi;
        data += "&tarih=" + tarih;
        data = encodeURI(data);
        //$(nesne).attr("disabled", "disabled").val("İşlem Yapılıyor...");
        $("#proje_butce_yeri").loadHTML({ url: "/ajax_request2/", data: data }, function () {
            mesaj_ver("Proje Bütçeler", "Kayıt Başarıyla Güncellendi", "success");
            proje_butce_listesi_getir(proje_id);
            $(".close").click();
        });
    }
}

function is_ilerleme_ajanda_senkronizasyon(TamamlanmaID, tamamlanma_orani, IsID, onceki_oran) {

    var data = "islem=is_ilerleme_ajanda_senkronizasyon";
    data += "&IsID=" + IsID;
    data += "&TamamlanmaID=" + TamamlanmaID;
    data += "&tamamlanma_orani=" + tamamlanma_orani;
    data += "&onceki_oran=" + onceki_oran;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        sayfa_yuklenince();
    });
}


function is_ilerleme_ajanda_senkronizasyon2(TamamlanmaID, tamamlanma_orani, IsID, onceki_oran, baslangic_tarihi, baslangic_saati) {

    var data = "islem=is_ilerleme_ajanda_senkronizasyon2";
    data += "&IsID=" + IsID;
    data += "&TamamlanmaID=" + TamamlanmaID;
    data += "&tamamlanma_orani=" + tamamlanma_orani;
    data += "&onceki_oran=" + onceki_oran;
    data += "&baslangic_tarihi=" + baslangic_tarihi;
    data += "&baslangic_saati=" + baslangic_saati;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        sayfa_yuklenince();
    });
}


function senkronizasyon_tarih_degistir() {

    $("#tarih_degistirme_yeri").slideToggle();
}



function is_ilerleme_ajanda_senkronizasyon_kaydet2(IsID, TamamlanmaID, tamamlanma_orani, onceki_oran, baslama_saati, bitirme_saati, baslama_tarihi, bitirme_tarihi, ajanda_baslik, ajanda_aciklama) {


    var data = "islem=is_ilerleme_ajanda_senkronizasyon_kaydet&islem2=islem2";
    data += "&IsID=" + IsID;
    data += "&TamamlanmaID=" + TamamlanmaID;
    data += "&tamamlanma_orani=" + tamamlanma_orani;
    data += "&onceki_oran=" + onceki_oran;
    data += "&baslama_saati=" + baslama_saati;
    data += "&bitirme_saati=" + bitirme_saati;
    data += "&baslama_tarihi=" + baslama_tarihi;
    data += "&bitirme_tarihi=" + bitirme_tarihi;
    data += "&ajanda_baslik=" + ajanda_baslik;
    data += "&ajanda_aciklama=" + ajanda_aciklama;
    data = encodeURI(data);
    $("#koftiden").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        var data = "TamamlanmaID=" + TamamlanmaID;
        data += "&tamamlanma_orani=" + tamamlanma_orani;
        data += "&IsID=" + IsID;
        $.ajax({
            type: "POST",
            url: "/System_Root/ajax/islem1.aspx/IsDurumGuncelle",
            data: JSON.stringify(QueryStringToJSON(data)),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response.d === "0") {
                    $.bigBox({
                        title: "Uyarı",
                        content: "Hata Oluştu",
                        color: "#C46A69",
                        icon: "fa fa-warning shake animated",
                        number: "1",
                        timeout: 6000
                    });
                } else {
                    $("#is_chart" + IsID).css('width', response.d + '%').attr('aria-valuenow', response.d).attr("data-progressbar-value", response.d);
                    $(".close").click();
                }
            }, failure: function (response) {


            }
        });
    });
}







function is_ilerleme_ajanda_senkronizasyon_kaydet(nesne, IsID, TamamlanmaID, tamamlanma_orani, onceki_oran) {


    var baslama_saati = $("#baslama_saati").val();
    var bitirme_saati = $("#bitirme_saati").val();
    var baslama_tarihi = $("#baslama_tarihi").val();
    var bitirme_tarihi = $("#bitirme_tarihi").val();
    var ajanda_baslik = encodeURIComponent($("#ajanda_baslik").val());
    var ajanda_aciklama = encodeURIComponent($("#ajanda_aciklama").val());

    if ($("#ajanda_senkronize_form input:not(input[type=button])").valid("valid")) {

        $(nesne).attr("disabled", "disabled").val("İşlem Yapılıyor...");

        var data = "islem=is_ilerleme_ajanda_senkronizasyon_kaydet";
        data += "&IsID=" + IsID;
        data += "&TamamlanmaID=" + TamamlanmaID;
        data += "&tamamlanma_orani=" + tamamlanma_orani;
        data += "&onceki_oran=" + onceki_oran;
        data += "&baslama_saati=" + baslama_saati;
        data += "&bitirme_saati=" + bitirme_saati;
        data += "&baslama_tarihi=" + baslama_tarihi;
        data += "&bitirme_tarihi=" + bitirme_tarihi;
        data += "&ajanda_baslik=" + ajanda_baslik;
        data += "&ajanda_aciklama=" + ajanda_aciklama;
        data = encodeURI(data);

        $("#koftiden").loadHTML({ url: "/ajax_request2/", data: data }, function () {

            var data = "TamamlanmaID=" + TamamlanmaID;
            data += "&tamamlanma_orani=" + tamamlanma_orani;
            data += "&IsID=" + IsID;
            $.ajax({
                type: "POST",
                url: "/System_Root/ajax/islem1.aspx/IsDurumGuncelle",
                data: JSON.stringify(QueryStringToJSON(data)),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    if (response.d == "0") {
                        $.bigBox({
                            title: "Uyarı",
                            content: "Hata Oluştu",
                            color: "#C46A69",
                            icon: "fa fa-warning shake animated",
                            number: "1",
                            timeout: 6000
                        });
                    } else {
                        $("#is_chart" + IsID).css('width', response.d + '%').attr('aria-valuenow', response.d).attr("data-progressbar-value", response.d);
                        mesaj_ver("Görevler", "Kayıt Başarıyla Güncellendi", "success");
                        $(".close").click();
                    }
                }, failure: function (response) {

                    $.bigBox({
                        title: "Uyarı",
                        content: "Hata Oluştu",
                        color: "#C46A69",
                        icon: "fa fa-warning shake animated",
                        number: "1",
                        timeout: 6000
                    });
                }
            });


        })
    }





}


function manuel_isi_bitir2(TamamlanmaID, tamamlanma_orani, IsID) {

    var data = "TamamlanmaID=" + TamamlanmaID;
    data += "&tamamlanma_orani=" + tamamlanma_orani;
    data += "&IsID=" + IsID;
    $.ajax({
        type: "POST",
        url: "/System_Root/ajax/islem1.aspx/IsDurumGuncelle",
        data: JSON.stringify(QueryStringToJSON(data)),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {

            if (response.d == "0") {
                $.bigBox({
                    title: "Uyarı",
                    content: "Hata Oluştu",
                    color: "#C46A69",
                    icon: "fa fa-warning shake animated",
                    number: "1",
                    timeout: 6000
                });
            } else {
                $("#is_chart" + IsID).css('width', response.d + '%').attr('aria-valuenow', response.d).attr("data-progressbar-value", response.d);
                mesaj_ver("Görevler", "Kayıt Başarıyla Güncellendi", "success");
                $(".close").click();
            }
        }, failure: function (response) {

            $.bigBox({
                title: "Uyarı",
                content: "Hata Oluştu",
                color: "#C46A69",
                icon: "fa fa-warning shake animated",
                number: "1",
                timeout: 6000
            });
        }
    });
}


function manuel_isi_bitir(TamamlanmaID, tamamlanma_orani, IsID) {

    var data = "TamamlanmaID=" + TamamlanmaID;
    data += "&tamamlanma_orani=" + tamamlanma_orani;
    data += "&IsID=" + IsID;
    $.ajax({
        type: "POST",
        url: "/System_Root/ajax/islem1.aspx/IsDurumGuncelle",
        data: JSON.stringify(QueryStringToJSON(data)),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {


        }, failure: function (response) {


        }
    });
}



var vis_options2 = {
    stack: true,
    tooltip: {
        followMouse: true,
        overflowMethod: 'cap'
    },
    align: 'auto',
    zoomKey: 'ctrlKey',
    orientation: { item: "top", axis: "top" },
    start: start_tarih,
    clickToUse: true,
    horizontalScroll: true,
    showTooltips: true,
    tooltipOnItemUpdateTime: true,
    maxHeight: 400,
    height: 250,
    zoomMin: 1000 * 60 * 60 * 24,
    zoomMax: 1000 * 60 * 60 * 24 * 31 * 3,
    editable: {
        add: false,
        updateTime: false,
        updateGroup: false,
        remove: false
    },
    showCurrentTime: true,
    margin: {
        item: 5,
        axis: 10
    }
};


function is_yuku_timeline_calistir(baslangic_tarihi, bitis_tarihi) {

    vis_items = new vis.DataSet();
    $(function () {


        var className = ['primarykutu', 'inversekutu', 'dangerkutu', 'infokutu', 'warningkutu', 'successkutu'];
        var groups = new vis.DataSet([
            { id: 1, content: 'İş Listesi' }
        ]);
        var yukseklik = (groups.length) * 75;
        if (yukseklik < 250) {
            yukseklik = 250;
        }
        if (yukseklik > 400) {
            yukseklik = 400;
        }





        var order = 0;
        $("lineer").each(function () {

            var baslangic_tarihi = $(this).attr("baslangic_tarihi");
            var baslangic_saati = $(this).attr("baslangic_saati");
            var bitis_tarihi = $(this).attr("bitis_tarihi");
            var bitis_saati = $(this).attr("bitis_saati");

            var yil = baslangic_tarihi.substr(6, 4);
            var ay = parseInt(baslangic_tarihi.substr(3, 2)) - 1;
            var gun = baslangic_tarihi.substr(0, 2);
            var saat = baslangic_saati.substr(0, 2);
            var dakika = baslangic_saati.substr(3, 2);


            var yil2 = bitis_tarihi.substr(6, 4);
            var ay2 = parseInt(bitis_tarihi.substr(3, 2)) - 1;
            var gun2 = bitis_tarihi.substr(0, 2);
            var saat2 = bitis_saati.substr(0, 2);
            var dakika2 = bitis_saati.substr(3, 2);

            var start = new Date(yil, ay, gun, saat, dakika, 0, 0);
            var end = new Date(yil2, ay2, gun2, saat2, dakika2, 0, 0);


            var title = '<div class="panel panel-danger" style="border-color:#FF5370;">\
                            <div class="panel-heading bg-danger"><div style="font-size:12px;"  class="liner_toltip_baslik"><i style="font-size:12px;" class="fa fa-info-circle"></i> ' + $(this).attr("adi").substring(0, 100) + '...</div>\
                               </div>\
<div class="panel-body" style="padding:10px;">\
<p><table class="linertoltip" style="font-size:12px;">\
<tr>\
<td style="width:100px;"><i class="icofont icofont-hand-right text-danger"></i> Başlangıç</td>\
<td style="width:10px;">:</td>\
<td id="tooltip_baslangic'+ $(this).attr("id") + '">' + baslangic_tarihi + ' ' + baslangic_saati + '</td>\
<td style="padding-left:10px;"><i class="icofont icofont-hand-right text-danger"></i> Bitiş</td>\
<td>:</td>\
<td id="tooltip_bitis'+ $(this).attr("id") + '">' + bitis_tarihi + ' ' + bitis_saati + '</td>\
</tr>\
<tr>\
<td><i class="icofont icofont-hand-right text-danger"></i> Ekleyen</td>\
<td>:</td>\
<td colspan="4">' + $(this).attr("ekleyen") + '</td>\
</tr>\
<tr>\
<td><i class="icofont icofont-hand-right text-danger"></i> Etiketler</td>\
<td>:</td>\
<td colspan="4">' + $(this).attr("etiketler").replace(/\<br>/g, ", ") + '</td>\
</tr>\
</table></p>\
</div>\
</div>';



            order++;
            var kutu = className[1];
            if (order % 11 == 0) {
                kutu = className[1];
            }

            if (order % 10 == 0) {
                kutu = className[2];
            }

            if (order % 9 == 0) {
                kutu = className[3];
            }
            if (order % 8 == 0) {
                kutu = className[4];
            }
            if (order % 7 == 0) {
                kutu = className[5];
            }
            if (order % 6 == 0) {
                kutu = className[1];
            }
            if (order % 5 == 0) {
                kutu = className[2];
            }
            if (order % 4 == 0) {
                kutu = className[3];
            }
            if (order % 3 == 0) {
                kutu = className[4];
            }
            if (order % 2 == 0) {
                kutu = className[5];
            }


            if ($(this).attr("renk") == "rgb(231, 76, 60)") {
                kutu = "kuturenk1";
            } else if ($(this).attr("renk") == "rgb(26, 188, 156)") {
                kutu = "kuturenk2";
            } else if ($(this).attr("renk") == "rgb(46, 204, 113)") {
                kutu = "kuturenk3";
            } else if ($(this).attr("renk") == "rgb(52, 152, 219)") {
                kutu = "kuturenk4";
            } else if ($(this).attr("renk") == "rgb(241, 196, 15)") {
                kutu = "kuturenk5";
            } else if ($(this).attr("renk") == "rgb(52, 73, 94)") {
                kutu = "kuturenk6";
            } else {
                kutu = "kuturenk4";
            }

            vis_items.add({
                id: $(this).attr("ID"),
                //group: 1,
                start: start,
                end: end,
                type: 'range',
                content: $(this).attr("adi"),
                title: title,
                editable: true,
                stack: true,
                //stackSubgroups: true,
                className: kutu //  'primarykutu', 'inversekutu', 'dangerkutu', 'infokutu', 'warningkutu', 'successkutu'
            });
        });
        var container = document.getElementById('visualization');
        $("#visualization").attr("baslangic_tarihi", baslangic_tarihi);
        $("#visualization").attr("bitis_tarihi", bitis_tarihi);
        timeline = new vis.Timeline(container, null, vis_options2);
        timeline.setOptions({
            start: baslangic_tarihi,
            end: bitis_tarihi,
        });
        timeline.setItems(vis_items);

        $(".visualizationmenu").show();

        $("#zoomIn").on("click", function () {
            timeline.zoomIn(0.2);
        });

        $("#zoomOut").on("click", function () {
            timeline.zoomOut(0.2);
        });

        $("#moveLeft").on("click", function () {
            move(0.2);
        });

        $("#moveRight").on("click", function () {
            move(-0.2);
        });

        $("#toggleRollingMode").on("click", function () {
            timeline.toggleRollingMode();
        });

        $("#toggleZoomMode").on("click", function () {
            var eldeki = $("#toggleZoomMode").val();
            var hedef = 550;
            if (eldeki == 550) {
                hedef = 250;
            }
            if (hedef == 550) {
                timeline.setOptions({ orientation: { axis: "both" } });
                timeline.setOptions({ height: hedef, maxHeight: hedef });
            } else {
                timeline.setOptions({ orientation: { axis: "top" } });
                timeline.setOptions({ height: hedef, maxHeight: hedef });
            }

            $("#toggleZoomMode").val(hedef);
        });


        vis_items.on('*', function (event, properties) {
            if ("update" == event) {

            }
        });


        timeline.on('doubleClick', function (properties) {
            is_kaydini_duzenle(properties.item);
        });

        vis_items.on('*', function (event, properties) {
            if ("update" == event) {

                var id = properties.data[0].id;

                if (id != null) {
                    var baslangic = properties.data[0].start;
                    var bitis = properties.data[0].end;

                    baslangic = tarih_saat_formatla(baslangic);
                    bitis = tarih_saat_formatla(bitis);

                    console.log(baslangic);
                    console.log(bitis);


                    $("#" + id).find(".tablo_baslangic").find("div").html(baslangic.replace(" ", "<br>"));
                    $("#" + id).find(".tablo_bitis").find("div").html(bitis.replace(" ", "<br>"));

                    var data = "islem=is_listesi_tarih_saat_update";
                    data += "&id=" + id;
                    data += "&baslangic=" + baslangic;
                    data += "&bitis=" + bitis;
                    data = encodeURI(data);
                    $("#koftiden").loadHTML({ url: "/ajax_request2/", data: data }, function () {
                        mesaj_ver("İş Listesi", "Kayıt Başarıyla Güncellendi", "success");
                    });
                }
            }
        });


        setTimeout(function () {
            timeline.setOptions({
                locale: "tr"
            });
            timeline.zoomIn(0.8);
            timeline.setOptions({ orientation: { axis: "both" } });
            timeline.setOptions({ height: 550, maxHeight: 550 });

        }, 200);
    });

}

function is_yuku_detay_geri_don() {
    $("#is_yuku_birinci_ekran2").slideUp();
    $("#is_yuku_birinci_ekran").slideDown();
}

function KaynakIsYukuDetayGoster(kaynak_tipi, kaynak_id) {

    var data = "islem=KaynakIsYukuDetayGoster";
    data += "&kaynak_tipi=" + kaynak_tipi;
    data += "&kaynak_id=" + kaynak_id;
    data = encodeURI(data);
    $("#is_yuku_birinci_ekran").slideUp();
    $("#is_yuku_birinci_ekran2").slideDown();
    $("#is_yuku_birinci_ekran2").loadHTML({ url: "/ajax_request3/", data: data }, function () {

    });
}

function proje_kopyalama_baslat(nesne, proje_id) {

    var hedef_proje_id = $("#hedef_proje_id").val();
    var islem_tipi = $("#islem_tipi").val();

    $(nesne).attr("disabled", "disabled").val("İşlem Yapılıyor...");

    var data = "islem=proje_kopy";
    data += "&proje_id=" + proje_id;
    data += "&hedef_proje_id=" + hedef_proje_id;
    data += "&islem_tipi=" + islem_tipi;
    data = encodeURI(data);
    $("#kopyalama_donus").loadHTML({ url: "/ajax_request3/", data: data }, function () {
        mesaj_ver("Proje Planlama", "Kayıt Başarıyla Eklendi", "success");
        $(".close").click();
    });
}

function proje_plan_kopyala(proje_id) {

    var data = "islem=proje_plan_kopyala";
    data += "&proje_id=" + proje_id;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request3/", data: data }, function () {
        sayfa_yuklenince();
    });

}


function talep_fisleri_getir() {

    var data = "islem=talep_fisleri";
    $("#talep_listesi").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        datatableyap();
    });
}

function user_list() {
    var data = "islem=user_list";
    $("#logincard").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        datatableyap();
    });
}


function talep_fisi_sil(kayit_id) {

    var r = confirm("Kaydı Silmek İstediğinize Emin misiniz?");
    if (r) {
        var data = "islem=talep_fisleri&islem2=sil";
        data += "&kayit_id=" + kayit_id;
        data = encodeURI(data);
        $("#talep_listesi").loadHTML({ url: "/ajax_request6/", data: data }, function () {
            mesaj_ver("Talep Fişleri", "Kayıt Başarıyla Silindi", "success");
        });

    }

}

function talep_fisi_onay(talep_id, deger) {

    var data = "islem=talep_fisleri&islem2=onay";
    data += "&talep_id=" + talep_id;
    data += "&deger=" + deger;
    data = encodeURI(data);

    $("#talep_listesi").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        if (deger == "Onaylandı") {
        } else {
            mesaj_ver("Talep Fişleri", "Kayıt Başarıyla Reddedildi. !", "success");
        }

    });

    //var saveData = $.ajax({
    //    type: 'POST',
    //    url: "/ajax_request6/",
    //    data: data,
    //    dataType: "text",
    //    fail: function () {
    //        mesaj_ver("Talep Fişleri", "Sadece sizden talep edilen 'Talep Fişlerini' Reddedebilirsiniz !", "danger");
    //    },
    //    success: function () {
    //        $("#talep_listesi").loadHTML({ url: "/ajax_request6/", data: data }, function () {
    //            mesaj_ver("Talep Fişleri", "Kayıt Başarıyla Reddedildi. !", "success");
    //        });
    //    }
    //});
    //saveData.error(function () {
    //    mesaj_ver("Talep Fişleri", "Sadece sizden talep edilen 'Talep Fişlerini' Reddedebilirsiniz !", "danger");
    //});
}


function yeni_talep_fisi_guncelle(kayit_id) {

    var baslik = $("#talep_baslik").val();
    var oncelik = $("#talep_oncelik").val();
    var aciklama = $("#talep_aciklama").val();
    var dosya = $("#talep_dosya").attr("filepath");

    var data = "islem=talep_fisleri&islem2=guncelle";
    data += "&kayit_id=" + kayit_id;
    data += "&baslik=" + baslik;
    data += "&oncelik=" + oncelik;
    data += "&aciklama=" + aciklama;
    data += "&dosya=" + dosya;
    data = encodeURI(data);
    if ($("#talepfisform input:not(input[type=button])").valid("valid")) {
        $("#talep_listesi").loadHTML({ url: "/ajax_request6/", data: data }, function () {
            mesaj_ver("Talep Fişleri", "Kayıt Başarıyla Güncellendi.", "success");
            $(".close").click();
        });
    }

}



function talep_fisi_duzenle(kayit_id) {

    var data = "islem=ModalTalepDuzenle";
    data += "&kayit_id=" + kayit_id;
    data = encodeURI(data);

    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request5/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function yeni_talep_fisi_ekle() {

    var baslik = $("#talep_baslik").val();
    var oncelik = $("#talep_oncelik").val();
    var talep_edilen = $("#talep_edilen").val();
    var bildirim = $("#kontrol_select").val();
    var aciklama = $("#talep_aciklama").val();
    var dosya = $("#talep_dosya").attr("filepath");

    var data = "islem=talep_fisleri&islem2=ekle";

    data += "&baslik=" + baslik;
    data += "&oncelik=" + oncelik;
    data += "&talep_edilen=" + talep_edilen;
    data += "&bildirimTuru=" + bildirim;
    data += "&aciklama=" + aciklama;
    data += "&dosya=" + dosya;
    data = encodeURI(data);
    if ($("#talepfisform input:not(input[type=button])").valid("valid")) {
        $("#talep_listesi").loadHTML({ url: "/ajax_request6/", data: data }, function () {
            mesaj_ver("Talep Fişleri", "Kayıt Başarıyla Eklendi.", "success");
            $(".close").click();
        });
    }
}

function YeniTekliBakimKaydiEkle() {

    var data = "islem=YeniTekliBakimKaydiEkle";
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function YeniServisBakimKaydiEkle() {

    var data = "islem=YeniServisBakimKaydiEkle";
    data = encodeURI(data);
    $("#modal_butonum3").click();
    $("#modal_div3").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        sayfa_yuklenince();
    });
    $("#musteri_id").addClass("yapilan").select2();
}

function ServisBakimKaydiEkle() {

    var data = "islem=YeniServisBakimKaydiEkle&islem2=ekle";
    data += "&firmaunvani=" + $("#firmaadi").val();
    if ($("#textyetkili").is(':visible') === false) {
        var value = $("#selectyetkilikisi").find('option:selected');
        var result = value.attr("name");
        data += "&firmayetkili=" + result;
    }
    else { data += "&firmayetkili=" + $("#yetkilikisi").val(); }
    data += "&firmatelefon=" + $("#firmatelefon").val();
    data += "&firmaeposta=" + $("#firmaeposta").val();
    data += "&firmaadress=" + $("#firmaadress").val();
    data += "&firmavergidairesi=" + $("#firmavergidairesi").val();
    data += "&firmavergino=" + $("#firmavergino").val();
    data += "&gorevli=" + $("#firmagorevli").val();

    data += "&siparisdurumu=" + $("#siparisformu").attr("siparisdurumu");
    //data += "&siparisparcaid=" + $("#siparisformu").attr("siparisparcaid");
    //data += "&siparisadet=" + $("#siparisformu").attr("siparisadet");
    //data += "&stokparcaid=" + $("#siparisformu").attr("stokparcaid");
    //data += "&stokadet=" + $("#siparisformu").attr("stokadet");

    data += "&sayi=" + $("#servisparca").attr("sayi");
    data += "&ParcaId=" + $("#servisparca").attr("parcaId");
    data += "&Adet=" + $("#servisparca").attr("adet");

    data += "&musteri_id=" + $("#musteri_id").val();
    data += "&proje_id=" + $("#proje-bilgi").val();
    data += "&rapor_durumu=" + $("#firmarapordurumu").val();
    data += "&personelbildirim=" + $("#personelbildirim").val();
    data += "&firmamakinebilgi=" + $("#firmamakinebilgi").val();
    data += "&firmaariza=" + $("#firmaariza").val();
    data += "&baslangic_tarihi=" + $("#baslangic_tarihi").val();
    data += "&bitis_tarihi=" + $("#bitis_tarihi").val();
    data += "&baslangic_saati=" + $("#baslangic_saati").val();
    data += "&bitis_saati=" + $("#bitis_saati").val();
    data += "&firmayapilanislemler=" + $("#firmayapilanislemler").val();
    data += "&firmanot=" + $("#firmanot").val();
    data += "&listeyeekle=" + $("#listeyeekle").is(":checked");
    data = encodeURI(data);

    if ($("#firmaadi").val().length !== 0) {
        if ($("#yetkilikisi").is(":visible") === true && $("#yetkilikisi").val().length !== 0) {
            $("#servis_kayit").loadHTML({ url: "/ajax_request5/", data: data }, function () {
                mesaj_ver("Servis Bakım Formu", "Kayıt Başarıyla Eklendi.", "success");
                $(".close").click();
            });
        }
        else if ($("#yetkilikisi").is(":visible") === false) {
            $("#servis_kayit").loadHTML({ url: "/ajax_request5/", data: data }, function () {
                mesaj_ver("Servis Bakım Formu", "Kayıt Başarıyla Eklendi.", "success");
                $(".close").click();
            });
        }
        else { mesaj_ver("Servis Bakım Formu", "Yetkili Kişi zorunlu alan.", "danger"); }
    }
    else { mesaj_ver("Servis Bakım Formu", "Firma Adı zorunlu alan.", "danger"); }
}

function ServisBakimKaydiSil(kayitId) {
    var r = confirm("Kaydı Silmek İstediğinize Emin misiniz?");
    if (r) {
        var data = "islem=YeniServisBakimKaydiEkle&islem2=sil";
        data += "&kayit_id=" + kayitId;
        data = encodeURI(data);
        $("#servis_kayit").loadHTML({ url: "/ajax_request5/", data: data }, function () {
            mesaj_ver("Servis Bakım Formu", "Kayıt Başarıyla Silindi", "success");
        });
    }
}

function ServisBakimKaydiDuzenle(kayitId, firmaId) {

    var data = "islem=YeniServisBakimKaydiDuzenle";
    data += "&kayitId=" + kayitId;
    data += "&firmaId=" + firmaId;
    data = encodeURI(data);
    $("#modal_butonum3").click();
    $("#modal_div3").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function parcaDuzenle(id) {
    $("#parca" + id).remove();
    var parcalarId = $("#parcalarId").attr("parcaid").split(",");
    var adet = $("#parcalarId").attr("adet").split(",");
    var stokadet = $("#parcalarId").attr("stokadet").split(",");
    var index = parcalarId.indexOf(id);
    if (index !== -1) {
        var silinenParca = parcalarId.splice(index, 1);
        var silinenAdet = adet.splice(index, 1);
        var silinenstokadet = stokadet.splice(index, 1);

        $("#parcalarId").attr("parcaid", parcalarId);
        $("#parcalarId").attr("adet", adet);
        $("#parcalarId").attr("stokadet", stokadet);

        if ($("#parcalarId").attr("delparcaid") != "") {
            $("#parcalarId").attr("delParcaId", $("#parcalarId").attr("delParcaId") + "," + silinenParca).attr("delAdet", $("#parcalarId").attr("delAdet") + "," + silinenAdet).attr("delstokadet", $("#parcalarId").attr("delstokadet") + "," + silinenstokadet).attr("sayi", "birdenfazla").attr("index2", "silme");
        }
        else { $("#parcalarId").attr("delParcaId", silinenParca).attr("delAdet", silinenAdet).attr("delstokadet", silinenstokadet).attr("sayi", "tek").attr("index2", "silme"); }
    }
    //var parcaId = $("#siparisformu").attr("siparisparcaid").split(",");
    //var parcaAdet = $("#siparisformu").attr("siparisadet").split(",");
    //var index2 = parcaId.indexOf(id);
    //if (index2 !== -1) {
    //    parcaId.splice(index2, 1);
    //    parcaAdet.splice(index2, 1);
    //    $("#siparisformu").attr("siparisparcaid", parcalarId);
    //    $("#siparisformu").attr("siparisadet", adet);
    //}

    //var stokparcaId = $("#siparisformu").attr("stokparcaid").split(",");
    //var stokparcaAdet = $("#siparisformu").attr("stokadet").split(",");
    //var index3 = stokparcaId.indexOf(id);
    //if (index3 !== -1) {
    //    stokparcaId.splice(index3, 1);
    //    stokparcaAdet.splice(index3, 1);
    //    $("#siparisformu").attr("stokparcaid", stokparcaId);
    //    $("#siparisformu").attr("stokadet", stokparcaAdet);
    //}
    sumPrice();
}

function sumPrice() {
    var sumTL = 0;
    var sumUSD = 0;
    var sumEUR = 0;
    var valueTL = 0;
    var valueUSD = 0;
    var valueEUR = 0;

    if ($("#stoklist").children('tr').length == 1) {
        $("#totalPrice").text(0 + " TL" + " - " + 0 + " USD" + " - " + 0 + " EUR");
    }

    $(".price").each(function () {

        var sonucTL = $(this).text().indexOf("TL");
        var sonucUSD = $(this).text().indexOf("USD");
        var sonucEUR = $(this).text().indexOf("EUR");

        if (sonucTL != -1) {
            valueTL = $(this).text().replace('TL', '').replace(' ', '').replace(',', '.');
            if (!isNaN(valueTL) && valueTL.length != 0 && valueTL > 0) {
                sumTL += parseFloat(valueTL);
                $("#totalPrice").text(sumTL.toFixed(2) + " TL" + " - " + sumUSD.toFixed(2) + " USD" + " - " + sumEUR.toFixed(2) + " EUR");
            }
        }

        if (sonucUSD != -1) {
            valueUSD = $(this).text().replace('USD', '').replace(' ', '').replace(',', '.');
            if (!isNaN(valueUSD) && valueUSD.length != 0 && valueUSD > 0) {
                sumUSD += parseFloat(valueUSD);
                $("#totalPrice").text(sumTL.toFixed(2) + " TL" + " - " + sumUSD.toFixed(2) + " USD" + " - " + sumEUR.toFixed(2) + " EUR");
            }
        }

        if (sonucEUR != -1) {
            valueEUR = $(this).text().replace('EUR', '').replace(' ', '').replace(',', '.');
            if (!isNaN(valueEUR) && valueEUR.length != 0 && valueEUR > 0) {
                sumEUR += parseFloat(valueEUR);
                $("#totalPrice").text(sumTL.toFixed(2) + " TL" + " - " + sumUSD.toFixed(2) + " USD" + " - " + sumEUR.toFixed(2) + " EUR");
            }
        }
    });
}

function ServisBakimKaydiDuzenlemeYap(kayitId) {

    var data = "islem=YeniServisBakimKaydiEkle&islem2=duzenle";
    data += "&kayitId=" + kayitId;
    data += "&firmaunvani=" + $("#firmaadi").val();
    if ($("#textyetkili").is(':visible') == false) {
        var value = $("#selectyetkilikisi").find('option:selected');
        var result = value.attr("name");
        data += "&firmayetkili=" + result;
    }
    else { data += "&firmayetkili=" + $("#yetkilikisi").val(); }
    data += "&firmatelefon=" + $("#firmatelefon").val();
    data += "&firmaeposta=" + $("#firmaeposta").val();
    data += "&firmaadress=" + $("#firmaadress").val();
    data += "&firmavergidairesi=" + $("#firmavergidairesi").val();
    data += "&firmavergino=" + $("#firmavergino").val();
    data += "&gorevli=" + $("#firmagorevli").val();
    data += "&parcaId=" + $("#parcalarId").attr("parcaId");
    data += "&adet=" + $("#parcalarId").attr("adet");
    data += "&stokadet=" + $("#parcalarId").attr("stokadet");

    data += "&index=" + $("#parcalarId").attr("index");
    data += "&index2=" + $("#parcalarId").attr("index2");
    data += "&sayi=" + $("#parcalarId").attr("sayi");
    data += "&delparcaid=" + $("#parcalarId").attr("delparcaid");
    data += "&deladet=" + $("#parcalarId").attr("deladet");
    data += "&delstokadet=" + $("#parcalarId").attr("delstokadet");
    data += "&sonradaneklenenparca=" + $("#parcalarId").attr("sonradaneklenenparca");
    data += "&sonradaneklenenadet=" + $("#parcalarId").attr("sonradaneklenenadet");
    data += "&sonradaneklenensayi=" + $("#parcalarId").attr("sonradaneklenensayi");
    data += "&musteri_id=" + $("#musteri_id").val();
    data += "&proje_id=" + $("#proje-bilgi").val();
    data += "&rapor_durumu=" + $("#firmarapordurumu").val();
    data += "&personelbildirim=" + $("#personelbildirim").val();
    data += "&firmamakinebilgi=" + $("#firmamakinebilgi").val();
    data += "&firmaariza=" + $("#firmaariza").val();
    data += "&baslangic_tarihi=" + $("#baslangic_tarihi").val();
    data += "&bitis_tarihi=" + $("#bitis_tarihi").val();
    data += "&baslangic_saati=" + $("#baslangic_saati").val();
    data += "&bitis_saati=" + $("#bitis_saati").val();
    data += "&firmayapilanislemler=" + $("#firmayapilanislemler").val();
    data += "&firmanot=" + $("#firmanot").val();
    data += "&listeyeekle=" + $("#listeyeekle").is(":checked");
    data = encodeURI(data);

    //if ($("#servisbakimduzenle input:not(input#firmaadi, input#yetkilikisi)").valid("valid")) {
    //    if ($("#firmagorevli").val().length > 0) {
    //        $("#servis_kayit").loadHTML({ url: "/ajax_request5/", data: data }, function () {
    //            mesaj_ver("Servis Bakım Formu", "Kayıt Başarıyla Düzenlendi.", "success");
    //            $(".close").click();
    //        });
    //    }
    //    else { mesaj_ver("Servis Bakım Formu", "Görevli alanı zorunludur.", "danger"); }
    //}
    //else { mesaj_ver("Servis Bakım Formu", "Lütfen tüm zorunlu alanları doldurunuz .", "danger"); }


    if ($("#firmaadi").val().length !== 0) {
        if ($("#yetkilikisi").is(":visible") === true && $("#yetkilikisi").val().length !== 0) {
            $("#servis_kayit").loadHTML({ url: "/ajax_request5/", data: data }, function () {
                mesaj_ver("Servis Bakım Formu", "Kayıt Başarıyla Eklendi.", "success");
                $(".close").click();
            });
        }
        else if ($("#yetkilikisi").is(":visible") === false) {
            $("#servis_kayit").loadHTML({ url: "/ajax_request5/", data: data }, function () {
                mesaj_ver("Servis Bakım Formu", "Kayıt Başarıyla Eklendi.", "success");
                $(".close").click();
            });
        }
        else { mesaj_ver("Servis Bakım Formu", "Yetkili Kişi zorunlu alan.", "danger"); }
    }
    else { mesaj_ver("Servis Bakım Formu", "Firma Adı zorunlu alan.", "danger"); }
}

function YeniMusteriOlustur() {
    $("#musteriformu").slideDown("slow");
    //$("#tabloyaekle").show();
    //$("#musteri_id").attr("disabled");
}

function musteribilgilerial(state) {
    var ID = $("#musteri_id").val();
    var pathname = window.location.origin;

    $.ajax({
        type: 'POST',
        contentType: 'application/json; charset=utf-8',
        url: pathname + "/System_Root/ajax/islem1.aspx/musteribilgilerial",
        data: JSON.stringify({ Id: ID }),
        dataType: "JSON",
        error: function (xhr) {
            console.log(xhr);
        },
        success: function (data) {
            $("#musteriformu").slideDown();
            var bilgi = jQuery.parseJSON(data.d);

            $("#firmaadi").val(bilgi[0].firma_adi);
            //$("#yetkilikisi").val(bilgi[0].firma_yetkili);
            $("#firmatelefon").val(bilgi[0].firma_telefon);
            $("#firmaeposta").val(bilgi[0].firma_mail);
            $("#firmavergidairesi").val(bilgi[0].firma_vergi_daire);
            $("#firmaadress").val(bilgi[0].firma_adres);
            $("#firmavergino").val(bilgi[0].firma_vergi_no);

            var y1 = "";
            var y2 = "";
            var y3 = "";
            var y4 = "";

            if (bilgi[0].firma_yetkili !== undefined || new String(bilgi[0].yetkili2_adi).valueOf() != new String("null").valueOf()) {
                y1 = "<option name= '" + bilgi[0].firma_yetkili + "' value='" + bilgi[0].firma_yetkili.replace(' ', '') + "'>" + bilgi[0].firma_yetkili + "</option >";
            }
            if (bilgi[0].yetkili2_adi != undefined || new String(bilgi[0].yetkili2_adi).valueOf() != new String("null").valueOf()) {
                y2 = "<option name = '" + bilgi[0].yetkili2_adi + "' value='" + bilgi[0].yetkili2_adi.replace(' ', '') + "'>" + bilgi[0].yetkili2_adi + "</option >";
            }
            if (bilgi[0].yetkili3_adi != undefined || new String(bilgi[0].yetkili3_adi).valueOf() != new String("null").valueOf()) {
                y3 = "<option name = '" + bilgi[0].yetkili3_adi + "' value='" + bilgi[0].yetkili3_adi.replace(' ', '') + "'>" + bilgi[0].yetkili3_adi + "</option >";
            }
            if (bilgi[0].yetkili4_adi != undefined || new String(bilgi[0].yetkili4_adi).valueOf() != new String("null").valueOf()) {
                y4 = "<option name = '" + bilgi[0].yetkili4_adi + "' value='" + bilgi[0].yetkili4_adi.replace(' ', '') + "'>" + bilgi[0].yetkili4_adi + "</option >";
            }
            $("#selectyetkilikisi").children().remove().end().append(y1 + y2 + y3 + y4);
            var yetkili = $("#yetkilikisi").val().replace(' ', '');
            var txtYetkili = $("#yetkilikisi").val();

            if (state === "edit") {
                if (txtYetkili !== bilgi[0].yetkili1_adi && txtYetkili !== bilgi[0].yetkili2_adi && txtYetkili !== bilgi[0].yetkili3_adi && txtYetkili !== bilgi[0].yetkili4_adi && txtYetkili.length > 0) {
                    $("#selectyetkili").hide();
                    $("#textyetkili").show();
                }
                else {
                    $("#textyetkili").hide();
                    $("#selectyetkili").show();
                    //$("#selectyetkilikisi option[value='" + yetkili + "']").attr('selected', 'selected');
                }
            }
            else {
                $("#textyetkili").hide();
                $("#selectyetkili").show();
                $("#selectyetkilikisi option[value='" + yetkili + "']").attr('selected', 'selected');
            }
        }
    });
}

//Araç Takip
function AracaTakipParametreleri(durum) {
    var data = "islem=aracTakipParametreleri";
    data += "&durum=" + durum;
    $("#aracTakipParametreleri").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function AracTakipGrupList() {
    var data = "islem=aractakipGrupList";
    $("#AracTakipGrupListesi").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function AracTakipGrupDegerleri() {
    var data = "islem=aracTakipGrupDegerleri";
    $("#AracTakipGrupDegerleri").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function AracTakipGrupKaydet(url) {
    var params = {
        grupAdi: $("#grupAdi").val()
    };

    GenericAjax(url, params, AracTakipGrupKaydetSuccess, true);
}

function AracTakipGrupKaydetSuccess(data) {
    var result = jQuery.parseJSON(data.d);
    if (result.message !== "notBeAdded") {
        $("#parametre").trigger("click");
        mesaj_ver("Araç Takip", "Ekleme İşlemi Başarılı", "success");
        $("#grupAdi").val("");
        AracTakipGrupList();
        if (result.grupId !== 0 || result.grupId !== null) {
            $("#gruplar").append("<option selected value='" + result.grupId + "'> " + result.grupAdi + " </option>");
        }
    }
    else {
        mesaj_ver("Araç Takip", "Eklemek İstediğiniz Grup Adı Mevcut !", "danger");
    }
}

function AracTakipGrupDuzenle(url, id) {
    var params = {
        grupId: id
    };

    GenericAjax(url, params, AracTakipGrupDuzenleSuccess, true);
}

function AracTakipGrupDuzenleSuccess(data) {
    var result = jQuery.parseJSON(data.d);

    $("#grupKaydet").hide();
    $("#grupDuzenle").show().attr("onclick", "AracTakipGrupDuzenlemeYap('/System_Root/ajax/islem1.aspx/AracTakipGrupDuzenlemeYap', '" + result[0].AracTakipGrupID + "');");
    $("#grupAdi").val(result[0].GrupAdi);
}

function AracTakipGrupDuzenlemeYap(url, id) {
    var params = {
        grupId: id,
        grupAdi: $("#grupAdi").val()
    };

    GenericAjax(url, params, AracTakipGrupDuzenlemeYapSuccess, true);
}

function AracTakipGrupDuzenlemeYapSuccess(data) {
    if (data.d === "true") {
        mesaj_ver("Araç Takip", "Güncelleme İşlemi Başarılı", "success");
        AracTakipGrupList();
        $("#grupAdi").val("");
        $("#grupKaydet").show();
        $("#grupDuzenle").hide();
    }
    else
        mesaj_ver("Araç Takip", "Güncelleme İşlemi Başarısız !", "danger");
}

function AracTakipGrupSil(url, id) {
    var r = confirm("Grup Adını Silmek İstiyormusunuz ?");
    if (r) {
        var params = {
            grupId: id
        };
        GenericAjax(url, params, AracTakipGrupSilSuccess, true);
    }
}

function AracTakipGrupSilSuccess(data) {
    if (data.d === "true") {
        mesaj_ver("Araç Takip", "Silme İşlemi Başarılı", "success");
        AracTakipGrupList();
        $("#grupAdi").val("");
        $("#grupKaydet").show();
        $("#grupDuzenle").hide();
    }
    else if (data.d === "kullanımda")
        mesaj_ver("Araç Takip", "Silmek İstediğiniz Grup Kullanımda", "danger");
    else
        mesaj_ver("Araç Takip", "Silme İşlemi Başarısız !", "danger");
}

function AracTakipGrupParametreKaydet(url) {
    var params = {
        grupId: $("#gruplar").val(),
        parametreAdi: $("#parametreAdi").val(),
        parametreTipi: $("#parametreTipi").val(),
        hatirlatma: $("#hatirlatma_Chk").is(":checked")
    };

    GenericAjax(url, params, AracTakipGrupParametreKaydetSuccess, true);
}

function AracTakipGrupParametreKaydetSuccess(data) {
    if (data.d === "false")
        mesaj_ver("Parametre Tanımı", "Ekleme İşlemi Başarısız !", "danger");
    else if (data.d === "notBeAdded")
        mesaj_ver("Araç Takip", "Girmiş Olduğunuz Parametre Mevcut.", "danger");
    else {
        mesaj_ver("Araç Takip", "Ekleme İşlemi Başarılı", "success");
        $("#parametreAdi").val("");
        $("#parametreTipi").val(0).select();
        if ($("#hatirlatma_Chk").is(":checked") === true)
            $("#hatirlatma_Chk").trigger("click");
    }
    AracaTakipParametreleri();
}

var state = "";
function AracTakipParametreTanimlamalariDuzenle(url, id, durum) {
    var params = {
        paramID: id,
        durum: durum
    };

    GenericAjax(url, params, AracTakipParametreTanimlamalariDuzenleSuccess, true);

    state = durum;
}

function AracTakipParametreTanimlamalariDuzenleSuccess(data) {

    var result = jQuery.parseJSON(data.d);

    if ($("#parametreTanimi").height() < 300)
        $("#parametre").trigger("click");

    $("#ParametreKaydet").hide();
    $("#ParametreDuzenle").show();

    if (state === "hatirlatma") {
        if (result[0].HatirlatmaID === undefined)
            $("#ParametreDuzenle").attr("onclick", "AracTakipParametreTanimlamalariDuzenlemeYap('/System_Root/ajax/islem1.aspx/AracTakipParametreTanimlamalariDuzenlemeYap', '" + result[0].AracTakipGrupParametreleriID + "', '', 'arac')");
        else
            $("#ParametreDuzenle").attr("onclick", "AracTakipParametreTanimlamalariDuzenlemeYap('/System_Root/ajax/islem1.aspx/AracTakipParametreTanimlamalariDuzenlemeYap', '" + result[0].AracTakipGrupParametreleriID + "', '" + result[0].HatirlatmaID + "', 'arac')");
    }
    else {
        if (result[0].HatirlatmaID === undefined)
            $("#ParametreDuzenle").attr("onclick", "AracTakipParametreTanimlamalariDuzenlemeYap('/System_Root/ajax/islem1.aspx/AracTakipParametreTanimlamalariDuzenlemeYap', '" + result[0].AracTakipGrupParametreleriID + "', '', 'arac')");
        else
            $("#ParametreDuzenle").attr("onclick", "AracTakipParametreTanimlamalariDuzenlemeYap('/System_Root/ajax/islem1.aspx/AracTakipParametreTanimlamalariDuzenlemeYap', '" + result[0].AracTakipGrupParametreleriID + "', '" + result[0].HatirlatmaID + "')");
    }

    if (state === "hatirlatma") {
        $("#gruplar").hide();
        $("#gruplarArac").show();
        $("#gruplarArac").val(result[0].AracTakipGrupID).change();
    }
    else {
        $("#gruplar").val(result[0].AracTakipGrupID).change();
    }

    $("#gruplarArac").val(result[0].AracTakipGrupID).change();
    $("#parametreAdi").val(result[0].GrupParametre);
    $("#parametreTipi").val(result[0].Tip).change();

    if (state === "hatirlatma") {
        if ($("#hatirlama_1").is(":checked") === true)
            $("#hatirlama_1").trigger('click');
        $("#sayi").val("");
        $("#inputValue").val("");
        if ($("#degerile").is(":checked") === true)
            $("#degerile").trigger('click');

        if ($("#sms_ile").is(':checked') === true)
            $("#sms_ile").trigger('click');
        if ($("#mail_ile").is(':checked') === true)
            $("#mail_ile").trigger('click');
        if ($("#bildirim_ile").is(':checked') === true)
            $("#bildirim_ile").trigger('click');

        var id = 0;
        if (result[0].Hatirlatma === true) {

            if ($("#hatirlatma_Chk").is(":checked") === false)
                $("#hatirlatma_Chk").trigger('click');

            if (result[0].Tip === "Tarih") {

                if (result[0].TarihindeHatirlat === true && $("#hatirlama_1").is(":checked") === false)
                    $("#hatirlama_1").trigger('click');
                else if (result[0].TarihindeHatirlat === false && $("#hatirlama_1").is(":checked") === true)
                    $("#hatirlama_1").trigger('click');

                if (result[0].TarihindenOnceHatirlat === true && $("#degerile").is(":checked") === false) {
                    $("#degerile").trigger('click');
                    $("#inputValue").val(result[0].TarihindenOnce);
                }
                else if (result[0].TarihindenOnceHatirlat === false && $("#degerile").is(":checked") === true) {
                    $("#degerile").trigger('click');
                    $("#inputValue").val("");
                }
                var tarihbildirim = result[0].TarihBildirim.split(',');
                if (tarihbildirim !== -1) {
                    if ($("#sms_ile").is(':checked') === true)
                        $("#sms_ile").trigger('click');
                    if ($("#mail_ile").is(':checked') === true)
                        $("#mail_ile").trigger('click');
                    if ($("#bildirim_ile").is(':checked') === true)
                        $("#bildirim_ile").trigger('click');
                    for (var t = 0; t < tarihbildirim.length; t++) {
                        if (tarihbildirim[t] === "sms" && $("#sms_ile").is(":checked") === false)
                            $("#sms_ile").trigger('click');
                        if (tarihbildirim[t] === "mail" && $("#mail_ile").is(":checked") === false)
                            $("#mail_ile").trigger('click');
                        if (tarihbildirim[t] === "bildirim" && $("#bildirim_ile").is(":checked") === false)
                            $("#bildirim_ile").trigger('click');


                        if (result[0].BildirimiAlacakPersonelID > 0) {
                            id = result[0].BildirimiAlacakPersonelID;
                        }
                        $("#bildirimAlacakPersonel").val(id).chenge();
                    }
                }
            }
            if (result[0].Tip === "Sayi") {

                if (result[0].SayiyaGeldigindeHatirlat === true && $("#hatirlama_1").is(':checked') === false) {
                    $("#hatirlama_1").trigger('click');
                    $("#sayi").val(result[0].SayiyaGeldiginde);
                }
                else if (result[0].SayiyaGeldigindeHatirlat === false && $("#hatirlama_1").is(':checked') === true) {
                    $("#hatirlama_1").trigger('click');
                    $("#sayi").val("");
                }
                if (result[0].SayiyaKalaHatirlat === true && $("#degerile").is(":checked") === false) {
                    $("#degerile").trigger('click');
                    $("#inputValue").val(result[0].SayiyaKala);
                }
                else if (result[0].SayiyaKalaHatirlat === false && $("#degerile").is(":checked") === true) {
                    $("#degerile").trigger('click');
                    $("#inputValue").val("");
                }
                var sayibildirim = result[0].SayiBildirim.split(',');
                if (sayibildirim !== -1) {
                    if ($("#sms_ile").is(':checked') === true)
                        $("#sms_ile").trigger('click');
                    if ($("#mail_ile").is(':checked') === true)
                        $("#mail_ile").trigger('click');
                    if ($("#bildirim_ile").is(':checked') === true)
                        $("#bildirim_ile").trigger('click');
                    for (var s = 0; s < sayibildirim.length; s++) {
                        if (sayibildirim[s] === "sms" && $("#sms_ile").is(":checked") === false)
                            $("#sms_ile").trigger('click');
                        if (sayibildirim[s] === "mail" && $("#mail_ile").is(":checked") === false)
                            $("#mail_ile").trigger('click');
                        if (sayibildirim[s] === "bildirim" && $("#bildirim_ile").is(":checked") === false)
                            $("#bildirim_ile").trigger('click');

                        if (result[0].BildirimiAlacakPersonelID > 0) {
                            id = result[0].BildirimiAlacakPersonelID;
                        }
                        $("#bildirimAlacakPersonel").val(id).chenge();
                    }
                }
            }
        }
        else {
            if ($("#hatirlatma_Chk").is(":checked") === true)
                $("#hatirlatma_Chk").trigger('click');

            $("#panel_hatirlatici").slideUp('slow');
        }
    }
    else {
        if (result[0].Hatirlatma === true) {
            if ($("#hatirlatma_Chk").is(":checked") === false)
                $("#hatirlatma_Chk").trigger('click');
        }
        else {
            if ($("#hatirlatma_Chk").is(":checked") === true)
                $("#hatirlatma_Chk").trigger('click');
        }
    }
}

function AracTakipParametreTanimlamalariDuzenlemeYap(url, id, hatirlatmaId, state) {

    if (hatirlatmaId === undefined || hatirlatmaId === '')
        hatirlatmaId = 0;
    var hatirlatma = $("#hatirlatma_Chk").is(":checked");
    var bildirimiAlacakPersonelID = 0;

    var tarihindeHatirlat = false;
    var tarihindeOnceHatirlat = false;
    var tarihindenOnce = 0;
    var tarihBildirim = "";

    var sayiyaGeldiğindeHatirlat = false;
    var sayiyaGeldiğinde = 0;
    var sayiyaKalaHatirlat = false;
    var sayiyaKala = 0;
    var sayiBildirim = "";

    if ($("#hatirlatma_Chk").is(":checked") === true) {
        if ($("#parametreTipi").val() === "Tarih") {
            if ($("#hatirlama_1").is(":checked") === true)
                tarihindeHatirlat = true;
            if ($("#degerile").is(":checked") === true) {
                tarihindeOnceHatirlat = true;
                tarihindenOnce = $("#inputValue").val();
            }
            if ($("#sms_ile").is(":checked") === true) {
                if (tarihBildirim === "")
                    tarihBildirim = "sms";
                else
                    tarihBildirim += "," + "sms";
            }
            if ($("#mail_ile").is(":checked") === true) {
                if (tarihBildirim === "")
                    tarihBildirim = "mail";
                else
                    tarihBildirim += "," + "mail";
            }
            if ($("#bildirim_ile").is(":checked") === true) {
                if (tarihBildirim === "")
                    tarihBildirim = "bildirim";
                else
                    tarihBildirim += "," + "bildirim";
            }
        }
        if ($("#parametreTipi").val() === "Sayi") {
            if ($("#hatirlama_1").is(":checked") === true) {
                sayiyaGeldiğindeHatirlat = true;
                sayiyaGeldiğinde = $("#sayi").val();
            }
            if ($("#degerile").is(":checked") === true) {
                sayiyaKalaHatirlat = true;
                sayiyaKala = $("#inputValue").val();
            }
            if ($("#sms_ile").is(":checked") === true) {
                if (sayiBildirim === "")
                    sayiBildirim = "sms";
                else
                    sayiBildirim = "," + "sms";
            }
            if ($("#mail_ile").is(":checked") === true) {
                if (sayiBildirim === "")
                    sayiBildirim = "mail";
                else
                    sayiBildirim += "," + "mail";
            }
            if ($("#bildirim_ile").is(":checked") === true) {
                if (sayiBildirim === "")
                    sayiBildirim = "bildirim";
                else
                    sayiBildirim += "," + "bildirim";
            }
        }
    }

    var grupID = 0;
    if (state === "arac") {
        grupID = $("#gruplarArac").val();
        bildirimiAlacakPersonelID = $("#bildirimAlacakPersonel").val();
    }
    else if (state === "arac") {
        grupID = $("#gruplar").val();
    }

    var params = {
        grupId: grupID,
        parametreAdi: $("#parametreAdi").val(),
        parametreTipi: $("#parametreTipi").val(),
        hatirlatma: hatirlatma,
        parametrId: id,
        hatirlatmaId: hatirlatmaId,
        bildirimiAlacakPersonelID: bildirimiAlacakPersonelID,

        tarihindeHatirlat: tarihindeHatirlat,
        tarihindeOnceHatirlat: tarihindeOnceHatirlat,
        tarihindenOnce: tarihindenOnce,
        tarihBildirim: tarihBildirim,

        sayiyaGeldigindeHatirlat: sayiyaGeldiğindeHatirlat,
        sayiyaGeldiginde: sayiyaGeldiğinde,
        sayiyaKalaHatirlat: sayiyaKalaHatirlat,
        sayiyaKala: sayiyaKala,
        sayiBildirim: sayiBildirim,
        durum: state
    };

    GenericAjax(url, params, AracTakipParametreTanimlamalariDuzenlemeYapSuccess, true);
}

function AracTakipParametreTanimlamalariDuzenlemeYapSuccess(data) {
    var result = jQuery.parseJSON(data.d);
    if (result === true) {
        mesaj_ver("Araç Takip", "Güncelleme İşlemi Başarılı", "success");
        if (state === "hatirlatma") {
            AracaTakipParametreleri('hatirlatma');
            $("#gruplar").show();
            $("#gruplarArac").hide();
        }
        else {
            AracaTakipParametreleri('arac');
        }

        clearItem();
        $("#ParametreDuzenle").hide();
        $("#ParametreKaydet").show();
    }
    else {
        mesaj_ver("Araç Takip", "Güncelleme İşlemi Başarısız", "danger");
    }
}

function AracTakipParametreTanimlamalariSil(url, id) {
    var r = confirm("Parametreyi Silmek İstiyormusunuz ?");
    if (r) {
        var params = {
            paramId: id
        };

        GenericAjax(url, params, AracTakipParametreTanimlamalariSilSuccess, true);
    }
}

function AracTakipParametreTanimlamalariSilSuccess(data) {
    if (data.d === "true") {
        mesaj_ver("Araç Takip", "Silme İşlemi Başarılı.", "success");
        AracaTakipParametreleri('arac');
    }
    else if (data.d === "silinemez")
        mesaj_ver("Araç Takip", "Silmek İstediğiniz Parametreye Tanımlı Hatırlatma Var. Silinemez", "danger");
    else
        mesaj_ver("Araç Takip", "Silme İşlemi Başarısız.", "danger");
}

function AracTakipGrupDegerAl(url) {
    var parametr = {
        GrupId: $("#grupAdi").val()
    };
    GenericAjax(url, parametr, AracTakipGrupDegerAlSuccess, true);
}

function AracTakipGrupDegerAlSuccess(data) {

    $("#grupdegerleri").empty();
    var result = jQuery.parseJSON(data.d);
    for (var i = 0; i < result.length; i++) {
        var tip = result[i].Tip;
        var parametre = result[i].GrupParametre;
        var Id = result[i].AracTakipGrupParametreleriID;
        //var paramsId = result[i].HatirlaticiGrupParametreleriID;

        if (tip === "Metin") {
            $("#grupdegerleri").append("<label class='col-form-label'>" + parametre + "</label> <input type='text' paramId='" + Id + "' class='form-control mb-1' placeholder='" + parametre + "'/>");
        }
        if (tip === "Sayi") {
            $("#grupdegerleri").append("<label class='col-form-label'>" + parametre + "</label> <input type='number' min='1' paramId='" + Id + "' class='form-control mb-1' placeholder='" + parametre + "'/>");
        }
        if (tip === "Tarih") {
            $("#grupdegerleri").append("<label class='col-form-label'>" + parametre + "</label> <div class='input-group input-group-primary mb-1' style='margin-bottom:0px'> <span class='input-group-addon'><i class='icon-prepend fa fa-calendar'></i></span> <input type='text' paramId='" + Id + "' class='takvimyap form-control' /> </div>");
        }
    }
    $("#grupdegerleri").append("<button type='button' class='btn btn-success mt-3 float-right' onclick='AracTakipGrupDegeriKaydet();'>Kaydet</button>");
    sayfa_yuklenince();
}

function AracTakipGrupDegeriKaydet() {
    var grupId = $("#grupAdi").val();
    var data = "islem=aracTakipGrupDegerleri&islem2=ekle";
    var elementCount = $("#grupDeger input").length;
    var paramsId = [];
    var params = [];
    $("#grupDeger input").each(function () {
        params.push($(this).val());
        paramsId.push($(this).attr("paramId"));
    });

    for (var i = 0; i < params.length; i++) {
        if (data === "") {
            data = "value" + i + "=" + params[i];
        }
        else {
            data += "&value" + i + "=" + params[i];
        }
        if (data === "") {
            data = "paramId" + i + "=" + paramsId[i];
        }
        else {
            data += "&paramId" + i + "=" + paramsId[i];
        }
    }
    data += "&grupId=" + grupId;
    data += "&count=" + elementCount;

    $("#parametreDeger").loadHTML({ url: "/ajax_request6/", data: data }, function (data) {
        mesaj_ver("Parametre Değerleri", "Ekleme Işlemi Başarılı", "success");
        datatableyap();
        AracTakipGrupDegerleri();
        $("#grupAdi").val(0).select();
        $("#grupdegerleri").empty();
    });
}

function AracTakipGrupDegerleriDuzenle(url, Id) {
    var params = {
        degerId: Id
    };
    GenericAjax(url, params, AracTakipGrupDegerleriDuzenleSuccess, true);
}

function AracTakipGrupDegerleriDuzenleSuccess(data) {
    $("#grupdegerleri").empty();
    var result = jQuery.parseJSON(data.d);

    $("#grupAdi").val(result[0].AracTakipGrupID).select();

    for (var i = 0; i < result.length; i++) {
        var tip = result[i].Tip;
        var parametre = result[i].GrupParametre;
        var Id = result[i].AracTakipGrupDegerleriID;
        var grupValue = result[i].GrupValue;

        if (tip === "Metin") {
            $("#grupdegerleri").append("<label class='col-form-label'>" + parametre + "</label> <input type='text' value='" + grupValue + "' id='" + Id + "' class='form-control mb-1' placeholder='" + parametre + "'/>");
        }
        if (tip === "Sayi") {
            $("#grupdegerleri").append("<label class='col-form-label'>" + parametre + "</label> <input type='number' value='" + grupValue + "' min='1' id='" + Id + "' class='form-control mb-1' placeholder='" + parametre + "'/>");
        }
        if (tip === "Tarih") {
            $("#grupdegerleri").append("<label class='col-form-label'>" + parametre + "</label> <div class='input-group input-group-primary mb-1' style='margin-bottom:0px'> <span class='input-group-addon'><i class='icon-prepend fa fa-calendar'></i></span> <input type='text' id='" + Id + "' value='" + grupValue + "' class='form-control takvimyap' /> </div>");
        }
    }
    $("#grupdegerleri").append("<button type='button' class='btn btn-info mt-3 float-right' id='degerDuzenle'>Düzenle</button>");
    $("#degerDuzenle").attr("onclick", "AracTakipGrupDegerDuzenleYap('/System_Root/ajax/islem1.aspx/AracTakipGrupDegerDuzenleYap', '" + Id + "');");
    sayfa_yuklenince();
}

function AracTakipGrupDegerDuzenleYap(url, id) {
    var params = {
        degerID: id,
        degerValue: $("#" + id).val()
    };
    GenericAjax(url, params, AracTakipGrupDegerDuzenleYapSuccess, true);
}

function AracTakipGrupDegerDuzenleYapSuccess(data) {
    var result = jQuery.parseJSON(data.d);

    if (result === true) {
        mesaj_ver("Hatırlatıcı", "Kayıt Başarıyla Güncellendi", "success");
        AracTakipGrupDegerleri();
        $("#grupAdi").val(0).select();
        $("#grupdegerleri").empty();
    }
    else
        mesaj_ver("Hatırlatıcı", "Güncelleme İşlemi Başarısız !", "danger");
}

function AracTakipGrupDegerleriSil(url, id) {
    var r = confirm("Değeri Silmek İstiyormusunuz ?");
    if (r) {
        var params = {
            degerId: id
        };

        GenericAjax(url, params, AracTakipGrupDegerleriSilSuccess, true);
    }
}

function AracTakipGrupDegerleriSilSuccess(data) {
    var result = jQuery.parseJSON(data.d);
    if (result === true) {
        mesaj_ver("Hatırlarıcı", "Silme İşlemi Başarılı", "success");
        AracTakipGrupDegerleri();
    }
    else
        mesaj_ver("Hatırlarıcı", "Silme İşlemi Başarısız !", "danger");
}

//Hatırlarıcı
function ParametreDegerAl(url) {
    var parametr = {
        GrupId: $("#grupAdi").val()
    };
    GenericAjax(url, parametr, ParametreDegerAlSuccess, true);
}

function ParametreDegerAlSuccess(data) {
    $("#grupdegerleri").empty();

    var result = jQuery.parseJSON(data.d);

    var d = new Date();
    var strDate = d.getDate() + "-" + (d.getMonth() + 1) + "-" + d.getFullYear();

    for (var i = 0; i < result.length; i++) {
        var tip = result[i].Tip;
        var parametre = result[i].GrupParametre;
        var Id = result[i].HatirlaticiGrupParametreleriID;
        //var paramsId = result[i].HatirlaticiGrupParametreleriID;

        if (tip === "Metin") {
            $("#grupdegerleri").append("<label class='col-form-label'>" + parametre + "</label> <input type='text' paramId='" + Id + "' class='form-control mb-1' placeholder='" + parametre + "'/>");
        }
        if (tip === "Sayi") {
            $("#grupdegerleri").append("<label class='col-form-label'>" + parametre + "</label> <input type='number' min='1' paramId='" + Id + "' class='form-control mb-1' placeholder='" + parametre + "'/>");
        }
        if (tip === "Tarih") {
            $("#grupdegerleri").append("<label class='col-form-label'>" + parametre + "</label> <div class='input-group input-group-primary mb-1' style='margin-bottom:0px'> <span class='input-group-addon'><i class='icon-prepend fa fa-calendar'></i></span> <input type='text' paramId='" + Id + "' class='takvimyap form-control' /> </div>");
        }
    }

    $("#grupdegerleri").append("<label class='col-form-label'>Açıklama</label> <textarea id='aciklama' class='form-control mb-1' placeholder='Açıklama'></textarea>");

    $("#grupdegerleri").append("<button type='button' class='btn btn-success mt-3 float-right' onclick='GrupDegerKaydet();'>Kaydet</button>");
    sayfa_yuklenince();
}

function GrupList() {
    var data = "islem=grup_list";
    $("#GrupListesi").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function GrupDuzenle(url, Id) {
    var params = {
        grupId: Id
    };
    GenericAjax(url, params, GrupDuzenleSuccess, true);
}

function GrupDuzenleSuccess(data) {
    var result = jQuery.parseJSON(data.d);

    $("#grupKaydet").hide();
    $("#grupDuzenle").show().attr("onclick", "GrupDuzenlemeYap('/System_Root/ajax/islem1.aspx/GrupDuzenlemeYap', '" + result[0].HatirlaticiGrupID + "');");
    $("#grupAdi").val(result[0].GrupAdi);
}

function GrupDuzenlemeYap(url, Id) {
    var params = {
        grupId: Id,
        grupAdi: $("#grupAdi").val()
    };
    GenericAjax(url, params, GrupDuzenlemeYapSuccess, true);
}

function GrupDuzenlemeYapSuccess(data) {
    if (data.d === "true") {
        mesaj_ver("Hatırlatıcı", "Güncelleme İşlemi Başarılı", "success");
        GrupList();
        $("#grupAdi").val("");
        $("#grupKaydet").show();
        $("#grupDuzenle").hide();
    }
    else
        mesaj_ver("Hatırlatıcı", "Güncelleme İşlemi Başarısız !", "danger");
}

function GrupSil(url, Id) {
    var r = confirm("Grup Adını Silmek İstiyormusunuz ?");
    if (r) {
        var params = {
            grupId: Id
        };
        GenericAjax(url, params, GrupSilSuccess, true);
    }
}

function GrupSilSuccess(data) {
    if (data.d === "true") {
        mesaj_ver("Hatırlatıcı", "Silme İşlemi Başarılı", "success");
        GrupList();
        $("#grupAdi").val("");
        $("#grupKaydet").show();
        $("#grupDuzenle").hide();
    }
    else if (data.d === "kullanımda")
        mesaj_ver("Hatırlatıcı", "Silmek İstediğiniz Grup Kullanımda", "danger");
    else
        mesaj_ver("Hatırlatıcı", "Silme İşlemi Başarısız !", "danger");
}

function ParametreTanimlamalariDuzenlemeYap(url, Id, hatirlatmaId) {
    if (hatirlatmaId === undefined)
        hatirlatmaId = 0;
    var hatirlatma = $("#hatirlatma_Chk").is(":checked");
    var bildirimiAlacakPersonelID = $("#bildirimAlacakPersonel").val();

    var tarihindeHatirlat = false;
    var tarihindeOnceHatirlat = false;
    var tarihindenOnce = 0;
    var tarihBildirim = "";

    var sayiyaGeldiğindeHatirlat = false;
    var sayiyaGeldiğinde = 0;
    var sayiyaKalaHatirlat = false;
    var sayiyaKala = 0;
    var sayiBildirim = "";

    if ($("#hatirlatma_Chk").is(":checked") === true) {
        if ($("#parametreTipi").val() === "Tarih") {
            if ($("#hatirlama_1").is(":checked") === true)
                tarihindeHatirlat = true;
            if ($("#degerile").is(":checked") === true) {
                tarihindeOnceHatirlat = true;
                tarihindenOnce = $("#inputValue").val();
            }
            if ($("#sms_ile").is(":checked") === true) {
                if (tarihBildirim === "")
                    tarihBildirim = "sms";
                else
                    tarihBildirim += "," + "sms";
            }
            if ($("#mail_ile").is(":checked") === true) {
                if (tarihBildirim === "")
                    tarihBildirim = "mail";
                else
                    tarihBildirim += "," + "mail";
            }
            if ($("#bildirim_ile").is(":checked") === true) {
                if (tarihBildirim === "")
                    tarihBildirim = "bildirim";
                else
                    tarihBildirim += "," + "bildirim";
            }
        }
        if ($("#parametreTipi").val() === "Sayi") {
            if ($("#hatirlama_1").is(":checked") === true) {
                sayiyaGeldiğindeHatirlat = true;
                sayiyaGeldiğinde = $("#sayi").val();
            }
            if ($("#degerile").is(":checked") === true) {
                sayiyaKalaHatirlat = true;
                sayiyaKala = $("#inputValue").val();
            }
            if ($("#sms_ile").is(":checked") === true) {
                if (sayiBildirim === "")
                    sayiBildirim = "sms";
                else
                    sayiBildirim = "," + "sms";
            }
            if ($("#mail_ile").is(":checked") === true) {
                if (sayiBildirim === "")
                    sayiBildirim = "mail";
                else
                    sayiBildirim += "," + "mail";
            }
            if ($("#bildirim_ile").is(":checked") === true) {
                if (sayiBildirim === "")
                    sayiBildirim = "bildirim";
                else
                    sayiBildirim += "," + "bildirim";
            }
        }
    }

    var parametr = {
        grupId: $("#gruplar").val(),
        parametreAdi: $("#parametreAdi").val(),
        parametreTipi: $("#parametreTipi").val(),
        hatirlatma: hatirlatma,
        parametrId: Id,
        hatirlatmaId: hatirlatmaId,
        bildirimiAlacakPersonelID: bildirimiAlacakPersonelID,

        tarihindeHatirlat: tarihindeHatirlat,
        tarihindeOnceHatirlat: tarihindeOnceHatirlat,
        tarihindenOnce: tarihindenOnce,
        tarihBildirim: tarihBildirim,

        sayiyaGeldigindeHatirlat: sayiyaGeldiğindeHatirlat,
        sayiyaGeldiginde: sayiyaGeldiğinde,
        sayiyaKalaHatirlat: sayiyaKalaHatirlat,
        sayiyaKala: sayiyaKala,
        sayiBildirim: sayiBildirim
    };
    GenericAjax(url, parametr, ParametreTanimlamalariDuzenlemeYapSuccess, true);
    datatableyap();
}

function ParametreTanimlamalariDuzenlemeYapSuccess(data) {
    var result = jQuery.parseJSON(data.d);
    if (result === true) {
        mesaj_ver("Parametre Tanımlamaları", "Güncelleme İşlemi Başarılı", "success");
        GrupParametreleri();
        clearItem();
    }
    else {
        mesaj_ver("Parametre Tanımlamaları", "Güncelleme İşlemi Başarısız", "danger");
    }
}

function ParametreTanimlamalariDuzenle(url, Id) {
    var params = {
        paramID: Id
    };
    GenericAjax(url, params, ParametreTanimlamalariDuzenleSuccess, true);
}

function ParametreTanimlamalariDuzenleSuccess(data) {

    var result = jQuery.parseJSON(data.d);
    if ($("#parametreTanimi").height() < 363)
        $("#parametre").trigger("click");

    $("#ParametreKaydet").hide();
    $("#ParametreDuzenle").show();

    if (result[0].HatirlatmaID === undefined)
        $("#ParametreDuzenle").attr("onclick", "ParametreTanimlamalariDuzenlemeYap('/System_Root/ajax/islem1.aspx/ParametreTanimlamalariDuzenlemeYap', '" + result[0].HatirlaticiGrupParametreleriID + "')");
    else
        $("#ParametreDuzenle").attr("onclick", "ParametreTanimlamalariDuzenlemeYap('/System_Root/ajax/islem1.aspx/ParametreTanimlamalariDuzenlemeYap', '" + result[0].HatirlaticiGrupParametreleriID + "', '" + result[0].HatirlatmaID + "')");

    $("#gruplarArac").hide();
    $("#gruplar").show();

    $("#gruplar").val(result[0].HatirlaticiGrupID).change();
    $("#parametreAdi").val(result[0].GrupParametre);

    $("#parametreTipi").val(result[0].Tip).change();

    if ($("#hatirlama_1").is(":checked") === true)
        $("#hatirlama_1").trigger('click');
    $("#sayi").val("");
    $("#inputValue").val("");
    if ($("#degerile").is(":checked") === true)
        $("#degerile").trigger('click');

    if ($("#sms_ile").is(':checked') === true)
        $("#sms_ile").trigger('click');
    if ($("#mail_ile").is(':checked') === true)
        $("#mail_ile").trigger('click');
    if ($("#bildirim_ile").is(':checked') === true)
        $("#bildirim_ile").trigger('click');

    var id = 0;
    if (result[0].Hatirlatma === true) {

        if ($("#hatirlatma_Chk").is(":checked") === false)
            $("#hatirlatma_Chk").trigger('click');

        if (result[0].Tip === "Tarih") {

            if (result[0].TarihindeHatirlat === true && $("#hatirlama_1").is(":checked") === false)
                $("#hatirlama_1").trigger('click');
            else if (result[0].TarihindeHatirlat === false && $("#hatirlama_1").is(":checked") === true)
                $("#hatirlama_1").trigger('click');

            if (result[0].TarihindenOnceHatirlat === true && $("#degerile").is(":checked") === false) {
                $("#degerile").trigger('click');
                $("#inputValue").val(result[0].TarihindenOnce);
            }
            else if (result[0].TarihindenOnceHatirlat === false && $("#degerile").is(":checked") === true) {
                $("#degerile").trigger('click');
                $("#inputValue").val("");
            }
            var tarihbildirim = result[0].TarihBildirim.split(',');
            if (tarihbildirim !== -1) {
                if ($("#sms_ile").is(':checked') === true)
                    $("#sms_ile").trigger('click');
                if ($("#mail_ile").is(':checked') === true)
                    $("#mail_ile").trigger('click');
                if ($("#bildirim_ile").is(':checked') === true)
                    $("#bildirim_ile").trigger('click');
                for (var t = 0; t < tarihbildirim.length; t++) {
                    if (tarihbildirim[t] === "sms" && $("#sms_ile").is(":checked") === false)
                        $("#sms_ile").trigger('click');
                    if (tarihbildirim[t] === "mail" && $("#mail_ile").is(":checked") === false)
                        $("#mail_ile").trigger('click');
                    if (tarihbildirim[t] === "bildirim" && $("#bildirim_ile").is(":checked") === false)
                        $("#bildirim_ile").trigger('click');


                    if (result[0].BildirimiAlacakPersonelID > 0) {
                        id = result[0].BildirimiAlacakPersonelID;
                    }
                    $("#bildirimAlacakPersonel").val(id).select();
                }
            }
        }
        if (result[0].Tip === "Sayi") {

            if (result[0].SayiyaGeldigindeHatirlat === true && $("#hatirlama_1").is(':checked') === false) {
                $("#hatirlama_1").trigger('click');
                $("#sayi").val(result[0].SayiyaGeldiginde);
            }
            else if (result[0].SayiyaGeldigindeHatirlat === false && $("#hatirlama_1").is(':checked') === true) {
                $("#hatirlama_1").trigger('click');
                $("#sayi").val("");
            }
            if (result[0].SayiyaKalaHatirlat === true && $("#degerile").is(":checked") === false) {
                $("#degerile").trigger('click');
                $("#inputValue").val(result[0].SayiyaKala);
            }
            else if (result[0].SayiyaKalaHatirlat === false && $("#degerile").is(":checked") === true) {
                $("#degerile").trigger('click');
                $("#inputValue").val("");
            }
            var sayibildirim = result[0].SayiBildirim.split(',');
            if (sayibildirim !== -1) {
                if ($("#sms_ile").is(':checked') === true)
                    $("#sms_ile").trigger('click');
                if ($("#mail_ile").is(':checked') === true)
                    $("#mail_ile").trigger('click');
                if ($("#bildirim_ile").is(':checked') === true)
                    $("#bildirim_ile").trigger('click');
                for (var s = 0; s < sayibildirim.length; s++) {
                    if (sayibildirim[s] === "sms" && $("#sms_ile").is(":checked") === false)
                        $("#sms_ile").trigger('click');
                    if (sayibildirim[s] === "mail" && $("#mail_ile").is(":checked") === false)
                        $("#mail_ile").trigger('click');
                    if (sayibildirim[s] === "bildirim" && $("#bildirim_ile").is(":checked") === false)
                        $("#bildirim_ile").trigger('click');

                    if (result[0].BildirimiAlacakPersonelID > 0) {
                        id = result[0].BildirimiAlacakPersonelID;
                    }
                    $("#bildirimAlacakPersonel").val(id).select();
                }
            }
        }
    }
    else {
        if ($("#hatirlatma_Chk").is(":checked") === true)
            $("#hatirlatma_Chk").trigger('click');

        $("#panel_hatirlatici").slideUp('slow');
    }
}

function ParametreTanimlamalariSil(url, parametreId) {
    var r = confirm("Kaydı Silmek İstediğinize Emin misiniz?");
    if (r) {
        var params = {
            parametreId: parametreId
        };
        GenericAjax(url, params, ParametreTanimlamalariSilSuccess, true);
        datatableyap();
    }
}

function ParametreTanimlamalariSilSuccess(data) {
    if (data.d === "true")
        mesaj_ver("Parametre Tanımlamaları", "Silme İşlemi Başarılı.", "success");
    else if (data.d === "silinemez")
        mesaj_ver("Parametre Tanımlamaları", "Silmek İstediğiniz Parametreye Tanımlı Hatırlatma Var. Silinemez", "danger");
    else
        mesaj_ver("Parametre Tanımlamaları", "Silme İşlemi Başarısız.", "danger");
    GrupParametreleri();
}

function GrupDegerleriDuzenle(url, Id) {
    var params = {
        degerId: Id
    };
    GenericAjax(url, params, GrupDegerleriDuzenleSuccess, true);
}

function GrupDegerleriDuzenleSuccess(data) {
    $("#grupdegerleri").empty();
    var result = jQuery.parseJSON(data.d);
    $("#grupAdi").val(result[0].HatirlaticiGrupID).select();

    for (var i = 0; i < result.length; i++) {
        var tip = result[i].Tip;
        var parametre = result[i].GrupParametre;
        var Id = result[i].HatirlaticiGrupDegerleriID;
        var paramsId = result[i].HatirlaticiGrupDegerleriID;
        var grupValue = result[i].GrupValue;

        if (tip === "Metin") {
            $("#grupdegerleri").append("<label class='col-form-label'>" + parametre + "</label> <input type='text' value='" + grupValue + "' id='" + Id + "' class='form-control mb-1' placeholder='" + parametre + "'/>");
        }
        if (tip === "Sayi") {
            $("#grupdegerleri").append("<label class='col-form-label'>" + parametre + "</label> <input type='number' value='" + grupValue + "' min='1' id='" + Id + "' class='form-control mb-1' placeholder='" + parametre + "'/>");
        }
        if (tip === "Tarih") {
            $("#grupdegerleri").append("<label class='col-form-label'>" + parametre + "</label> <div class='input-group input-group-primary mb-1' style='margin-bottom:0px'> <span class='input-group-addon'><i class='icon-prepend fa fa-calendar'></i></span> <input type='text' id='" + Id + "' value='" + grupValue + "' class='form-control takvimyap' /> </div>");
        }
        $("#grupdegerleri").append("<label class='col-form-label'>Açıklama</label> <textarea id='aciklama' class='form-control mb-1' placeholder='Açıklama'>" + result[i].Aciklama + "</textarea>");
    }
    $("#grupdegerleri").append("<button type='button' class='btn btn-info mt-3 float-right' id='degerDuzenle'>Düzenle</button>");
    $("#degerDuzenle").attr("onclick", "GrupDegerDuzenle('/System_Root/ajax/islem1.aspx/GrupDegerDuzenle', '" + paramsId + "');");
    sayfa_yuklenince();
}

function GrupDegerDuzenle(url, id) {
    var params = {
        degerID: id,
        degerValue: $("#" + id).val(),
        aciklama: $("#aciklama").val()
    };
    GenericAjax(url, params, GrupDegerDuzenleSuccess, true);
}

function GrupDegerDuzenleSuccess(data) {
    var result = jQuery.parseJSON(data.d);

    if (result === true) {
        mesaj_ver("Hatırlatıcı", "Kayıt Başarıyla Güncellendi", "success");
        ParametreDegerleri();
        $("#grupAdi").val(0).select();
        $("#grupdegerleri").empty();
    }
    else
        mesaj_ver("Hatırlatıcı", "Güncelleme İşlemi Başarısız !", "danger");
}

function GrupDegerleriSil(url, id) {
    var r = confirm("Parametre Değerini Silmek İsiyormusunuz ?");
    if (r) {
        var params = {
            degerID: id
        };
        GenericAjax(url, params, GrupDegerleriSilSuccess, true);
    }
}

function GrupDegerleriSilSuccess(data) {
    var result = jQuery.parseJSON(data.d);
    if (result === true) {
        mesaj_ver("Hatırlarıcı", "Silme İşlemi Başarılı", "success");
        ParametreDegerleri();
    }
    else
        mesaj_ver("Hatırlarıcı", "Silme İşlemi Başarısız !", "danger");
}

function GrupDegerKaydet() {

    var grupId = $("#grupAdi").val();
    var aciklama = $("#aciklama").val();
    var data = "islem=grup_deger_kaydet&islem2=ekle";
    var elementCount = $("#grupDeger input").length;
    var paramsId = [];
    var params = [];
    $("#grupDeger input").each(function () {
        params.push($(this).val());
        paramsId.push($(this).attr("paramId"));
    });

    for (var i = 0; i < params.length; i++) {
        if (data === "") {
            data = "value" + i + "=" + params[i];
        }
        else {
            data += "&value" + i + "=" + params[i];
        }
        if (data === "") {
            data = "paramId" + i + "=" + paramsId[i];
        }
        else {
            data += "&paramId" + i + "=" + paramsId[i];
        }
    }
    data += "&grupId=" + grupId;
    data += "&count=" + elementCount;
    data += "&aciklama=" + aciklama;

    $("#parametreDeger").loadHTML({ url: "/ajax_request6/", data: data }, function (data) {
        mesaj_ver("Parametre Değerleri", "Ekleme Işlemi Başarılı", "success");
        datatableyap();
        $("#grupAdi").val(0).select();
        $("#grupdegerleri").empty();
    });
}

function GrupParametreKaydet(url) {

    var hatirlatma = $("#hatirlatma_Chk").is(":checked");
    var bildirimAlacakPersonelID = $("#bildirimAlacakPersonel").val();

    var tarihindeHatirlat = false;
    var tarihindeOnceHatirlat = false;
    var tarihindenOnce = 0;
    var tarihBildirim = "";

    var sayiyaGeldiğindeHatirlat = false;
    var sayiyaGeldiğinde = 0;
    var sayiyaKalaHatirlat = false;
    var sayiyaKala = 0;
    var sayiBildirim = "";

    if ($("#hatirlatma_Chk").is(":checked") === true) {
        if ($("#parametreTipi").val() === "Tarih") {
            if ($("#hatirlama_1").is(":checked") === true)
                tarihindeHatirlat = true;
            if ($("#degerile").is(":checked") === true) {
                tarihindeOnceHatirlat = true;
                tarihindenOnce = $("#inputValue").val();
            }
            if ($("#sms_ile").is(":checked") === true) {
                if (tarihBildirim === "")
                    tarihBildirim = "sms";
                else
                    tarihBildirim += "," + "sms";
            }
            if ($("#mail_ile").is(":checked") === true) {
                if (tarihBildirim === "")
                    tarihBildirim = "mail";
                else
                    tarihBildirim += "," + "mail";
            }
            if ($("#bildirim_ile").is(":checked") === true) {
                if (tarihBildirim === "")
                    tarihBildirim = "bildirim";
                else
                    tarihBildirim += "," + "bildirim";
            }
        }
        if ($("#parametreTipi").val() === "Sayi") {
            if ($("#hatirlama_1").is(":checked") === true) {
                sayiyaGeldiğindeHatirlat = true;
                sayiyaGeldiğinde = $("#sayi").val();
            }
            if ($("#degerile").is(":checked") === true) {
                sayiyaKalaHatirlat = true;
                sayiyaKala = $("#inputValue").val();
            }
            if ($("#sms_ile").is(":checked") === true) {
                if (sayiBildirim === "")
                    sayiBildirim = "sms";
                else
                    sayiBildirim = "," + "sms";
            }
            if ($("#mail_ile").is(":checked") === true) {
                if (sayiBildirim === "")
                    sayiBildirim = "mail";
                else
                    sayiBildirim += "," + "mail";
            }
            if ($("#bildirim_ile").is(":checked") === true) {
                if (sayiBildirim === "")
                    sayiBildirim = "bildirim";
                else
                    sayiBildirim += "," + "bildirim";
            }
        }
    }

    var parametr = {
        grupId: $("#gruplar").val(),
        parametreAdi: $("#parametreAdi").val(),
        parametreTipi: $("#parametreTipi").val(),
        hatirlatma: hatirlatma,
        bildirimAlacakPersonelID: bildirimAlacakPersonelID,

        tarihindeHatirlat: tarihindeHatirlat,
        tarihindeOnceHatirlat: tarihindeOnceHatirlat,
        tarihindenOnce: tarihindenOnce,
        tarihBildirim: tarihBildirim,

        sayiyaGeldiğindeHatirlat: sayiyaGeldiğindeHatirlat,
        sayiyaGeldiğinde: sayiyaGeldiğinde,
        sayiyaKalaHatirlat: sayiyaKalaHatirlat,
        sayiyaKala: sayiyaKala,
        sayiBildirim: sayiBildirim
    };
    GenericAjax(url, parametr, GrupParametreSuccess, true);
    //datatableyap();
}

function GrupParametreSuccess(data) {
    if (data.d === "false")
        mesaj_ver("Parametre Tanımı", "Ekleme İşlemi Başarısız !", "danger");
    else if (data.d === "notBeAdded")
        mesaj_ver("Parametre Tanımı", "Girmiş Olduğunuz Parametre Mevcut.", "danger");
    else {
        mesaj_ver("Parametre Tanımı", "Ekleme İşlemi Başarılı", "success");
        clearItem();
    }
    GrupParametreleri();
}

function HatirlaticiGrupKaydet(url) {
    var parametr = {
        grupAdi: $("#grupAdi").val()
    };
    GenericAjax(url, parametr, HatirlaticiGrupSuccess, true);
}

function HatirlaticiGrupSuccess(data) {

    var result = jQuery.parseJSON(data.d);
    if (result.message !== "notBeAdded") {
        $("#parametre").trigger("click");
        mesaj_ver("Grup Tanımı", "Ekleme İşlemi Başarılı", "success");
        $("#grupAdi").val("");

        if (result.grupId !== 0 || result.grupId !== null) {
            $("#gruplar").append("<option selected value='" + result.grupId + "'> " + result.grupAdi + " </option>");
        }
    }
    else {
        mesaj_ver("Grup Tanımı", "Eklemek İstediğiniz Grup Adı Mevcut !", "danger");
    }
}

function GenericAjaxError() {

    //var result = jQuery.parseJSON(data.d);
    //if (result.durum === "false") {
    //    mesaj_ver(loc, "Ekleme İşlemi Başarısız Bu Parametre Zaten Var.", "danger");
    //}
    //else { mesaj_ver(loc, "Ekleme İşlemi Başarısız", "danger"); }

    mesaj_ver("Hata", "İşlem Başarısız", "danger");
}

function GenericAjax(url, parameters, successFunc, async) {
    var pathname = window.location.origin;
    $.ajax({
        type: 'POST',
        contentType: 'application/json; charset=utf-8',
        url: pathname + url,
        data: JSON.stringify(parameters),
        dataType: "JSON",
        async: async,
        error: GenericAjaxError,
        success: successFunc
    });
}

function GrupParametreleri() {
    var data = "islem=grup_parametreleri";
    $("#grupList").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        datatableyap();
    });
}

function ParametreDegerleri() {
    var data = "islem=grup_deger_kaydet";
    $("#parametreDeger").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function Hatirlatma() {
    $("#panel_hatirlatici").slideToggle();

    if ($("#hatirlatma_Chk").is(":checked") === true) {
        var tip = $("#parametreTipi").val();
        if (tip === "Tarih") {
            $("#sayi").hide();
            $("#hatirlama_adi1").html("Tarihinde Hatırlat");
            $("#ilkYazi").html("Tarihinden");
            $("#ikinciYazi").html("gün önce hatırlat");
        }
        else if (tip === "Sayi") {
            $("#sayi").show();
            $("#hatirlama_adi1").html("Bu sayıya gelince hatırlat");
            $("#ilkYazi").html("Bu sayıya");
            $("#ikinciYazi").html("kala hatırlat");
        }
    }
}

function tip() {
    var tip = $("#parametreTipi").val();
    if ($("#hatirlatma_Chk").is(":checked") === true) {
        if (tip === "Tarih") {
            $("#panel_hatirlatici").show();
            $("#hatirlatma").show();
            $("#sayi").hide();
            $("#hatirlama_adi1").html("Tarihinde Hatırlat");
            $("#ilkYazi").html("Tarihinden");
            $("#ikinciYazi").html("gün önce hatırlat");
        }
        else if (tip === "Sayi") {
            $("#panel_hatirlatici").show();
            $("#hatirlatma").show();
            $("#sayi").show();
            $("#hatirlama_adi1").html("Bu sayıya gelince hatırlat");
            $("#ilkYazi").html("Bu sayıya");
            $("#ikinciYazi").html("kala hatırlat");
        }
        else {
            $("#panel_hatirlatici").hide();
            $("#hatirlatma").hide();
        }
    }
    else {
        if (tip === "Tarih") {
            $("#hatirlatma").show();
        }
        else if (tip === "Sayi") {
            $("#hatirlatma").show();
        }
        else {
            $("#panel_hatirlatici").hide();
            $("#hatirlatma").hide();
        }
    }
}

function clearItem() {
    $("#gruplar").val(0).select();
    $("#parametreAdi").val("");
    $("#parametreTipi").val(0).select();
    if ($("#hatirlatma_Chk").is(":checked") === true)
        $("#hatirlatma_Chk").trigger("click");
    if ($("#hatirlatma_1").is(":checked") === true)
        $("#hatirlatma_1").trigger("click");
    if ($("#degerile").is(":checked") === true)
        $("#degerile").trigger("click");
    $("#inputValue").val("");
    $("#sayi").val("");
    if ($("#sms_ile").is(":checked") === true)
        $("#sms_ile").trigger("click");
    if ($("#mail_ile").is(":checked") === true)
        $("#mail_ile").trigger("click");
    if ($("#bildirim_ile").is(":checked") === true)
        $("#bildirim_ile").trigger("click");
}

function raporDurumKontrol() {
    var rapor = $("#firmarapordurumu").val();

    if (rapor === "Faturası Kesildi") {
        $("#faturagorevli").css("display", "");
    }
    if (rapor === "Faturası Kesilecek") {
        $("#faturagorevli").css("display", "");
    }
    if (rapor === "Durum Seç") {
        $("#faturagorevli").slideUp('slow');
    }
    if (rapor === "Garanti Kapsamında") {
        $("#faturagorevli").slideUp('slow');
    }
}

function ZorunluDosyaListesi() {
    var data = "islem=zorunlu_dosyalar";
    $("#dosyalar").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        datatableyap();
    });
}

function zorunlu_dosyalar(etiket, kayit_id) {

    var data = "islem=zorunlu_dosyalar";
    data += "&etiket=" + etiket;
    data += "&kayit_id=" + kayit_id;
    data = encodeURI(data);
    $("#zorunlu_dosyalar").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        datatableyap();
    });
}

function ZorunluDosyaKayıt(url) {
    if ($("#dosyaAdi").val().length > 0) {
        var params = {
            dosyaAdi: $("#dosyaAdi").val(),
            zorunlu: $("#zorunlu").is(":checked")
        };
        GenericAjax(url, params, ZorunluDosyaListesiSuccess, true);
    }
    else
        mesaj_ver("Dosyalar", "Dosya Adı Giriniz.", "danger");
}

function ZorunluDosyaListesiSuccess(data) {
    if (data.d === "notBeAdded")
        mesaj_ver("Zorunlu Belgeler", "Girmiş Olduğunuz Dosya Adı Mevcuttur !", "danger");
    else if (data.d === "true") {
        mesaj_ver("Zorunlu Belgeler", "Ekleme İşlemi Başarılı", "success");
        ZorunluDosyaListesi();
        $("#dosyaAdi").val("");
        if ($("#zorunlu").is(":checked") === true)
            $("#zorunlu").trigger("click");
    }
    else if (data.d === "false")
        mesaj_ver("Zorunlu Belgeler", "Ekleme İşlemi Başarısız !", "danger");
}

function ZorunluDosyaDuzenle(url, dosyaId) {
    var params = {
        dosyaId: dosyaId
    };
    GenericAjax(url, params, ZorunluDosyaDuzenleSuccess, true);
}

function ZorunluDosyaDuzenleSuccess(data) {
    var result = jQuery.parseJSON(data.d);
    $("#dosyaKaydet").hide();
    $("#dosyaDuzenle").show().attr("onclick", "ZorunluDosyaDuzenlemeYap('/System_Root/ajax/islem1.aspx/ZorunluDosyaDuzenlemeYap', '" + result[0].DosyaID + "')");
    $("#dosyaAdi").val(result[0].DosyaAdi);
    if (result[0].Zorunlu === true) {
        if ($("#zorunlu").is(":checked") === false)
            $("#zorunlu").trigger("click");
    }
    else {
        if ($("#zorunlu").is(":checked") === true)
            $("#zorunlu").trigger("click");
    }
}

function ZorunluDosyaDuzenlemeYap(url, dosyaId) {
    var params = {
        dosyaId: dosyaId,
        dosyaAdi: $("#dosyaAdi").val(),
        zorunlu: $("#zorunlu").is(":checked")
    };
    GenericAjax(url, params, ZorunluDosyaDuzenlemeYapSuccess, true);
}

function ZorunluDosyaDuzenlemeYapSuccess(data) {

    if (data.d === "true") {
        mesaj_ver("Zorunlu Belgeler", "Ekleme İşlemi Başarılı", "success");
        $("#dosyaKaydet").show();
        $("#dosyaDuzenle").hide();
        ZorunluDosyaListesi();
        $("#dosyaAdi").val("");
        if ($("#zorunlu").is(":checked") === true)
            $("#zorunlu").trigger("click");
    }
    else if (data.d === "false")
        mesaj_ver("Zorunlu Belgeler", "Ekleme İşlemi Başarısız !", "danger");
}

function ZorunluDosyaSil(url, dosyaId) {
    var r = confirm("Belgeyi Silmek İstiyormusunuz ?");
    if (r) {
        var params = {
            dosyaId: dosyaId
        };
        GenericAjax(url, params, ZorunluDosyaSilSuccess, true);
    }
}

function ZorunluDosyaSilSuccess(data) {
    if (data.d === "true") {
        mesaj_ver("Zorunlu Belgeler", "Silme İşlemi Başarılı.", "success");
        ZorunluDosyaListesi();
    }
    else if (data.d === "false") {
        mesaj_ver("Zorunlu Belgeler", "Silme İşlemi Başarısız !", "danger");
    }
    else if (data.d === "indelible") {
        mesaj_ver("Zorunlu Belgeler", "Silmek İstediğiniz Belge Kullanımda !", "danger");
    }
}

function bildirimAlacakKullanici() {
    if ($("#sms_ile").is(":checked") === false && $("#mail_ile").is(":checked") === false && $("#bildirim_ile").is(":checked") === false) {
        $("#bildirimiAlan").slideUp('slow');
    }
    else {
        $("#bildirimiAlan").slideDown('slow');
    }
}

//Araç Takip Yeni

function AracTakipKayitlari() {
    var data = "islem=aracTakipKayitlari";
    $("#AracTakipKayitlari").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function AracTakipKilometreKayitlari(id) {
    var data = "islem=aracTakipKilometreKayitlari";
    data += "&id=" + id;
    $("#AracTakipKilometreKayitlari").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function ServisBakimKayitlari(id) {
    var data = "islem=servisBakimKayitlari";
    data += "&id=" + id;
    $("#ServisBakimKayitlari").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function aracBilgileriKaydet(url) {
    var param = {
        aracMarka: $("#aracMarka").val(),
        aracModel: $("#aracModel").val(),
        aracYil: $("#aracYil").val(),
        aracPlaka: $("#aracPlaka").val()
    };

    GenericAjax(url, param, aracBilgileriKaydetSuccess, true);
}

function aracBilgileriKaydetSuccess(data) {
    if (data.d === "true") {
        mesaj_ver("Araç Kayıtları", "Ekleme İşlemi Başarılı.", "success");
        AracTakipKayitlari();
        var d = new Date();
        var n = d.getFullYear();
        $("#aracMarka").val("");
        $("#aracModel").val("");
        $("#aracYil").val(n).select().trigger("change");
        $("#aracPlaka").val("");
    }
    else {
        mesaj_ver("Araç Kayıtları", "Ekleme İşlemi Başarısız.", "danger");
    }
}

function AracKaydiSil(url, id) {
    var r = confirm("Araç Kaydını Silmek İstiyormusunuz ?");
    if (r) {
        var param = {
            aracID: id
        };

        GenericAjax(url, param, AracKaydiSilSuccess, true);
    }
}

function AracKaydiSilSuccess(data) {
    if (data.d === "true") {
        mesaj_ver("Araç Kayıtları", "Silme İşlemi Başarılı.");
        AracTakipKayitlari();
    }
    else {
        mesaj_ver("Araç Kayıtları", "Silme İşlemi Başarısız.");
    }
}

function AracKilometreBilgiAl(url, aracId, kmId) {
    var param = {
        aracId: aracId,
        kmId: kmId
    };

    GenericAjax(url, param, AracKilometreBilgiAlSuccess, true);
}

function AracKilometreBilgiAlSuccess(data) {
    var result = JSON.parse(data.d);
    if (result[0].Kilometre === 0) {
        $("#aracKilometre").val("0");
        $("#AracKilometreKaydet").hide();
        $("#AracKilometreDuzenlemeYap").show().attr("onclick", "AracKilometreGuncelle('/System_Root/ajax/islem1.aspx/AracKilometreGuncelle', '" + result[0].AracTakipAracID + "', '" + result[0].AracTakipKilometreID + "');");
    }
    else {
        $("#aracKilometre").val(result[0].Kilometre);
        $("#AracKilometreKaydet").hide();
        $("#AracKilometreDuzenlemeYap").show().attr("onclick", "AracKilometreGuncelle('/System_Root/ajax/islem1.aspx/AracKilometreGuncelle', '" + result[0].AracTakipAracID + "', '" + result[0].AracTakipKilometreID + "');");
    }
}

var ID;
function AracKilometreKaydet(url, id, kmId) {
    var param = {
        aracId: id,
        kmId: kmId,
        kilometre: $("#aracKilometre").val()
    };
    ID = id;
    GenericAjax(url, param, AracKilometreKaydetSuccess, true);
}

function AracKilometreKaydetSuccess(data) {
    if (data.d === "true") {
        mesaj_ver("Araç Kilometre", "Ekleme İşlemi Başarılı.", "success");
        AracTakipKilometreKayitlari(ID);
        ServisBakimKayitlari(ID);
        $("#aracKilometre").val("");
    }
    else {
        mesaj_ver("Araç Kilometre", "Ekleme İşlemi Başarısız.", "danger");
    }
}

var aracID;
function AracKilometreGuncelle(url, aracId, kmId) {
    var param = {
        aracId: aracId,
        kmId: kmId,
        kilometre: $("#aracKilometre").val()
    };
    aracID = aracId;
    GenericAjax(url, param, AracKilometreGuncelleSuccess, true);
}

function AracKilometreGuncelleSuccess(data) {
    if (data.d === "true") {
        mesaj_ver("Kilometre Bilgileri", "Ekleme İşlemi Başarılı.", "success");
        AracTakipKilometreKayitlari(aracID);
        $("#aracKilometre").val("");
    }
    else {
        mesaj_ver("Kilometre Bilgileri", "Ekleme İşlemi Başarısız.", "danger");
    }
}

function bakimKaydiEkle(kmId, aracId) {
    var data = "islem=bakimKaydiEkle";
    data += "&aracId=" + aracId;
    data += "&kmId=" + kmId;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        sayfa_yuklenince();
    });
}

var kmid;
function YeniServisBakimEkle(url, kmId, aracId) {
    var param = {
        aracId: aracId,
        kmId: kmId,
        servisAdi: $("#servisAdi").val(),
        servisAdresi: $("#servisAdresi").val(),
        servisTelefonu: $("#servisTelefonu").val(),
        servisTutari: $("#tutari").val(),
        servisDetayi: $("#servisDetayi").val(),
        bakimTarihi: $("#bakimTarihi").val(),
        tarihinde: $("#tarihinde").is(":checked"),
        kilometreyeGeldiginde: $("#kilometreyeGeldiginde").is(":checked"),
        txtKm: $("#txtKm").val(),
        herKmdebir: $("#herKmdebir").is(":checked"),
        herKmDegeri: $("#herKm").val()
    };

    kmid = aracId;
    GenericAjax(url, param, YeniServisBakimEkleSuccess, true);
}

function YeniServisBakimEkleSuccess(data) {
    if (data.d === "true") {
        mesaj_ver("Servis Bakım", "Ekleme İşlemi Başarılı.", "success");
        ServisBakimKayitlari(kmid);
        $(".close").click();
    }
    else {
        mesaj_ver("Servis Bakım", "Ekleme İşlemi Başarısız.", "danger");
    }
}

function YeniServisBakimDuzenle(url, bakimId, hatirlatmaId, aracId) {
    var param = {
        bakimId: bakimId,
        hatirlatmaId: hatirlatmaId,
        servisAdi: $("#servisAdi").val(),
        servisAdresi: $("#servisAdresi").val(),
        servisTelefonu: $("#servisTelefonu").val(),
        servisTutari: $("#tutari").val(),
        servisDetayi: $("#servisDetayi").val(),
        bakimTarihi: $("#bakimTarihi").val(),
        tarihinde: $("#tarihinde").is(":checked"),
        kilometreyeGeldiginde: $("#kilometreyeGeldiginde").is(":checked"),
        txtKm: $("#txtKm").val(),
        herKmdebir: $("#herKmdebir").is(":checked"),
        herKmDegeri: $("#herKm").val()
    };

    kmid = aracId;
    GenericAjax(url, param, YeniServisBakimDuzenleSuccess, true);
}

function YeniServisBakimDuzenleSuccess(data) {
    if (data.d === "true") {
        mesaj_ver("Servis Bakım", "Güncelleme İşlemi Başarılı.", "success");
        ServisBakimKayitlari(kmid);
        $(".close").click();
    }
    else {
        mesaj_ver("Servis Bakım", "Güncelleme İşlemi Başarısız.", "danger");
    }
}

function ServisBakimDuzenle(id) {
    var data = "islem=bakimKaydiDuzenle";
    data += "&servisID=" + id;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request6/", data: data }, function () {
        sayfa_yuklenince();
    });
}

var KmId;
function BakimServisDuzenle(url, id, kmid, aracId) {
    var param = {
        servisId: id,
        servisBakim: $("#selectServis" + id).val()
    };
    KmId = aracId;
    GenericAjax(url, param, BakimServisDuzenleSuccess, true);
}

function BakimServisDuzenleSuccess(data) {
    if (data.d === "true") {
        ServisBakimKayitlari(KmId);
        mesaj_ver("Servis Bakım", "Ekleme İşlemi Başarılı.", "success");
    }
    else {
        mesaj_ver("Servis Bakım", "Ekleme İşlemi Başarısız.", "danger");
    }
}

// MAliyet Analizi Bütçe

function AltButceKalemEkle() {
    var data = "islem=AltButceKalemEkle";
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function ProjeAltButceDuzenle(altButceId, butceId) {
    var data = "islem=ProjeAltButceDuzenle";
    data += "&altButceId=" + altButceId;
    data += "&butceId=" + butceId;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function AltButceKalemDuzenle(altButceKalemDegerId, altButceKalemId, altButceId) {
    var data = "islem=ProjeAltKalemButceDuzenle";
    data += "&altButceKalemDegerId=" + altButceKalemDegerId;
    data += "&altButceKalemId=" + altButceKalemId;
    data += "&altButceId=" + altButceId;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function ProjeAltButceEkle(butceId, projeId) {
    var data = "islem=ProjeAltButceEkle";
    data += "&butceId=" + butceId;
    data += "&projeId=" + projeId;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        sayfa_yuklenince();
    });
}

var prjId;
function ProjeButcesi(projeId) {
    var param = {
        projeId: projeId
    };
    var url = "/System_Root/ajax/islem1.aspx/ProjeButcesi";
    prjId = projeId;
    GenericAjax(url, param, ProjeButcesiSuccess, true);
}

function ProjeButcesiSuccess(data) {
    var result = JSON.parse(data.d);
    if (result.length === 0) {
        $("#btnProjeButcesiEkle").attr("onclick", "ProjeButcesiEkle('/System_Root/ajax/islem1.aspx/ProjeButcesiEkle', '" + prjId + "', '" + 0 + "')").attr("maliyetid", 0);
    }
    else {
        $("#btnProjeButcesiEkle").attr("onclick", "ProjeButcesiEkle('/System_Root/ajax/islem1.aspx/ProjeButcesiEkle', '" + result[0].MaliyetButceID + "', '" + result[0].ProjeID + "')").attr("maliyetid", result[0].MaliyetButceID);
    }

    ProjeAltButceler(0);
}

function ProjeButcesiEkle(url, projeId, butceId) {
    if ($("#txtProjeButcesi").val() !== "") {
        var param = {
            projeId: projeId,
            butceId: butceId,
            projeButcesi: $("#txtProjeButcesi").val().replace(",", ".")
        };

        GenericAjax(url, param, ProjeButcesiEkleSuccess, true);
    }
    else {
        mesaj_ver("Proje Bütçesi", "Bütçe Alanını Boş Geçmeyiniz.", "danger");
    }
}

function ProjeButcesiEkleSuccess(data) {
    if (data.d === "true") {
        mesaj_ver("Proje Butçesi", "Ekleme İşlemi Başarılı.", "success");
        $("#txtProjeButcesi").val("");
    }
}

function ProjeAltButceler(altButceId) {

    if (altButceId === undefined || altButceId === 0) {
        altButceId = $("#btnProjeButcesiEkle").attr("maliyetid");
    }

    var data = "islem=ProjeAltButceler";
    data += "&butceId=" + altButceId;
    data += "&projeId=" + proje_id;
    data = encodeURI(data);

    $("#altbutceler").loadHTML({ url: "/ajax_request2/", data: data }, function () {

    });
}

function ProjeAltButceKayit(butceId, projeId) {
    var data = "islem=ProjeAltButceKayit&islem2=ekle";
    data += "&butceId=" + butceId;
    data += "&altbutcemalzemeadi=" + $("#altbutcemalzemeadi").val();
    data += "&altbutcemalzemetutar=" + $("#altbutcemalzemetutar").val().replace(",", ".");
    data = encodeURI(data);

    $("#altbutceler").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        mesaj_ver("Alt Butçeler", "Ekleme İşlemi Başarılı.", "success");
        $(".close").click();
        ProjeAltButceler(butceId, projeId);
    });
}

function ProjeAltKalemler(altButceId) {
    var data = "islem=ProjeAltButceler";
    data += "&altButceId=" + altButceId;
    data = encodeURI(data);

    $("#altButceKalem").loadHTML({ url: "/ajax_request2/", data: data }, function () {

    });
}

function AltButceKalemKayit() {
    var data = "islem=AltButceKalemKayit&islem2=ekle";
    data += "&altButceId=" + 1;
    data += "&altButceKalemMalzemeAdi=" + $("#altButceKalemMalzemeAdi").val();
    data += "&altButceKalemMalzemeTutar=" + $("#altButceKalemMalzemeTutar").val().replace(",", ".");

    $("#altButceKalem1").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        var data2 = "islem=AltButceKalemKayit";
        data2 += "&altButceId=" + 2;
        $("#altButceKalem2").loadHTML({ url: "/ajax_request2/", data: data2 }, function () {
            mesaj_ver("Alt Butçeler", "Ekleme İşlemi Başarılı.", "success");
            $("#altButceKalemMalzemeAdi").val("");
            $("#altButceKalemMalzemeTutar").val(0);
        });
    });

}

function AltButceKayitGuncelle(altButceId, butceId) {
    var data = "islem=ProjeAltButceKayit&islem2=guncelle";
    data += "&butceId=" + altButceId;
    data += "&altbutcemalzemetutar=" + $("#AltButceTutari" + altButceId).val().replace(",", ".");
    data = encodeURI(data);

    $("#altbutceler").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        mesaj_ver("Alt Butçeler", "Güncelleme İşlemi Başarılı.", "success");
        $(".close").click();
        ProjeAltButceler(butceId);
    });
}

function AltButceKalemKayitGuncelle(altButceKalemId, altButceKalemDegerId, altButceId) {
    var data = "islem=AltButceKalemKayit&islem2=guncelle";
    data += "&altButceKalemId=" + altButceKalemId;
    data += "&altButceKalemDegerId=" + altButceKalemDegerId;
    data += "&altButceId=" + altButceId;
    data += "&altButceKalemMalzemeAdi=" + $("#altButceKalemAdi" + altButceKalemId).val();
    data += "&altButceKalemMalzemeTutar=" + $("#AltButceKalem" + altButceKalemId).val().replace(",", ".");

    if (altButceId === "2") {
        $("#altButceKalem2").loadHTML({ url: "/ajax_request2/", data: data }, function () {
            mesaj_ver("Alt Butçe Kalem", "Güncelleme İşlemi Başarılı.", "success");
            $(".close").click();
        });
    }
    else {
        $("#altButceKalem1").loadHTML({ url: "/ajax_request2/", data: data }, function () {
            mesaj_ver("Alt Butçe Kalem", "Güncelleme İşlemi Başarılı.", "success");
            $(".close").click();
            var data2 = "islem=AltButceKalemKayit";
            data2 += "&altButceId=" + 2;
            $("#altButceKalem2").loadHTML({ url: "/ajax_request2/", data: data2 }, function () {

            });
        });
    }
}

function AltButceKalemSil(altButceKalemId, altButceKalemDegerId, altButceId) {
    var r = confirm("Kaydı Silmek İstediğinize Eminmisiniz?");
    if (r) {
        var data = "islem=AltButceKalemKayit&islem2=sil";
        data += "&altButceKalemId=" + altButceKalemId;
        data += "&altButceKalemDegerId=" + altButceKalemDegerId;
        data += "&altButceId=" + altButceId;
        data = encodeURI(data);

        $("#altButceKalem" + altButceId).loadHTML({ url: "/ajax_request2/", data: data }, function () {
            mesaj_ver("Alt Butçe Kalem", "Güncelleme İşlemi Başarılı.", "success");
            $(".close").click();
        });
    }
}

function ProjeAltButceSil(altButceId, ) {
    var r = confirm("Kaydı Silmek İstediğinize Eminmisiniz?");
    if (r) {
        var data = "islem=ProjeAltButceKayit&islem2=sil";
        data += "&butceId=" + altButceId;
        data = encodeURI(data);

        $("#altbutceler").loadHTML({ url: "/ajax_request2/", data: data }, function () {
            mesaj_ver("Alt Butçeler", "Güncelleme İşlemi Başarılı.", "success");
            $(".close").click();
            ProjeAltButceler(altButceId);
        });
    }
}

function MaliyetAltButceKalemToplamTutari(id) {
    var sp = split(id);
    alert(sp);
}

// MAliyet Proje Anlaşma Bedeli
var proje_id;
function ProjeAnlasmaBedeli(projeId) {
    var param = {
        projeId: projeId
    };
    var url = "/System_Root/ajax/islem1.aspx/ProjeAnlasmaBedeli";
    proje_id = projeId;

    GenericAjax(url, param, ProjeAnlasmaBedeliSuccess, true);
}

function ProjeAnlasmaBedeliSuccess(data) {
    var result = JSON.parse(data.d);
    if (result.length === 0) {
        $("#btnProjeAnlasmaBedeliEkle").attr("onclick", "ProjeAnlasmaBedeliEkle('/System_Root/ajax/islem1.aspx/ProjeAnlasmaBedeliEkle', '" + proje_id + "', '" + 0 + "');").attr("maliyetid", 0);
    }
    else {
        $("#btnProjeAnlasmaBedeliEkle").attr("onclick", "ProjeAnlasmaBedeliEkle('/System_Root/ajax/islem1.aspx/ProjeAnlasmaBedeliEkle', '" + result[0].ProjeID + "', '" + result[0].MaliyetProjeAnlasmaBedeliID + "');").attr("maliyetid", result[0].MaliyetProjeAnlasmaBedeliID);
    }

    ProjeAnlasmaBedeliAltButceler(proje_id);
}

function AnlasmaBedeliAltButceler(anlasmaBedeliAltButce) {
    if (anlasmaBedeliAltButce === undefined) {
        anlasmaBedeliAltButce = $("#btnProjeButcesiEkle").attr("maliyetid");
    }

    var data = "islem=ProjeAltButceler";
    data += "&butceId=" + anlasmaBedeliAltButce;
    data = encodeURI(data);

    $("#altbutceler").loadHTML({ url: "/ajax_request2/", data: data }, function () {

    });
}

function ProjeAnlasmaBedeliEkle(url, projeId, anlasmaBedeliId) {

    if ($("#txtProjeAnlasmaBedeli").val().length !== 0) {
        var param = {
            txtProjeAnlasmaBedeli: $("#txtProjeAnlasmaBedeli").val().replace(",", "."),
            projeId: projeId,
            anlasmaBedeliId: anlasmaBedeliId
        };

        GenericAjax(url, param, ProjeAnlasmaBedeliEkleSuccess, true);
    }
    else {
        mesaj_ver("Anlaşma Bedeli", "Anlaşma bedelini boş geçmeyiniz!.", "danger");
    }
}

function ProjeAnlasmaBedeliEkleSuccess(data) {
    if (data.d === "true") {
        mesaj_ver("Proje Anlaşma Bedeli", "Ekleme İşlemi Başarılı.", "success");
        $("#txtProjeAnlasmaBedeli").val("");
    }
    else {
        mesaj_ver("Proje Anlaşma Bedeli", "Ekleme İşlemi Başarısız.", "success");
    }
}

function ProjeAnlasmaBedeliAltButceler(proje_id) {

    setTimeout(function () {
        var data = "islem=ProjeAnlasmaBedeliAltButce";
        data += "&alnasmaBedeliButceId=" + $("#btnProjeAnlasmaBedeliEkle").attr("maliyetid");
        data += "&proje_id=" + proje_id;

        $("#anlasmaBedeliAltbutceler").loadHTML({ url: "/ajax_request2/", data: data }, function () {

        });
    }, 1000);
}

function projeAnlasmaBedeliTutar(maliyetAltButceKalemID, maliyetAltButceKalemDegerID, maliyetAltButceID, i, projeID, ProjeAnlasmaBedeliId, MaliyetProjeAnlasmaBedeliDetayID) {
    var data = "islem=projeAnlasmaBedeliTutarKayit";
    data += "&maliyetAltButceKalemID=" + maliyetAltButceKalemID;
    data += "&maliyetAltButceKalemDegerID=" + maliyetAltButceKalemDegerID;
    data += "&maliyetAltButceID=" + maliyetAltButceID;
    data += "&i=" + i;
    data += "&projeID=" + projeID;
    data += "&ProjeAnlasmaBedeliId=" + ProjeAnlasmaBedeliId;
    data += "&MaliyetProjeAnlasmaBedeliDetayID=" + MaliyetProjeAnlasmaBedeliDetayID;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function projeAnlasmaBedeliGuncelle(maliyetAltButceKalemID, maliyetAltButceKalemDegerID, maliyetAltButceID, projeID, ProjeAnlasmaBedeliId, MaliyetProjeAnlasmaBedeliDetayID) {
    var data = "islem=ProjeAnlasmaBedeliKayit&islem2=Guncelle";
    data += "&maliyetAltButceKalemID=" + maliyetAltButceKalemID;
    data += "&maliyetAltButceKalemDegerID=" + maliyetAltButceKalemDegerID;
    data += "&maliyetAltButceID=" + maliyetAltButceID;
    data += "&projeAnlasmaBedeliTutar=" + $("#AnlasmaBedeliAltButceKalemTutari" + maliyetAltButceKalemID).val().replace(",", ".");
    data += "&projeID=" + projeID;
    data += "&ProjeAnlasmaBedeliId=" + ProjeAnlasmaBedeliId;
    data += "&MaliyetProjeAnlasmaBedeliDetayID=" + MaliyetProjeAnlasmaBedeliDetayID;
    data = encodeURI(data);

    $("#projeAnlasmaBedeliAltKalemTable" + maliyetAltButceID).loadHTML({ url: "/ajax_request2/", data: data }, function () {

    });
}

function ProjeAnlasmaBedeliDuzenle(MaliyetProjeAnlasmaBedeliID, MaliyetProjeAltButceAnlasmaBedeliID, ProjeID, MaliyetAltButceID, ProjeAnlasmaBedeli) {
    var data = "islem=ProjeAnlasmaBedeliDuzenle";
    data += "&MaliyetProjeAnlasmaBedeliID=" + MaliyetProjeAnlasmaBedeliID;
    data += "&MaliyetProjeAltButceAnlasmaBedeliID=" + MaliyetProjeAltButceAnlasmaBedeliID;
    data += "&ProjeID=" + ProjeID;
    data += "&MaliyetAltButceID=" + MaliyetAltButceID;
    data += "&ProjeAnlasmaBedeli=" + ProjeAnlasmaBedeli;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function projeAnlasmaBedeliAltButceGuncelle(MaliyetProjeAnlasmaBedeliID, MaliyetProjeAltButceAnlasmaBedeliID, ProjeID, MaliyetAltButceID, ProjeAnlasmaBedeli) {
    var data = "islem=ProjeAnlasmaBedeliAltButceDuzenle&islem2=Guncelle";
    data += "&MaliyetProjeAnlasmaBedeliID=" + MaliyetProjeAnlasmaBedeliID;
    data += "&MaliyetProjeAltButceAnlasmaBedeliID=" + MaliyetProjeAltButceAnlasmaBedeliID;
    data += "&ProjeID=" + ProjeID;
    data += "&MaliyetAltButceID=" + MaliyetAltButceID;
    data += "&ProjeAnlasmaBedeli=" + ProjeAnlasmaBedeli;
    data += "&projeAnlasmaBedeliTutari=" + $("#AnlasmaBedeliAltButceTutari" + MaliyetAltButceID).val().replace(",", ".");

    $("#anlasmaBedeliAltbutceler").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        $(".close").click();
        ProjeAnlasmaBedeliAltButceler(ProjeID);
    });
}

function projeAnlasmaBedeliTutarSil(maliyetAltButceKalemID, maliyetAltButceKalemDegerID, maliyetAltButceID, projeID, ProjeAnlasmaBedeliId, MaliyetProjeAnlasmaBedeliDetayID) {
    var r = confirm("Kaydı silmek istediğinize eminmisiniz?");
    if (r) {
        var data = "islem=ProjeAnlasmaBedeliKayit&islem2=Sil";
        data += "&maliyetAltButceKalemID=" + maliyetAltButceKalemID;
        data += "&maliyetAltButceKalemDegerID=" + maliyetAltButceKalemDegerID;
        data += "&maliyetAltButceID=" + maliyetAltButceID;
        data += "&projeID=" + projeID;
        data += "&ProjeAnlasmaBedeliId=" + ProjeAnlasmaBedeliId;
        data += "&MaliyetProjeAnlasmaBedeliDetayID=" + MaliyetProjeAnlasmaBedeliDetayID;

        $("#projeAnlasmaBedeliAltKalemTable" + maliyetAltButceID).loadHTML({ url: "/ajax_request2/", data: data }, function () {
            $(".close").click();
        });
    }
}

// MAliyet Proje Tahmini Bitiş Bedeli

var projeID;
function ProjeTahminiBitisBedeli(projeId) {
    var param = {
        projeId: projeId,
    };

    projeID = projeId;
    var url = "/System_Root/ajax/islem1.aspx/ProjeTahminiBitisBedeli";
    GenericAjax(url, param, ProjeTahminiBitisBedeliSuccess, true);
}

function ProjeTahminiBitisBedeliSuccess(data) {
    var result = JSON.parse(data.d);
    if (result.length === 0) {
        $("#btnProjeTahminiBitisEkle").attr("onclick", "ProjeTahminiBitisBedeliEkle('/System_Root/ajax/islem1.aspx/ProjeTahminiBitisBedeliEkle', '" + projeID + "', '" + 0 + "');").attr("maliyetid", 0);
    }
    else {
        $("#btnProjeTahminiBitisEkle").attr("onclick", "ProjeTahminiBitisBedeliEkle('/System_Root/ajax/islem1.aspx/ProjeTahminiBitisBedeliEkle', '" + result[0].ProjeID + "', '" + result[0].MaliyetProjeTahminiBitisBedeliID + "');").attr("maliyetid", result[0].MaliyetProjeTahminiBitisBedeliID);
    }
}

function ProjeTahminiBitisBedeliEkle(url, projeId, tahminiBitisBedeliId) {
    if ($("#txtProjeTahminiBitisBedeli").val().length !== 0) {
        var param = {
            txtProjeTahminiBitisBedeli: $("#txtProjeTahminiBitisBedeli").val().replace(",", "."),
            projeId: projeId,
            tahminiBitisBedeliId: tahminiBitisBedeliId
        };

        GenericAjax(url, param, ProjeTahminiBitisBedeliEkleSuccess, true);
    }
    else {
        mesaj_ver("Anlaşma Bedeli", "Anlaşma bedelini boş geçmeyiniz!.", "danger");
    }
}

function ProjeTahminiBitisBedeliEkleSuccess(data) {
    if (data.d === "true") {
        mesaj_ver("Proje Anlaşma Bedeli", "Ekleme İşlemi Başarılı.", "success");
        $("#txtProjeTahminiBitisBedeli").val("");
    }
    else {
        mesaj_ver("Proje Anlaşma Bedeli", "Ekleme İşlemi Başarısız.", "success");
    }
}

function TahminiBitisBedeliAltButceler(projeId) {
    var data = "islem=ProjeTahminiBitisBedeliAltButce";
    data += "&tahminiBitisBedeliButceId=" + $("#btnProjeTahminiBitisEkle").attr("maliyetid");
    data += "&projeId=" + projeId;

    $("#TahminiBitisAltbutceler").loadHTML({ url: "/ajax_request2/", data: data }, function () {

    });
}

function ProjeTahminiBitisBedeliDuzenle(MaliyetProjeTahminiBitisBedeliID, MaliyetProjeAltButceTahminiBitisBedeliID, ProjeID, MaliyetAltButceID, MaliyetButceID, TahminiBitisBedeliID, i) {
    var data = "islem=ProjeTahminiBitisBedeliTutarDuzenle";
    data += "&MaliyetProjeTahminiBitisBedeliID=" + MaliyetProjeTahminiBitisBedeliID;
    data += "&MaliyetProjeAltButceTahminiBitisBedeliID=" + MaliyetProjeAltButceTahminiBitisBedeliID;
    data += "&ProjeID=" + ProjeID;
    data += "&MaliyetAltButceID=" + MaliyetAltButceID;
    data += "&MaliyetButceID=" + MaliyetButceID;
    data += "&TahminiBitisBedeliID=" + TahminiBitisBedeliID;
    data += "&i=" + i;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function projeTahminiBitisBedeliAltButceGuncelle(MaliyetProjeTahminiBitisBedeliID, MaliyetProjeAltButceTahminiBitisBedeliID, ProjeID, MaliyetAltButceID, MaliyetButceID, TahminiBitisBedeliID, i) {
    var data = "islem=ProjeTahminiBitisBedeliTutar&islem2=Guncelle";
    data += "&MaliyetProjeTahminiBitisBedeliID=" + MaliyetProjeTahminiBitisBedeliID;
    data += "&MaliyetProjeAltButceTahminiBitisBedeliID=" + MaliyetProjeAltButceTahminiBitisBedeliID;
    data += "&ProjeID=" + ProjeID;
    data += "&MaliyetAltButceID=" + MaliyetAltButceID;
    data += "&MaliyetButceID=" + MaliyetButceID;
    data += "&TahminiBitisBedeliID=" + TahminiBitisBedeliID;
    data += "&i=" + i;
    data += "&projeTahminiBitisBedeliTutar=" + $("#projeTahminiBitisBedeliTutar").val().replace(",", ".");
    data = encodeURI(data);
    $("#TahminiBitisAltbutceler").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        mesaj_ver("Tahmini Bitiş Bedeli", "Ekleme İşlemi Başarılı.", "success");
        TahminiBitisBedeliAltButceler();
        $(".close").click();
    });
}

function ProjeTahminiBitisBedeliAltKelemDuzenle(MaliyetAltButceKalemID, MaliyetAltButceID, MaliyetProjeAltButceKalemTahminiBitisBedeliID, MaliyetProjeAltButceTahminiBitisBedeliID, ProjeID) {
    var data = "islem=ProjeTahminiBitisBedeliAltKelem";
    data += "&MaliyetAltButceKalemID=" + MaliyetAltButceKalemID;
    data += "&MaliyetAltButceID=" + MaliyetAltButceID;
    data += "&i=" + i;
    data += "&MaliyetProjeAltButceKalemTahminiBitisBedeliID=" + MaliyetProjeAltButceKalemTahminiBitisBedeliID;
    data += "&MaliyetProjeAltButceTahminiBitisBedeliID=" + MaliyetProjeAltButceTahminiBitisBedeliID;
    data += "&ProjeID=" + ProjeID;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function projeTahminiBitisBedeliAltButceKalemGuncelle(MaliyetAltButceKalemID, MaliyetAltButceID, MaliyetProjeAltButceKalemTahminiBitisBedeliID, MaliyetProjeAltButceTahminiBitisBedeliID, ProjeID) {
    var data = "islem=ProjeTahminiBitisBedeliAltKalemTutar&islem2=Guncelle";
    data += "&MaliyetAltButceKalemID=" + MaliyetAltButceKalemID;
    data += "&MaliyetAltButceID=" + MaliyetAltButceID;
    data += "&MaliyetProjeAltButceKalemTahminiBitisBedeliID=" + MaliyetProjeAltButceKalemTahminiBitisBedeliID;
    data += "&MaliyetProjeAltButceTahminiBitisBedeliID=" + MaliyetProjeAltButceTahminiBitisBedeliID;
    data += "&ProjeID=" + ProjeID;
    data += "&projeTahminiBitisBedeliAltKalemTutari=" + $("#TahminiBitisBedeliAlButceKalemTutar" + MaliyetAltButceKalemID).val().replace(",", ".");
    data = encodeURI(data);
    $("#projeTahminiBitisBedeliAltKalem" + MaliyetAltButceID).loadHTML({ url: "/ajax_request2/", data: data }, function () {
        mesaj_ver("Tahmini Bitiş Bedeli Alt Kalem", "Ekleme İşlemi Başarılı.", "success");
    });
}

function ProjeTahminiBitisBedeliAltKelemSil(MaliyetAltButceKalemID, MaliyetAltButceID, MaliyetProjeAltButceKalemTahminiBitisBedeliID, MaliyetProjeAltButceTahminiBitisBedeliID, ProjeID) {
    var r = confirm("Kaydı simek istiyormusunuz ?");
    if (r) {
        var data = "islem=ProjeTahminiBitisBedeliAltKalemTutar&islem2=Sil";
        data += "&MaliyetAltButceKalemID=" + MaliyetAltButceKalemID;
        data += "&MaliyetAltButceID=" + MaliyetAltButceID;
        data += "&MaliyetProjeAltButceKalemTahminiBitisBedeliID=" + MaliyetProjeAltButceKalemTahminiBitisBedeliID;
        data += "&MaliyetProjeAltButceTahminiBitisBedeliID=" + MaliyetProjeAltButceTahminiBitisBedeliID;
        data += "&ProjeID=" + ProjeID;
        data = encodeURI(data);

        $("#projeTahminiBitisBedeliAltKalem" + MaliyetAltButceID).loadHTML({ url: "/ajax_request2/", data: data }, function () {
            mesaj_ver("Tahmini Bitiş Bedeli Alt Kalem", "Silme İşlemi Başarılı.", "success");
        });
    }
}

// Maliyet Satınalma

var satinalmaProjeId;
function ProjeSatinalmaButcesi(projeId) {
    var param = {
        projeId: projeId
    };

    satinalmaProjeId = projeId;
    var url = "/System_Root/ajax/islem1.aspx/SatinalmaButcesi";
    GenericAjax(url, param, ProjeSatinalmaButcesiSuccess, true);
}

function ProjeSatinalmaButcesiSuccess(data) {
    var result = JSON.parse(data.d);
    if (result.length === 0) {
        $("#satinalmaButcesiKaydet").attr("onclick", "SatinalmaButceKaydet('" + satinalmaProjeId + "', '" + 0 + "');").attr("satinalmaId", 0);
    }
    else {
        $("#satinalmaButcesiKaydet").attr("onclick", "SatinalmaButceKaydet('" + result[0].ProjeID + "', '" + result[0].SatinalmaButceID + "');").attr("satinalmaId", result[0].SatinalmaButceID);
        $("#txtSatinalmaButcesi").val(result[0].SatinalmaTutari);
        $("#txtSatinalmaButcesi").focus();
    }
}

function SatinalmaButceKaydet(projeId, satinalmaButceId) {
    var param = {
        projeId: projeId,
        satinalmaButceId: satinalmaButceId,
        satinalmaTutari: $("#txtSatinalmaButcesi").val().replace(",", ".")
    };

    var url = "/System_Root/ajax/islem1.aspx/SatinalmaButcesiEkle";
    GenericAjax(url, param, SatinalmaButceKaydetSuccess, true);
}

function SatinalmaButceKaydetSuccess(data) {
    if (data.d === "true") {
        mesaj_ver("Satınalma", "Ekleme İşlemi Başarılı. ", "success");
    }
    else {
        mesaj_ver("Satınalma", "Ekleme İşlemi Başarısız. ", "danger");
    }
}

function SatinalmaAltButceDuzenle(MaliyetAltButceID, SatinalmaAltButceID, SatinalmaButceID, projeId) {
    var data = "islem=SatinalmaAltButceDuzenle&islem2=Guncelle";
    data += "&MaliyetAltButceID=" + MaliyetAltButceID;
    data += "&SatinalmaAltButceID=" + SatinalmaAltButceID;
    data += "&SatinalmaButceID=" + SatinalmaButceID;
    data += "&projeId=" + projeId;
    data += "&satinalmaAltButceTutari=" + $("#satinalmaAltButceTutari" + MaliyetAltButceID).val().replace(",", ".");
    data = encodeURI(data);

    $("#satinalmaAltButceler").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        mesaj_ver("Satınalma Alt Bütçe", "Ekleme İşlemi Başarılı.", "success");
    });
}

function SatinalmaAltButceKalemDuzenle(MaliyetAltButceKalemID, MaliyetAltButceID, SatinalmaAltButceKalemID, SatinalmaAltButceID) {
    var data = "islem=SatinalmaAltButceKalem&islem2=Guncelle";
    data += "&MaliyetAltButceKalemID=" + MaliyetAltButceKalemID;
    data += "&MaliyetAltButceID=" + MaliyetAltButceID;
    data += "&SatinalmaAltButceKalemID=" + SatinalmaAltButceKalemID;
    data += "&SatinalmaAltButceID=" + SatinalmaAltButceID;
    data += "&satinalmaAltButceKalemTutari=" + $("#satinalmaAltButceKalemTutari" + MaliyetAltButceKalemID).val().replace(",", ".");
    data = encodeURI(data);

    $("#satinalmaAltButceKalemListesi").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        mesaj_ver("Satınalma Alt Bütçe", "Ekleme İşlemi Başarılı.", "success");
    });
}

function SatinalmaAltButceKalemSil(MaliyetAltButceKalemID, MaliyetAltButceID, SatinalmaAltButceKalemID, SatinalmaAltButceID) {
    var r = confirm("Kaydı silmek istiyormusunuz ?");
    if (r) {
        var data = "islem=SatinalmaAltButceKalem&islem2=Sil";
        data += "&MaliyetAltButceKalemID=" + MaliyetAltButceKalemID;
        data += "&MaliyetAltButceID=" + MaliyetAltButceID;
        data += "&SatinalmaAltButceKalemID=" + SatinalmaAltButceKalemID;
        data += "&SatinalmaAltButceID=" + SatinalmaAltButceID;
        data = encodeURI(data);

        $("#satinalmaAltButceKalemListesi").loadHTML({ url: "/ajax_request2/", data: data }, function () {
            mesaj_ver("Satınalma Alt Bütçe", "Ekleme İşlemi Başarılı.", "success");
            $("#satinalmaAltButceKalemTutari" + MaliyetAltButceKalemID).val("0,00");
        });
    }
}

// Tahsilat Kaydı Ekleme

function TahsilatListesi(projeId) {
    var data = "islem=TahsilatKaydi";
    data += "&ProjeID=" + projeId;

    $("#Tahsilat").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function TahsilatEklemeForm(projeId) {
    var data = "islem=TahsilatKaydiForm";
    data += "&ProjeID=" + projeId;

    $("#TahsilatForm").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function TolamTahsilat(projeId) {

    var param = {
        projeId: projeId
    };

    var url = "/System_Root/ajax/islem1.aspx/TolamTahsilat";
    GenericAjax(url, param, TolamTahsilatSuccess, true);
}

function TolamTahsilatSuccess(data) {
    var result = JSON.parse(data.d);

    for (var i = 0; i < result.length; i++) {
        if (result[i].MaliyetTahsilatTipiID === 1) {
            if (result[i].ParaBirimi === "TL") {
                $("#nakitTL").html(result[i].TahsilatTutari + " ₺");
            }
            if (result[i].ParaBirimi === "USD") {
                $("#nakitUSD").html(result[i].TahsilatTutari + " $");
            }
            if (result[i].ParaBirimi === "EUR") {
                $("#nakitEUR").html(result[i].TahsilatTutari + " €");
            }
        }
        if (result[i].MaliyetTahsilatTipiID === 2) {
            if (result[i].ParaBirimi === "TL") {
                $("#cekTL").html(result[i].TahsilatTutari + " ₺");
            }
            if (result[i].ParaBirimi === "USD") {
                $("#cekUSD").html(result[i].TahsilatTutari + " $");
            }
            if (result[i].ParaBirimi === "EUR") {
                $("#cekEUR").html(result[i].TahsilatTutari + " €");
            }
        }
        if (result[i].MaliyetTahsilatTipiID === 3) {
            if (result[i].ParaBirimi === "TL") {
                $("#senetTL").html(result[i].TahsilatTutari + " ₺");
            }
            if (result[i].ParaBirimi === "USD") {
                $("#senetUSD").html(result[i].TahsilatTutari + " $");
            }
            if (result[i].ParaBirimi === "EUR") {
                $("#senetEUR").html(result[i].TahsilatTutari + " €");
            }
        }
        if (result[i].MaliyetTahsilatTipiID === 4) {
            if (result[i].ParaBirimi === "TL") {
                $("#krediTL").html(result[i].TahsilatTutari + " ₺");
            }
            if (result[i].ParaBirimi === "USD") {
                $("#krediUSD").html(result[i].TahsilatTutari + " $");
            }
            if (result[i].ParaBirimi === "EUR") {
                $("#krediEUR").html(result[i].TahsilatTutari + " €");
            }
        }
    }
}

function TahsilatKaydiEkle(ProjeId) {

    var tahsilatTipi;
    if ($("#1").is(":checked") === true)
        tahsilatTipi = 1;
    if ($("#2").is(":checked") === true)
        tahsilatTipi = 2;
    if ($("#3").is(":checked") === true)
        tahsilatTipi = 3;
    if ($("#4").is(":checked") === true)
        tahsilatTipi = 4;

    var data = "islem=TahsilatKaydi&islem2=Ekle";
    data += "&TahsilatTipi=" + tahsilatTipi;
    data += "&Tarih=" + $("#islem_tarihi").val();
    data += "&Meblag=" + $("#meblag").val().replace(",", ".");
    data += "&VadeTarihi=" + $("#vade_tarihi").val();
    data += "&ParaBirimi=" + $("#parabirimi").val();
    data += "&Aciklama=" + $("#aciklama").val();
    data += "&ProjeID=" + ProjeId;

    $("#Tahsilat").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        mesaj_ver("Tahsilat", "Ekleme İşlemi Başarılı.", "success");
        sayfa_yuklenince();

        $("#islem_tarihi").val();
        $("#meblag").val("0,00");
        $("#parabirimi").val(1).change();
        $("#aciklama").val("");
        $("#1").prop("checked", true).trigger("onclick");
        TolamTahsilat(ProjeId);
    });
}

function TahsilatKaydiDuzenle(MaliyetTahsilatID, ProjeId) {
    var param = {
        MaliyetTahsilatID: MaliyetTahsilatID,
        ProjeId: ProjeId
    };

    var url = "/System_Root/ajax/islem1.aspx/TahsilatKaydiCek";
    GenericAjax(url, param, TahsilatKaydiDuzenleSuccess, true);
}

function getFormattedDate(date) {
    var d = date.slice(0, 10).split('-');
    return d[2] + '.' + d[1] + '.' + d[0];
}

function TahsilatKaydiDuzenleSuccess(data) {
    var result = JSON.parse(data.d);
    $("#" + result[0].MaliyetTahsilatTipiID).prop("checked", true).trigger("onclick");
    $("#islem_tarihi").val(getFormattedDate($.trim(result[0].TahsilatTarihi)));
    $("#vade_tarihi").val(getFormattedDate($.trim(result[0].VadeTarihi)));
    $("#meblag").val(result[0].TahsilatTutari);
    $("#meblag").focus();
    $("#aciklama").val(result[0].Aciklama);
    $("#parabirimi").val(result[0].MaliyetParaBirimiID).change();

    $("#TahsilatFormTitle").html("Tahsilat Güncelleme Formu");
    $("#btnTahsilatEkle").hide();
    $("#btnTahsilatDuzenle").show().attr("onclick", "TahsilatKaydiGuncelle('" + result[0].MaliyetTahsilatID + "', '" + result[0].ProjeID + "')");
}

function TahsilatKaydiGuncelle(MaliyetTahsilatID, ProjeId) {

    var tahsilatTipi;
    if ($("#1").is(":checked") === true)
        tahsilatTipi = 1;
    if ($("#2").is(":checked") === true)
        tahsilatTipi = 2;
    if ($("#3").is(":checked") === true)
        tahsilatTipi = 3;
    if ($("#4").is(":checked") === true)
        tahsilatTipi = 4;

    var data = "islem=TahsilatKaydi&islem2=Guncelle";
    data += "&TahsilatTipi=" + tahsilatTipi;
    data += "&Tarih=" + $("#islem_tarihi").val();
    data += "&Meblag=" + $("#meblag").val().replace(",", ".");
    data += "&VadeTarihi=" + $("#vade_tarihi").val();
    data += "&ParaBirimi=" + $("#parabirimi").val();
    data += "&Aciklama=" + $("#aciklama").val();
    data += "&ProjeID=" + ProjeId;
    data += "&MaliyetTahsilatID=" + MaliyetTahsilatID;

    $("#Tahsilat").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        mesaj_ver("Tahsilat", "Güncelleme İşlemi Başarılı.", "success");
        sayfa_yuklenince();

        $("#TahsilatFormTitle").html("Tahsilat Kaydı Ekleme Formu");
        $("#btnTahsilatEkle").show();
        $("#btnTahsilatDuzenle").hide();

        $("#islem_tarihi").val();
        $("#meblag").val("0,00");
        $("#parabirimi").val(1).change();
        $("#aciklama").val("");
        $("#1").prop("checked", true).trigger("onclick");
    });
}

function TahsilatKaydiSil(MaliyetTahsilatID, ProjeId) {
    var r = confirm("Kaydı silmek istediğinize eminmisiniz. ?");
    if (r) {
        var data = "islem=TahsilatKaydi&islem2=Sil";
        data += "&MaliyetTahsilatID=" + MaliyetTahsilatID;
        data += "&ProjeId=" + ProjeId;

        $("#Tahsilat").loadHTML({ url: "/ajax_request2/", data: data }, function () {
            mesaj_ver("Tahsilat", "Silme İşlemi Başarılı.", "success");
            sayfa_yuklenince();
        });
    }
}

//Proje Kar

var karProjeID;
function ProjeOngorulenKarCek(projeID) {
    var param = {
        projeID: projeID
    };

    karProjeID = projeID;
    var url = "/System_Root/ajax/islem1.aspx/ProjeOngorulenKar";

    GenericAjax(url, param, ProjeOngorulenKarCekSuccess, true);
}

function ProjeOngorulenKarCekSuccess(data) {
    var result = JSON.parse(data.d);
    console.log(result);
    if (result.length === 0) {
        $("#btnProjeKarEkle").attr("onclick", "ProjeKarEkle('" + karProjeID + "', '0')").attr("karId", "0");
        $("#OngorulenMaliyetTutari0").attr("onkeyup", "ButceOranHesapla('0')");
        $("#OngorulenAnlasmaTutari0").attr("onkeyup", "ButceOranHesapla('0')");
    }
    else {
        $("#btnProjeKarEkle").attr("onclick", "ProjeKarEkle('" + result[0].ProjeID + "', '" + result[0].MaliyetProjeOngorulenKarID + "')").attr("karId", result[0].MaliyetProjeOngorulenKarID);
        $("#OngorulenMaliyetTutari0").removeAttr("id").attr("id", "OngorulenMaliyetTutari" + result[0].MaliyetProjeOngorulenKarID).attr("onkeyup", "ButceOranHesapla('" + result[0].MaliyetProjeOngorulenKarID + "')");
        $("#OngorulenAnlasmaTutari0").removeAttr("id").attr("id", "OngorulenAnlasmaTutari" + result[0].MaliyetProjeOngorulenKarID).attr("onkeyup", "ButceOranHesapla('" + result[0].MaliyetProjeOngorulenKarID + "')");
        $("#OngorulenKarOrani0").removeAttr("id").attr("id", "OngorulenKarOrani" + result[0].MaliyetProjeOngorulenKarID);
    }
}

function ProjeKarEkle(projeID, ongorulenKarId) {
    var param = {
        projeID: projeID,
        ongorulenKarId: ongorulenKarId,
        OngorulenMaliyetTutari: $("#OngorulenMaliyetTutari" + ongorulenKarId).val().replace(",", "."),
        OngorulenAnlasmaTutari: $("#OngorulenAnlasmaTutari" + ongorulenKarId).val().replace(",", "."),
        OngorulenKarOrani: $("#OngorulenKarOrani" + ongorulenKarId).val()
    };

    var url = "/System_Root/ajax/islem1.aspx/ProjeOngorulenKarEkle";

    GenericAjax(url, param, ProjeKarEkleSuccess, true);
}

function ProjeKarEkleSuccess(data) {
    var slip = data.d.split('-');

    for (var i = 0; i < slip.length; i++) {
        if (slip[i].toString() === "true") {
            mesaj_ver("Proje Öngörülen Kar", "Ekleme işlemi başarılı.", "success");
        }
        else if (parseInt(slip[i]) > 0) {
            $("#btnProjeKarEkle").attr("onclick", "ProjeKarEkle('" + karProjeID + "', '" + slip[i] + "')").attr("karId", slip[i]);
            $("#OngorulenMaliyetTutari" + slip[i] - 1).val("0,00").focus();
            $("#OngorulenAnlasmaTutari" + slip[i] - 1).val("0,00").focus();
            $("#OngorulenKarOrani" + slip[i] - 1).val("0,00").focus();
        }
    }
}

function KarListesiCek(projeId) {
    var data = "islem=KarListesi";
    data += "&ProjeID=" + projeId;

    $("#KarListesi").loadHTML({ url: "/ajax_request2/", data: data }, function () {

    });
}

function AnlikKarListesiCek(projeId) {
    var data = "islem=AnlikKarListesi";
    data += "&ProjeID=" + projeId;

    $("#AnlikKarListesi").loadHTML({ url: "/ajax_request2/", data: data }, function () {

    });
}

function MaliyetProjeAltButceOngorulenKarDuzenle(MaliyetAltButceID, MaliyetButceID, MaliyetProjeAltButceOngorulenKarID, MaliyetProjeOngorulenKarID, ProjeID) {

    var data = "islem=KarListesi&islem2=ekle";
    data += "&ProjeID=" + ProjeID;
    data += "&MaliyetAltButceID=" + MaliyetAltButceID;
    data += "&MaliyetButceID=" + MaliyetButceID;
    data += "&MaliyetProjeAltButceOngorulenKarID=" + MaliyetProjeAltButceOngorulenKarID;
    data += "&MaliyetProjeOngorulenKarID=" + MaliyetProjeOngorulenKarID;
    data += "&AltButceOngorulenMaliyetTutari=" + $("#AltButceOngorulenMaliyetTutari" + MaliyetAltButceID).val().replace(",", ".");
    data += "&AltButceOngorulenAnlasmaTutari=" + $("#AltButceOngorulenAnlasmaTutari" + MaliyetAltButceID).val().replace(",", ".");
    data += "&AltButceOngorulenKarOrani=" + $("#AltButceOngorulenKarOrani" + MaliyetAltButceID).val().replace(",", ".");

    $("#KarListesi").loadHTML({ url: "/ajax_request2/", data: data }, function () {
        mesaj_ver("Öngörülen Kar", "Güncelleme işlemi başarılı.", "success");
    });
}

function ProjeAltButceKalemOngorulenKarDuzenle(MaliyetAltButceKalemID, MaliyetAltButceID, MaliyetProjeAltButceKalemOngorulenKarID, MaliyetProjeAltButceOngorulenKarID, MaliyetProjeOngorulenKarID, ProjeID) {

    var data = "islem=AltButceKalemKarListesi&islem2=guncelle";
    data += "&ProjeID=" + ProjeID;
    data += "&MaliyetAltButceKalemID=" + MaliyetAltButceKalemID;
    data += "&MaliyetAltButceID=" + MaliyetAltButceID;
    data += "&MaliyetProjeAltButceKalemOngorulenKarID=" + MaliyetProjeAltButceKalemOngorulenKarID;
    data += "&MaliyetProjeAltButceOngorulenKarID=" + MaliyetProjeAltButceOngorulenKarID;
    data += "&MaliyetProjeOngorulenKarID=" + MaliyetProjeOngorulenKarID;
    data += "&AltButceKalemOngorulenMaliyetTutari=" + $("#AltButceKalemOngorulenMaliyetTutari" + MaliyetAltButceKalemID).val().replace(",", ".");
    data += "&AltButceKalemOngorulenAnlasmaTutari=" + $("#AltButceKalemOngorulenAnlasmaTutari" + MaliyetAltButceKalemID).val().replace(",", ".");
    data += "&AltButceKalemOngorulenKarOrani=" + $("#AltButceKalemOngorulenKarOrani" + MaliyetAltButceKalemID).val().replace(",", ".");

    $("#projeKarAltKalemTable" + MaliyetAltButceID).loadHTML({ url: "/ajax_request2/", data: data }, function () {
        mesaj_ver("Öngörülen Kar", "Ekleme işlemi başarılı.", "success");
    });
}

function ProjeAltButceKalemOngorulenKarSil(MaliyetAltButceKalemID, MaliyetAltButceID, MaliyetProjeAltButceKalemOngorulenKarID, MaliyetProjeAltButceOngorulenKarID, MaliyetProjeOngorulenKarID, ProjeID) {
    var r = confirm("Kaydı silmek istiyormusunuz. ?");
    if (r) {
        var data = "islem=AltButceKalemKarListesi&islem2=sil";
        data += "&ProjeID=" + ProjeID;
        data += "&MaliyetAltButceKalemID=" + MaliyetAltButceKalemID;
        data += "&MaliyetAltButceID=" + MaliyetAltButceID;
        data += "&MaliyetProjeAltButceKalemOngorulenKarID=" + MaliyetProjeAltButceKalemOngorulenKarID;
        data += "&MaliyetProjeAltButceOngorulenKarID=" + MaliyetProjeAltButceOngorulenKarID;
        data += "&MaliyetProjeOngorulenKarID=" + MaliyetProjeOngorulenKarID;

        $("#projeKarAltKalemTable" + MaliyetAltButceID).loadHTML({ url: "/ajax_request2/", data: data }, function () {
            mesaj_ver("Öngörülen Kar", "Ekleme işlemi başarılı.", "success");
        });
    }
}

function calisma_kaydi_duzenleme(id, is_id, gorevli_id) {

    var data = "islem=calisma_kaydi_duzenleme";
    data += "&ID=" + id;
    data += "&IsID=" + is_id;
    data += "&GorevliID=" + gorevli_id;

    $("#modal_butonum_mini").click();
    $("#modal_div_mini").loadHTML({ url: "/ajax_request5/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function calisma_kaydi_duzenle(id, isId, gorevli_id) {

    var splitStartDate = $("#BaslangicTarihi").val().split(/[.]/);
    var splitEndDate = $("#BitisTarihi").val().split(/[.]/);

    var startDate = splitStartDate[1] + "." + splitStartDate[0] + "." + splitStartDate[2];
    var endDate = splitEndDate[1] + "." + splitEndDate[0] + "." + splitEndDate[2];

    var sDate = new Date(startDate);
    var eDate = new Date(endDate);

    var startDate2 = splitStartDate[2] + "-" + splitStartDate[1] + "-" + splitStartDate[0];
    var endDate2 = splitEndDate[2] + "-" + splitEndDate[1] + "-" + splitEndDate[0];

    var t1 = new Date(startDate2 + " " + $("#BaslangicSaati").val());
    var t2 = new Date(endDate2 + " " + $("#BitisSaati").val());

    if (t1 < t2) {
        var data = {
            id: id,
            isId: isId,
            baslangicTarihi: sDate,
            baslangicSaati: $("#BaslangicSaati").val(),
            bitisTarihi: eDate,
            bitisSaati: $("#BitisSaati").val()
        };

        $.ajax({
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            url: "/System_Root/ajax/islem1.aspx/calisma_kaydi_duzenle",
            data: JSON.stringify(data),
            datatype: 'json',
            error: function (xhr) { },
            success: function (data) {
                mesaj_ver("Çalışma Geçmişi", "Kayıt Başarıyla Güncellendi.", "success");
                is_calisma_listesi(isId, gorevli_id);
                $(".close").click();
            }
        });
    }
    else if (t1 === t2) {
        mesaj_ver("Çalışma Geçmişi", "Bitiş tarihi ve başlangıç tarihi eşit olamaz. !", "warning");
    }
    else {
        mesaj_ver("Çalışma Geçmişi", "Bitiş tarihi başlangıçtan önce olamaz. !", "warning");
    }
}

function is_calisma_listesi(is_id, gorevli_id) {
    var data = "islem=is_timer_start_kaydi";
    data += "&is_id=" + is_id;
    data += "&gorevli_id=" + gorevli_id;
    data = encodeURI(data);
    $("#calisma_kayitlari" + is_id + "-" + gorevli_id).loadHTML({ url: "/ajax_request5/", data: data, loading: false }, function () {
        datatableyap();
    });
}