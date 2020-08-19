<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    cari_id = trn(request("cari_id"))
    tip = trn(request("tip"))

    if trim(tip)="firma" then
        SQL="select * from ucgem_firma_listesi where id = '"& cari_id &"' and ekleyen_firma_id = '"& Request.Cookies("kullanici")("firma_id") &"'"
        set firma = baglanti.execute(SQL)
        cari_hesap_adi = firma("firma_adi")
    end if


%>

    <div class="page-body breadcrumb-page">
        <div class="card page-header p-0">
            <div class="card-block front-icon-breadcrumb  align-items-end">
                <div class="row">
                <div class="breadcrumb-header col-md-4 col-lg-2 col-xl-1">
                    <div class="big-icon">
                        <i class="icofont icofont-home"></i>
                    </div>
                    
                </div>

                <div class="d-inline-block col-md-6">
                        <h5 style="font-size:15px;"><%=cari_hesap_adi %></h5>
                        <span><%=day(cdate(date)) %>&nbsp;<%=monthname(month(cdate(date))) %>&nbsp;<%=year(cdate(date)) %>&nbsp;<%=weekdayname(weekday(cdate(date))) %></span>
                    </div>
                    </div>
                <div class="col" style="display:none;">
                    <div class="page-header-breadcrumb">
                        <ul class="breadcrumb-title" style="display:none;">
                            <li class="breadcrumb-item"><a href="javascript:void(0);" class="btn btn-labeled btn-success btn-mini btn-round" style="color: white;"><span class="btn-label" style="color: white;"><i class="fa fa-trash-o"></i></span>&nbsp;<%=LNG("İndir")%></a>
                            </li>
                            <li class="breadcrumb-item"><a href="javascript:void(0);" class="btn btn-labeled btn-info btn-mini btn-round" style="color: white;"><span class="btn-label" style="color: white;"><i class="fa fa-history"></i></span>&nbsp;<%=LNG("Yazdır")%></a>
                            </li>
                            <li class="breadcrumb-item"><a href="javascript:void(0);" class="btn btn-labeled btn-danger btn-mini btn-round" style="color: white;"><span class="btn-label" style="color: white;"><i class="fa fa-history"></i></span>&nbsp;<%=LNG("Gönder")%></a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="tabela_yeri" class="row">
        <script>
            $(function (){
                cari_detay_tabela_getir('<%=cari_id %>', '<%=tip %>');
            });
        </script>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <div class="card">
                <div class="card-header">
                    <h5 style="font-size:20px;"><%=LNG("Cari İşlemler Dökümü")%></h5>
                    <span style="float:right;">
                        <a href="javascript:void(0);" onclick="cari_hareket_tahsilat_ekle('<%=cari_id %>', '<%=tip %>', 'icerden');" class="btn btn-mini btn-success btn-round" style="color: white;"><i class="fa fa-money"></i>&nbsp;<%=LNG("Tahsilat Ekle")%></a>
                        <a href="javascript:void(0);" onclick="cari_hareket_odeme_ekle('<%=cari_id %>', '<%=tip %>', 'icerden');" class="btn btn-mini btn-danger btn-round" style="color: white;"><i class="fa fa-paper-plane-o"></i>&nbsp;<%=LNG("Ödeme Ekle")%></a>
                    </span>
                </div>
                <div id="cari_hareket_listesi" class="card-block">
                    <script>
                        $(function (){
                            cari_hareket_listesi_getir('<%=cari_id %>', '<%=tip %>', 'icerden');
                        });
                    </script>
                </div>
            </div>
        </div>
    </div>
    