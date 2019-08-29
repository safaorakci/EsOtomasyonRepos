
    <div class="page-body breadcrumb-page">
        <div class="card page-header p-0">
            <div class="card-block front-icon-breadcrumb row align-items-end">
                <div class="breadcrumb-header col">
                    <div class="big-icon">
                        <div class="card-block user-info" style="bottom: -65px;">
                            <div class="media-left">
                                <a href="#" class="profile-image">
                                    <img class="user-img img-radius" src="/img/taseron_logo.jpg" style="width: 140px;" alt="user-img">
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="d-inline-block" style="padding-left: 175px;">
                        <h5 style="font-size:15px;">Taşeron 1 Ltd Şti</h5>
                        <span>Bursa</span>
                    </div>
                </div>
                <div class="col">
                    <div class="page-header-breadcrumb" style="display:none;">
                        <ul class="breadcrumb-title">
                            <li class="breadcrumb-item"><a href="javascript:void(0);" class="btn btn-success btn-round" style="color: white;"><i class="fa  fa-cube"></i>&nbsp;Taşeron Bilgilerini Düzenle</a>
                            </li>
                            <li class="breadcrumb-item"><a href="javascript:void(0);" class="btn btn-danger btn-round" style="color: white;"><i class="fa fa-search"></i>&nbsp;Taşeron Sil</a>
                            </li>

                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <style>
        .md-tabs .nav-item {
            width: calc(100% / 9);
            border-right: solid 1px #007bff;
        }

        .nav-tabs .slide {
            width: calc(100% / 9);
        }

        .yuvarla {
            font-size: 13px;
    border-radius: 50%;
    color: white;
    width: 25px;
    height: 25px;
    background-color: #4099ff;


    font-size: 14px;
    padding: 4px;
    margin-right: 10px;
    color: #fff;
    border-radius: 4px;
    width: 30px;
    display: inline-block;
    height: 30px;
    text-align: center;


        }
        .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active i {
    color: #fff!important;
}
            .yuvarla i {
                
                font-family: 'themify';
    speak: none;
    font-style: normal;
    font-weight: normal;
    font-variant: normal;
    text-transform: none;
    line-height: 1;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
            }
    </style>
    <div class="row">
        <div class="col-lg-12">
            <!-- tab header start -->
            <div class="tab-header card">
                <ul class="nav nav-tabs md-tabs tab-timeline" style="border: solid 1px #007bff;" role="tablist" id="mytab">
                    <li class="nav-item">
                        <a class="nav-link active" data-toggle="tab" href="#personel_bilgileri" role="tab"><span class="yuvarla"><i class="icofont icofont-home"></i></span> Taşeron</a>
                        <div class="slide"></div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#giris_cikis" role="tab"><span class="yuvarla" style="background-color:#F88EA4;"><i class="icofont icofont-ui-user "></i></span> Puantaj</a>
                        <div class="slide"></div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#zimmet" role="tab"><span class="yuvarla" style="background-color:#2ed8b6;"><i class="icofont icofont-ui-message"></i></span> Zimmet</a>
                        <div class="slide"></div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#cari_hareketler" role="tab"><span class="yuvarla" style="background-color:#f1c40f;"><i class="icofont icofont-ui-settings"></i></span> Cari Hareketler</a>
                        <div class="slide"></div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#dosyalar" role="tab"><span class="yuvarla" style="background-color:#ab7967;"><i class="icofont icofont-home"></i></span> Dosyalar</a>
                        <div class="slide"></div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#ajanda" onclick='ajanda_calistir();' role="tab"><span class="yuvarla" style="background-color:#39adb5;"><i class="icofont icofont-ui-user "></i></span> Ajanda</a>
                        <div class="slide"></div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#is_listesi_panel" onclick='toplanti_is_listesi_getir(); return false;' role="tab"><span class="yuvarla" style="background-color:#7c4dff;"><i class="icofont icofont-ui-message"></i></span> İş Listesi</a>
                        <div class="slide"></div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#adam_saat_cetveli" role="tab"><span class="yuvarla" style="background-color:#ff5370;"><i class="icofont icofont-ui-settings"></i></span> Adam-Saat</a>
                        <div class="slide"></div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#raporlar" role="tab"><span class="yuvarla" style="background-color:#4099ff;"><i class="icofont icofont-home"></i></span> Raporlar</a>
                        <div class="slide"></div>
                    </li>
                </ul>
            </div>
            <div class="tab-content">
                <div class="tab-pane active" id="personel_bilgileri" role="tabpanel">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-header-text">Taşeron Bilgileri</h5>
                            <button id="edit-btn" type="button" class="btn btn-sm btn-primary waves-effect waves-light f-right">
                                <i class="icofont icofont-edit"></i>
                            </button>
                        </div>
                        <div class="card-block">
                            <div class="view-info">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <form id="taseron_ekle_form" runat="server">
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label">Taşeron Resim</label>
                            <div class="col-sm-12 col-lg-12" style="margin-bottom:15px;">
                                <input type="file" value="/img/buyukboy.png" id="taseron_resim" tip="buyuk" yol="taseron_resim/" class="form-control" />
                            </div>
                        </div>

                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label">Taşeron Firma Adı</label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                        <input type="text" id="taseron_firma_adi" required class="form-control" />
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label">Taşeron Yetkili Kişi</label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                        <input type="text" id="taseron_yetkili_kisi" class="form-control" required />
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label">Şehir</label>
                            <div class="col-sm-12 col-lg-12">
                                <select class="select2">
                                    <option value="0">BURSA</option>
                                </select>
                            </div>
                        </div>

                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label">Taşeron E-Posta</label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                        <input type="email" id="taseron_eposta" class="form-control" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label">Taşeron Telefon</label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                        <input type="text" id="taseron_telefon" class="form-control" required data-mask="0(999) 999 99 99" placeholder="0(532) 123 45 67" />
                                </div>
                            </div>
                        </div>
                    </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="tab-pane" id="giris_cikis" role="tabpanel">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-header-text">Yıllık Giriş Çıkış Raporu</h5>
                            <button id="edit-btn" type="button" class="btn btn-sm btn-primary waves-effect waves-light f-right">
                                <i class="icofont icofont-edit"></i>
                            </button>
                        </div>
                        <div class="card-block">
                            <div class="view-info">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div>
                                        <table class="reserve-list" style="width: 98%;">
                                            <thead>
                                                <tr>
                                                    <th style="width: 100px; text-align:center; background-color: #ff5370; border: solid 1px black; color: White; font-size: 14px;">
                                                        <input type="button" class="btn btn-mini btn-warning" onclick="yillik_yenile(1631, 2016);" style="float:left;" value="<<">&nbsp;2017&nbsp;<input type="button" class="btn btn-mini btn-warning" style="float:right;" onclick="yillik_yenile(1631, 2018);" value=">>">
                                                    </th>
                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">1</th>
                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">2</th>
                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">3</th>
                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">4</th>
                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">5</th>
                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">6</th>
                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">7</th>
                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">8</th>
                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">9</th>
                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">10</th>
                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">11</th>
                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">12</th>
                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">13</th>
                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">14</th>
                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">15</th>
                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">16</th>

                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">17</th>

                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">18</th>

                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">19</th>

                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">20</th>

                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">21</th>

                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">22</th>

                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">23</th>

                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">24</th>

                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">25</th>

                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">26</th>

                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">27</th>

                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">28</th>

                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">29</th>

                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">30</th>

                                                    <th style="text-align: center; background-color: #cccccc; border: solid 1px black;">31</th>

                                                </tr>
                                            </thead>


                                            <tbody>
                                                <tr>
                                                    <td align="center" style="font-weight: bold; height: 25px; background-color: #429aff; vertical-align: middle; border: solid 1px black; text-align: center; color: White;">OCAK</td>

                                                    <td tarih="01.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="02.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="03.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="04.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="05.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="06.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="07.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="08.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="09.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="10.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="11.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="12.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="13.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="14.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="15.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="16.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="17.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="18.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="19.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="20.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="21.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="22.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="23.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="24.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="25.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="26.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="27.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="28.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="29.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="30.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="31.01.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                </tr>


                                                <tr>
                                                    <td align="center" style="font-weight: bold; height: 25px; background-color: #73b4ff; vertical-align: middle; border: solid 1px black; text-align: center; color: White;">ŞUBAT</td>

                                                    <td tarih="01.02.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="02.02.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="03.02.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="04.02.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="05.02.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="06.02.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="07.02.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="08.02.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="09.02.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="10.02.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="11.02.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="12.02.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="13.02.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="14.02.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="15.02.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="16.02.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="17.02.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="18.02.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="19.02.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="20.02.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="21.02.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="22.02.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="23.02.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="24.02.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="25.02.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="26.02.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="27.02.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="28.02.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td style="background-color: Black;" align="center">&nbsp;</td>

                                                    <td style="background-color: Black;" align="center">&nbsp;</td>

                                                    <td style="background-color: Black;" align="center">&nbsp;</td>

                                                </tr>


                                                <tr>
                                                    <td align="center" style="font-weight: bold; height: 25px; background-color: #429aff; vertical-align: middle; border: solid 1px black; text-align: center; color: White;">MART</td>

                                                    <td tarih="01.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="02.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="03.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="04.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="05.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="06.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="07.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="08.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="09.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="10.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="11.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="12.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="13.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="14.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="15.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="16.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="17.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="18.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="19.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="20.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="21.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="22.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="23.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="24.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="25.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="26.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="27.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="28.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="29.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="30.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="31.03.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                </tr>


                                                <tr>
                                                    <td align="center" style="font-weight: bold; height: 25px; background-color: #73b4ff; vertical-align: middle; border: solid 1px black; text-align: center; color: White;">NISAN</td>

                                                    <td tarih="01.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="02.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="03.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="04.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="05.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="06.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="07.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="08.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="09.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="10.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="11.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="12.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="13.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="14.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="15.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="16.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="17.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="18.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="19.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="20.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="21.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="22.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="23.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="24.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="25.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="26.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="27.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="28.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="29.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="30.04.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td style="background-color: Black;" align="center">&nbsp;</td>

                                                </tr>


                                                <tr>
                                                    <td align="center" style="font-weight: bold; height: 25px; background-color: #429aff; vertical-align: middle; border: solid 1px black; text-align: center; color: White;">MAYıS</td>

                                                    <td tarih="01.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="02.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="03.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="04.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="05.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="06.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="07.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="08.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="09.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="10.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="11.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="12.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="13.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="14.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="15.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="16.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="17.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="18.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="19.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="20.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="21.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="22.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="23.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="24.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="25.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="26.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="27.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="28.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="29.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="30.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="31.05.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                </tr>


                                                <tr>
                                                    <td align="center" style="font-weight: bold; height: 25px; background-color: #73b4ff; vertical-align: middle; border: solid 1px black; text-align: center; color: White;">HAZIRAN</td>

                                                    <td tarih="01.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="02.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="03.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="04.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="05.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="06.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="07.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="08.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="09.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="10.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="11.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="12.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="13.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="14.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="15.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="16.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="17.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="18.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="19.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="20.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="21.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="22.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="23.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="24.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="25.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="26.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="27.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="28.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="29.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="30.06.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td style="background-color: Black;" align="center">&nbsp;</td>

                                                </tr>


                                                <tr>
                                                    <td align="center" style="font-weight: bold; height: 25px; background-color: #429aff; vertical-align: middle; border: solid 1px black; text-align: center; color: White;">TEMMUZ</td>

                                                    <td tarih="01.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="02.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="03.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="04.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="05.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="06.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="07.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="08.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="09.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="10.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="11.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="12.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="13.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="14.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="15.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="16.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="17.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="18.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="19.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="20.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="21.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="22.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="23.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="24.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="25.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="26.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="27.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="28.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="29.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="30.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="31.07.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                </tr>


                                                <tr>
                                                    <td align="center" style="font-weight: bold; height: 25px; background-color: #73b4ff; vertical-align: middle; border: solid 1px black; text-align: center; color: White;">AĞUSTOS</td>

                                                    <td tarih="01.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="02.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="03.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="04.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="05.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="06.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="07.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="08.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="09.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="10.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="11.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="12.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="13.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="14.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="15.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="16.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="17.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="18.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="19.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="20.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="21.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="22.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="23.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="24.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="25.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="26.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="27.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="28.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="29.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="30.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="31.08.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                </tr>


                                                <tr>
                                                    <td align="center" style="font-weight: bold; height: 25px; background-color: #429aff; vertical-align: middle; border: solid 1px black; text-align: center; color: White;">EYLÜL</td>

                                                    <td tarih="01.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="02.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="03.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="04.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="05.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="06.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="07.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="08.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="09.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="10.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="11.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="12.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="13.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="14.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="15.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="16.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="17.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="18.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="19.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="20.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="21.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="22.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="23.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="24.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="25.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="26.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="27.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="28.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="29.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="30.09.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td style="background-color: Black;" align="center">&nbsp;</td>

                                                </tr>


                                                <tr>
                                                    <td align="center" style="font-weight: bold; height: 25px; background-color: #73b4ff; vertical-align: middle; border: solid 1px black; text-align: center; color: White;">EKIM</td>

                                                    <td tarih="01.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="02.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="03.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="04.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="05.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="06.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="07.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="08.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="09.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="10.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="11.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="12.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="13.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="14.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="15.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="16.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="17.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="18.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="19.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="20.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="21.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="22.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="23.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="24.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="25.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="26.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="27.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="28.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="29.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="30.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                    <td tarih="31.10.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 " align="center">&nbsp;</td>

                                                </tr>


                                                <tr>
                                                    <td align="center" style="font-weight: bold; height: 25px; background-color: #429aff; vertical-align: middle; border: solid 1px black; text-align: center; color: White;">KASıM</td>

                                                    <td tarih="01.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="02.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="03.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="04.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="05.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="06.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="07.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="08.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="09.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="10.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="11.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="12.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="13.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="14.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_1" align="center">&nbsp;</td>

                                                    <td tarih="15.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_4" align="center">&nbsp;</td>

                                                    <td tarih="16.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_4" align="center">&nbsp;</td>

                                                    <td tarih="17.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_4" align="center">&nbsp;</td>

                                                    <td tarih="18.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_4" align="center">&nbsp;</td>

                                                    <td tarih="19.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_4" align="center">&nbsp;</td>

                                                    <td tarih="20.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_4" align="center">&nbsp;</td>

                                                    <td tarih="21.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_4" align="center">&nbsp;</td>

                                                    <td tarih="22.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_4" align="center">&nbsp;</td>

                                                    <td tarih="23.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_4" align="center">&nbsp;</td>

                                                    <td tarih="24.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_4" align="center">&nbsp;</td>

                                                    <td tarih="25.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_4" align="center">&nbsp;</td>

                                                    <td tarih="26.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_4" align="center">&nbsp;</td>

                                                    <td tarih="27.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_4" align="center">&nbsp;</td>

                                                    <td tarih="28.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_4" align="center">&nbsp;</td>

                                                    <td tarih="29.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_4" align="center">&nbsp;</td>

                                                    <td tarih="30.11.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_4" align="center">&nbsp;</td>

                                                    <td style="background-color: Black;" align="center">&nbsp;</td>

                                                </tr>


                                                <tr>
                                                    <td align="center" style="font-weight: bold; height: 25px; background-color: #73b4ff; vertical-align: middle; border: solid 1px black; text-align: center; color: White;">ARALıK</td>

                                                    <td tarih="01.12.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_4" align="center">&nbsp;</td>

                                                    <td tarih="02.12.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_4" align="center">&nbsp;</td>

                                                    <td tarih="03.12.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_4" align="center">&nbsp;</td>

                                                    <td tarih="04.12.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_4" align="center">&nbsp;</td>

                                                    <td tarih="05.12.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_4" align="center">&nbsp;</td>

                                                    <td tarih="06.12.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_4" align="center">&nbsp;</td>

                                                    <td tarih="07.12.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_3" align="center">&nbsp;</td>

                                                    <td tarih="08.12.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_3" align="center">&nbsp;</td>

                                                    <td tarih="09.12.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_3" align="center">&nbsp;</td>

                                                    <td tarih="10.12.2017" style="border: solid 1px black; width: 3%;" class=" secilemez3 renk2_3" align="center">&nbsp;</td>

                                                    <td tarih="11.12.2017" style="border: solid 2px red; width: 3%;" class=" secilebilir3 renk2_2" align="center">&nbsp;</td>

                                                    <td tarih="12.12.2017" style="border: solid 1px black; width: 3%;" class=" secilebilir3 renk2_2" align="center">&nbsp;</td>

                                                    <td tarih="13.12.2017" style="border: solid 1px black; width: 3%;" class=" secilebilir3 renk2_2" align="center">&nbsp;</td>

                                                    <td tarih="14.12.2017" style="border: solid 1px black; width: 3%;" class=" secilebilir3 renk2_2" align="center">&nbsp;</td>

                                                    <td tarih="15.12.2017" style="border: solid 1px black; width: 3%;" class=" secilebilir3 renk2_2" align="center">&nbsp;</td>

                                                    <td tarih="16.12.2017" style="border: solid 1px black; width: 3%;" class=" secilebilir3 renk2_2" align="center">&nbsp;</td>

                                                    <td tarih="17.12.2017" style="border: solid 1px black; width: 3%;" class=" secilebilir3 renk2_2" align="center">&nbsp;</td>

                                                    <td tarih="18.12.2017" style="border: solid 1px black; width: 3%;" class=" secilebilir3 renk2_2" align="center">&nbsp;</td>

                                                    <td tarih="19.12.2017" style="border: solid 1px black; width: 3%;" class=" secilebilir3 renk2_2" align="center">&nbsp;</td>

                                                    <td tarih="20.12.2017" style="border: solid 1px black; width: 3%;" class=" secilebilir3 renk2_2" align="center">&nbsp;</td>

                                                    <td tarih="21.12.2017" style="border: solid 1px black; width: 3%;" class=" secilebilir3 renk2_2" align="center">&nbsp;</td>

                                                    <td tarih="22.12.2017" style="border: solid 1px black; width: 3%;" class=" secilebilir3 renk2_2" align="center">&nbsp;</td>

                                                    <td tarih="23.12.2017" style="border: solid 1px black; width: 3%;" class=" secilebilir3 renk2_2" align="center">&nbsp;</td>

                                                    <td tarih="24.12.2017" style="border: solid 1px black; width: 3%;" class=" secilebilir3 renk2_2" align="center">&nbsp;</td>

                                                    <td tarih="25.12.2017" style="border: solid 1px black; width: 3%;" class=" secilebilir3 renk2_2" align="center">&nbsp;</td>

                                                    <td tarih="26.12.2017" style="border: solid 1px black; width: 3%;" class=" secilebilir3 renk2_2" align="center">&nbsp;</td>

                                                    <td tarih="27.12.2017" style="border: solid 1px black; width: 3%;" class=" secilebilir3 renk2_2" align="center">&nbsp;</td>

                                                    <td tarih="28.12.2017" style="border: solid 1px black; width: 3%;" class=" secilebilir3 renk2_2" align="center">&nbsp;</td>

                                                    <td tarih="29.12.2017" style="border: solid 1px black; width: 3%;" class=" secilebilir3 " align="center">&nbsp;</td>

                                                    <td tarih="30.12.2017" style="border: solid 1px black; width: 3%;" class=" secilebilir3 " align="center">&nbsp;</td>

                                                    <td tarih="31.12.2017" style="border: solid 1px black; width: 3%;" class=" secilebilir3 " align="center">&nbsp;</td>

                                                </tr>


                                            </tbody>
                                        </table>
                                            <table>
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <div style="border: solid 1px black; width: 39px; height: 28px; background-color: #2ed8b6;"></div>
                                                    </td>
                                                    <td style="vertical-align: middle; padding: 6px;">Zamanında</td>
                                                    <td>
                                                        <div style="border: solid 1px black; width: 39px; height: 28px; background-color: #f1c40f;"></div>
                                                    </td>
                                                    <td style="vertical-align: middle; padding: 6px;">30 Dakika Geç Kaldı</td>
                                                    <td>
                                                        <div style="border: solid 1px black; width: 39px; height: 28px; background-color: #ff5370;"></div>
                                                    </td>
                                                    <td style="vertical-align: middle; padding: 6px;">30 Dakikadan Fazla Geç Kaldı</td>
                                                </tr>
                                            </tbody>
                                        </table>

                                        <style>
                                            .renk2_1 {
                                                background-color: #f2f2f2;
                                            }

                                            .renk2_2 {
                                                background-color: #2ed8b6;
                                            }

                                            .renk2_3 {
                                                background-color: #f1c40f;
                                            }

                                            .renk2_4 {
                                                background-color: #ff5370;
                                            }

                                            .ui-selecting {
                                                background-color: #FECA40 !important;
                                            }
                                        </style><br /><br />
                                        <h5 class="card-header-text">Personel Giriş Çıkış Bilgileri</h5><br />
                                            <table id="dt_basic" class="table table-striped table-bordered table-hover" width="100%">
                                            <thead>
                                                <tr>
                                                    <th style="width: 30px;">ID</th>
                                                    <th>Tarih</th>
                                                    <th>Saat</th>
                                                    <th>Tip</th>
                                                    <th>Durum</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>1</td>
                                                    <td>11 Aralık 2017 Pazartesi</td>
                                                    <td>08:15</td>
                                                    <td>Giriş</td>
                                                    <td><span class="label label-warning">15 Dakika Geç</span></td>
                                                </tr>
                                                <tr>
                                                    <td>2</td>
                                                    <td>11 Aralık 2017 Pazartesi</td>
                                                    <td>18:00</td>
                                                    <td>Çıkış</td>
                                                    <td><span class="label label-success">Zamanında</span></td>
                                                </tr>
                                                <tr>
                                                    <td>2</td>
                                                    <td>12 Aralık 2017 Pazartesi</td>
                                                    <td>18:00</td>
                                                    <td>Giriş</td>
                                                    <td><span class="label label-danger">45 Dakika Geç</span></td>
                                                </tr>
                                                <tr>
                                                    <td>2</td>
                                                    <td>12 Aralık 2017 Pazartesi</td>
                                                    <td>18:00</td>
                                                    <td>Çıkış</td>
                                                    <td><span class="label label-success">Zamanında</span></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        

                                        


                                    </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="tab-pane" id="zimmet" role="tabpanel">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-header-text">Personel Zimmet Listesi</h5>
                            <button id="edit-btn" type="button" class="btn btn-sm btn-primary waves-effect waves-light f-right">
                                <i class="icofont icofont-edit"></i>
                            </button>
                        </div>
                        <div class="card-block">
                            <div class="view-info">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <table id="dt_basic" class="table table-striped table-bordered table-hover" width="100%">
                                            <thead>
                                                <tr>
                                                    <th style="width: 30px;">ID</th>
                                                    <th>Zimmet Edilen</th>
                                                    <th>Zimmet Eden</th>
                                                    <th>Zimmet Zamanı</th>
                                                    <th>İşlem</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>1</td>
                                                    <td>Çekiç</td>
                                                    <td>Salih ŞAHİN</td>
                                                    <td>07.07.2018 10:00</td>
                                                    <td class="dropdown">
                                                                <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-cog" aria-hidden="true"></i></button>
                                                                <div class="dropdown-menu dropdown-menu-right b-none contact-menu">
                                                                    <a class="dropdown-item" href="#!"><i class="icofont icofont-edit"></i>Edit</a>
                                                                    <a class="dropdown-item" href="#!"><i class="icofont icofont-ui-delete"></i>Delete</a>
                                                                    <a class="dropdown-item" href="#!"><i class="icofont icofont-eye-alt"></i>View</a>
                                                                    <a class="dropdown-item" href="#!"><i class="icofont icofont-tasks-alt"></i>Project</a>
                                                                    <a class="dropdown-item" href="#!"><i class="icofont icofont-ui-note"></i>Notes</a>
                                                                    <a class="dropdown-item" href="#!"><i class="icofont icofont-eye-alt"></i>Activity</a>
                                                                    <a class="dropdown-item" href="#!"><i class="icofont icofont-badge"></i>Schedule</a>
                                                                </div>
                                                            </td>
                                                </tr>
                                                <tr>
                                                    <td>2</td>
                                                    <td>Matkap</td>
                                                    <td>Salih ŞAHİN</td>
                                                    <td>07.07.2018 10:00</td>
                                                    <td class="dropdown">
                                                                <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-cog" aria-hidden="true"></i></button>
                                                                <div class="dropdown-menu dropdown-menu-right b-none contact-menu">
                                                                    <a class="dropdown-item" href="#!"><i class="icofont icofont-edit"></i>Edit</a>
                                                                    <a class="dropdown-item" href="#!"><i class="icofont icofont-ui-delete"></i>Delete</a>
                                                                    <a class="dropdown-item" href="#!"><i class="icofont icofont-eye-alt"></i>View</a>
                                                                    <a class="dropdown-item" href="#!"><i class="icofont icofont-tasks-alt"></i>Project</a>
                                                                    <a class="dropdown-item" href="#!"><i class="icofont icofont-ui-note"></i>Notes</a>
                                                                    <a class="dropdown-item" href="#!"><i class="icofont icofont-eye-alt"></i>Activity</a>
                                                                    <a class="dropdown-item" href="#!"><i class="icofont icofont-badge"></i>Schedule</a>
                                                                </div>
                                                            </td>
                                                </tr>
                                                <tr>
                                                    <td>3</td>
                                                    <td>El Arabası</td>
                                                    <td>Salih ŞAHİN</td>
                                                    <td>07.07.2018 10:00</td>
                                                    <td class="dropdown">
                                                                <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-cog" aria-hidden="true"></i></button>
                                                                <div class="dropdown-menu dropdown-menu-right b-none contact-menu">
                                                                    <a class="dropdown-item" href="#!"><i class="icofont icofont-edit"></i>Edit</a>
                                                                    <a class="dropdown-item" href="#!"><i class="icofont icofont-ui-delete"></i>Delete</a>
                                                                    <a class="dropdown-item" href="#!"><i class="icofont icofont-eye-alt"></i>View</a>
                                                                    <a class="dropdown-item" href="#!"><i class="icofont icofont-tasks-alt"></i>Project</a>
                                                                    <a class="dropdown-item" href="#!"><i class="icofont icofont-ui-note"></i>Notes</a>
                                                                    <a class="dropdown-item" href="#!"><i class="icofont icofont-eye-alt"></i>Activity</a>
                                                                    <a class="dropdown-item" href="#!"><i class="icofont icofont-badge"></i>Schedule</a>
                                                                </div>
                                                            </td>
                                                </tr>
                                                <tr>
                                                    <td>4</td>
                                                    <td>Telefon</td>
                                                    <td>Salih ŞAHİN</td>
                                                    <td>07.07.2018 10:00</td>
                                                    <td class="dropdown">
                                                                <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-cog" aria-hidden="true"></i></button>
                                                                <div class="dropdown-menu dropdown-menu-right b-none contact-menu">
                                                                    <a class="dropdown-item" href="#!"><i class="icofont icofont-edit"></i>Edit</a>
                                                                    <a class="dropdown-item" href="#!"><i class="icofont icofont-ui-delete"></i>Delete</a>
                                                                    <a class="dropdown-item" href="#!"><i class="icofont icofont-eye-alt"></i>View</a>
                                                                    <a class="dropdown-item" href="#!"><i class="icofont icofont-tasks-alt"></i>Project</a>
                                                                    <a class="dropdown-item" href="#!"><i class="icofont icofont-ui-note"></i>Notes</a>
                                                                    <a class="dropdown-item" href="#!"><i class="icofont icofont-eye-alt"></i>Activity</a>
                                                                    <a class="dropdown-item" href="#!"><i class="icofont icofont-badge"></i>Schedule</a>
                                                                </div>
                                                            </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="tab-pane" id="cari_hareketler" role="tabpanel">
                    <div class="card">
                <div class="card-header">
                    <h5 style="font-size:20px;">Cari İşlemler Dökümü</h5>
                    <div class="col">
                        <div class="page-header-breadcrumb" style="margin-top:-35px;">
                            <ul class="breadcrumb-title">
                                <li class="breadcrumb-item"><a href="javascript:void(0);" class="btn btn-success btn-round" style="color: white;"><i class="fa fa-money"></i>&nbsp;Tahsilat Ekle</a>
                                </li>
                                <li class="breadcrumb-item"><a href="javascript:void(0);" class="btn btn-danger btn-round" style="color: white;"><i class="fa fa-paper-plane-o"></i>&nbsp;Ödeme Ekle</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="card-block">
                    <div class="dt-responsive table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th style="width: 150px;">İşlem Tarihi</th>
                                    <th>Açıklama</th>
                                    <th style="width: 200px;">Vade Tarihi</th>
                                    <th style="text-align: center; width: 150px;">Borç</th>
                                    <th style="text-align: center; width: 150px;">Alacak</th>
                                    <th style="text-align: center; width:150px; background:linear-gradient(45deg, #4099ff, #73b4ff); "><span class="label label-primary arkaplansiz badge-lg">₺ BAKİYE</span></th>
                                    <th style="text-align: center; width:150px; background:linear-gradient(45deg, #FF5370, #ff869a);"><span class="label label-danger arkaplansiz badge-lg ">$ BAKİYE</span></th>
                                    <th style="text-align: center; width:150px; background:linear-gradient(45deg, #FFB64D, #ffcb80);"><span class="label label-warning arkaplansiz badge-lg">€ BAKİYE</span></th>
                                    <th style="text-align: center; width: 150px;">İşlemler</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for x = 1 to 3 %>
                                <tr>
                                    <td>05 Temmuz 2018</td>
                                    <td>Tahsilat</td>
                                    <td></td>
                                    <td></td>
                                    <td style="text-align: center; border-right: 2px solid #ddd;">200,00 ₺</td>
                                    <td style="text-align: center;">200,00 ₺</td>
                                    <td style="text-align: center;">1.500,00 $</td>
                                    <td style="text-align: center;  border-right: 2px solid #ddd;">3.000,00 €</td>
                                    <td style="text-align: center;">
                                        <div class="btn-group dropdown-split-primary">
                                            <button type="button" class="btn btn-mini btn-primary"><i class="icofont icofont-exchange"></i>İşlemler</button>
                                            <button type="button" class="btn btn-primary btn-mini dropdown-toggle dropdown-toggle-split waves-effect waves-light" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                <span class="sr-only">İşlemler</span>
                                            </button>
                                            <div class="dropdown-menu">
                                                <a class="dropdown-item waves-effect waves-light" href="javascript:void(0);" onclick="">Kaydı Düzenle</a>
                                                <a class="dropdown-item waves-effect waves-light" href="#">Kaydı Sil</a>
                                                <a class="dropdown-item waves-effect waves-light" href="#">Makbuz</a>
                                            </div>
                                        </div>
                                    </td>

                                </tr>
                                <tr>
                                    <td>05 Temmuz 2018</td>
                                    <td>Tahsilat</td>
                                    <td></td>
                                    <td style="text-align: center;">200,00 ₺</td>
                                    <td style="border-right: 2px solid #ddd;"></td>
                                    <td style="text-align: center;">200,00 ₺</td>
                                    <td style="text-align: center;">400,00 $</td>
                                    <td style="text-align: center; border-right: 2px solid #ddd;">-200,00 €</td>
                                    <td style="text-align: center;">
                                        <div style="width: 150px;">
                                            <div class="btn-group dropdown-split-primary">
                                                <button type="button" class="btn btn-mini btn-primary"><i class="icofont icofont-exchange"></i>İşlemler</button>
                                                <button type="button" class="btn btn-primary btn-mini dropdown-toggle dropdown-toggle-split waves-effect waves-light" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                    <span class="sr-only">İşlemler</span>
                                                </button>
                                                <div class="dropdown-menu">
                                                    <a class="dropdown-item waves-effect waves-light" href="javascript:void(0);" onclick="">Kaydı Düzenle</a>
                                                    <a class="dropdown-item waves-effect waves-light" href="#">Kaydı Sil</a>
                                                    <a class="dropdown-item waves-effect waves-light" href="#">Makbuz</a>
                                                </div>
                                            </div>
                                        </div>
                                    </td>

                                </tr>
                                <% next %>
                                <tr>
                                    <td colspan="3" style="border:none;"></td>
                                    <td style="border-top: 2px solid #ddd; text-align:right; padding-right:10px;" colspan="2">TOPLAM ALACAK</td>
                                    <td style="border-top: 2px solid #ddd; text-align: center;">200,00 ₺</td>
                                    <td style="border-top: 2px solid #ddd; text-align: center;">400,00 $</td>
                                    <td style="text-align: center; border-top: 2px solid #ddd;">-200,00 €</td>
                                    <td style="border-top: 2px solid #ddd;"></td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="border:none;"></td>
                                    <td style="border-top: 2px solid #ddd; text-align:right; padding-right:10px;" colspan="2">TOPLAM BORÇ</td>
                                    <td style="border-top: 2px solid #ddd; text-align: center;">200,00 ₺</td>
                                    <td style="border-top: 2px solid #ddd; text-align: center;">400,00 $</td>
                                    <td style="border-top: 2px solid #ddd; text-align: center;">-200,00 €</td>
                                    <td style="border-top: 2px solid #ddd;"></td>

                                </tr>
                                <tr>
                                    <td colspan="3" style="border:none;"></td>
                                    <td style="border-top: 2px solid #ddd; text-align:right; padding-right:10px;" colspan="2">BAKİYE</td>
                                    <td style="border-top: 2px solid #ddd; text-align: center;">200,00 ₺</td>
                                    <td style="border-top: 2px solid #ddd; text-align: center;">400,00 $</td>
                                    <td style="border-top: 2px solid #ddd; text-align: center;">-200,00 €</td>
                                    <td style="border-top: 2px solid #ddd;"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
                </div>

                <div class="tab-pane" id="dosyalar" role="tabpanel">
                    <div class="card">
                        
                        <div class="card-block">
                            <div class="view-info">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="row"><br>
                            <div class="col-md-3">
                            <h4>Dosya Ekle</h4><br>
                                <div id="upload48"><table border="0" cellspacing="0" cellpadding="0"><tbody><tr><td><div style="width:28px; height:28px; border:solid 1px #dddddd; margin-right:1px; background-color:White; float:left;"><img id="uploadresim48" style="width:28px; height:28px;" "="" class="resim" src="/img/kucukboy.png"></div></td><td><input class="file fileupload" placeholder="Yeni Dosya Yükle" style="display: inline; color: rgb(102, 102, 102); font-size: 11px; width: 142px; height: 25px;"><div class="filebtn" style="width: 190px; height: 30px; background: url(&quot;/img/addFiles.png&quot;) right center no-repeat; display: inline; position: absolute; margin-left: -152px; margin-top: 1px;"><input type="file" iid="48" id="uploadsrc48" tip="kucuk" yol="dosya_deposu/" style="height: 30px; position: absolute; width: 170px; margin-left: 5px; display: inline; cursor: pointer; opacity: 0;" class="fileupload" yapildi="true"></div><input type="hidden" resimurl="48" name="dosya_yolu409" id="dosya_yolu409" value="/img/kucukboy.png"></td></tr></tbody></table></div>
                            <br>
                                Dosya Adı:<br>
                                <input name="dosya_adi409" type="text" id="dosya_adi409"><br>
                                <br>
                                <input type="submit" name="dosya_kaydet_buton" value="Kaydet" onclick="yeni_is_dosya_ekle('409'); return false;" id="dosya_kaydet_buton" class="btn btn-success"><br>
                            
                                </div>
                                <div class="col-md-8"><h4>Dosya Listesi</h4><br>
                                    <div class="table-responsive">
										
                                        <div id="dosya_listesi409"><form method="post" action="./islem1.aspx" id="form1" class="smart-form validateform">
<div class="aspNetHidden">
<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="AR4kulfeBN1AdxAd+9t9xFv5FTMJm+4+GQOTHE9YskiFC4cs9HDzY49hETkTp/r2bVgDkk67kUZBpeeiKCznyiEofRTiLme/pDlcbcTLD4w=">
</div>


    

    
    <div id="dosya_listesi_panel">
	
        <div id="dosya_yok_panel">
		
                    </div><table class="table table-bordered">
			<thead>
				<tr>
					<th style="width:20px; text-align:center;">ID</th>
					<th>Dosya Adı</th>
					<th>Ekleme Tarihi</th>
					<th>Ekleme Saati</th>
                    <th>Ekleyen</th>
                    <th>İşlem</th>
				</tr>
			</thead>
			<tbody>
                <tr>
                        <td colspan="6" style="text-align:center;">Kayıt Yok</td>
                    </tr>
                
	
                								
			</tbody>
		</table>

    
</div>
    
    

    

    
    
    

    

    


    
    

    <script>
        $(function () {
            setTimeout(function () { $("#olay").focus();  }, 1500);
            autosize($("#olay"));
        });
    </script>
    

    


    

    

    



    

    

    
    



</form>
</div>
											
											
										</div>
                                    </div>
                                </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="tab-pane" id="ajanda" role="tabpanel">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-header-text">İş Listesi</h5>
                            <button id="edit-btn" type="button" class="btn btn-sm btn-primary waves-effect waves-light f-right">
                                <i class="icofont icofont-edit"></i>
                            </button>
                        </div>
                        <div class="card-block">
                            <div class="view-info">
                                <div class="row">
                                    <div class="col-lg-12">
                                       <link rel="stylesheet" type="text/css" href="/files/bower_components/fullcalendar/css/fullcalendar.css">
    <link rel="stylesheet" type="text/css" href="/files/bower_components/fullcalendar/css/fullcalendar.print.css" media='print'>
    <div class=" full-calender">
        

        <div class="page-body">
            <div class="card">
                <div class="card-block">
                    <div class="row">
                        <div class="col-xl-2 col-md-12">
                            <div id="external-events">
                                <h6 class="m-b-30 m-t-20">Olaylar</h6>
                                <div class="fc-event ui-draggable ui-draggable-handle">Olay 1</div>
                                <div class="fc-event ui-draggable ui-draggable-handle">Olay 2</div>
                                <div class="fc-event ui-draggable ui-draggable-handle">Olay 3</div>
                                <div class="fc-event ui-draggable ui-draggable-handle">Olay 4</div>
                                <div class="fc-event ui-draggable ui-draggable-handle">Olay 5</div>
                                <div class="checkbox-fade fade-in-primary m-t-10" style="display:none;">
                                    <label>
                                        <input type="checkbox" value="">
                                        <span class="cr">
                                            <i class="cr-icon icofont icofont-ui-check txt-primary"></i>
                                        </span>
                                        <span>Remove After Drop</span>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-10 col-md-12">
                            <div id='calendar'></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="page-error" style="display:none;">
            <div class="card text-center">
                <div class="card-block">
                    <div class="m-t-10">
                        <i class="icofont icofont-warning text-white bg-c-yellow"></i>
                        <h4 class="f-w-600 m-t-25">Not supported</h4>
                        <p class="text-muted m-b-0">Full Calender not supported in this device</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- calender js -->
    <script src="/files/bower_components/moment/js/moment.min.js"></script>
    <script src="/files/bower_components/fullcalendar/js/fullcalendar.min.js"></script>
    <!-- Custom js -->
    <script src="/files/assets/pages/full-calender/calendar.js"></script>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                      
                </div>
                <div class="tab-pane" id="is_listesi_panel" role="tabpanel">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-header-text">İş Listesi</h5>
                            <button id="edit-btn" type="button" class="btn btn-sm btn-primary waves-effect waves-light f-right">
                                <i class="icofont icofont-edit"></i>
                            </button>
                        </div>
                        <div class="card-block">
                            <div class="view-info">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div id="tum_isler_loading">
                                            <br><table style=" width:100%; height:100%;"><tr><td style=" text-align:center; vertical-align:middle;"><div class="cell preloader5 loader-block"><div class="circle-5 l"></div><div class="circle-5 m"></div><div class="circle-5 r"></div></div></td></td></table>
                                        </div>
                                        <div id="tum_isler">
                                           
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="tab-pane" id="adam_saat_cetveli" role="tabpanel">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-header-text">Adam Saat Cetveli</h5>
                            <button id="edit-btn" type="button" class="btn btn-sm btn-primary waves-effect waves-light f-right">
                                <i class="icofont icofont-edit"></i>
                            </button>
                        </div>
                        <div class="card-block">
                            <div class="view-info">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div id="visualization">
                <div class="visualizationmenu">
                    <div class="btn-group " role="group" data-toggle="tooltip" data-placement="top" title="" data-original-title=".btn-xlg">
                        <button type="button" id="zoomIn" class="btn btn-primary btn-mini waves-effect waves-light">+</button>
                        <button type="button" id="zoomOut" class="btn btn-primary btn-mini waves-effect waves-light">-</button>
                        <button type="button" id="moveLeft" class="btn btn-primary btn-mini waves-effect waves-light"><</button>
                        <button type="button" id="moveRight" class="btn btn-primary btn-mini waves-effect waves-light">></button>
                    </div>
                </div>
            </div>
            <script>
                var timeline;
                $(function (){

                    /*
                    var items = new vis.DataSet({
                        type: { start: 'ISODate', end: 'ISODate' }
                    });

                    items.add([
                      {id: 1, content: 'item 1<br>start', start: '2018-01-23'},
                      {id: 2, content: 'item 2', start: '2018-01-18'},
                      {id: 3, content: 'item 3', start: '2018-01-21'},
                      {id: 4, content: 'item 4', start: '2018-01-19', end: '2018-01-24'},
                      {id: 5, content: 'item 5', start: '2018-01-28', type:'point'},
                      {id: 6, content: 'item 6', start: '2018-01-26'}
                    ]);

                    var container = document.getElementById('visualization');
                    var options = {
                        start: '2018-01-10',
                        end: '2018-02-10',
                        editable: true,
                        showCurrentTime: true
                    };

                    var timeline = new vis.Timeline(container, items, options);*/

                    var count = 1000;

                    // create groups
                    /*
                    var groups = new vis.DataSet([
                        {id: 1, content: 'Soğutma'},
                      {id: 2, content: 'Yangın Tesisatı'},
                      {id: 3, content: 'Mekanik Tesisat'},
                      {id: 4, content: 'Proje'},
                      {id: 5, content: 'Havalandırma',  nestedGroups: [7,8,9]},
                      {id: 6, content: 'Isıtma', nestedGroups: [10,11]},
                      
                    ]);

                                        
                    groups.add([
                    {
                        id: 7,
                        content: "Mutfak Havalandırma",
                    },
                    {
                        id: 8,
                        content: "Banyo Havalandırma",
                    },
                    {
                        id: 9,
                        content: "Turbo Havalandırma",
                    },
                    {
                        id: 10,
                        content: "Yerden Isıtma",
                    },
                    {
                        id: 11,
                        content: "Havadan Isıtma",
                    }
                    ]);*/

                    
                    var groups = new vis.DataSet([
                           {id: 1, content: 'Havalandırma'},
                           {id: 2, content: 'Isıtma'},
                    ]);



                          

                    // create items
                    var items = new vis.DataSet();

                    var types = [ 'box', 'point', 'range', 'background'];
                    types = [ 'range', 'range', 'range', 'range'];
                    var className = [ 'primarykutu', 'inversekutu', 'dangerkutu', 'infokutu', 'warningkutu', 'successkutu'];

                    var order = 1;
                    var truck = 1;
                    for (var j = 0; j < groups.length; j++) {
                        var date = new Date();
                        for (var i = 0; i < count/groups.length; i++) {
                            date.setHours(date.getHours() +  4 * (Math.random() < 0.2));
                            var start = new Date(date);
                            date.setHours(date.getHours() + 2 + Math.floor(Math.random()*4));
                            var end = new Date(date);


                            var type = types[Math.floor(4 * Math.random())];
                            var kutu = className[Math.floor(6 * Math.random())]

                            kutu = className[0];

                            if (j%11==0) {
                                kutu = className[1];
                            }

                            if (j%10==0) {
                                kutu = className[2];
                            }

                            if (j%9==0) {
                                kutu = className[3];
                            }
                            if (j%8==0) {
                                kutu = className[4];
                            }
                            if (j%7==0) {
                                kutu = className[5];
                            }
                            if (j%6==0) {
                                kutu = className[1];
                            }
                            

                            items.add({
                                id: order,
                                group: truck,
                                start: start,
                                end: end,
                                type: type,
                                content: 'Yapılacak İş ' + order,
                                editable: true,
                                stack: true,
                                stackSubgroups: true,
                                className: kutu
                            });

                            order++;
                        }
                        truck++;
                    }

                    var yukseklik = (groups.length)*75;
                    if (yukseklik<250) {
                        yukseklik = 250;
                    }

                    if (yukseklik>400) {
                        yukseklik=400;
                    }
                    
                    // specify options
                    var options = {
                        stack: true,
                        maxHeight: 400,
                        height:yukseklik,
                        orientation: 'top',
                        start: new Date(),
                        end: new Date(1000*60*60*24 + (new Date()).valueOf()),
                        // end: new Date().addDays(80),
                        editable: {
                            add: true,
                            updateTime: true,
                            updateGroup: true,
                            remove: true
                        },
                        showCurrentTime: true,
                        margin: {
                            item: 3, // minimal margin between items
                            axis: 3   // minimal margin between items and the axis
                        }
                    };


                    // create a Timeline
                    var container = document.getElementById('visualization');
                    timeline = new vis.Timeline(container, null, options);
                    timeline.setGroups(groups);
                    timeline.setItems(items);

                    $("#zoomIn").on("click", function (){
                        timeline.zoomIn( 0.2);
                    });
                    $("#zoomOut").on("click", function (){
                        timeline.zoomOut( 0.2);
                    });

                    $("#moveLeft").on("click", function (){
                        move( 0.2);
                    });

                    $("#moveRight").on("click", function (){
                        move(-0.2);
                    });

                    $("#toggleRollingMode").on("click", function (){
                        timeline.toggleRollingMode();
                    });

                    function move (percentage) {
                        var range = timeline.getWindow();
                        var interval = range.end - range.start;

                        timeline.setWindow({
                            start: range.start.valueOf() - interval * percentage,
                            end:   range.end.valueOf()   - interval * percentage
                        });
                    }

                    /*
                    document.getElementById('zoomIn').onclick    = function () { timeline.zoomIn( 0.2); };
                    document.getElementById('zoomOut').onclick   = function () { timeline.zoomOut( 0.2); };
                    document.getElementById('moveLeft').onclick  = function () { move( 0.2); };
                    document.getElementById('moveRight').onclick = function () { move(-0.2); };
                    document.getElementById('toggleRollingMode').onclick = function () { timeline.toggleRollingMode() };*/

                    setTimeout(function () {
                        timeline.setOptions({
                            locale: "tr"
                        });
                    }, 200);
                });

                Date.prototype.addDays = function(days) {
                    var date = new Date(this.valueOf());
                    date.setDate(date.getDate() + days);
                    return date;
                }


            </script>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="tab-pane" id="raporlar" role="tabpanel">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-header-text">Raporlar</h5>
                            <button id="edit-btn" type="button" class="btn btn-sm btn-primary waves-effect waves-light f-right">
                                <i class="icofont icofont-edit"></i>
                            </button>
                        </div>
                        <div class="card-block">
                            <div class="view-info">
                                <div class="row">
                                    <div class="col-lg-12">
                                         <div class="row">
                                            <div class="col-xl-8">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <h5>Line chart</h5>
                                                        <span>lorem ipsum dolor sit amet, consectetur adipisicing elit</span>
                                                    </div>
                                                    <div class="card-block">
                                                        <div id="main" style="height:300px"></div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xl-4">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <h5>Pie chart</h5>
                                                        <span>lorem ipsum dolor sit amet, consectetur adipisicing elit</span>
                                                    </div>
                                                    <div class="card-block">
                                                        <div id="pie-chart" style="height:300px"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xl-8">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <h5>Bar chart</h5>
                                                        <span>lorem ipsum dolor sit amet, consectetur adipisicing elit</span>
                                                    </div>
                                                    <div class="card-block">
                                                        <div id="bar_chart" style="height:300px"></div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xl-4">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <h5>Server load</h5>
                                                        <span>lorem ipsum dolor sit amet, consectetur adipisicing elit</span>
                                                    </div>
                                                    <div class="card-block">
                                                        <div id="server-load" style="height:300px"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <h5>Scatter chart</h5>
                                                        <span>lorem ipsum dolor sit amet, consectetur adipisicing elit</span>
                                                    </div>
                                                    <div class="card-block">
                                                        <div id="scatter" style="height:300px"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <script src="/files/assets/pages/chart/echarts/js/echarts-all.js" ></script>
                                    <script  src="/files/assets/pages/chart/echarts/echart-custom.js"></script>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
