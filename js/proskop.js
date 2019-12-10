
var sonsayfa = 0;
var sondata = 0;
var sonbas = 9999;
var sonorta = 9999;
var sonson = 9999;
var sontab = 1;
var tiklanacak = 0;


var tempsayfa = new Array();
var tempdata = new Array();
var tempfunctionid = new Array();

tempsayfa[0] = "/temp/sayfa/";
tempdata[0] = "jsid=4559&linkid=689";
tempfunctionid[0] = "1";


var indis = 1;
var buyukindis = 1;



(function ($) {
    $.loadHTML = {
        options: {
            url: "",
            data: "",
            encode: true,
            loading: true,
            type: "POST"
        },
        callback: function () { }
    };
    $.fn.loadHTML = function (options, callback) {

        var newurl = options.url + options.data;
        if (options.encode) {
            newurl = encodeURI(newurl);
        }
        if (options.loading != false) {
            $(this).html('<br><table style=" width:100%; height:100%;"><tr><td style=" text-align:center; vertical-align:middle;"><div class="cell preloader5 loader-block"><div class="circle-5 l"></div><div class="circle-5 m"></div><div class="circle-5 r"></div></div></td></td></table>');
        }
        var yer_adi = $(this).attr("id");
        if (options.type == undefined) {
            options.type = "POST";
        }
        $.ajax({
            type: options.type,
            url: options.url,
            data: options.data,
            success: function (data) {
                $("#" + yer_adi).html(data);
                pageSetUp();
                if ($.isFunction(callback)) {
                    callback();
                }
                // dil_calistir(yer_adi, -1, data, callback); 
            }
        });
        $.ajaxSetup({ async: true });
    };
})(jQuery);


function dil_calistir(yer, deger, data, callback) {
    var fulldata = data;
    var kelimeler = dilayikla(fulldata);
    var datai = "jsid=4559&kelimeler=" + kelimeler;
    datai = encodeURI(datai);
    $.ajax({
        type: "POST",
        url: "/ajax/dilayikla.asp",
        data: datai,
        success: function () {

        }
    });
}

function dilayikla(value) {

    var stringOfHtml = value;
    var wrappedString = '<div>' + stringOfHtml + '</div>';
    var noScript = wrappedString.replace(/script/g, "THISISNOTASCRIPTREALLY");
    var html = $(noScript);
    html.find('THISISNOTASCRIPTREALLY').remove();
    value = html.html().replace(/THISISNOTASCRIPTREALLY/g, 'script');

    var stringOfHtml = value;
    var wrappedString = '<div>' + stringOfHtml + '</div>';
    var noScript = wrappedString.replace(/style/g, "THISISNOTASCRIPTREALLY");
    var html = $(noScript);
    html.find('THISISNOTASCRIPTREALLY').remove();
    value = html.html().replace(/THISISNOTASCRIPTREALLY/g, 'style');

    var reg = /(<([^>]+)>)/ig;
    data = value.replace(reg, "");
    data = data.replace(/(\r\n|\n|\r)/gm, "~");
    var Msgs = data.split("~");
    var data1 = "";
    for (x = 0; x <= Msgs.length; x++) {
        data1 = data1 + "~" + $.trim(Msgs[x]);
    }
    for (var i = 0; i < data1.split('&gt;').length; i++) {
        data1 = data1.replace("&gt;", "~");
        data1 = data1.replace("&gt;", "~");
        data1 = data1.replace("&gt;", "~");
    }
    for (var i = 0; i < data1.split('~').length; i++) {
        data1 = data1.replace("~~", "~");
        data1 = data1.replace("~~", "~");
        data1 = data1.replace("~~", "~");
    }
    for (var i = 0; i < data1.split('&amp;').length; i++) {
        data1 = data1.replace("&amp;", "");
        data1 = data1.replace("&amp;", "");
        data1 = data1.replace("&amp;", "");
    }
    return (data1);
}





function pageSetUp() {

    var elem = Array.prototype.slice.call(document.querySelectorAll('.js-switch:not(.yapilan)'));
    elem.forEach(function (html) {
        var switchery = new Switchery(html, { color: '#4099ff', jackColor: '#fff', size: 'small' });
    });
    $(".js-switch").addClass("yapilan");
    $("select.select2:not(.yapilan)").addClass("yapilan").select2();

    fileyap();
}

function QueryStringToJSON(str) {
    var pairs = str.split('&');
    var result = {};
    pairs.forEach(function (pair) {
        pair = pair.split('=');
        var name = pair[0]
        var value = pair[1]
        if (name.length)
            if (result[name] !== undefined) {
                if (!result[name].push) {
                    result[name] = [result[name]];
                }
                result[name].push(value || '');
            } else {
                result[name] = value || '';
            }
    });
    return (result);
}


(function ($) {
    $.loadWebMethod = {
        options: {
            url: "",
            data: "",
            encode: true,
            loading: true
        },
        callback: function () { }
    };
    $.fn.loadWebMethod = function (options, callback) {
        var json_data = JSON.stringify(QueryStringToJSON(options.data));
        $.ajax({
            type: "POST",
            url: options.url,
            data: json_data,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response.d == "true") {
                    if ($.isFunction(callback)) {
                        callback();
                    } else {
                    }
                } else {
                    /*
                    $.bigBox({
                        title: "Uyarı",
                        content: "Hata Oluştu",
                        color: "#C46A69",
                        icon: "fa fa-warning shake animated",
                        number: "1",
                        timeout: 6000
                    });
                    */
                    mesaj_ver("Uyarı", "Hata Oluştu", "danger");
                }
            }, failure: function (response) {
                /*
                $.bigBox({
                    title: "Uyarı",
                    content: "Hata Oluştu",
                    color: "#C46A69",
                    icon: "fa fa-warning shake animated",
                    number: "1",
                    timeout: 6000
                });*/
                mesaj_ver("Uyarı", "Hata Oluştu", "danger");
            }
        });
        $.ajaxSetup({ async: true });
    };
})(jQuery);



function AJAX() {
    var ajax = false;

    // Internet Explorer (5.0+)
    try {
        ajax = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {

        try {
            ajax = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (e) {
            ajax = false;
        }

    }

    // Mozilla veya Safari
    if (!ajax && typeof XMLHttpRequest != 'undefined') {
        try {
            ajax = new XMLHttpRequest();
        } catch (e) {
            ajax = false;
        }
    }

    // Diger (IceBrowser)
    if (!ajax && window.createRequest) {
        try {
            ajax = window.createRequest();
        } catch (e) {
            ajax = false;
        }
    }
    return ajax;
}

(function ($) {
    $.loadHTML2 = {
        options: {
            url: "",
            data: "",
            encode: true,
            loading: true
        },
        callback: function () { }
    };
    $.fn.loadHTML2 = function (options, callback) {
        var newurl = options.url + "?" + options.data;
        if (options.encode) {
            newurl = encodeURI(newurl);
        }
        if (options.loading != false) {
            $(this).html('<br><table style=" width:100%; height:100%;"><tr><td style=" text-align:center; vertical-align:middle;"><div class="cell preloader5 loader-block"><div class="circle-5 l"></div><div class="circle-5 m"></div><div class="circle-5 r"></div></div></td></td></table>');
        }
        ajax = new AJAX();

        //  if (ajax) {
        //      ajax.onreadystatechange = function () { }
        //      ajax.abort()
        //  }

        var str = $(this).attr("id");

        ajax.onreadystatechange = function () { Loadingyeni(0, str, options.url, callback) }
        if (options.encode) {
            options.data = encodeURI(options.data);
        }

        ajax.open('POST', options.url, true)
        ajax.setRequestHeader("If-Modified-Since", "Sat, 1 Jan 2000 00:00:00 GMT")
        ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8')
        ajax.setRequestHeader("Content-length", options.data.length)
        ajax.setRequestHeader("Connection", "close")
        ajax.send(options.data)
        $.ajaxSetup({ async: true });
    };
})(jQuery);


function sayfagetir(sayfa, data) {



    tiklandi = 1;

    if (indis > buyukindis) {
        buyukindis = indis;
    }
    tempsayfa[indis] = sayfa;
    tempdata[indis] = data;
    indis++;
    sonsayfa = sayfa;


    var sonum = data.substr(-10)
    if (sonum == "&tab5=true") {
        tiklanacak = 1;
    } else {
        tiklanacak = 0;
    }
    sondata = data;

    $("#ortadiv").html('<br><table style=" width:100%; height:100%;"><tr><td style="text-align:center; vertical-align:middle;"><div class="cell preloader5 loader-block"><div class="circle-5 l"></div><div class="circle-5 m"></div><div class="circle-5 r"></div></div></td></td></table>');

    $.ajax({
        type: "GET",
        url: sayfa,
        data: data,
        success: function (data) {
            $("#ortadiv").html(data);
            sayfa_yuklenince();
            $("body").click();
            if ($("#pcoded").attr("pcoded-device-type") == "phone") {
                $(".mobile-menu").click();
            }
            if (window.innerWidth.innerWidth < 1025) {
                $('.pcoded-navbar').removeClass('show-menu');
            }
        }
    });

    var yer = data.indexOf("uyari");
    if (yer > 0) {
        data = data.slice(0, yer - 1);
    }
    sondata = data;


}
//personel_giris_cikis_getir('<%=personel_id %>', this)
function CokluIsYap(sayfa,personelid, subpage,IsID) {

    if (sayfa == "personel_detaylari") {
        sayfagetir('/' + sayfa + '/', 'jsid=4559&personel_id=' + personelid);
    } else if (sayfa == "is_listesi") {
        sayfagetir('/' + sayfa + '/', 'jsid=4559&bildirim=true&bildirim_id=' + IsID );
    }
    

    if (subpage == "izin") {
        setTimeout(function () {
            var tabID = $("#giris_cikis_buton").attr("href");
            $(".personel_tablar").html("");
            $(".nav-link_yeni").removeClass("tab-current");
            personel_giris_cikis_getir(personelid, $("#giris_cikis_buton"));
            $(".tabs ul li").removeClass("tab-current");
            $($("#giris_cikis_buton")).parent("li").addClass("tab-current");
            $(".tabs .content-wrap section").removeClass("content-current");
            $("section" + tabID).addClass("content-current");
        }, 100);
    }
    else if (subpage == "mesai") {
        setTimeout(function () {
            var nesne = $("#mesai_buton");
            var tabID = nesne.attr("href");
            $(".personel_tablar").html("");
            $(".nav-link_yeni").removeClass("tab-current");
            personel_mesai_getir(personelid, nesne);
            $(".tabs ul li").removeClass("tab-current");
            $(nesne).parent("li").addClass("tab-current");
            $(".tabs .content-wrap section").removeClass("content-current");
            $("section" + tabID).addClass("content-current");
        }, 100);
    }
    else if (subpage == "biten") {
        setTimeout(function () {
            $("#biten").trigger("click");
            //$("#birnumara").attr("style", "display: none;");
        }, 1000);
    }
    


    

}



function notify(from, align, icon, type, animIn, animOut, title, mesaj) {
    $.growl({
        icon: icon,
        title: title,
        message: mesaj,
        allow_dismiss: false,
        url: ''
    }, {
        element: 'body',
        type: type,
        allow_dismiss: true,
        placement: {
            from: from,
            align: align
        },
        offset: {
            x: 30,
            y: 30
        },
        spacing: 10,
        z_index: 999999,
        delay: 2500,
        timer: 1000,
        url_target: '_blank',
        mouse_over: false,
        animate: {
            enter: animIn,
            exit: animOut
        },
        icon_type: 'class',
        template: '<div data-growl="container" class="alert" role="alert">' +
            '<button type="button" class="close" data-growl="dismiss">' +
            '' +
            '<span class="sr-only">Close</span>' +
            '</button>' +
            '<span data-growl="icon"></span>' +
            '<span data-growl="title"></span>' +
            '<span data-growl="message"></span>' +
            '<a href="#" data-growl="url"></a>' +
            '</div>'
    });
};


function mesaj_ver(title, mesaj, durum) {

    var p = 0;
    if ($(".ui-pnotify").length > 1) {
        $(".ui-pnotify").each(function () {
            p++;
            if (p < 2) {
                $(this).remove();
            }
        });
    }



    // primary style
    if (durum == "info") {
        new PNotify({
            title: title,
            text: mesaj,
            icon: 'icofont icofont-info-circle',
            type: 'primary',
            buttons: {
                closer_hover: false,
                sticker_hover: true
            }
        });
    } else if (durum == "success") {
        new PNotify({
            title: title,
            text: mesaj,
            icon: 'icofont icofont-info-circle',
            type: 'success',
            buttons: {
                closer_hover: false,
                sticker_hover: true
            }
        });
    } else if (durum == "warning") {
        new PNotify({
            title: title,
            text: mesaj,
            icon: 'icofont icofont-info-circle',
            type: 'primary',
            buttons: {
                closer_hover: false,
                sticker_hover: true
            }
        });
    } else if (durum == "danger") {


        new PNotify({
            title: title,
            text: mesaj,
            icon: 'icofont icofont-info-circle',
            type: 'error',
            buttons: {
                closer_hover: false,
                sticker_hover: true
            }
        });
    }


    // notify("top", "center", "", durum, "animated bounceIn", "animated bounceOut", "", mesaj);

    /*
    if (durum == "success") {
        $.smallBox({
            title: title,
            content: mesaj,
            color: "#739e73",
            iconSmall: "fa fa-thumbs-up bounce animated",
            timeout: 4000
        });
    } else if (durum == "warning") {
        $.smallBox({
            title: title,
            content: mesaj,
            color: "#c79121",
            iconSmall: "fa fa-thumbs-up bounce animated",
            timeout: 4000
        });
    } else if (durum == "important") {

        notify("top", "center", "fa-thumbs-up", durum, "animated bounceIn", "animated bounceOut", title, mesaj);

    } else {
        $.smallBox({
            title: title,
            content: mesaj,
            color: "#296191",
            iconSmall: "fa fa-thumbs-up bounce animated",
            timeout: 4000
        });
    }
    */

}

function sayfa_yuklenince() {

    $(".select2-hidden-accessible").hide();
    $("select.select2:not(.yapilan)").addClass("yapilan").select2();

    //pageSetUp();

    $(".takvimyap").datepicker({

    }).mask("99.99.9999");

    $(".timepicker").mask("99:99");

    if ($("input[type=file]").lenght > 0) {
        fileyap();
    }

    $('form').submit(false);

    $(".validateform").each(function () {

        $(this).validate();

        var $buton = $(this).find("input[type=button]")[0];

        $(this).find("input:not(.select2-input)").each(function () {
            $(this).keyup(function (event) {
                if (event.keyCode === 13) {
                    $($buton).click();
                }
            });
        });
    });
    $('.tabsyap').tabs();


    $(':input').each(function () {
        $(this).attr('autocomplete', 'new-password');
    });

    datatableyap();
}

function Loadingyeni(yukleniyor, yer, deger, callback) {
    if (ajax.readyState == 4 && yer != 'no_id') {
        var fulldata = ajax.responseText;
        $("#" + yer).html(fulldata);
        if ($.isFunction(callback)) {
            callback();
        }
    }
}


function popUp(URL, yukseklik, genislik) {
    day = new Date();
    id = day.getTime();
    eval("page" + id + " = window.open(URL, '" + id + "', 'location=no,directories=0,titlebar=0,toolbar=0,scrollbars=1,statusbar=0,menubar=0,resizable=0,width=" + genislik + ",height=" + yukseklik + ",left = 300,top = 100');");
}

$(document).on("click", "#btnUploadKaydet", function () {
    mesaj_ver("Envanter Kaydı", "İşlem Başarılı", "success");
    sayfagetir('/parcalar/', 'jsid=4559');
    sayfa_yuklenince();
    $("button.close[data-dismiss=modal]").trigger("click");
    return false;
});

function upload(id, folderName) {
    var formData = new FormData();
    var totalFiles = document.getElementById(id).files.length;

    for (var i = 0; i < totalFiles; i++) {
        var file = document.getElementById(id).files[i];
        console.log(file);
        formData.append("FileUpload", file);
        formData.append("folderName", folderName);
    }

    $.ajax({
        type: 'post',
        url: '/upload.ashx',
        data: formData,
        dataType: 'json',
        contentType: false,
        processData: false,
        success: function (response) {
            if (response.status) {
                mesaj_ver("Dosya Yükleme", "İşlem Başarılı", "success");
                var htmlControl = $("#" + id);
                $(htmlControl).attr("filePath", "/" + response.fileFullPath);
                $(htmlControl).attr("value", "/" + response.fileFullPath);
                console.log($(htmlControl).attr("filePath"));
                $("#fileLoading").hide();
            }
        },
        beforeSend: function () {
            // setting a timeout
            $("#fileLoading").show();
        },
        error: function (error) {
            mesaj_ver("Uyarı", "Hata Oluştu", "danger");
            $("#fileLoading").hide();
        }
    });
}

$(document).on("change", "input[type=file]", function () {
    var id = $(this).attr("id");
    var folderName = $(this).attr("folder");
    upload(id, folderName);
});

function fileyap() {

    //$("input:file").addClass("fileupload");

    //$('input:file:not(input[yapildi=true])').each(function (o) {

    //    var d = new Date();
    //    var i = parseInt(o) + parseInt(d.getSeconds());
    //    var attrs = $(this)[0].attributes;
    //    var nesne = '<input type="file"  iid="' + i + '" id="uploadsrc' + i + '" ';
    //    var nesne1 = '<input type="hidden" resimurl="' + i + '" ';
    //    var mevcutresim = "";
    //    var resimvar = "false";
    //    for (var r = 0; r < attrs.length; r++) {
    //        if (attrs[r].nodeName != "name" && attrs[r].nodeName != "id" && attrs[r].nodeName != "sutun" && attrs[r].nodeName != "value") {
    //            nesne = nesne + attrs[r].nodeName + '="' + attrs[r].nodeValue + '" ';
    //        } else {
    //            if (attrs[r].nodeName == "value") {
    //                mevcutresim = attrs[r].nodeValue;
    //                resimvar = "true";
    //            }
    //            nesne1 = nesne1 + attrs[r].nodeName + '="' + attrs[r].nodeValue + '" ';
    //        }
    //    }

    //    if (resimvar == "false") {
    //        if ($(this).attr("tip") == "kucuk") {
    //            mevcutresim = "/img/kucukboy.png";
    //        } else if ($(this).attr("tip") == "orta") {
    //            mevcutresim = "/img/ortaboy.png";
    //        } else if ($(this).attr("tip") == "buyuk") {
    //            mevcutresim = "/img/buyukboy.png";
    //        } else {
    //            mevcutresim = "/img/ortaboy.png";
    //        }
    //    }


    //    nesne = nesne + "/>";
    //    nesne1 = nesne1 + "/>";


    //    if ($(this).attr("tip") == "kucuk") {

    //        $('<div id="upload' + i + '"><table border="0" cellspacing="0" cellpadding="0"><tr><td><div style="width:28px; height:28px; border:solid 1px #dddddd; margin-right:1px; background-color:White; float:left;"><img id="uploadresim' + i + '" tip="' + $(this).attr("tip") + '" style="width:28px; height:28px;"" class="resim" src="' + mevcutresim + '" /></div></td><td>' + nesne + nesne1 + '</td></tr></table></div>').insertBefore(this);
    //        $(this).remove();

    //    } else if ($(this).attr("tip") == "orta") {

    //        $('<div id="upload' + i + '"><table border="0" cellspacing="0" cellpadding="0"><tr><td><div style="width:143px; height:104px; border:solid 1px #dddddd; margin-bottom:1px; background-color:White; float:left;"><img id="uploadresim' + i + '" tip="' + $(this).attr("tip") + '" style="width:143px; height:104px;"" class="resim" src="' + mevcutresim + '" /></div></td></tr><tr><td>' + nesne + nesne1 + '</td></tr></table></div>').insertBefore(this);
    //        $(this).remove();

    //    } else if ($(this).attr("tip") == "buyuk") {

    //        $('<div id="upload' + i + '"><table border="0" cellspacing="0" cellpadding="0"><tr><td><div style="width:181px; height:130px; border:solid 1px #dddddd; margin-bottom:1px; background-color:White; float:left;"><img id="uploadresim' + i + '" tip="' + $(this).attr("tip") + '" style="width:178px; height:130px;"" class="resim" src="' + mevcutresim + '" /></div></td></tr><tr><td>' + nesne + nesne1 + '</td></tr></table></div>').insertBefore(this);
    //        $(this).remove();

    //    } else {

    //        $('<div id="upload' + i + '"><table border="0" cellspacing="0" cellpadding="0"><tr><td><div style="width:143px; height:104px; border:solid 1px #dddddd; margin-bottom:1px; background-color:White; float:left;"><img id="uploadresim' + i + '" tip="' + $(this).attr("tip") + '" style="width:143px; height:104px;"" class="resim" src="' + mevcutresim + '" /></div></td></tr><tr><td>' + nesne + nesne1 + '</td></tr></table></div>').insertBefore(this);
    //        $(this).remove();

    //    }
    //});
    //$('input:file:not(input[yapildi=true])').filestyle();



    //$('input:file:not(input[yapildi=true])').each(function (i) {

    //    $(this).attr("yapildi", "true");
    //    if ($.browser.mozilla) {

    //        $(this).css("width", "150px");
    //        $(this).css("margin-left", "40px");
    //    }


    //    //$(this).fileupload({




    //    //    uploadtemplateıd: null,
    //    //    downloadtemplateıd: null,
    //    //    uploadtemplate: null,
    //    //    downloadtemplate: null,
    //    //    url: '/upload.ashx',
    //    //    datatype: 'json',
    //    //    formdata: { yol: $(this).attr("yol") }

    //    //});

    //    $(this)
    //        //  .bind('fileuploadadd', function (e, data) { alert("1"); })
    //        // .bind('fileuploadsubmit', function (e, data) { alert("2"); })
    //        //  .bind('fileuploadsend', function (e, data) { alert("3"); })
    //        .bind('fileuploaddone', function (e, data) {

    //            // $("/imgid" + $(this).attr("iid")).remove();
    //            $(".loadlar" + $(this).attr("iid")).remove();

    //            //burdan

    //            var url;
    //            $.each(data.result, function (i) {
    //                url = data.result[i].url;
    //            });
    //            //burdan		

    //            if ($("#uploadresim" + $(this).attr("iid")).attr("tip") == "buyuk") {
    //                $("#uploadresim" + $(this).attr("iid")).attr("src", url);
    //            } else {
    //                $("#uploadresim" + $(this).attr("iid")).attr("src", "/img/done.png");
    //            }
    //            $("input[resimurl=" + $(this).attr("iid") + "]").val(url);

    //        })
    //        .bind('fileuploadfail', function (e, data) {
    //            //notify_e("Uyarı", "Hata oluştu.");
    //            mesaj_ver("Uyarı", "Hata Oluştu", "danger");
    //        })
    //        // .bind('fileuploadalways', function (e, data) { alert("6"); })
    //        // .bind('fileuploadprogress', function (e, data) { alert("7"); })
    //        // .bind('fileuploadprogressall', function (e, data) { alert("8"); })
    //        .bind('fileuploadstart', function (e) {

    //            if ($(this).attr("tip") == "kucuk") {
    //                $('<div class="loadlar' + $(this).attr("iid") + '" style=" position:absolute; margin-left:5px; margin-top:7px;" ><img id="/imgid' + $(this).attr("iid") + '" src="/img/loader_green.gif" /></div>').insertBefore("#uploadresim" + $(this).attr("iid"));
    //                $("#uploadresim" + $(this).attr("iid")).attr("src", "/img/duzarkaplan.png")
    //            } else if ($(this).attr("tip") == "orta") {
    //                $('<div class="loadlar' + $(this).attr("iid") + '" style=" position:absolute; margin-left:63px; margin-top:50px;" ><img src="/img/loader_green.gif" /></div>').insertBefore("#uploadresim" + $(this).attr("iid"));
    //                $("#uploadresim" + $(this).attr("iid")).attr("src", "/img/duzarkaplan.png")
    //            } else if ($(this).attr("tip") == "buyuk") {
    //                $('<div class="loadlar' + $(this).attr("iid") + '" style=" position:absolute; margin-left:85px; margin-top:57px;" ><img src="/img/loader_green.gif" /></div>').insertBefore("#uploadresim" + $(this).attr("iid"));
    //                $("#uploadresim" + $(this).attr("iid")).attr("src", "/img/duzarkaplan.png")
    //            } else {
    //                $('<div class="loadlar' + $(this).attr("iid") + '" style=" position:absolute; margin-left:63px; margin-top:50px;" ><img src="/img/loader_green.gif" /></div>').insertBefore("#uploadresim" + $(this).attr("iid"));
    //                $("#uploadresim" + $(this).attr("iid")).attr("src", "/img/duzarkaplan.png")
    //            }
    //        })


    //        .bind('fileuploadstop', function (e, data) {
    //            if ($.browser.msie) {
    //                throw new Error('This is not an error. This is just to abort javascript');
    //            }
    //        })


    //    // buralardan oldu


    //    //
    //    //  .bind('fileuploadchange', function (e, data) { alert("11"); })
    //    // .bind('fileuploadpaste', function (e, data) { alert("12"); })
    //    // .bind('fileuploaddrop', function (e, data) { alert("13"); })
    //    // .bind('fileuploaddragover', function (e, data) { alert("14"); })
    //    //.bind('fileuploaddestroy', function (e, data) { alert("15"); })
    //    //.bind('fileuploaddestroyed', function (e, data) { alert("16"); })


    //});



    //$('input:file:not(input[yapildi=true])').each(function () {

    //    var that = this;
    //    $.getJSON(this.action, function (result) {
    //        if (result && result.length) {
    //            $(that).fileupload('option', 'done')
    //                .call(that, null, { result: result });

    //        }
    //    });
    //});






}

var responsiveHelper_dt_basic = undefined;
var responsiveHelper_datatable_fixed_column = undefined;
var responsiveHelper_datatable_col_reorder = undefined;
var responsiveHelper_datatable_tabletools = undefined;

var breakpointDefinition = {
    tablet: 1366,
    phone: 480
};

function datatableyap() {

    responsiveHelper_dt_basic = undefined;
    if ($('.datatableyap:not(.yapilan)').length > 0) {
        $('.datatableyap:not(.yapilan)').addClass("yapilan").removeClass("datatableyap").dataTable({
            "sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6'><'col-sm-6 col-xs-12 hidden-xs'l>r>" + "t" + "<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
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

}




function datatableyap2() {
    responsiveHelper_dt_basic = undefined;
    if ($('.datatableyap:not(.yapilan)').length > 0) {
        $('.datatableyap:not(.yapilan)').addClass("yapilan").dataTable({
            "sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6'f><'col-sm-6 col-xs-12 hidden-xs'l>r>" +
                "t" +
                "<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
            "autoWidth": true,
            "searching": false,
            "preDrawCallback": function () {


                var table = $(this);
                if (!responsiveHelper_dt_basic) {
                    responsiveHelper_dt_basic = new ResponsiveDatatablesHelper(table, breakpointDefinition);
                }

            },
            "paging": false,
            "rowCallback": function (nRow) {
                responsiveHelper_dt_basic.createExpandIcon(nRow);
            },
            "drawCallback": function (oSettings) {
                responsiveHelper_dt_basic.respond();
            }
        });
    }

}

function ajax_dil(dil) {

    $(window).off('beforeunload');
    window.location.href = "/ajax_dil.aspx?jsid=4559&dil=" + dil;

}



function IsNumeric(strString) {
    var strValidChars = "0123456789.-";
    var strChar;
    var blnResult = true;

    if (strString.length === 0) return false;
    //  test strString consists of valid characters listed above
    for (i = 0; i < strString.length && blnResult === true; i++) {
        strChar = strString.charAt(i);
        if (strValidChars.indexOf(strChar) === -1) {
            blnResult = false;
        }
    }
    return blnResult;
}

