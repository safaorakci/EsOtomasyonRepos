<%@ Page Language="C#" AutoEventWireup="true" CodeFile="is_listesi.aspx.cs" Inherits="System_root_is_listesi_is_listesi" %>

<form autocomplete="off" id="form1" runat="server">
    <style>
        span.gecikmis {
            background-color: #FF5377;
        }


        span.baslamamis {
            background-color: #00bcd4;
        }


        span.biten {
            background-color: #2ed8b6;
        }


        span.devam_eden {
            background-color: #FFB64D;
        }

        span.tag2 {
            width: 36px;
            height: 30px;
            border-radius: 50%;
            color: #fff;
            padding: 10px 12px 10px 12px;
            font-size: 11px;
            text-align: center;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .btn-lg {
            line-height: 0.7;
        }

        .ustunegelince2 {
            background-color: #fffbae;
        }
    </style>
    <section id="widget-grid">
        <div class="row">
            <div class="col-xs-12 col-sm-6">
                <button onclick="is_listesi_gosterge('benim_tum');" type="button" class="btn btn-primary btn-lg btn-block" style="-webkit-border-top-left-radius: 15px; -webkit-border-top-right-radius: 15px; -moz-border-radius-topleft: 15px; -moz-border-radius-topright: 15px; border-top-left-radius: 15px; border-top-right-radius: 15px; font-size: 13px;"><i class="fa fa-child"></i>&nbsp;&nbsp;<% Response.Write(LNG("Bana Verilen İşler")); %></button>
                <div class="well well-sm well-light" style="padding: 0; background-color: white; -webkit-border-bottom-right-radius: 15px; -webkit-border-bottom-left-radius: 15px; -moz-border-radius-bottomright: 15px; -moz-border-radius-bottomleft: 15px; border-bottom-right-radius: 15px; border-bottom-left-radius: 15px;">
                    <div class="row" style="margin: 0;">
                        <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 ustunegelince" style="border: 1px dotted #dfe5e9; margin: 0;">
                            <div class="text-center " onclick="is_listesi_gosterge('benim_baslanmamis');" style="cursor: pointer; padding-top: 10px; padding-bottom: 10px;">
                                <span class="tag2 baslamamis">
                                    <asp:label runat="server" id="bana_verilen_baslanmamis"></asp:label>
                                </span>
                                <h5 style="padding-top: 0; color: #5a5a5a; font-size: 12px; margin-top: 10px; font-weight: 400;"><% Response.Write(LNG("Başlanmamış")); %></h5>
                            </div>
                        </div>
                        <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 ustunegelince" style="border: 1px dotted #dfe5e9; margin: 0;">
                            <div class="text-center " onclick="is_listesi_gosterge('benim_devameden');" style="cursor: pointer; padding-top: 10px; padding-bottom: 10px;">
                                <span class="tag2 devam_eden">
                                    <asp:label runat="server" id="bana_verilen_devameden"></asp:label>
                                </span>
                                <h5 style="padding-top: 0; color: #5a5a5a; font-size: 12px; margin-top: 10px; font-weight: 400;"><% Response.Write(LNG("Devam Eden")); %></h5>
                            </div>
                        </div>
                        <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 ustunegelince" style="border: 1px dotted #dfe5e9; margin: 0; -webkit-border-bottom-left-radius: 15px; -moz-border-radius-bottomleft: 15px; border-bottom-left-radius: 15px;">
                            <div class="text-center " onclick="is_listesi_gosterge('benim_gecikmis');" style="cursor: pointer; padding-top: 10px; padding-bottom: 10px;">
                                <span class="tag2 gecikmis">
                                    <asp:label runat="server" id="bana_verilen_geciken"></asp:label>
                                </span>
                                <h5 style="padding-top: 0; color: #5a5a5a; font-size: 12px; margin-top: 10px; font-weight: 400;"><span style="color: #ea0036;"><% Response.Write(LNG("Gecikmiş")); %></span></h5>
                            </div>
                        </div>
                        <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 ustunegelince" style="border: 1px dotted #dfe5e9; margin: 0; -webkit-border-bottom-right-radius: 15px; -moz-border-radius-bottomright: 15px; border-bottom-right-radius: 15px;">
                            <div class="text-center" onclick="is_listesi_gosterge('benim_tamamlanan');" style="cursor: pointer; padding-top: 10px; padding-bottom: 10px;">
                                <span class="tag2 biten">
                                    <asp:label runat="server" id="bana_verilen_tamamlanan"></asp:label>
                                </span>
                                <h5 style="padding-top: 0; color: #5a5a5a; font-size: 12px; margin-top: 10px; font-weight: 400;"><% Response.Write(LNG("Tamamlanan")); %></h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-6">
                <button type="button" onclick="is_listesi_gosterge('baskasi_tumu');" class="btn btn-danger btn-lg btn-block" style="-webkit-border-top-left-radius: 15px; -webkit-border-top-right-radius: 15px; -moz-border-radius-topleft: 15px; -moz-border-radius-topright: 15px; border-top-left-radius: 15px; border-top-right-radius: 15px; font-size: 12px;">
                    <i class="fa fa-group"></i>&nbsp;&nbsp;<% Response.Write(LNG("Başkalarına Verdiğim İşler")); %></button>
                <div class="well well-sm well-light" style="padding: 0; background-color: white; -webkit-border-bottom-right-radius: 15px; -webkit-border-bottom-left-radius: 15px; -moz-border-radius-bottomright: 15px; -moz-border-radius-bottomleft: 15px; border-bottom-right-radius: 15px; border-bottom-left-radius: 15px;">
                    <div class="row" style="margin: 0;">
                        <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 ustunegelince" style="border: 1px dotted #dfe5e9; margin: 0;">
                            <div class="text-center " onclick="is_listesi_gosterge('baskasi_baslanmamis');" style="padding-top: 10px; padding-bottom: 10px; cursor: pointer;">
                                <span class="tag2 baslamamis">
                                    <asp:label runat="server" id="baskasina_baslanmamis"></asp:label>
                                </span>
                                <h5 style="padding-top: 0; color: #5a5a5a; font-size: 12px; margin-top: 10px; font-weight: 400;"><% Response.Write(LNG("Başlanmamış")); %></h5>
                            </div>
                        </div>
                        <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 ustunegelince" style="border: 1px dotted #dfe5e9; margin: 0;">
                            <div class="text-center " onclick="is_listesi_gosterge('baskasi_devameden');" style="padding-top: 10px; padding-bottom: 10px; cursor: pointer;">
                                <span class="tag2 devam_eden">
                                    <asp:label runat="server" id="baskasina_devameden"></asp:label>
                                </span>
                                <h5 style="padding-top: 0; color: #5a5a5a; font-size: 12px; margin-top: 10px; font-weight: 400;"><% Response.Write(LNG("Devam Eden")); %></h5>
                            </div>
                        </div>
                        <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 ustunegelince" style="border: 1px dotted #dfe5e9; margin: 0; -webkit-border-bottom-left-radius: 15px; -moz-border-radius-bottomleft: 15px; border-bottom-left-radius: 15px;">
                            <div class="text-center " onclick="is_listesi_gosterge('baskasi_gecikmis');" style="padding-top: 10px; padding-bottom: 10px; cursor: pointer;">
                                <span class="tag2 gecikmis">
                                    <asp:label runat="server" id="baskasina_geciken"></asp:label>
                                </span>
                                <h5 style="padding-top: 0; color: #5a5a5a; font-size: 12px; margin-top: 10px; font-weight: 400;"><span style="color: #ea0036;"><% Response.Write(LNG("Gecikmiş")); %></span></h5>
                            </div>
                        </div>
                        <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 ustunegelince" style="border: 1px dotted #dfe5e9; margin: 0; -webkit-border-bottom-right-radius: 15px; -moz-border-radius-bottomright: 15px; border-bottom-right-radius: 15px;">
                            <div class="text-center " onclick="is_listesi_gosterge('baskasi_biten');" style="padding-top: 10px; padding-bottom: 10px; cursor: pointer;">
                                <span class="tag2 biten">
                                    <asp:label runat="server" id="baskasina_tamamlanan"></asp:label>
                                </span>
                                <h5 style="padding-top: 0; color: #5a5a5a; font-size: 12px; margin-top: 10px; font-weight: 400;"><% Response.Write(LNG("Tamamlanan")); %></h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-4" style="display: none">
                <style>
                    #s2id_sayac_departman {
                        text-align: left !important;
                        margin-bottom: 2px !important;
                        margin-top: 2px !important;
                        width: 60% !important;
                    }

                    .tablo_is_adi {
                        overflow-wrap: break-word;
                        word-wrap: break-word;
                        -ms-word-break: break-all;
                        word-break: break-all;
                        word-break: break-word;
                        -ms-hyphens: auto;
                        -moz-hyphens: auto;
                        -webkit-hyphens: auto;
                        hyphens: auto;
                    }
                </style>
                <div class="btn btn-warning btn-lg btn-block" style="padding: 3px 16px; -webkit-border-top-left-radius: 15px; -webkit-border-top-right-radius: 15px; -moz-border-radius-topleft: 15px; -moz-border-radius-topright: 15px; border-top-left-radius: 15px; border-top-right-radius: 15px; font-size: 13px;">
                    <div style="height: 28px; width: 100%; margin-left: auto; margin-right: auto;">
                        <div onclick="is_listesi_gosterge('departman_tumu');" style="float: left; padding-top: 8px; padding-right: 10px; width: 30%;"><i class="fa fa-institution"></i>&nbsp;&nbsp;<% Response.Write(LNG("Etiketler :")); %> </div>
                        <div id="yerlesim_item" style="float: left; width: 70%;">
                            <div>
                                <asp:listbox id="sayac_departman" runat="server"></asp:listbox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="well well-sm well-light" style="padding: 0; background-color: white; -webkit-border-bottom-right-radius: 15px; -webkit-border-bottom-left-radius: 15px; -moz-border-radius-bottomright: 15px; -moz-border-radius-bottomleft: 15px; border-bottom-right-radius: 15px; border-bottom-left-radius: 15px;">
                    <div id="departman_donus_yeri" style="margin: 0;">
                        <div class="row" style="margin: 0;">
                            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 ustunegelince" style="border: 1px dotted #dfe5e9; cursor: pointer; margin: 0;">
                                <div class="text-center" style="padding-top: 10px; padding-bottom: 10px;">
                                    <span class="tag2 baslamamis"><span id="departman_baslanmamis">0</span>
                                    </span>
                                    <h5 style="padding-top: 0; color: #5a5a5a; font-size: 12px; margin-top: 10px; font-weight: 400;"><% Response.Write(LNG("Başlanmamış")); %></h5>
                                </div>
                            </div>
                            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 ustunegelince" style="border: 1px dotted #dfe5e9; cursor: pointer; margin: 0;">
                                <div class="text-center" style="padding-top: 10px; padding-bottom: 10px;">
                                    <span class="tag2 devam_eden"><span id="departman_devameden">0</span>
                                    </span>
                                    <h5 style="padding-top: 0; color: #5a5a5a; font-size: 12px; margin-top: 10px; font-weight: 400;"><% Response.Write(LNG("Devam Eden")); %></h5>
                                </div>
                            </div>
                            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 ustunegelince" style="border: 1px dotted #dfe5e9; cursor: pointer; margin: 0; -webkit-border-bottom-left-radius: 15px; -moz-border-radius-bottomleft: 15px; border-bottom-left-radius: 15px;">
                                <div class="text-center" style="padding-top: 10px; padding-bottom: 10px;">
                                    <span class="tag2 gecikmis"><span id="departman_gecikmis">0</span>
                                    </span>
                                    <h5 style="padding-top: 0; color: #5a5a5a; font-size: 12px; margin-top: 10px; font-weight: 400;"><span style="color: #ea0036;"><% Response.Write(LNG("Gecikmiş")); %></span></h5>
                                </div>
                            </div>
                            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 ustunegelince" style="border: 1px dotted #dfe5e9; cursor: pointer; margin: 0; -webkit-border-bottom-right-radius: 15px; -moz-border-radius-bottomright: 15px; border-bottom-right-radius: 15px;">
                                <div class="text-center" style="padding-top: 10px; padding-bottom: 10px;">
                                    <span class="tag2 biten"><span id="departman_tamamlanan">0</span>
                                    </span>
                                    <h5 style="padding-top: 0; color: #5a5a5a; font-size: 12px; margin-top: 10px; font-weight: 400;"><% Response.Write(LNG("Tamamlanan")); %></h5>
                                </div>
                            </div>



                            <script>
                                $(function () {

                                    $("#sayac_departman").attr("size", "1");

                                    $("select#sayac_departman option[optiongroup='Departmanlar']").wrapAll("<optgroup label='Departmanlar'>");
                                    $("select#sayac_departman option[optiongroup='Firmalar']").wrapAll("<optgroup label='Firmalar'>");
                                    $("select#sayac_departman option[optiongroup='Projeler']").wrapAll("<optgroup label='Projeler'>");

                                    $("select#sayac_departman option").each(function () {
                                        if ($(this).text() == "") {
                                            $(this).remove();
                                        }
                                    });

                                    departman_degistim_sayac_getir();


                                });
                            </script>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </section>

    <div class="page-body breadcrumb-page">
        <div class="card page-header p-0">
            <div class="card-block front-icon-breadcrumb row align-items-end">
                <div class="breadcrumb-header col">
                    <div class="big-icon">
                        <i class="fa-fw fa fa-lg fa-fw fa-sitemap"></i>
                    </div>
                    <div class="d-inline-block">
                        <h5><% Response.Write(LNG("İş Emirleri")); %></h5>
                        <span><%Response.Write(DateTime.Today.ToLongDateString()); %></span>
                    </div>
                </div>
                <div class="col">
                    <div class="page-header-breadcrumb">
                        <ul class="breadcrumb-title">
                            <li class="breadcrumb-item"><a href="javascript:void(0);" onclick="yeni_is_ekle();" class="btn btn-success btn-round" style="color: white;"><i class="fa  fa-cube"></i>&nbsp;<% Response.Write(LNG("Yeni İş Emri Ekle")); %></a>
                            </li>
                            <li class="breadcrumb-item"><a href="javascript:void(0);" onclick="is_aramasi_yap();" class="btn btn-danger btn-round" style="color: white;"><i class="fa fa-search"></i>&nbsp;<% Response.Write(LNG("Arama Yap")); %></a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="is_listesi_takvim_yeri" style="display:none;">
        <div class="card">
            <div class="card-block" style="padding: 0; min-height: 250px;">
                <div id="visualization">
                    <div class="visualizationmenu" style="display: none;">
                        <div class="btn-group " role="group" data-toggle="tooltip" data-placement="top" title="" data-original-title=".btn-xlg">
                            <button type="button" value="250" id="toggleZoomMode" class="btn btn-primary btn-sm waves-effect waves-light"><i class="fa fa-arrows-v"></i></button>
                            <button type="button" id="zoomIn" class="btn btn-primary btn-sm waves-effect waves-light"><i class="fa fa-plus"></i></button>
                            <button type="button" id="zoomOut" class="btn btn-primary btn-sm waves-effect waves-light"><i class="fa fa-minus"></i></button>
                            <button type="button" id="moveLeft" class="btn btn-primary btn-sm waves-effect waves-light" style="font-weight: bold; font-size: 17px;"><</button>
                            <button type="button" id="moveRight" class="btn btn-primary btn-sm waves-effect waves-light" style="font-weight: bold; font-size: 17px;">></button>
                        </div>
                    </div>
                </div>

                <%
                    string baslangic_tarihi = DateTime.Now.AddDays(-10).ToString("yyyy-MM-dd");
                    string bitis_tarihi = DateTime.Now.AddDays(60).ToString("yyyy-MM-dd");
                %>
                <script>
                    $(function () {
                        is_listesi_timeline_calistir('<%Response.Write(baslangic_tarihi); %>', '<%Response.Write(bitis_tarihi); %>');
            })
                </script>
            </div>
        </div>
    </div>
    <section id="widget-grid" class="">
        <div class="row">
            <div class="col-sm-12">
                <!-- Tab variant tab card start -->
                <div class="card z-depth-top-0">

                    <div class="card-block tab-icon" style="padding: 0px!important;">
                        <!-- Row start -->
                        <div class="row">
                            <div class="col-lg-12 col-xl-12">

                                <!-- Nav tabs -->
                                <ul class="nav nav-tabs tabs is_tab" role="tablist" style="text-align-last: justify">
                                    <li class="nav-item">
                                        <a class="nav-link active" onclick="is_listesi('tum');" data-toggle="tab" href="#tum_isler_ust" role="tab"><i class="fa fa-lg fa-cubes" style="color: black;"></i><% Response.Write(LNG("Tamamlanmamış")); %></a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" onclick="is_listesi('geciken');" data-toggle="tab" href="#geciken_isler_ust" role="tab"><i class="fa fa-lg fa-frown-o" style="color: red;"></i><% Response.Write(LNG("Gecikenler")); %></a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" onclick="is_listesi('bekleyen');" data-toggle="tab" href="#bekleyen_isler_ust" role="tab"><i class="fa fa-lg fa-folder" style="color: #c79121;"></i><% Response.Write(LNG("Bekleyenler")); %></a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" onclick="is_listesi('devameden');" data-toggle="tab" href="#devameden_isler_ust" role="tab"><i class="fa fa-lg fa-clock-o" style="color: blue;"></i><% Response.Write(LNG("Devam Edenler")); %></a>
                                    </li>

                                    <li class="nav-item">
                                        <a class="nav-link" id="biten" onclick="is_listesi('biten');" data-toggle="tab" href="#biten_isler_ust" role="tab"><i class="fa fa-lg fa-gavel" style="color: green;"></i><% Response.Write(LNG("Bitenler")); %></a>
                                    </li>

                                    <li class="nav-item">
                                        <a class="nav-link" onclick="is_listesi('iptal');" data-toggle="tab" href="#iptal_isler_ust" role="tab"><i class="fa fa-minus-circle" style="color: black;"></i><% Response.Write(LNG("İptaller")); %></a>
                                    </li>

                                    <li class="nav-item" style="display: none;">
                                        <a class="nav-link" data-toggle="tab" href="#takvim_gorunumu" role="tab"><i class="fa fa-lg fa fa-calendar"></i><% Response.Write(LNG("Ajanda")); %></a>
                                    </li>

                                </ul>
                                <!-- Tab panes -->
                                <div class="tab-content tabs card-block" style="padding: 0!important; border-left: 1px solid #ddd;">
                                    <div class="tab-pane active" id="tum_isler_ust" role="tabpanel">
                                        <div id="tum_isler_loading">
                                            <br>
                                            <table style="width: 100%; height: 100%;">
                                                <tr>
                                                    <td style="text-align: center; vertical-align: middle;">
                                                        <div class="cell preloader5 loader-block">
                                                            <div class="circle-5 l"></div>
                                                            <div class="circle-5 m"></div>
                                                            <div class="circle-5 r"></div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div id="tum_isler">
                                            <script>
                                                $(function () {
                                                    is_listesi();
                                                });
                                            </script>
                                        </div>
                                    </div>
                                    <div class="tab-pane " id="geciken_isler_ust" role="tabpanel">
                                        <div id="geciken_isler_loading" style="display: none;">
                                            <br>
                                            <table style="width: 100%; height: 100%;">
                                                <tr>
                                                    <td style="text-align: center; vertical-align: middle;">
                                                        <div class="cell preloader5 loader-block">
                                                            <div class="circle-5 l"></div>
                                                            <div class="circle-5 m"></div>
                                                            <div class="circle-5 r"></div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div id="geciken_isler">
                                        </div>
                                    </div>
                                    <div class="tab-pane " id="bekleyen_isler_ust" role="tabpanel">
                                        <div id="bekleyen_isler_loading" style="display: none;">
                                            <br>
                                            <table style="width: 100%; height: 100%;">
                                                <tr>
                                                    <td style="text-align: center; vertical-align: middle;">
                                                        <div class="cell preloader5 loader-block">
                                                            <div class="circle-5 l"></div>
                                                            <div class="circle-5 m"></div>
                                                            <div class="circle-5 r"></div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div id="bekleyen_isler">
                                        </div>
                                    </div>
                                    <div class="tab-pane " id="devameden_isler_ust" role="tabpanel">
                                        <div id="devameden_isler_loading" style="display: none;">
                                            <br>
                                            <table style="width: 100%; height: 100%;">
                                                <tr>
                                                    <td style="text-align: center; vertical-align: middle;">
                                                        <div class="cell preloader5 loader-block">
                                                            <div class="circle-5 l"></div>
                                                            <div class="circle-5 m"></div>
                                                            <div class="circle-5 r"></div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div id="devameden_isler">
                                        </div>
                                    </div>
                                    <div class="tab-pane " id="biten_isler_ust" role="tabpanel">
                                        <div id="biten_isler_loading" style="display: none;">
                                            <br>
                                            <table style="width: 100%; height: 100%;">
                                                <tr>
                                                    <td style="text-align: center; vertical-align: middle;">
                                                        <div class="cell preloader5 loader-block">
                                                            <div class="circle-5 l"></div>
                                                            <div class="circle-5 m"></div>
                                                            <div class="circle-5 r"></div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div id="biten_isler">
                                        </div>
                                    </div>
                                    <div class="tab-pane " id="iptal_isler_ust" role="tabpanel">
                                        <div id="iptal_isler_loading" style="display: none;">
                                            <br>
                                            <table style="width: 100%; height: 100%;">
                                                <tr>
                                                    <td style="text-align: center; vertical-align: middle;">
                                                        <div class="cell preloader5 loader-block">
                                                            <div class="circle-5 l"></div>
                                                            <div class="circle-5 m"></div>
                                                            <div class="circle-5 r"></div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div id="iptal_isler">
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <!-- Row end -->
                    </div>
                </div>
                <!-- Tab variant tab card start -->
            </div>
        </div>

        <div class="row">

            <!-- a blank row to get started -->
            <div class="col-sm-12">
                <!-- your contents here -->
            </div>

        </div>
    </section>



    <script type="text/javascript">

        $(document).ready(function () {


            pageSetUp();


            // Takvim Başlangıç


            "use strict";

            var date = new Date();
            var d = date.getDate();
            var m = date.getMonth();
            var y = date.getFullYear();

            var hdr = {
                left: 'title',
                center: 'month,agendaWeek,agendaDay',
                right: 'prev,today,next'
            };

            var initDrag = function (e) {
                // create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
                // it doesn't need to have a start or end

                var eventObject = {
                    title: $.trim(e.children().text()), // use the element's text as the event title
                    description: $.trim(e.children('span').attr('data-description')),
                    icon: $.trim(e.children('span').attr('data-icon')),
                    className: $.trim(e.children('span').attr('class')) // use the element's children as the event class
                };
                // store the Event Object in the DOM element so we can get to it later
                e.data('eventObject', eventObject);

                // make the event draggable using jQuery UI
                e.draggable({
                    zIndex: 999,
                    revert: true, // will cause the event to go back to its
                    revertDuration: 0 //  original position after the drag
                });
            };

            var addEvent = function (title, priority, description, icon) {
                title = title.length === 0 ? "Untitled Event" : title;
                description = description.length === 0 ? "No Description" : description;
                icon = icon.length === 0 ? " " : icon;
                priority = priority.length === 0 ? "label label-default" : priority;

                var html = $('<li><span class="' + priority + '" data-description="' + description + '" data-icon="' +
                    icon + '">' + title + '</span></li>').prependTo('ul#external-events').hide().fadeIn();

                $("#event-container").effect("highlight", 800);

                initDrag(html);
            };

            /* initialize the external events
             -----------------------------------------------------------------*/

            $('#external-events > li').each(function () {
                initDrag($(this));
            });

            $('#add-event').click(function () {
                var title = $('#title').val(),
                    priority = $('input:radio[name=priority]:checked').val(),
                    description = $('#description').val(),
                    icon = $('input:radio[name=iconselect]:checked').val();

                addEvent(title, priority, description, icon);
            });

            /* initialize the calendar
             -----------------------------------------------------------------*/

            $('#calendar').fullCalendar({

                header: hdr,
                buttonText: {
                    prev: '<i class="fa fa-chevron-left"></i>',
                    next: '<i class="fa fa-chevron-right"></i>'
                },


                editable: true,
                droppable: true, // this allows things to be dropped onto the calendar !!!

                drop: function (date, allDay) { // this function is called when something is dropped

                    // retrieve the dropped element's stored Event Object
                    var originalEventObject = $(this).data('eventObject');

                    // we need to copy it, so that multiple events don't have a reference to the same object
                    var copiedEventObject = $.extend({}, originalEventObject);

                    // assign it the date that was reported
                    copiedEventObject.start = date;
                    copiedEventObject.allDay = allDay;

                    // render the event on the calendar
                    // the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
                    $('#calendar').fullCalendar('renderEvent', copiedEventObject, true);

                    // is the "remove after drop" checkbox checked?
                    if ($('#drop-remove').is(':checked')) {
                        // if so, remove the element from the "Draggable Events" list
                        $(this).remove();
                    }

                },

                select: function (start, end, allDay) {
                    var title = prompt('Event Title:');
                    if (title) {
                        calendar.fullCalendar('renderEvent', {
                            title: title,
                            start: start,
                            end: end,
                            allDay: allDay
                        }, true // make the event "stick"
                        );
                    }
                    calendar.fullCalendar('unselect');
                },

                events: [{
                    title: 'All Day Event',
                    start: new Date(y, m, 1),
                    description: 'long description',
                    className: ["event", "bg-color-greenLight"],
                    icon: 'fa-check'
                }, {
                    title: 'Long Event',
                    start: new Date(y, m, d - 5),
                    end: new Date(y, m, d - 2),
                    className: ["event", "bg-color-red"],
                    icon: 'fa-lock'
                }, {
                    id: 999,
                    title: 'Repeating Event',
                    start: new Date(y, m, d - 3, 16, 0),
                    allDay: false,
                    className: ["event", "bg-color-blue"],
                    icon: 'fa-clock-o'
                }, {
                    id: 999,
                    title: 'Repeating Event',
                    start: new Date(y, m, d + 4, 16, 0),
                    allDay: false,
                    className: ["event", "bg-color-blue"],
                    icon: 'fa-clock-o'
                }, {
                    title: 'Meeting',
                    start: new Date(y, m, d, 10, 30),
                    allDay: false,
                    className: ["event", "bg-color-darken"]
                }, {
                    title: 'Lunch',
                    start: new Date(y, m, d, 12, 0),
                    end: new Date(y, m, d, 14, 0),
                    allDay: false,
                    className: ["event", "bg-color-darken"]
                }, {
                    title: 'Birthday Party',
                    start: new Date(y, m, d + 1, 19, 0),
                    end: new Date(y, m, d + 1, 22, 30),
                    allDay: false,
                    className: ["event", "bg-color-darken"]
                }, {
                    title: 'Smartadmin Open Day',
                    start: new Date(y, m, 28),
                    end: new Date(y, m, 29),
                    className: ["event", "bg-color-darken"]
                }],

                eventRender: function (event, element, icon) {
                    if (!event.description == "") {
                        element.find('.fc-event-title').append("<br/><span class='ultra-light'>" + event.description +
                            "</span>");
                    }
                    if (!event.icon == "") {
                        element.find('.fc-event-title').append("<i class='air air-top-right fa " + event.icon +
                            " '></i>");
                    }
                },

                windowResize: function (event, ui) {
                    $('#calendar').fullCalendar('render');
                }
            });

            /* hide default buttons */
            $('.fc-header-right, .fc-header-center').hide();


            $('#calendar-buttons #btn-prev').click(function () {
                $('.fc-button-prev').click();
                return false;
            });

            $('#calendar-buttons #btn-next').click(function () {
                $('.fc-button-next').click();
                return false;
            });

            $('#calendar-buttons #btn-today').click(function () {
                $('.fc-button-today').click();
                return false;
            });

            $('#mt').click(function () {
                $('#calendar').fullCalendar('changeView', 'month');
            });

            $('#ag').click(function () {
                $('#calendar').fullCalendar('changeView', 'agendaWeek');
            });

            $('#td').click(function () {
                $('#calendar').fullCalendar('changeView', 'agendaDay');
            });



        })

    </script>
</form>
