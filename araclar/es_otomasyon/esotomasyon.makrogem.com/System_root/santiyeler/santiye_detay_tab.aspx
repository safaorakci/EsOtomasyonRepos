<%@ Page Language="C#" AutoEventWireup="true" CodeFile="santiye_detay_tab.aspx.cs" Inherits="System_root_santiyeler_santiye_detay_tab" %>
<form autocomplete="off" id="form1" runat="server">
    <asp:hiddenfield id="hproje_id" runat="server"></asp:hiddenfield>
    <asp:hiddenfield id="hdepartman_id" runat="server"></asp:hiddenfield>
    <asp:hiddenfield id="htab_id" runat="server"></asp:hiddenfield>
    <style>

        ul.accordion {
          list-style: none;
        }

        #birnumara {
            display:none;
        }
        input.accordion {
          position: absolute;
          top: -9999px;
          left: -9999px;
        }

        label.accordion {
          display: block;
          height: 1000px;
          width: 30px;
          background: #f1f1f1;
          text-align: center;
          font: 14px/50px Helvetica, Verdana, sans-serif;
          margin-bottom: 10px;
          float: left;
          overflow: hidden;

          -webkit-transition: width 1s ease, background 0.5s ease;
          -moz-transition: width 1s ease, background 0.5s ease;
          -o-transition: width 1s ease, background 0.5s ease;
          -ms-transition: width 1s ease, background 0.5s ease;
          transition: width 1s ease, background 0.5s ease;
          border: solid 1px #55606e;
        }

        #rad2 + label {
          background: #f1f1f1;

          -webkit-transition: width 1s ease, background 0.5s ease;
          -moz-transition: width 1s ease, background 0.5s ease;
          -o-transition: width 1s ease, background 0.5s ease;
          -ms-transition: width 1s ease, background 0.5s ease;
          transition: width 1s ease, background 0.5s ease;

        }

        label.accordion:hover, #rad2 + label.accordion:hover {
          background: #4099ff;
          color: #fff;
          cursor: pointer;
        }

        /*SLIDES*/
        .accslide {
          color: #333;
          display: block;
          height: 1000px;
          width: 0px;
          background: #fff;
          font: 12px/1.5 Helvetica, Verdana, sans-serif;
          padding: 10px 0;
          float: left;
          overflow: hidden;

          -webkit-transition: all 1s ease;
          -moz-transition: all 1s ease;
          -o-transition: all 1s ease;
          -ms-transition: all 1s ease;
          transition: all 1s ease;
          border: solid 1px #55606e;
          overflow-y:scroll;
        }

        
        input.accordion[type="radio"]:checked+label ~ .accslide {
          width: 88%;
        }

        @media screen and (min-width:1300px) {
            input.accordion[type="radio"]:checked+label ~ .accslide {
              width: 94%;
            }

        }

        @media screen and (max-width:767px) {
           
            .accslide {
          color: #333;
          display: block;
          height: 1000px;
          width: 0px;
          background: #fff;
          font: 12px/1.5 Helvetica, Verdana, sans-serif;
          padding: 5px 0;
          float: left;
          overflow: hidden;

          -webkit-transition: all 1s ease;
          -moz-transition: all 1s ease;
          -o-transition: all 1s ease;
          -ms-transition: all 1s ease;
          transition: all 1s ease;
          border: solid 1px #55606e;
          overflow-y:scroll;
        }

        .boyutlandirilacak {
            padding-left:5px!important;
            padding-right:5px!important;
        }

        input.accordion[type="radio"]:checked+label ~ .accslide {
          width: 78%;
        }

        }
        .accslide p, h2, img {
          width: 100%;
          padding-left: 10px;
        }

        .accslide img {
          margin-top: 10px;
        }

        .vertical1 {
            -ms-transform: rotate(270deg);
            -moz-transform: rotate(270deg);
            -webkit-transform: rotate(270deg);
            transform: rotate(90deg);
            margin-left: 14px;
            margin-top: 65px;
            width: 3px;
            font-size: 20px;
            margin-top:-9px;
        }

        
        .vertical2 {

         -ms-transform: rotate(270deg);
        -moz-transform: rotate(270deg);
        -webkit-transform: rotate(270deg);
        transform: rotate(90deg);
        
        margin-left: 14px;
        margin-top: -6px;
        width: 3px;
        font-size: 20px;

        }


    </style>
    <div class="row" style=" padding-top: 50px; padding-left: 0;  padding-right: 0;  ">
        <div class="col-sm-12">
        <ul class="accordion">
            <li>
            <input class="accordion" checked id="rad1" type="radio" name="rad">
            <label class="accordion" for="rad1"><div class="vertical1"><% Response.Write(LNG("OlayÇizelgesi")); %></div></label>
            <div class="accslide">
                <div class="boyutlandirilacak" style="padding-left:15px; padding-right:15px;">
        <h5 style="font-size:15px;"><% Response.Write(LNG("Olay Çizelgesi")); %><a style="float: right; margin-right:10px; color:white;" onclick="yeni_olay_ekle('<%Response.Write(Request.Form["proje_id"]); %>','<%Response.Write(Request.Form["departman_id"]); %>','<%Response.Write(Request.Form["tab_id"]); %>');" href="javascript:void(0);" class="btn btn-mini btn-grd-success btn-round"> <span class="btn-label "><i class="glyphicon glyphicon-ok"></i></span><% Response.Write(LNG("Olay Ekle")); %> </a></h5>
        <div class="z-depth-top-1" style="padding: 10px; margin-top: 20px;">
            <asp:panel id="olay_yok_panel" runat="server">
                <ItemTemplate>
                    <center><br /><br /><i style="font-size:50px; color:#f53232;" class="fa fa-flag"></i><br /><br /><% Response.Write(LNG("Proje Olay Kaydı Bulunamadı")); %></center>
                </ItemTemplate>
            </asp:panel>
            <div class="tree">
                <asp:repeater id="ay_repeater" runat="server">
                        <ItemTemplate>
                <ul>
                    <li><span class="label label-inverse-info" style="   
    color: white;
    font-weight: bold;"><i class="fa fa-lg fa-calendar"></i>&nbsp;&nbsp;<%# DataBinder.Eval(Container.DataItem, "ay_baslik") %></span>
                <ul>
                    <asp:repeater id="hafta_repeater" runat="server">
                        <ItemTemplate>
                            <li>
                                <span class="label label-inverse-danger" style=" color: #325071!important; font-weight: bold;"><i class="fa fa-lg fa-calendar-o	"></i>&nbsp;&nbsp;<%# DataBinder.Eval(Container.DataItem, "baslik") %></span>
                                <ul>
                                    <asp:repeater id="gun_repeater" runat="server">
                                        <ItemTemplate>
                                            <li>
                                                <span class="label label-inverse-primary" style="color:#32506d !important;"><i class="fa fa-lg fa-minus-circle"></i>&nbsp;&nbsp;<%# DataBinder.Eval(Container.DataItem, "gun_adi") %></span>
                                                <ul>
                                                    <asp:repeater id="olay_repeater" runat="server">
                                                        <ItemTemplate>
                                                            <li>
                                                                <span class="label label-inverse-primary"><i class="fa fa-clock-o"></i>&nbsp;<%# DataBinder.Eval(Container.DataItem, "saat") %></span> &ndash;<a href="javascript:void(0);" onclick="olay_duzenle('<%# DataBinder.Eval(Container.DataItem, "proje_id") %>', '<%# DataBinder.Eval(Container.DataItem, "departman_id") %>', '<%# DataBinder.Eval(Container.DataItem, "tab_id") %>', '<%# DataBinder.Eval(Container.DataItem, "olay_id") %>', '<%# DataBinder.Eval(Container.DataItem, "ekleyen_id") %>');"><span class="project-members" style="border:none; margin-top:-30px; font-size:13px;">
                                                    <span rel="tooltip" data-html="true" data-original-title="<img src='<%# DataBinder.Eval(Container.DataItem, "resim") %>' alt='me' class='online' style='width:75px;'><br><%# DataBinder.Eval(Container.DataItem, "ekleyen") %>" data-placement="top" href="javascript:void(0)" style="border:none;"><img src="<%# DataBinder.Eval(Container.DataItem, "resim") %>" class="online" style="width:30px; height:30px; padding:0;"></span>&nbsp;
                                     
                                                </span><x style="font-size:13px;"><%# DataBinder.Eval(Container.DataItem, "olaystr") %></x></a>
                                                            </li>
                                                        </ItemTemplate>
                                                    </asp:repeater>
                                                </ul>
                                            </li>
                                        </ItemTemplate>
                                    </asp:repeater>

                                </ul>
                            </li>
                        </ItemTemplate>
                    </asp:repeater>
                </ul>
                        </li>
                </ul>
 </ItemTemplate>
                    </asp:repeater>
            </div>
        </div>
    </div>
            </div>
            </li>
            <li>
            <input class="accordion" id="rad2" type="radio" name="rad">
            <label class="accordion" for="rad2"><div class="vertical2"><% Response.Write(LNG("İşListesi")); %></div></label>
            <div class="accslide">
                <div class="boyutlandirilacak" style=" min-height:500px; padding-left:15px; padding-right:15px;">
       
        <div style="float: right; margin-right: 15px;">
                    <a href="javascript:void(0);" onclick="yeni_is_ekle('<%Response.Write(Request.Form["proje_id"]); %>', '<%Response.Write(Request.Form["departman_id"]); %>');" class="btn btn-mini btn-round btn-labeled btn-success"><span class="btn-label" style="color: white;"><i class="fa  fa-cube"></i></span>&nbsp;<% Response.Write(LNG("Yeni İş Ekle")); %> </a>
                </div><h5 style="font-size:15px;"><% Response.Write(LNG("İş Listesi")); %></h5>
        
        <div id="is_listesi">
            <script>
                $(function () {
                    is_listesi();

                    $(".boyutlandirilacak").css("min-width", $("#ortadiv").outerWidth()-200);

                });
            </script>
        </div>
    </div>
            </div>
            </li>
        </ul>  
            </div>
    </div>
</form>