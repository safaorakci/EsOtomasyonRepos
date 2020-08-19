function getPagination(table) {
    var lastPage = 1;
    $('#maxRows').on('change', function (evt) {
        //$('.paginationprev').html('');						// reset pagination

        lastPage = 1;
        $('.pagination').find('li').slice(1, -1).remove();
        var trnum = 0; // reset tr counter
        var maxRows = parseInt($(this).val()); // get Max Rows from select option

        var totalRows = $(table + ' > tbody > tr:not(.departman-detay)').length;

        if (maxRows === 5000) {
            $('.pagination').hide();
        } else if (maxRows > totalRows) {
            $('.pagination').hide();
        } else {
            $('.pagination').show();
        }

        $(table + ' > tbody > tr:not(.departman-detay)').each(function () {
            // each TR in  table and not the header
            trnum++; // Start Counter
            if (trnum > maxRows) {
                // if tr number gt maxRows
                $(this).hide(); // fade it out
            }
            if (trnum <= maxRows) {
                $(this).show();
            } // else fade in Important in case if it ..
        }); //  was fade out to fade it in
        if (totalRows > maxRows) {
            // if tr total rows gt max rows option
            var pagenum = Math.ceil(totalRows / maxRows); // ceil total(rows/maxrows) to get ..
            //	numbers of pages
            for (var i = 1; i <= pagenum;) {
                // for each page append pagination li
                $('.pagination #prev').before('<li class="cursor-pointer" data-page="' + i + '">\ <span>' + i++ + '<span class="sr-only">(current)</span></span>\ </li>').show();
            } // end for i
        } // end if row count > max rows
        $('.pagination [data-page="1"]').addClass('active'); // add active class to the first li
        $('.pagination li').on('click', function (evt) {
            // on click each page
            evt.stopImmediatePropagation();
            evt.preventDefault();
            var pageNum = $(this).attr('data-page'); // get it's number

            var maxRows = parseInt($('#maxRows').val()); // get Max Rows from select option

            if (pageNum === 'prev') {
                if (lastPage === 1) {
                    return;
                }
                pageNum = --lastPage;
            }
            if (pageNum === 'next') {
                if (lastPage === $('.pagination li').length - 2) {
                    return;
                }
                pageNum = ++lastPage;
            }

            lastPage = pageNum;
            var trIndex = 0; // reset tr counter
            $('.pagination li').removeClass('active'); // remove active class from all li
            $('.pagination [data-page="' + lastPage + '"]').addClass('active'); // add active class to the clicked
            // $(this).addClass('active');					// add active class to the clicked
            limitPagging();
            $(table + ' > tbody > tr:not(.departman-detay)').each(function () {
                // each tr in table not the header
                trIndex++; // tr index counter
                // if tr index gt maxRows*pageNum or lt maxRows*pageNum-maxRows fade if out
                if (trIndex > maxRows * pageNum || trIndex <= maxRows * pageNum - maxRows) {
                    $(this).hide();
                    $('.departman-detay').hide();
                    $(".arrow-icon").removeClass("flip");
                } else {
                    $(this).show();
                } //else fade in
            }); // end of for each tr in table
        }); // end of on click pagination list
        limitPagging();
    }).val(10).change();
}

function limitPagging() {
    // alert($('.pagination li').length)

    if ($('.pagination li').length > 7) {
        if ($('.pagination li.active').attr('data-page') <= 3) {
            $('.pagination li:gt(5)').hide();
            $('.pagination li:lt(5)').show();
            $('.pagination [data-page="next"]').show();
        } if ($('.pagination li.active').attr('data-page') > 3) {
            $('.pagination li:gt(0)').hide();
            $('.pagination [data-page="next"]').show();
            for (let i = (parseInt($('.pagination li.active').attr('data-page')) - 2); i <= (parseInt($('.pagination li.active').attr('data-page')) + 2); i++) {
                $('.pagination [data-page="' + i + '"]').show();
            }
        }
    }
}

function TabsPassage(tabID, way, state) {

    if (way === "task") {
        AllTask(state);
        TaskFilterSelect();
        FilterSelect();
    }

    if (tabID === "scoring") {
        if ($("#Personeller").val() !== "0") {
            PersonelPuanlama($("#Personeller").val());
        }
        else {
            PersonelPuanlama(0);
        }
    }

    $(".nav-link").removeClass("active").attr("aria-expanded", "false");
    $(".tab-pane").removeClass("active").attr("aria-expanded", "false");

    $("#" + tabID + "-tab").addClass("active").attr("aria-expanded", "true");
    $("#" + tabID).addClass("fade show active").attr("aria-expanded", "true");
}

function Collapse(id) {
    if ($("#taskCollapse" + id).is(":visible") === true) {
        $("#taskCollapse" + id).slideDown('slow');
    }
    else {
        $("#taskCollapse" + id).slideDown('slow');
    }
}

function Delete() {
    $.confirm({
        title: 'Confirm!',
        content: 'Simple confirm!',
        type: 'blue',
        typeAnimated: true,
        backgroundDismissAnimation: 'snake',
        buttons: {
            confirm: function () {
                $.alert('Confirmed!');
            },
            cancel: function () {
                $.alert('Canceled!');
            }
        }
    });
}

function ToplantiGrubu() {
    var data = "islem=ToplantiGrubu";
    data = encodeURI(data);
    $("#accordionExample").loadHTML({ url: "/ajax_request7/", data: data }, function () { });
}

function ToplantiGrubuEkle() {
    if ($("#GrupAdi").val().length !== 0) {
        var data = "islem=ToplantiGrubu&islem2=Ekle";
        data += "&GrupAdi=" + $("#GrupAdi").val();
        data = encodeURI(data);
        $("#accordionExample").loadHTML({ url: "/ajax_request7/", data: data }, function () {
            $("#GrupAdi").val("");
            mesaj_ver("Toplantı Yönetimi", "Ekleme İşlemi Başarılı.", "success");
        });
    }
    else {
        mesaj_ver("Toplantı Yönetimi", "Grup Adını boş geçmeyiniz. !", "warning");
    }
}

function ToplantiGrubuSil(GrupID) {
    var r = confirm("Kaydı Silmek İstiyormusunuz. ?");
    if (r) {
        var data = "islem=ToplantiGrubu&islem2=Sil";
        data += "&GrupID=" + GrupID;
        data = encodeURI(data);

        $("#accordionExample").loadHTML({ url: "/ajax_request7/", data: data }, function () {
            mesaj_ver("Toplantılar", "Silme İşlemi Başarılı", "success");
        });
    }
}

function ToplantiGrubuDuzenle(GrupID) {
    var data = "islem=ToplantiGrubuDuzenle";
    data += "&GrupID=" + GrupID;

    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request7/", data: data }, function () { });
}

function ToplantiGrubuGuncelle(GrupID) {
    var data = "islem=ToplantiGrubu&islem2=Guncelle";
    data += "&GrupID=" + GrupID;
    data += "&GrupAdi=" + $("#GrupAdi" + GrupID).val();
    data = encodeURI(data);

    $("#accordionExample").loadHTML({ url: "/ajax_request7/", data: data }, function () {
        mesaj_ver("Toplantılar", "Güncelleme İşlemi Başarılı", "success");
        $(".close").click();
    });
}

function GrupToplantilari(GrupID) {
    var data = "islem=GrupToplantilari";
    data += "&GrupID=" + GrupID;
    $("#accordionBody" + GrupID).loadHTML({ url: "/ajax_request7/", data: data }, function () {
        datatableyap();
    });
}

function YeniGrupToplantisiEkle(GrupID) {
    var data = "islem=YeniGrupToplantisiEkle";
    data += "&GrupID=" + GrupID;
    data = encodeURI(data);

    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request7/", data: data }, function () { });
}

function YeniToplantiEkle(GrupID) {
    if ($("#ToplantiKonu").val().length !== 0 && $("#ToplantiTarihi").val().length !== 0 && $("#ToplantiKatilimcilar").val().length !== 0) {
        var data = "islem=YeniToplantiEkle&islem2=Ekle";
        data += "&GrupID=" + GrupID;
        data += "&ToplantiDosya=" + $("#ToplantiDosya").attr("filepath");
        data += "&ToplantiYapildi=" + $("#ToplantiYapildi").is(":checked");
        data += "&ToplantiKonu=" + $("#ToplantiKonu").val();
        data += "&ToplantiTarihi=" + $("#ToplantiTarihi").val();
        data += "&ToplantiKatilimcilar=" + $("#ToplantiKatilimcilar").val();
        data += "&ToplantiAlinanKararlar=" + $("#ToplantiAlinanKararlar").val();
        data += "&ToplantiNotlar=" + $("#ToplantiNotlar").val();
        data = encodeURI(data);

        $("#accordionBody" + GrupID).loadHTML({ url: "/ajax_request7/", data: data }, function () {
            mesaj_ver("Toplantılar", "Ekleme İşlemi Başarılı.", "success");
            datatableyap();
            $(".close").click();
        });
    }
    else {
        mesaj_ver("Toplantılar", "Konu, Toplantı Tarihi ve Katılımcılar alanı zorunludur.", "warning");
    }
}

function ToplantiDosyaAc(DosyaYolu) {
    window.open(DosyaYolu);
}

function ToplantiSil(GrupID, ToplantiID) {
    var r = confirm("Kaydı Silmek İstiyormusunuz. ?");
    if (r) {
        var data = "islem=YeniToplantiEkle&islem2=Sil";
        data += "&GrupID=" + GrupID;
        data += "&ToplantiID=" + ToplantiID;
        data = encodeURI(data);

        $("#accordionBody" + GrupID).loadHTML({ url: "/ajax_request7/", data: data }, function () {
            mesaj_ver("Toplantılar", "Silme İşlemi Başarılı.", "success");
            datatableyap();
        });
    }
}

function ToplantiDuzenle(GrupID, ToplantiID) {
    var data = "islem=ToplantiGuncelle&islem2=GuncellemeEkrani";
    data += "&GrupID=" + GrupID;
    data += "&ToplantiID=" + ToplantiID;
    data = encodeURI(data);

    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request7/", data: data }, function () { });
}

function ToplantiGuncelle(GrupID, ToplantiID) {
    if ($("#ToplantiKonu").val().length !== 0 && $("#ToplantiTarihi").val().length !== 0 && $("#ToplantiKatilimcilar").val().length !== 0) {
        var data = "islem=ToplantiGuncelle&islem2=Guncelle";
        data += "&GrupID=" + GrupID;
        data += "&ToplantiID=" + ToplantiID;
        data += "&ToplantiDosya=" + $("#ToplantiDosya").attr("filepath");
        data += "&ToplantiKonu=" + $("#ToplantiKonu").val();
        data += "&ToplantiYapildi=" + $("#ToplantiYapildi").is(":checked");
        data += "&ToplantiTarihi=" + $("#ToplantiTarihi").val();
        data += "&ToplantiKatilimcilar=" + $("#ToplantiKatilimcilar").val();
        data += "&ToplantiAlinanKararlar=" + $("#ToplantiAlinanKararlar").val();
        data += "&ToplantiNotlar=" + $("#ToplantiNotlar").val();
        data = encodeURI(data);

        $("#accordionBody" + GrupID).loadHTML({ url: "/ajax_request7/", data: data }, function () {
            mesaj_ver("Toplantılar", "Güncelleme İşlemi Başarılı.", "success");
            datatableyap();
            $(".close").click();
        });
    }
    else {
        mesaj_ver("Toplantılar", "Konu, Toplantı Tarihi ve Katılımcılar alanı zorunludur.", "warning");
    }
}

function DepartmanListesi() {
    var data = "islem=Departmanlar";
    data = encodeURI(data);
    $("#DepartmanListesi").loadHTML({ url: "/ajax_request7/", data: data }, function () {
        datatableyap();
    });
}

function DepartmanKurallari(DepartmanID) {

    if ($("#DepartmanUp" + DepartmanID).is(":visible") === true && $("#DepartmanDown" + DepartmanID).is(":visible") === true) {
        $("#DepartmanUptr" + DepartmanID).slideToggle("slow");
        $("#DepartmanUp" + DepartmanID).slideToggle("slow");
        $("#DepartmanDown" + DepartmanID).slideToggle("slow");
        $("#departmanDetayIcon" + DepartmanID).removeClass("flip");
    }
    else {
        $("#DepartmanUptr" + DepartmanID).slideDown("slow");
        $("#DepartmanUp" + DepartmanID).slideDown("slow");
        $("#DepartmanDown" + DepartmanID).slideToggle("slow");
        $("#departmanDetayIcon" + DepartmanID).addClass("flip");
    }

    var data = "islem=DepartmanKurallari";
    data += "&DepartmanID=" + DepartmanID;
    $("#DepartmanKurallari" + DepartmanID).loadHTML({ url: "/ajax_request7/", data: data }, function () {
        datatableyap();
    });
}

function DepartmanKuraliEkle(DepartmanID) {
    if ($("#KuralBasligi" + DepartmanID).val().length !== 0 && $("#Kurallar" + DepartmanID).val().length !== 0) {
        var data = "islem=DepartmanKurallari&islem2=Ekle";
        data += "&DepartmanID=" + DepartmanID;
        data += "&KuralBasligi=" + $("#KuralBasligi" + DepartmanID).val();
        data += "&Kurallar=" + $("#Kurallar" + DepartmanID).val();
        data = encodeURI(data);

        $("#DepartmanKurallari" + DepartmanID).loadHTML({ url: "/ajax_request7/", data: data }, function () {
            mesaj_ver("Departman Kuralları", "Ekleme İşlemi Başaralı", "success");
            $("#KuralBasligi" + DepartmanID).val("");
            $("#Kurallar" + DepartmanID).val("");
            datatableyap();
        });
    }
    else {
        mesaj_ver("Departman Kuralları", "Başlık ve Açıklama alanı zorunludur. !", "warning");
    }
}

function DepartmanKurallariSil(DepartmanID, ID) {
    var r = confirm("Kaydı Silmek İstiyormusunuz. ?");
    if (r) {
        var data = "islem=DepartmanKurallari&islem2=Sil";
        data += "&DepartmanID=" + DepartmanID;
        data += "&ID=" + ID;
        $("#DepartmanKurallari" + DepartmanID).loadHTML({ url: "/ajax_request7/", data: data }, function () {
            mesaj_ver("Departman Kuralları", "Silme İşlemi Başarılı", "success");
            datatableyap();
        });
    }
}

function DepartmanKurallariGuncelle(DepartmanID, ID) {
    if ($("#EditKuralBasligi" + ID).val().length !== 0 && $("#EditKurallar" + ID).val().length !== 0) {
        var data = "islem=DepartmanKurallari&islem2=Guncelle";
        data += "&DepartmanID=" + DepartmanID;
        data += "&ID=" + ID;
        data += "&KuralBasligi=" + $("#EditKuralBasligi" + ID).val();
        data += "&Kurallar=" + $("#EditKurallar" + ID).val();
        data = encodeURI(data);

        $("#DepartmanKurallari" + DepartmanID).loadHTML({ url: "/ajax_request7/", data: data }, function () {
            mesaj_ver("Departman Kuralları", "Güncelleme İşlemi Başarılı", "success");
            $(".close").click();
            datatableyap();
        });
    }
    else {
        mesaj_ver("Departman Kuralları", "Başlık ve Açıklama alanı zorunludur. !", "warning");
    }
}

function DepartmanKurallariDuzenle(DepartmanID, ID) {
    var data = "islem=DepartmanKurallariDuzenlemeEkrani";
    data += "&DepartmanID=" + DepartmanID;
    data += "&ID=" + ID;

    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request7/", data: data }, function () { });
}

// Personel Puanlama

function PersonelPuanlama(PersonelID) {

    if (PersonelID === undefined) {
        PersonelID = $("#Personeller").val();
    }

    var data = "islem=PersonelPuanlama";
    data += "&PersonelID=" + PersonelID;
    data = encodeURI(data);
    $("#PersonelPuanlama").loadHTML({ url: "/ajax_request7/", data: data }, function () { });
}

function PersonelPuanlamaKaydet(PersonelID) {
    var data = "islem=PersonelPuanlamaKaydet&islem2=Ekle";
    data += "&PersonelID=" + PersonelID;
    data += "&SoruVePuan=";
    var i = 0;
    $(".rating-input").each(function () {
        i++;
        if (i === 1)
            data += $(this).attr("soru-id") + ',' + $(this).attr("value");
        else
            data += "-" + $(this).attr("soru-id") + ',' + $(this).attr("value");
    });

    $("#PersonelPuanlama").loadHTML({ url: "/ajax_request7/", data: data }, function () {
        mesaj_ver("Personel Puanlama", "Puanlama İşlemi Başarılı", "success");
    });
}

function PersonelOnerileri() {
    var data = "islem=PersonelOneri";
    $("#PersonelOneriListesi").loadHTML({ url: "/ajax_request7/", data: data }, function () {
        datatableyap();
    });
}

function PersonelOneriEkle() {

    if ($("#OneriBaslik").val().length === 0 && $("#OneriAciklama").val().length === 0) {
        mesaj_ver("Öneri Kutusu", "Başlık ve Açıklama alanını boş geçmeyiniz. !", "warning");
    }
    else {
        var data = "islem=PersonelOneri&islem2=Ekle";
        data += "&OneriBaslik=" + $("#OneriBaslik").val();
        data += "&OneriAciklama=" + $("#OneriAciklama").val();
        data += "&OneriDepartman=" + $("#OneriDepartman").val();
        data = encodeURI(data);

        $("#PersonelOneriListesi").loadHTML({ url: "/ajax_request7/", data: data }, function () {
            mesaj_ver("Personel Önerileri", "Ekleme İşlemi Başarılı", "success");
            $("#OneriBaslik").val("");
            $("#OneriAciklama").val("");
            $("#OneriDepartman").val(0).change();
        });
    }
}

function PersonelOneriDuzenle(OneriID, OnerenPersonelID, OnerenDepartmanID) {
    var data = "islem=PersonelOneriDuzenle";
    data += "&OneriID=" + OneriID;
    data += "&OnerenPersonelID=" + OnerenPersonelID;
    data += "&OnerenDepartmanID=" + OnerenDepartmanID;

    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request7/", data: data }, function () { });
}

function PersonelOneriGuncelle(OneriID, OnerenPersonelID, OnerenDepartmanID) {
    if ($("#OneriBaslik" + OneriID).val().length !== 0 && $("#OneriAciklama" + OneriID).val().length !== 0) {
        var data = "islem=PersonelOneri&islem2=Guncelle";
        data += "&OneriID=" + OneriID;
        data += "&OnerenPersonelID=" + OnerenPersonelID;
        data += "&OneriBaslik=" + $("#OneriBaslik" + OneriID).val();
        data += "&OneriAciklama=" + $("#OneriAciklama" + OneriID).val();
        data += "&OneriDepartman=" + $("#OneriDepartman" + OneriID).val();
        data = encodeURI(data);

        $("#PersonelOneriListesi").loadHTML({ url: "/ajax_request7/", data: data }, function () {
            mesaj_ver("Personel Önerileri", "Güncelleme İşlemi Başarılı", "success");
            $(".close").click();
        });
    }
    else {
        mesaj_ver("Personel Önerileri", "Başlık ve Açıklama alanını boş geçmeyiniz. !", "warning");
    }
}

function PersonelOneriSil(OneriID, OnerenPersonelID) {
    var r = confirm("Kaydı Silmek İstiyormusunuz. ?");
    if (r) {
        var data = "islem=PersonelOneri&islem2=Sil";
        data += "&OneriID=" + OneriID;
        data += "&OnerenPersonelID=" + OnerenPersonelID;

        $("#PersonelOneriListesi").loadHTML({ url: "/ajax_request7/", data: data }, function () {
            mesaj_ver("Personel Önerileri", "Silme İşlemi Başarılı", "success");
        });
    }
}

function PersonelOneriDegerlendir(OneriID, OnerenPersonelID) {
    var r = confirm("Kaydı Değerlendirmeye Almak İstiyormusunuz. ?");
    if (r) {
        var data = "islem=PersonelOneri&islem2=Degerlendir";
        data += "&OneriID=" + OneriID;
        data += "&OnerenPersonelID=" + OnerenPersonelID;

        $("#PersonelOneriListesi").loadHTML({ url: "/ajax_request7/", data: data }, function () {
            mesaj_ver("Personel Önerileri", "Kayıt Başarılı Şekilde Değerlendirmeye Alındı", "success");
        });
    }
}

function PersonelOneriUygula(OneriID, OnerenPersonelID) {
    var r = confirm("Kaydı Kabul Etmek İstiyormusunuz. ?");
    if (r) {
        var data = "islem=PersonelOneri&islem2=Uygula";
        data += "&OneriID=" + OneriID;
        data += "&OnerenPersonelID=" + OnerenPersonelID;

        $("#PersonelOneriListesi").loadHTML({ url: "/ajax_request7/", data: data }, function () {
            mesaj_ver("Personel Önerileri", "Kayıt Başarılı Şekilde Kabul Edildi", "success");
        });
    }
}

function PersonelOneriReddet(OneriID, OnerenPersonelID) {
    var r = confirm("Kaydı Reddetmek İstiyormusunuz. ?");
    if (r) {
        var data = "islem=PersonelOneri&islem2=Reddet";
        data += "&OneriID=" + OneriID;
        data += "&OnerenPersonelID=" + OnerenPersonelID;

        $("#PersonelOneriListesi").loadHTML({ url: "/ajax_request7/", data: data }, function () {
            mesaj_ver("Personel Önerileri", "Kayıt Başarılı Şekilde Reddedildi", "success");
        });
    }
}

//Personel Puanlama Soruları

function PersonelPuanlamaSorulari() {
    var data = "islem=PersonelPuanlamaSorulari";
    $("#PersonelPuanlamaSorulari").loadHTML({ url: "/ajax_request7/", data: data }, function () {
        datatableyap();
    });
}

function PersonelPuanlamaSorulariEkle() {
    if ($("#PuanlamaSorusu").val().length !== 0) {
        var data = "islem=PersonelPuanlamaSorulari&islem2=Ekle";
        data += "&PuanlamaSorusu=" + $("#PuanlamaSorusu").val();
        data = encodeURI(data);
        $("#PersonelPuanlamaSorulari").loadHTML({ url: "/ajax_request7/", data: data }, function () {
            datatableyap();
            mesaj_ver("Puanlama Soruları", "Ekleme İşlemi Başarılı", "success");
            $("#PuanlamaSorusu").val("");
        });
    }
    else {
        mesaj_ver("Puanlama Soruları", "Puanlama Soru alanı zorunludur. !", "warning");
    }
}

function PersonelPuanlamaSorulariDuzenle(SoruID) {

    var data = "islem=PersonelPuanlamaSorulariDuzenle";
    data += "&SoruID=" + SoruID;

    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request7/", data: data }, function () { });
}

function PersonelPuanlamaSorulariGuncelle(SoruID) {
    if ($("#PuanlamaSorusu" + SoruID).val().length !== 0) {
        var data = "islem=PersonelPuanlamaSorulari&islem2=Guncelle";
        data += "&SoruID=" + SoruID;
        data += "&PuanlamaSorusu=" + $("#PuanlamaSorusu" + SoruID).val();
        data = encodeURI(data);
        $("#PersonelPuanlamaSorulari").loadHTML({ url: "/ajax_request7/", data: data }, function () {
            datatableyap();
            mesaj_ver("Puanlama Soruları", "Güncelleme İşlemi Başarılı", "success");
            $(".close").click();
        });
    }
    else {
        mesaj_ver("Puanlama Soruları", "Puanlama Soru alanı zorunludur. !", "warning");
    }
}

function PersonelPuanlamaSorulariSil(SoruID) {
    var r = confirm("Kaydı Silmek İstediğinize eminmisiniz. ?");
    if (r) {
        var data = "islem=PersonelPuanlamaSorulari&islem2=Sil";
        data += "&SoruID=" + SoruID;
        data = encodeURI(data);
        $("#PersonelPuanlamaSorulari").loadHTML({ url: "/ajax_request7/", data: data }, function () {
            datatableyap();
            mesaj_ver("Puanlama Soruları", "Silme İşlemi Başarılı", "success");
        });
    }
}

function Performans() {
    var data = "islem=Performans";

    $("#Performans").loadHTML({ url: "/ajax_request7/", data: data }, function () {
        datatableyap();
    });
}

//Yeni iş emri listesi

function GetTaskDetail(TaskID) {
    var data = "islem=IsDetaylari";
    data += "&IsID=" + TaskID;

    $("#TaskDetail" + TaskID).loadHTML({ url: "/ajax_request7/", data: data }, function () { });
}

function TaskDetails(IsID, GorevliID) {
    $("#TaskDetails" + IsID + "-" + GorevliID).slideToggle();
}

function SearchTask() {
    var value = $("#SearchTaskInput").val().toLowerCase();
    $("#myTabContent").find(".active").find(".tasks").find(".taskBoard").filter(function () {
        if ($(this).attr("task-name").toLowerCase().indexOf(value) === -1) {
            $(this).hide().addClass("hideFilter");
        }
        else {
            $(this).show().removeClass("hideFilter");
        }
    });
    TaskPagination();
}

function TaskViewSave(view) {
    var data = {
        viewData: view.toString()
    };

    $.ajax({
        type: 'POST',
        contentType: 'application/json; charset=utf-8',
        url: "/System_Root/ajax/islem1.aspx/TaskViewSave",
        dataType: "JSON",
        async: true,
        data: JSON.stringify(data),
        success: function (data) {

        }
    });
}

function TaskFilter() {
    $.ajax({
        type: 'POST',
        contentType: 'application/json; charset=utf-8',
        url: "/System_Root/is_listesi/is_listesi.aspx/TaskFilter",
        dataType: "JSON",
        success: function (data) {
            var res = JSON.parse(data.d);
            res = res[0].is_tablo_gorunum.toString().split(',');

            $.each(res, function (key, value) {
                var replaceValue = value.replace(" ", "").replace(" ", "");
                if (replaceValue === "gorevliler") {
                    $("#framework option").filter('[value="TaskAttendant"]').attr('selected', true);
                }
                else if (replaceValue === "ekleyen") {
                    $("#framework option").filter('[value="TaskAddPersonel"]').attr('selected', true);
                }
                else if (replaceValue === "etiketler") {
                    $("#framework option").filter('[value="TaskTag"]').attr('selected', true);
                }
                else if (replaceValue === "tamamlanma") {
                    $("#framework option").filter('[value="TaskProgress"]').attr('selected', true);
                }
                else if (replaceValue === "baslangic") {
                    $("#framework option").filter('[value="TaskStartDate"]').attr('selected', true);
                }
                else if (replaceValue === "bitis") {
                    $("#framework option").filter('[value="TaskEndDate"]').attr('selected', true);
                }
                else if (replaceValue === "oncelik") {
                    $("#framework option").filter('[value="TaskPriority"]').attr('selected', true);
                }
                else if (replaceValue === "durum") {
                    $("#framework option").filter('[value="TaskState"]').attr('selected', true);
                }

                $("#framework").trigger("change");
                $("#framework").multiselect("refresh");
            });
        }
    });
}

//Proje Gelir

function ProjeGelirOngorulenEkle(projeID, durum) {
    var data = "islem=ProjeGelirOngorulenEkle";
    data += "&projeID=" + projeID;
    data += "&durum=" + durum;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request7/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function ProjeGelirGerceklesenEkle(projeID, durum) {
    var data = "islem=ProjeGelirGerceklesenEkle";
    data += "&projeID=" + projeID;
    data += "&durum=" + durum;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request7/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function ProjeGerceklesenGelirKaydiDuzenle(projeID, gelirID, durum) {
    var data = "islem=ProjeGerceklesenGelirKaydiDuzenle";
    data += "&projeID=" + projeID;
    data += "&gelirID=" + gelirID;
    data += "&durum=" + durum;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request7/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function ProjeOngorulenGelirKaydiDuzenle(projeID, gelirID, ongorulenID, durum) {
    var data = "islem=ProjeOngorulenGelirKaydiDuzenle";
    data += "&projeID=" + projeID;
    data += "&gelirID=" + gelirID;
    data += "&ongorulenID=" + ongorulenID;
    data += "&durum=" + durum;
    data = encodeURI(data);
    $("#modal_butonum").click();
    $("#modal_div").loadHTML({ url: "/ajax_request7/", data: data }, function () {
        sayfa_yuklenince();
    });
}

function ShowInClipboard(projeId) {
    if ($("#showInClipboard" + projeId).attr("chk") === "false") {
        var data = {
            projeId: projeId,
            pano: "1"
        };
        $.ajax({
            type: "POST",
            contentType: 'application/json; charset=utf-8',
            url: window.location.origin + "/System_Root/ajax/islem1.aspx/ShowInClipboard",
            data: JSON.stringify(data),
            dataType: "JSON",
            async: true,
            success: function (data) {
                var res = data.d;
                if (res === "true") {
                    $("#showInClipboard" + projeId).removeClass("fa fa-star-o").addClass("fa fa-star").attr("chk", "true");
                    mesaj_ver("Projeler", "Seçtiğiniz proje panoda gösterilecek. !", "success");
                }
                else {
                    mesaj_ver("Projeler", "Panoda en fazla 10 adet proje gösterebilirsiniz. !", "danger");
                }
            },
        });
    }
    else {
        var data2 = {
            projeId: projeId,
            pano: "0"
        };
        $.ajax({
            type: "POST",
            contentType: 'application/json; charset=utf-8',
            url: window.location.origin + "/System_Root/ajax/islem1.aspx/ShowInClipboard",
            data: JSON.stringify(data2),
            dataType: "JSON",
            async: true,
            success: function (data) {
                var res = data.d;
                if (res === "true") {
                    mesaj_ver("Projeler", "Seçtiğiniz proje panodan kaldırıldı. !", "success");
                }
            },
        });
        $("#showInClipboard" + projeId).removeClass("fa fa-star").addClass("fa fa-star-o").attr("chk", "false");
    }
}

function TaskPagination() {
    pageSize = 10;
    $("#pagination").empty();

    var pageCount = $(".taskBoard:not(.hideFilter)").length / pageSize;

    for (var i = 0; i < pageCount; i++) {
        $("#pagination").append('<li class="page-item"><a class="page-link" href="javascript:void(0)">' + (i + 1) + '</a></li>');
    }

    $("#pagination li:nth-child(1)").addClass("active");

    showPage = function (page) {
        $(".taskBoard:not(.hideFilter)").hide();
        $(".taskBoard:not(.hideFilter").each(function (n) {
            if (n >= pageSize * (page - 1) && n < pageSize * page)
                $(this).show();
        });
    }

    showPage(1);

    $("#pagination li a").click(function () {
        $("#pagination li").removeClass("active");
        $(this).parents("li:not(.previous .next)").addClass("active");
        showPage(parseInt($(this).text()))
    });
}

function TaskFilterSelect() {
    $('#framework').multiselect({
        nonSelectedText: 'Gösterim Türü',
        enableFiltering: false,
        enableCaseInsensitiveFiltering: false,
        buttonWidth: '200px',
        language: 'tr',
        buttonClass: 'btn btn-default btn-mini mr-3 border p-2 line-height filter-button',
        onDropdownHide: function () {
            var search = [];
            var view = "";
            $.each($('#framework option:selected'), function () {
                search.push($(this).val());
                if (view === "") {
                    if ($(this).val() === "TaskAttendant")
                        view = "gorevliler";
                    else if ($(this).val() === "TaskAddPersonel")
                        view = "ekleyen";
                    else if ($(this).val() === "TaskTag")
                        view = "etiketler";
                    else if ($(this).val() === "TaskProgress")
                        view = "tamamlanma";
                    else if ($(this).val() === "TaskStartDate")
                        view = "baslangic";
                    else if ($(this).val() === "TaskEndDate")
                        view = "bitis";
                    else if ($(this).val() === "TaskPriority")
                        view = "oncelik";
                    else if ($(this).val() === "TaskState")
                        view = "durum";
                }
                else {
                    if ($(this).val() === "TaskAttendant")
                        view += " , " + "gorevliler";
                    else if ($(this).val() === "TaskAddPersonel")
                        view += " , " + "ekleyen";
                    else if ($(this).val() === "TaskTag")
                        view += " , " + "etiketler";
                    else if ($(this).val() === "TaskProgress")
                        view += " , " + "tamamlanma";
                    else if ($(this).val() === "TaskStartDate")
                        view += " , " + "baslangic";
                    else if ($(this).val() === "TaskEndDate")
                        view += " , " + "bitis";
                    else if ($(this).val() === "TaskPriority")
                        view += " , " + "oncelik";
                    else if ($(this).val() === "TaskState")
                        view += " , " + "durum";
                }
            });
            TaskViewSave(view);
        }
    });

    var AttendantName = [];
    $(".attendantname").each(function () {
        if (AttendantName.indexOf($(this).attr("attendantname")) === -1) {
            AttendantName.push($(this).attr("attendantname"));
        }
    });

    $("#TaskAttendantSelect").empty();
    for (var i = 0; i < AttendantName.length; i++) {
        $("#TaskAttendantSelect").append("<option value='" + AttendantName[i] + "'>" + AttendantName[i] + "</option>");
        $('#TaskAttendantSelect').multiselect('destroy');
        $('#TaskAttendantSelect').multiselect({
            nonSelectedText: 'Tümü',
            enableFiltering: false,
            enableCaseInsensitiveFiltering: false,
            buttonWidth: '140px',
            language: 'tr',
            buttonClass: 'btn btn-default btn-mini mr-3 border p-2 line-height filter-button',
        });
    }

    var AddPersonel = [];
    $(".addpersonel").each(function () {
        if (AddPersonel.indexOf($(this).attr("addpersonel")) === -1) {
            AddPersonel.push($(this).attr("addpersonel"));
        }
    });

    $("#TaskAddPersonelSelect").empty();
    for (var i = 0; i < AddPersonel.length; i++) {
        $("#TaskAddPersonelSelect").append("<option value='" + AddPersonel[i] + "'>" + AddPersonel[i] + "</option>");
        $('#TaskAddPersonelSelect').multiselect('destroy');
        $('#TaskAddPersonelSelect').multiselect({
            nonSelectedText: 'Tümü',
            enableFiltering: false,
            enableCaseInsensitiveFiltering: false,
            buttonWidth: '140px',
            language: 'tr',
            buttonClass: 'btn btn-default btn-mini mr-3 border p-2 line-height filter-button',
        });
    }

    var Tag = [];
    $(".tasktag").each(function () {
        var sp = $(this).attr("tasktag").split(' - ');
        for (var i = 0; i < sp.length; i++) {
            if (Tag.indexOf(sp[i]) === -1) {
                Tag.push(sp[i]);
            }
        }
    });

    $("#TaskTagSelect").empty();
    for (var i = 0; i < Tag.length; i++) {
        $("#TaskTagSelect").append("<option value='" + Tag[i] + "'>" + Tag[i] + "</option>");
        $('#TaskTagSelect').multiselect('destroy');
        $('#TaskTagSelect').multiselect({
            nonSelectedText: 'Tümü',
            enableFiltering: false,
            enableCaseInsensitiveFiltering: false,
            buttonWidth: '140px',
            language: 'tr',
            buttonClass: 'btn btn-default btn-mini mr-3 border p-2 line-height filter-button',
        });
    }

    var StartDate = [];
    $(".startdate").each(function () {
        if (StartDate.indexOf($(this).attr("startdate")) === -1) {
            StartDate.push($(this).attr("startdate"));
        }
    });

    $("#TaskStartDateSelect").empty();
    for (var i = 0; i < StartDate.length; i++) {
        $("#TaskStartDateSelect").append("<option value='" + StartDate[i] + "'>" + StartDate[i] + "</option>");
        $('#TaskStartDateSelect').multiselect('destroy');
        $('#TaskStartDateSelect').multiselect({
            nonSelectedText: 'Tümü',
            enableFiltering: false,
            enableCaseInsensitiveFiltering: false,
            buttonWidth: '140px',
            language: 'tr',
            buttonClass: 'btn btn-default btn-mini mr-3 border p-2 line-height filter-button',
        });
    }

    var EndDate = [];
    $(".enddate").each(function () {
        if (EndDate.indexOf($(this).attr("enddate")) === -1) {
            EndDate.push($(this).attr("enddate"));
        }
    });

    $("#TaskEndDateSelect").empty();
    for (var i = 0; i < EndDate.length; i++) {
        $("#TaskEndDateSelect").append("<option value='" + EndDate[i] + "'>" + EndDate[i] + "</option>");
        $('#TaskEndDateSelect').multiselect('destroy');
        $('#TaskEndDateSelect').multiselect({
            nonSelectedText: 'Tümü',
            enableFiltering: false,
            enableCaseInsensitiveFiltering: false,
            buttonWidth: '140px',
            language: 'tr',
            buttonClass: 'btn btn-default btn-mini mr-3 border p-2 line-height filter-button',
        });
    }

    var Priority = [];
    $(".priority").each(function () {
        if (Priority.indexOf($(this).attr("priority")) === -1) {
            Priority.push($(this).attr("priority"));
        }
    });

    $("#TaskPrioritySelect").empty();
    for (var i = 0; i < Priority.length; i++) {
        $("#TaskPrioritySelect").append("<option value='" + Priority[i] + "'>" + Priority[i] + "</option>");
        $('#TaskPrioritySelect').multiselect('destroy');
        $('#TaskPrioritySelect').multiselect({
            nonSelectedText: 'Tümü',
            enableFiltering: false,
            enableCaseInsensitiveFiltering: false,
            buttonWidth: '140px',
            language: 'tr',
            buttonClass: 'btn btn-default btn-mini mr-3 border p-2 line-height filter-button',
        });
    }

    var State = [];
    $(".state").each(function () {
        if (State.indexOf($(this).attr("state")) === -1) {
            State.push($(this).attr("state"));
        }
    });

    $("#TaskStateSelect").empty();
    for (var i = 0; i < State.length; i++) {
        $("#TaskStateSelect").append("<option value='" + State[i] + "'>" + State[i] + "</option>");
        $('#TaskStateSelect').multiselect('destroy');
        $('#TaskStateSelect').multiselect({
            nonSelectedText: 'Tümü',
            enableFiltering: false,
            enableCaseInsensitiveFiltering: false,
            buttonWidth: '140px',
            language: 'tr',
            buttonClass: 'btn btn-default btn-mini mr-3 border p-2 line-height filter-button',
        });
    }
}

function FilterSelect(){
    $('.framework').multiselect('destroy');
    $('.framework').multiselect({
        nonSelectedText: 'Hepsi',
        enableFiltering: true,
        enableCaseInsensitiveFiltering: false,
        buttonWidth: '140px',
        language: 'tr',
        buttonClass: 'btn btn-default btn-mini mr-3 border p-2 line-height filter-button',
        onChange: function (e, key) {
            var filterKey = $(e).parent().attr("filterkey");

            var selectedValue = [];
            var selectedID = "";
            $($(e).parent()).each(function () {
                selectedValue.push($(this).val());
                selectedID = $(this).attr("id");
            });

            $("." + filterKey).each(function () {
                if (selectedValue[0].length === 0) {
                    $(".taskBoard").show().removeClass("hideFilter");
                }

                if (selectedID === "TaskProgressSelect") {
                    for (var a = 0; a < selectedValue[0].length; a++) {
                        if (parseInt(selectedValue[0][a]) === 25) {
                            if (parseInt(selectedValue[0][a]) < parseInt($(this).attr(filterKey))) {
                                $(this).parents(".taskBoard").hide().addClass("hideFilter").removeClass("filter");
                            }
                            else {
                                $(this).parents(".taskBoard").show().addClass("filter").removeClass("hideFilter");
                            }
                        }
                        else if (parseInt(selectedValue[0][a]) === 50) {
                            if (parseInt(selectedValue[0][a]) > parseInt($(this).attr(filterKey))) {
                                $(this).parents(".taskBoard:not(.filter)").hide().addClass("hideFilter").removeClass("filter");
                            }
                            else {
                                $(this).parents(".taskBoard").show().addClass("filter").removeClass("hideFilter");
                            }
                        }
                        else if (parseInt(selectedValue[0][a]) === 75) {
                            if (parseInt(selectedValue[0][a]) > parseInt($(this).attr(filterKey))) {
                                $(this).parents(".taskBoard:not(.filter)").hide().addClass("hideFilter").removeClass("filter");
                            }
                            else {
                                $(this).parents(".taskBoard").show().addClass("filter").removeClass("hideFilter");
                            }
                        }
                        else if (parseInt(selectedValue[0][a]) === 100) {
                            if (parseInt(selectedValue[0][a]) === parseInt($(this).attr(filterKey))) {
                                $(this).parents(".taskBoard:not(.filter)").hide().addClass("hideFilter").removeClass("filter");
                            }
                            else if (parseInt(selectedValue[0][a]) !== parseInt($(this).attr(filterKey))) {
                                $(this).parents(".taskBoard:not(.filter)").hide().addClass("hideFilter").removeClass("filter");
                            }
                            else {
                                $(this).parents(".taskBoard").show().addClass("filter").removeClass("hideFilter");
                            }
                        }
                    }
                }
                else if (selectedID === "TaskTagSelect") {
                    var sp = $(this).attr(filterKey).split(' - ');
                    for (var s = 0; s < sp.length; s++) {
                        if (selectedValue[0].indexOf(sp[s]) === -1) {
                            $(this).parents(".taskBoard").hide().addClass("hideFilter");
                        }
                        else {
                            $(this).parents(".taskBoard").show().removeClass("hideFilter");
                        }
                    }
                }
                else {
                    if (selectedValue[0].indexOf($(this).attr(filterKey)) === -1) {
                        $(this).parents(".taskBoard").hide().addClass("hideFilter");
                    }
                    else {
                        $(this).parents(".taskBoard").show().removeClass("hideFilter");
                    }
                }
            });

            //pagination

            pageSize = 10;
            $("#pagination").empty();

            var pageCount = $(".taskBoard:not(.hideFilter)").length / pageSize;

            for (var i = 0; i < pageCount; i++) {
                $("#pagination").append('<li class="page-item"><a class="page-link" href="javascript:void(0)">' + (i + 1) + '</a></li>');
            }

            $("#pagination li:nth-child(1)").addClass("active");

            showPage = function (page) {
                $(".taskBoard:not(.hideFilter)").hide();
                $(".taskBoard:not(.hideFilter").each(function (n) {
                    if (n >= pageSize * (page - 1) && n < pageSize * page)
                        $(this).show();
                });
            }

            showPage(1);

            $("#pagination li a").click(function () {
                $("#pagination li").removeClass("active");
                $(this).parents("li:not(.previous .next)").addClass("active");
                showPage(parseInt($(this).text()))
            });
        },
    });
}

function TasksCounter() {
    $.ajax({
        type: "POST",
        contentType: 'application/json; charset=utf-8',
        url: "/System_Root/is_listesi/is_listesi.aspx/TasksCounter",
        dataType: "JSON",
        success: function (data) {
            var res = JSON.parse(data.d);

            console.log(res);

            $("#bana_verilen_baslanmamis").html(res.bana_verilen_baslanmamis_int);
            $("#bana_verilen_devameden").html(res.bana_verilen_devameden_int);
            $("#bana_verilen_geciken").html(res.bana_verilen_geciken_int);
            $("#bana_verilen_tamamlanan").html(res.bana_verilen_tamamlanan_int);

            $("#baskasina_baslanmamis").html(res.baskasina_baslanmamis_int);
            $("#baskasina_devameden").html(res.baskasina_devameden_int);
            $("#baskasina_geciken").html(res.baskasina_geciken_int);
            $("#baskasina_tamamlanan").html(res.baskasina_tamamlanan_int);
        },
    });
}