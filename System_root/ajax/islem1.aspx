<%@ Page Language="C#" AutoEventWireup="true" CodeFile="islem1.aspx.cs" EnableViewState="false" Inherits="System_root_ajax_islem1" %>

<form autocomplete="off" id="form1" class="smart-form validateform" runat="server">

    <asp:panel id="yeni_santiye_ekle_panel" runat="server">

        <div class="modal-header">
            <% Response.Write(LNG("Proje Ekle")); %>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
            </div>
        <div id="proje_ekle_form"  runat="server" class="smart-form validateform" style="padding:15px;">

                        <div class="row">
                            <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Firma :")); %></label>
                            <div class="col-sm-10">
                                <asp:dropdownlist ID="firma_id" class="js-example-basic-multiple" name="states[]" multiple="multiple" runat="server"></asp:dropdownlist>
                            </div>
                            <div class="col-sm-2">
                                <a href="javascript:void(0);" onclick="javascript:$('.close').click();sayfagetir('/firma_yonetimi/','jsid=4559');"><i class="fa fa-plus-square"></i> <% Response.Write(LNG("Yeni")); %></a>
                            </div>
                        </div>

                        <div class="row">
                            <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Proje Durum :")); %></label>
                            <div class="col-sm-12">
                                <asp:dropdownlist ID="santiye_durum_id" class="js-example-basic-multiple" name="states[]" multiple="multiple" runat="server"></asp:dropdownlist>
                            </div>
                        </div>
            
                        <div class="row">
                            <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Proje Adı :")); %></label>
                            <div class="col-sm-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" id="proje_adi" class="form-control" required />
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Proje Departmanları :")); %></label>
                            <div class="col-sm-12">
                                <asp:ListBox ID="proje_departmanlari" runat="server"></asp:ListBox>
                            </div>
                        </div>

            
                        <div class="row" style="display:none;">
                            <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Enlem :")); %></label>
                            <div class="col-sm-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" id="enlem" class="form-control" />
                                </div>
                            </div>
                        </div>
            
                        <div class="row" style="display:none;">
                            <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Enlem :")); %></label>
                            <div class="col-sm-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" id="boylam" class="form-control" />
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Üretim Şablonu :")); %></label>
                            <div class="col-sm-12">
                                <asp:dropdownlist ID="uretim_sablon_id" class="form-control select2" runat="server"></asp:dropdownlist>
                            </div>
                        </div>


                        <div class="row" style="display:none;">
                            <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Supervisor :")); %></label>
                            <div class="col-sm-12">
                                <asp:dropdownlist ID="firma_supervisor_id" class="form-control select2" runat="server"></asp:dropdownlist>
                            </div>
                        </div>
            <div class="modal-footer">
                    <input type="button" onclick="proje_ekle();" class="btn btn-primary" value="<% Response.Write(LNG("Proje Ekle")); %>" />

                </div>
                            
                        </div>
    </asp:panel>

    <asp:panel id="tablo_customize_panel" runat="server">

    </asp:panel>
    <asp:panel id="dosya_listesi_panel" runat="server">
        <table class="table table-bordered">
			<thead>
				<tr>
					<th style="width:20px; text-align:center;">ID</th>
					<th><% Response.Write(LNG("Dosya Adı")); %></th>
					<th><% Response.Write(LNG("Ekleme Tarihi")); %></th>
					<th><% Response.Write(LNG("Ekleme Saati")); %></th>
                    <th><% Response.Write(LNG("Ekleyen")); %></th>
                    <th><% Response.Write(LNG("İşlem")); %></th>
				</tr>
			</thead>
			<tbody>
                <asp:panel id="dosya_yok_panel" runat="server">
                    <tr>
                        <td colspan="6" style="text-align:center;"><% Response.Write(LNG("Kayıt Yok")); %></td>
                    </tr>
                </asp:panel>
                <asp:panel id="dosya_var_panel" runat="server">
                    <asp:Repeater ID="dosya_repeater" runat="server">
                        <ItemTemplate>
				            <tr>
					            <td style="text-align:center;"><%# DataBinder.Eval(Container.DataItem, "id") %></td>
					            <td><%# DataBinder.Eval(Container.DataItem, "dosya_adi") %></td>
					            <td><%# DataBinder.Eval(Container.DataItem, "ekleme_tarihi") %></td>
					            <td><%# DataBinder.Eval(Container.DataItem, "ekleme_saati") %></td>
                                <td><%# DataBinder.Eval(Container.DataItem, "personel_adsoyad") %></td>
					            <td><a class="btn btn-primary btn-xs" onclick="yeni_is_dosyasi_indir('<%# DataBinder.Eval(Container.DataItem, "id") %>');" href="javascript:void(0);"><% Response.Write(LNG("İndir")); %></a>&nbsp;&nbsp;<a class="btn btn-danger btn-xs" onclick="dosya_listesi_sil('<%# DataBinder.Eval(Container.DataItem, "id") %>', '<%# DataBinder.Eval(Container.DataItem, "is_id") %>');" href="javascript:void(0);"><% Response.Write(LNG("Sil")); %></a></td>
				            </tr>
                        </ItemTemplate>
                </asp:Repeater>
				</asp:panel>								
			</tbody>
		</table>

    </asp:panel>
    <asp:panel id="kurlar_panel" runat="server">
        <asp:HiddenField ID="dolar_gelen" runat="server"></asp:HiddenField>
        <asp:HiddenField ID="euro_gelen" runat="server"></asp:HiddenField>
    </asp:panel>
    <asp:panel id="is_kaydini_duzenle_panel" runat="server">
         <script>
             $(function () {
                 setTimeout(function () { $("#dyeni_is_adi").focus() }, 1500);
                 autosize($("#dyeni_is_adi"));
             });

             $(function () {

                 $("#dyeni_is_departmanlar").attr("size", "1");

                 $("select#dyeni_is_departmanlar option[optiongroup='Departmanlar']").wrapAll("<optgroup label='Departmanlar'>");
                 $("select#dyeni_is_departmanlar option[optiongroup='Firmalar']").wrapAll("<optgroup label='Firmalar'>");
                 $("select#dyeni_is_departmanlar option[optiongroup='Projeler']").wrapAll("<optgroup label='Projeler'>");
                 $("select#dyeni_is_departmanlar option[optiongroup='Toplantılar']").wrapAll("<optgroup label='Toplantılar'>");

                 $("select#dyeni_is_departmanlar option").each(function () {
                     if ($(this).text() == "") {
                         $(this).remove();
                     }
                 });

             });
        </script>

         <div class="modal-header"> 
             
             <h4 class="modal-title"><% Response.Write(LNG("İş Düzenle")); %></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
            </div>
            <div class="modal-body">
            <div id="dyeni_is_ekle_form">
                        <div class="row">
                            
                            <div class="col-sm-12">
                                <label class=" col-form-label"><% Response.Write(LNG("Yapılacak İş")); %></label>
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-cubes"></i>
                                    </span>
                                    <asp:TextBox ID="dyeni_is_adi" style="width: 93%; padding-left: 5px; padding-top: 6px;" required runat="server"></asp:TextBox>
                                </div>
                            </div>

                             <div style="display:none">
                                <label class="col-sm-12 col-form-label" style="padding-left:0;"><% Response.Write(LNG("Renk")); %></label>
                                <!--<input type="hidden" id="renk" class="demo" value="#FC6180">-->
                                 <asp:TextBox id="renk" runat="server"></asp:TextBox>
                            </div>
                              <script>
                                  $(function () {
                                      $("#renk").spectrum({
                                          color: $(this).val(),
                                          showPaletteOnly: true,
                                          showPalette: true,
                                          hideAfterPaletteSelect: true,
                                          change: function (color) {
                                              $(this).val(color);
                                          },
                                          palette: [
                                              ["rgb(231, 76, 60)", "rgb(26, 188, 156)", "rgb(46, 204, 113)", "rgb(52, 152, 219)", "rgb(241, 196, 15)", "rgb(52, 73, 94)"]
                                          ]
                                      });

                                      dis_ekle_yeni_takvim_calistir();
                                  })
                                </script>
                        </div>

                        <div class="row">
                            <div class="col-sm-12">
                                <label class="col-form-label"><% Response.Write(LNG("İş Tipi")); %></label>
                                <div class="">
                                    <asp:ListBox ID="dis_tipi" class="select2" runat="server"></asp:ListBox>
                                </div>
                            </div>
                        </div>

                        <div class="row" style="display:none;">
                            <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Açıklama")); %></label>
                            <div class="col-sm-12">
                               <asp:TextBox ID="dyeni_is_aciklama" Multiline="true" required runat="server" Height="63px" Width="100%" TextMode="MultiLine"></asp:TextBox>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-6">
                                <label class=" col-form-label"><% Response.Write(LNG("Görevliler")); %></label>
                                <div class="">
                                   <asp:ListBox ID="dyeni_is_gorevliler" runat="server"></asp:ListBox>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <label class="col-form-label"><% Response.Write(LNG("Etiketler")); %></label>
                                <div class="">
                                   <asp:ListBox ID="dyeni_is_departmanlar" runat="server"></asp:ListBox>
                                </div>
                            </div>
                        </div>

                
                        <div class="row">
                            <div class="col-sm-12">
                                <label for="is_ajandada_goster2" style="float:left; cursor:pointer; " ><asp:CheckBox runat="server" onclick="is_ajandada_goster_secim2();" id="is_ajandada_goster2"></asp:CheckBox> <% Response.Write(LNG("Ajanda da Göster")); %></label>
                            </div>
                        </div>

                        <div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <label class=" col-form-label"><% Response.Write(LNG("Öncelik")); %></label>
                                    <div>
                                       <asp:ListBox id="dyeni_is_oncelik" class="select2" runat="server"></asp:ListBox>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <label class="col-form-label"><% Response.Write(LNG("Kontrol ve Bildirim")); %></label>
                                    <div>
                                       <asp:ListBox id="dyeni_is_kontrol_bildirim" class="select2" runat="server"></asp:ListBox>
                                    </div>
                                </div>
                            </div>


                            <div class="row">
                                <div class="col-sm-8">
                                    &nbsp;
                                </div>
                                
                                <div class="col-sm-4" style="padding:0;">
                                    <div class="col-sm-12" style="vertical-align: bottom; padding-left: 0; padding-top: 5px; ">
                                        <label for="dsinirlama_varmi" style="float:right; cursor:pointer; " ><asp:CheckBox runat="server" onclick="dsinirlama_gorunum_degis();" id="dsinirlama_varmi"></asp:CheckBox> <% Response.Write(LNG("Süre Sınırlama")); %></label>
                                    </div>
                                </div>
                                
                            </div>


                            <div class="row">
                                <div class="col-sm-4 dortlu" style="padding:0;">
                                    <label class="col-sm-12 col-form-label"><% Response.Write(LNG("İşe Başlama")); %></label>
                                    <div class="col-sm-12">
                                        <div class="input-group input-group-primary">
                                            <span class="input-group-addon">
                                                <i class="icon-prepend fa fa-calendar"></i>
                                            </span>
                                            <asp:TextBox id="dyeni_is_baslangic_tarihi" onkeyup="dyeni_is_ekle_sure_hesap();" required class="takvimyap_yeni" style="padding-left:10px; max-width:110px;" runat="server"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3 uclu" style="padding:0;">
                                    <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Saat")); %></label>
                                    <div class="col-sm-12">
                                        <div class="input-group input-group-primary">
                                            <span class="input-group-addon">
                                                <i class="icon-prepend fa fa-calendar"></i>
                                            </span>
                                            <asp:TextBox id="dyeni_is_baslangic_saati" required class="timepicker" style="padding-left:10px; max-width:55px;" runat="server"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-5 sinirlama_yeri" style="padding:0;">
                                    <label class="col-sm-12 col-form-label" style="font-size:12px;"><% Response.Write(LNG("Günlük Ort. Çalışma(saat)")); %></label>
                                    <div class="col-sm-12">
                                        <span style="float:left;">
                                            <asp:TextBox runat="server" onkeyup="dyeni_is_ekle_sure_hesap();" id="dyeni_is_gunluk_ortalama_calisma" required="" style="padding-left:10px; width:65px;" class="form-control" ></asp:TextBox>
                                            </span><span style="float:left;font-size: 18px; padding: 5px;"> X </span><span style="float:left;font-size: 18px; padding: 5px;" id="dgunluk_gun_hesap_yeri"><asp:Label runat="server" ID="dgun_gosterim"></asp:Label> <% Response.Write(LNG("gün")); %></span>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-4 dortlu" style="padding:0;">
                                    <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Planlanan Bitiş :")); %></label>
                                    <div class="col-sm-12">
                                        <div class="input-group input-group-primary">
                                            <span class="input-group-addon">
                                                <i class="icon-prepend fa fa-calendar"></i>
                                            </span>
                                            <asp:TextBox id="dyeni_is_bitis_tarihi" onkeyup="dyeni_is_ekle_sure_hesap();" required class="takvimyap_yeni" style="padding-left:10px; max-width:110px;" runat="server"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3 uclu" style="padding:0;">
                                    <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Saat :")); %></label>
                                    <div class="col-sm-12">
                                        <div class="input-group input-group-primary">
                                            <span class="input-group-addon">
                                                <i class="icon-prepend fa fa-calendar"></i>
                                            </span>
                                            <asp:TextBox runat="server" id="dyeni_is_bitis_saati" style="padding-left:10px; max-width:55px;" required class="timepicker"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-5 sinirlama_yeri" style="padding:0;">
                                    <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Toplam Çalışma(saat)")); %></label>
                                    <div class="col-sm-12">
                                        <div class="input-group input-group-primary">
                                            <asp:TextBox runat="server" id="dyeni_is_toplam_calisma" onkeyup="dyeni_is_ekle_sure_hesap2();" required  style="padding-left:10px; " class="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>

                            </div>


                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    
                    <asp:Button runat="server" class="btn btn-primary"  ID="dyeni_is_ekle_button"></asp:Button>

                </div>


 <%--        <header>
    <h2 style="margin: 0;"><strong>İş</strong> <i>Düzenle</i></h2>
</header>
        <script>
            $(function () {
                setTimeout(function () { $("#dyeni_is_adi").focus() }, 1500);
                autosize($("#dyeni_is_adi"));
            });
        </script>
<div id="dyeni_is_ekle_form" class="smart-form validateform">
    <fieldset>
        <section>
            <label class="label">Yapılacak İş :</label>
            <label class="input">
                <i class="icon-prepend fa fa-cubes"></i>
                
            </label>
        </section>
        <section style="display:none;">
            <label class="label">Açıklama :</label>
            <label class="input">
                
            </label>
        </section>
        <div class="row">
        <section class="col col-6">
            <label class="label">Görevliler :</label>
            <label class="select">
                <i class="icon-prepend fa fa-user"></i>
                
            </label>
        </section>
            <section class="col col-6">
            <label class="label">Etiketler :</label>
            <label class="select">
                <i class="icon-prepend fa fa-user"></i>
                
            </label>
                                 
        </section>
        </div>
        <div class="row">
        <section class="col col-6">
            <label class="label">Öncelik :</label>
            <label class="select">
                <i class="icon-prepend fa fa-user"></i>
                
            </label>
        </section>
            <section class="col col-6">
            <label class="label">Kontrol ve Bildirim :</label>
            <label class="select">
                
            </label>
        </section>
        </div>
        <div class="row">
         <section class="col col-6">
            <label class="label">İşe Başlama :</label>
            <label class="input">
                <i class="icon-prepend fa fa-calendar"></i>
                
            </label>
        </section>
         <section class="col col-6">
            <label class="label">Saat :</label>
            <label class="input">
                <i class="icon-prepend fa fa-calendar"></i>
                
            </label>
        </section></div>
        <div class="row">
        <section class="col col-6">
            <label class="label">Planlanan Bitiş :</label>
            <label class="input">
                <i class="icon-prepend fa fa-calendar"></i>
                
            </label>
        </section>
        
        <section class="col col-6">
            <label class="label">Saat :</label>
            <label class="input">
                <i class="icon-prepend fa fa-calendar"></i>
                
            </label>
        </section>
            </div>
    </fieldset>
    </div>
    <footer>
        
    </footer>--%>
    </asp:panel>

    <asp:panel id="is_yazisma_panel" runat="server">
        <ul>
                       <asp:Repeater ID="yazismaRepeater" runat="server">
                           <ItemTemplate>
                                <div class="timeline-seperator text-center"></div>
			<li class="message" style="min-height:60px;">
				<img src="<%# DataBinder.Eval(Container.DataItem, "resim") %>" style="width:54px;" class="online" alt="sunny">
				<span class="message-text" style="width:93%;"> <a href="javascript:void(0);" class="username"><%# DataBinder.Eval(Container.DataItem, "yazan") %> <small title="<%# DataBinder.Eval(Container.DataItem, "ekleme_zamani") %>" class="text-muted pull-right ultra-light"> <%# DataBinder.Eval(Container.DataItem, "ekleme_zaman2") %> </small></a> <%# DataBinder.Eval(Container.DataItem, "metin") %> </span>
			</li>
                                         
                           </ItemTemplate>
                       </asp:Repeater>                       
                      
						<asp:Panel ID="yazisma_kayit_yok_panel" runat="server">
                            <br /><br />
                            <center><% Response.Write(LNG("İşle ilgili yazışma kaydı bulunamadı !")); %></center>
                            <br /><br />
						</asp:Panel>					
                                                
		</ul>
    </asp:panel>

    <asp:panel id="departman_gosterge_panel" runat="server">
                      <div class="row" style="margin: 0;">
                        <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 ustunegelince" style="border: 1px dotted #dfe5e9; margin: 0;">
                            <div class="text-center " onclick="is_listesi_gosterge('departman_baslanmamis');" style="cursor: pointer; padding: 10px;">
                                <span class="tag2 baslamamis">
                                    <asp:label runat="server" ID="departman_baslanmamis"></asp:label>
                                </span>
                                <h5 style="padding-top: 0; color: #5a5a5a; font-size: 12px; margin-top: 10px; font-weight:400;"><% Response.Write(LNG("Başlanmamış")); %></h5>
                            </div>
                        </div>
                        <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 ustunegelince" style="border: 1px dotted #dfe5e9; margin: 0;">
                            <div class="text-center " onclick="is_listesi_gosterge('departman_devameden');" style="cursor: pointer; padding: 10px;">
                                <span class="tag2 devam_eden">
                                    <asp:label runat="server" ID="departman_devameden"></asp:label>
                                </span>
                                <h5 style="padding-top: 0; color: #5a5a5a; font-size: 12px; margin-top: 10px; font-weight:400;"><% Response.Write(LNG("Devam Eden")); %></h5>
                            </div>
                        </div>
                        <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 ustunegelince" style="border: 1px dotted #dfe5e9; margin: 0; -webkit-border-bottom-left-radius: 15px; -moz-border-radius-bottomleft: 15px; border-bottom-left-radius: 15px;">
                            <div class="text-center " onclick="is_listesi_gosterge('departman_gecikmis');" style="cursor: pointer; padding: 10px;">
                                <span class="tag2 gecikmis">
                                    <asp:label runat="server" ID="departman_gecikmis"></asp:label>
                                </span>
                                <h5 style="padding-top: 0; color: #5a5a5a; font-size: 12px; margin-top: 10px; font-weight:400;"><span style="color: #ea0036;"><% Response.Write(LNG("Gecikmiş")); %></span></h5>
                            </div>
                        </div>
                        <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 ustunegelince" style="border: 1px dotted #dfe5e9; margin: 0; -webkit-border-bottom-right-radius: 15px; -moz-border-radius-bottomright: 15px; border-bottom-right-radius: 15px;">
                            <div class="text-center" onclick="is_listesi_gosterge('departman_tamamlanan');" style="cursor: pointer; padding: 10px;">
                                <span class="tag2 biten">
                                    <asp:label runat="server" ID="departman_tamamlanan"></asp:label>
                                </span>
                                <h5 style="padding-top: 0; color: #5a5a5a; font-size: 12px; margin-top: 10px; font-weight:400;"><% Response.Write(LNG("Tamamlanan")); %></h5>
                            </div>
                        </div>
                 
        </div>

                 
    </asp:panel>
    <asp:panel id="firmalar_panel" runat="server">
        <div  class="dt-responsive table-responsive">
        <table id="dt_basic" class="table table-striped table-bordered table-hover datatableyap" width="100%">
    <thead>
        <tr>
            <th data-hide="phone">ID</th>
            <th data-hide="phone"><% Response.Write(LNG("Firma Kodu")); %></th>
            <th data-hide="phone"><% Response.Write(LNG("Yetkili Kişi")); %></th>
            <th data-class="expand"><% Response.Write(LNG("Firma Adı")); %></th>
            <th data-hide="phone"><% Response.Write(LNG("Yetkili Kişi")); %></th>
            <th data-hide="phone"><% Response.Write(LNG("Telefon")); %></th>
            <th data-hide="phone"><% Response.Write(LNG("Supervisor")); %></th>
            <th style="text-align:center;"><% Response.Write(LNG("Durum")); %></th>
            <th><% Response.Write(LNG("İşlem")); %></th>
        </tr>
    </thead>
    <tbody>
        <asp:Panel ID="firmalar_kayityok_panel" runat="server">
        <tr>
            <td colspan="7" style="text-align:center; vertical-align: middle;"><% Response.Write(LNG("Kayıt Yok")); %></td>
        </tr>
       </asp:Panel>
        <asp:Panel ID="firmalar_kayitvar_panel" runat="server">
            <asp:Repeater ID="firmalar_repeater" runat="server">
                <ItemTemplate>
                    <tr>
            <td><%# DataBinder.Eval(Container.DataItem, "sira") %></td>
            <td><%# DataBinder.Eval(Container.DataItem, "musteri_kodu") %></td>
            <td><%# DataBinder.Eval(Container.DataItem, "firma_yetkili") %></td>
            <td><%# DataBinder.Eval(Container.DataItem, "firma_adi") %></td>
            <td><%# DataBinder.Eval(Container.DataItem, "firma_yetkili") %></td>
            <td><%# DataBinder.Eval(Container.DataItem, "firma_telefon") %></td>
            <td><%# DataBinder.Eval(Container.DataItem, "supervisor") %></td>
            <td style="text-align:center;">
                <span class="onoffswitch">
                    <asp:Label runat="server" class="onoffswitch-label" ID="st4_label">
                        <asp:CheckBox ID="st4" runat="server"></asp:CheckBox>        
                    </asp:Label>
                </span>
            </td>
            <td class="icon-list-demo2">
                <a href="javascript:void(0);" onclick="sayfagetir('/firma_detaylari/', 'jsid=4559&firma_id=<%# DataBinder.Eval(Container.DataItem, "id") %>&yetki_kodu=<%Response.Write(Request.Form["yetki_kodu"].ToString()); %>');" rel="tooltip" data-placement="top" data-original-title="<% Response.Write(LNG("Firma Detaylarını Görüntüle")); %>">
                    <i class="fa fa-external-link"></i>
                </a>
                &nbsp;
                <a href="javascript:void(0);" onclick="kayit_sil('ucgem_firma_listesi', '<%# DataBinder.Eval(Container.DataItem, "id") %>', '<% Response.Write(LNG("Firmalar")); %>', '<% Response.Write(LNG("Kayıt Başarıyla Silindi")); %>', firma_listesi, '<%Response.Write(Request.Form["yetki_kodu"].ToString()); %>');" rel="tooltip" data-placement="top" data-original-title="<% Response.Write(LNG("Görev Sil")); %>">
                    <i class="ti-trash"></i>
                </a>
            </td>
        </tr>
                </ItemTemplate>
            </asp:Repeater>
        
       </asp:Panel>
    </tbody>
</table></div>
    </asp:panel>
    <asp:panel id="projeler_panel" runat="server">
        <div  class="dt-responsive table-responsive">
        <table id="dt_basic" class="table table-striped table-bordered table-hover datatableyap" width="100%">
    <thead>
        <tr>
            <th data-hide="phone">ID</th>
            <th data-class="expand"><% Response.Write(LNG("Proje Adı")); %></th>
            <th data-hide="phone"><% Response.Write(LNG("Firma Adı")); %></th>
            <th data-hide="phone"><% Response.Write(LNG("Supervisor")); %></th>
            <th style="text-align:center;"><% Response.Write(LNG("Durum")); %></th>
            <th><% Response.Write(LNG("İşlem")); %></th>
        </tr>
    </thead>
    <tbody>
        <asp:Panel ID="projeler_kayityok_panel" runat="server">
        <tr>
            <td colspan="7" style="text-align: center; vertical-align: middle;"><% Response.Write(LNG("Kayıt Yok")); %></td>
        </tr>
       </asp:Panel>
        <asp:Panel ID="projeler_kayitvar_panel" runat="server">
            <asp:Repeater ID="projeler_repeater" runat="server">
                <ItemTemplate>
                    <tr>
            <td><%# DataBinder.Eval(Container.DataItem, "id") %></td>
            <td><%# DataBinder.Eval(Container.DataItem, "proje_adi") %></td>
            <td><%# DataBinder.Eval(Container.DataItem, "firma_adi") %></td>
            <td><%# DataBinder.Eval(Container.DataItem, "supervisor") %></td>
            <td style="text-align:center;">
                <asp:Label runat="server" class="onoffswitch-label" ID="st5_label">
                        <asp:CheckBox ID="st5" runat="server"></asp:CheckBox>
                </asp:Label>
            </td>
            <td class="icon-list-demo2">
                <a href="javascript:void(0);" style="display:none;" onclick="sayfagetir('/proje_detaylari/', 'jsid=4559&firma_id=<%# DataBinder.Eval(Container.DataItem, "id") %>');" rel="tooltip" data-placement="top" data-original-title="<% Response.Write(LNG("Proje Detaylarını Görüntüle")); %>">
                    <i class="fa fa-external-link"></i>
                </a>
                &nbsp;
                <a href="javascript:void(0);" onclick="kayit_sil('ucgem_proje_listesi', '<%# DataBinder.Eval(Container.DataItem, "id") %>', '<% Response.Write(LNG("Projeler")); %>', '<% Response.Write(LNG("Kayıt Başarıyla Silindi")); %>', proje_listesi);" rel="tooltip" data-placement="top" data-original-title="Proje Sil">
                    <i class="ti-trash"></i>
                </a>
            </td>
        </tr>
                </ItemTemplate>
            </asp:Repeater>
        
       </asp:Panel>
    </tbody>
</table></div>
    </asp:panel>

    <asp:panel id="personeller_panel" runat="server">
        <div  class="dt-responsive table-responsive">
        <table id="dt_basic" class="table table-striped table-bordered table-hover datatableyap" width="100%">
    <thead>
        <tr>
            <th data-hide="phone">ID</th>
            <th data-class="expand"><% Response.Write(LNG("Ad Soyad")); %></th>
            <th data-hide="phone"><% Response.Write(LNG("GSM")); %></th>
            <th data-hide="phone"><% Response.Write(LNG("E-Posta")); %></th>
            <th data-hide="phone" style="display:none;"><% Response.Write(LNG("Departman")); %></th>
            <th><% Response.Write(LNG("Görev")); %></th>
            <th style="text-align:center;"><% Response.Write(LNG("Durum")); %></th>
            <th><% Response.Write(LNG("İşlem")); %></th>
        </tr>
    </thead>
    <tbody>
        <asp:Panel ID="personeller_kayityok_panel" runat="server">
        <tr>
            <td colspan="4" style="text-align: center; vertical-align: middle;"><% Response.Write(LNG("Kayıt Yok")); %></td>
        </tr>
       </asp:Panel>
        <asp:Panel ID="personeller_kayitvar_panel" runat="server">
            <asp:Repeater ID="personeller_repeater" runat="server">
                <ItemTemplate>
                    <tr>
            <td><%# DataBinder.Eval(Container.DataItem, "sira") %></td>
            <td><%# DataBinder.Eval(Container.DataItem, "personel_ad") %>&nbsp;<%# DataBinder.Eval(Container.DataItem, "personel_soyad") %></td>
            <td><%# DataBinder.Eval(Container.DataItem, "personel_telefon") %></td>
            <td><%# DataBinder.Eval(Container.DataItem, "personel_eposta") %></td>
            <td style="display:none;"><%# DataBinder.Eval(Container.DataItem, "departmanlar") %></td>
            <td><%# DataBinder.Eval(Container.DataItem, "gorevler") %></td>
            <td style="text-align:center;">
                <span class="onoffswitch">
                
                <asp:Label runat="server" ID="st3_label">
                        <asp:CheckBox ID="st3" runat="server"></asp:CheckBox>
                </asp:Label>
            </span></td>
            <td class="icon-list-demo2">
                <a href="javascript:void(0);" onclick="sayfagetir('/personel_detaylari/', 'jsid=4559&personel_id=<%# DataBinder.Eval(Container.DataItem, "id") %>');" rel="tooltip" data-placement="top" data-original-title="<% Response.Write(LNG("Personel Detaylarını Görüntüle")); %>">
                    <i class="fa fa-external-link"></i>
                </a>
                &nbsp;
                <a href="javascript:void(0);" onclick="kayit_sil('ucgem_firma_kullanici_listesi', '<%# DataBinder.Eval(Container.DataItem, "id") %>', '<% Response.Write(LNG("Personeller")); %>', '<% Response.Write(LNG("Kayıt Başarıyla Silindi")); %>', personel_listesi);" rel="tooltip" data-placement="top" data-original-title="<% Response.Write(LNG("Görev Sil")); %>">
                    <i class="ti-trash"></i>
                </a>
            </td>
        </tr>
                </ItemTemplate>
            </asp:Repeater>
        
       </asp:Panel>
    </tbody>
</table></div>
    </asp:panel>

    <asp:panel id="santiye_durum_panel" runat="server">

        <script>
            $(function () {


                var oTable = $('.datatableyap1').dataTable({
                    /*"sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6'f><'col-sm-6 col-xs-12 hidden-xs'l>r>" +
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
                    },
                    "order": []*/

                });


                $(".datatableyap1  tbody").sortable({
                    opacity: 0.6,
                    cursor: 'move',
                    update: function (ev, ui) {
                        var oSettings = oTable.fnSettings();
                        var clonedData = oSettings.aoData.slice();
                        var siralamam = "";
                        $('.datatableyap1 tbody tr').each(function (i) {
                            //   alert($('.datatableyap1 tbody tr td').html()[i]);
                            siralamam = siralamam + $(this).find(".idler").attr("id") + "-" + parseFloat(i + 1) + ",";
                            var startPos = oTable.fnGetPosition(this);
                            //alert("i: " + i + " startPos: " + startPos)
                            clonedData[i] = oSettings.aoData[startPos];
                            clonedData[i]._iId = i;
                            // App specific - first table col contains an incremental count which needs to be refreshed after a move
                            // Without cloning hack - do this with fnUpdate()
                            clonedData[i].nTr.cells[0].innerHTML = i + 1;
                            clonedData[i].nTr.cells[0].innerText = i + 1;
                        })
                        var data = "islem=siralamakaydet&siralama=" +
                            siralamam +
                            "&tablo=tanimlama_santiye_durum_listesi";
                        $("#koftiden").loadHTML({ url: "/ajax_request/", data: data },
                            function () {
                                mesaj_ver("<% Response.Write(LNG("Departmanlar")); %>",
                                    "<% Response.Write(LNG("Sıralama Başarıyla Kaydedildi")); %>",
                                    "success");
                            })
                        // $(".datatableyap1").fnReloadAjax();
                        // oTable.fnReloadAjax('/araclar/ajax_tablo_doldurucu/?tablono=' + $("#tablo1").attr('TabloNo') + '&' + sondata);
                        oSettings.aoData = clonedData;
                    }
                });
            });
        </script>
        <div  class="dt-responsive table-responsive">
            <table id="dt_basic" class="table table-striped table-bordered table-hover datatableyap" style="width:973px">
    <thead>
        <tr>
            <th style="width: 30px; ">ID</th>
            <th><% Response.Write(LNG("Durum Adı")); %></th>
            <th style="width: 40px; text-align:center;"><% Response.Write(LNG("Durum")); %></th>
            <th style="width: 60px;"><% Response.Write(LNG("İşlem")); %></th>
        </tr>
    </thead>
    <tbody>
        <asp:Panel ID="santiye_durum_kayityok_panel" runat="server">
        <tr>
            <td colspan="3" style="text-align: center; vertical-align: middle;"><% Response.Write(LNG("Kayıt Yok")); %></td>
        </tr>
       </asp:Panel>
        <asp:Panel ID="santiye_durum_kayitvar_panel" runat="server">
            <asp:Repeater ID="santiye_durum_repeater" runat="server">
                <ItemTemplate>
                    <tr>
            <td class="idler" id="<%# DataBinder.Eval(Container.DataItem, "id") %>"><%# DataBinder.Eval(Container.DataItem, "sirano") %></td>
            <td><%# DataBinder.Eval(Container.DataItem, "durum_adi") %></td>
            <td style="text-align:center;">
               <asp:Label runat="server" ID="str2santiye_label">
                    <asp:CheckBox ID="st2_santiye" runat="server"></asp:CheckBox>                   </asp:Label>                <%--
                    <span class="onoffswitch">
                        <asp:Label runat="server" class="onoffswitch-label" ID="str2santiye_label">
                        <span class="onoffswitch-inner" data-swchon-text="AKTİF" data-swchoff-text="PASİF"></span>
                        <span class="onoffswitch-switch"></span>
                    </asp:Label>
                </span>
                --%>
            </td>
            <td class="icon-list-demo2">
                <a href="javascript:void(0);" rel="tooltip" onclick="santiye_durum_duzenle(<%# DataBinder.Eval(Container.DataItem, "id") %>);" data-placement="top" data-original-title="<% Response.Write(LNG("Proje Durum Düzenle")); %>">
                    <i class="fa fa-edit"></i>
                </a>&nbsp;
                <a href="javascript:void(0);" onclick="kayit_sil('tanimlama_santiye_durum_listesi', '<%# DataBinder.Eval(Container.DataItem, "id") %>', '<% Response.Write(LNG("Proje Durumları")); %>', '<% Response.Write(LNG("Kayıt Başarıyla Silind")); %>i', santiye_durum_listesi);" rel="tooltip" data-placement="top" data-original-title="Görev Sil">
                    <i class="ti-trash"></i>
                </a>
            </td>
        </tr>
                </ItemTemplate>
            </asp:Repeater>
        
       </asp:Panel>
    </tbody>
</table></div>

        </asp:panel>


<%--    <asp:TextBox ID="hideValue" type="hidden" class="form-control" runat="server"></asp:TextBox>
    <script type="text/javascript">
        var value = $("#hideValue").val();
        $(".yetmislik option[value=" + value + "]").attr('selected', 'selected');
        $(".yetmislik").trigger("change");
    </script>--%>

    <asp:panel id="gorevler_panel" runat="server">
        <div  class="dt-responsive table-responsive">
        <table id="dt_basic" class="table table-striped table-bordered table-hover datatableyap">
    <thead>
        <tr>
            <th style="width: 30px;">ID</th>
            <th><% Response.Write(LNG("Görev Adı")); %></th>
            <th style="width: 60px; text-align:center;"><% Response.Write(LNG("Durum")); %></th>
            <th style="width: 60px;"><% Response.Write(LNG("İşlem")); %></th>
        </tr>
    </thead>
    <tbody>
        <asp:Panel ID="gorevler_kayityok_panel" runat="server">
        <tr>
            <td colspan="4" style="text-align: center; vertical-align: middle;"><% Response.Write(LNG("Kayıt Yok")); %></td>
        </tr>
       </asp:Panel>
        <asp:Panel ID="gorevler_kayitvar_panel" runat="server">
            <asp:Repeater ID="gorevler_repeater" runat="server">
                <ItemTemplate>
                    <tr>
            <td style="width:30px;"><%# DataBinder.Eval(Container.DataItem, "sira") %></td>
            <td><%# DataBinder.Eval(Container.DataItem, "gorev_adi") %></td>
            <td style="text-align:center; width:60px;">
                 <asp:Label runat="server" ID="str2_label">
                    <asp:CheckBox ID="st2" runat="server"></asp:CheckBox>                   </asp:Label>
            </td>
            <td class="icon-list-demo2" style="width:60px;">
                <a href="javascript:void(0);" rel="tooltip" onclick="gorev_duzenle(<%# DataBinder.Eval(Container.DataItem, "id") %>);" data-placement="top" data-original-title="<% Response.Write(LNG("Görev Düzenle")); %>">
                    <i class="fa fa-edit"></i>
                </a>&nbsp;
                <a href="javascript:void(0);" onclick="kayit_sil('tanimlama_gorev_listesi', '<%# DataBinder.Eval(Container.DataItem, "id") %>', '<% Response.Write(LNG("Görevler")); %>', '<% Response.Write(LNG("Kayıt Başarıyla Silindi")); %>', gorev_listesi);" rel="tooltip" data-placement="top" data-original-title="<% Response.Write(LNG("Görev Sil")); %>">
                    <i class="ti-trash"></i>
                </a>
            </td>
        </tr>
                </ItemTemplate>
            </asp:Repeater>
        
       </asp:Panel>
    </tbody>
</table></div>

        </asp:panel>
    <asp:panel id="departmanlar_panel" runat="server">

        <script>
            $(function () {


                var oTable = $('.datatableyap1').dataTable({
                    /* "sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6'f><'col-sm-6 col-xs-12 hidden-xs'l>r>" +
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
                     },
                     "order": []*/

                });


                $(".datatableyap1  tbody").sortable({
                    opacity: 0.6,
                    cursor: 'move',
                    update: function (ev, ui) {
                        var oSettings = oTable.fnSettings();
                        var clonedData = oSettings.aoData.slice();
                        var siralamam = "";
                        $('.datatableyap1 tbody tr').each(function (i) {
                            //   alert($('.datatableyap1 tbody tr td').html()[i]);
                            siralamam = siralamam + $(this).find(".idler").attr("id") + "-" + parseFloat(i + 1) + ",";
                            var startPos = oTable.fnGetPosition(this);
                            //alert("i: " + i + " startPos: " + startPos)
                            clonedData[i] = oSettings.aoData[startPos];
                            clonedData[i]._iId = i;
                            // App specific - first table col contains an incremental count which needs to be refreshed after a move
                            // Without cloning hack - do this with fnUpdate()
                            clonedData[i].nTr.cells[0].innerHTML = i + 1;
                            clonedData[i].nTr.cells[0].innerText = i + 1;
                        })
                        var data = "islem=siralamakaydet&siralama=" + siralamam + "&tablo=tanimlama_departman_listesi";
                        $("#koftiden").loadHTML({ url: "/ajax_request/", data: data },
                            function () {
                                mesaj_ver("<% Response.Write(LNG("Departmanlar")); %>",
                                    "<% Response.Write(LNG("Sıralama Başarıyla Kaydedildi")); %>",
                                    "success");
                            })
                        // $(".datatableyap1").fnReloadAjax();
                        // oTable.fnReloadAjax('/araclar/ajax_tablo_doldurucu/?tablono=' + $("#tablo1").attr('TabloNo') + '&' + sondata);
                        oSettings.aoData = clonedData;
                    }
                });


                c
            });
        </script>

    <div class="dt-responsive table-responsive">
        <table id="dt_basic" class="table table-striped table-bordered table-hover text-nowrap datatableyap" style="width:973px">
            <thead>
                <tr>
                    <th style="width: 30px;">ID</th>
                    <th><% Response.Write(LNG("Departman Adı")); %></th>
                    <th><% Response.Write(LNG("Departman Tipi")); %></th>
                    <th><% Response.Write(LNG("Yetkili Personeller")); %></th>
                    <th style="width: 60px; text-align: center;"><% Response.Write(LNG("Durum")); %></th>
                    <th style="width: 60px;"><% Response.Write(LNG("İşlem")); %></th>
                </tr>
            </thead>
            <tbody>
                <asp:panel id="departmanlar_kayityok_panel" runat="server">
        <tr>
            <td colspan="5" style="text-align: center; vertical-align: middle;"><% Response.Write(LNG("Kayıt Yok")); %></td>
        </tr>
       </asp:panel>
                <asp:panel id="departmanlar_kayitvar_panel" runat="server">
            <asp:Repeater ID="departmanlar_repeater" runat="server">
                <ItemTemplate>
                    <tr>
            <td class="idler" id="<%# DataBinder.Eval(Container.DataItem, "id") %>"><%# DataBinder.Eval(Container.DataItem, "sira") %></td>
            <td><%# DataBinder.Eval(Container.DataItem, "departman_adi") %></td>
                        
                        <td><%# DataBinder.Eval(Container.DataItem, "departman_tipi2") %></td>
                        <td class="tablo_etiketler" style="width:150px;"><div><%# DataBinder.Eval(Container.DataItem, "yetkili_personeller") %></div></td>
            <td style="text-align:center;">

                 <asp:Label runat="server" ID="str1_label">
                    <asp:CheckBox ID="st1" runat="server"></asp:CheckBox>                   </asp:Label>
            </td>
            <td class="icon-list-demo2">
                <a href="javascript:void(0);" rel="tooltip" onclick="departman_duzenle(<%# DataBinder.Eval(Container.DataItem, "id") %>);" data-placement="top" data-original-title="<% Response.Write(LNG("Departman Düzenle")); %>">
                    <i class="fa fa-edit"></i>
                </a>&nbsp;
                <a href="javascript:void(0);" onclick="kayit_sil('tanimlama_departman_listesi', '<%# DataBinder.Eval(Container.DataItem, "id") %>', '<% Response.Write(LNG("Departmanlar")); %>', '<% Response.Write(LNG("Kayıt Başarıyla Silindi")); %>', departman_listesi);" rel="tooltip" data-placement="top" data-original-title="<% Response.Write(LNG("Departman Sil")); %>">
                    <i class="ti-trash"></i>
                </a>
            </td>
        </tr>
                </ItemTemplate>
            </asp:Repeater>
        
       </asp:panel>
            </tbody>
        </table>
        </asp:panel>

    <script>
        $(function () {
            setTimeout(function () { $("#olay").focus() }, 1500);
            autosize($("#olay"));
            $("#olay").keyup(function (event) {
                if (event.keyCode === 13) {
                    $("#olay_kayit_buton").click();
                }
            });
        });
    </script>
        <asp:panel id="yeni_olay_ekle_panel" runat="server">


        <div id="yeni_olay_ekle_panel_form" style="padding:15px;">
        <div class="modal-header"> 
             
             <div>
		
    <h4 class="modal-title"> <h5><% Response.Write(LNG("Olay Ekle")); %></h5></h4>
        
	</div>
         
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
            </button>
            </div>

            <div class="row">
                <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Olay :")); %></label>
                <div class="col-sm-12">
                    <div class="input-group input-group-primary">
                        <span class="input-group-addon">
                            <i class="icon-prepend fa fa-user"></i>
                        </span>
                        <asp:TextBox required id="olay" name="olay" class="ola form-control" style="width: 93%; padding-left: 5px; padding-top: 6px;" runat="server"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="row">
                <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Olay Tarihi :")); %></label>
                <div class="col-sm-12">
                    <div class="input-group input-group-primary">
                        <span class="input-group-addon">
                            <i class="icon-prepend fa fa-calendar"></i>
                        </span>
                        <asp:TextBox ID="olay_tarihi" class="takvimyap form-control" runat="server"></asp:TextBox>
                             <script>
                                 var dt = new Date();
                                 var time = dt.getHours() + ":" + dt.getMinutes();
                                 $("#olay_saati").val(time);
                                 $("#olay_tarihi").val(new Date().toLocaleDateString());
                            </script>
                    </div>
                </div>
            </div>
            <div class="row">
                <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Olay Saati :")); %></label>
                <div class="col-sm-12">
                    <div class="input-group input-group-primary">
                        <span class="input-group-addon">
                            <i class="icon-prepend fa fa-clock-o"></i>
                        </span>
                        <asp:TextBox ID="olay_saati" class="timepicker form-control" runat="server"></asp:TextBox>
                    </div>
                </div>
            </div>


            
            </div>
        <div class="modal-footer" style="padding:20px">
                <asp:Button runat="server" class="btn btn-primary"  ID="olay_kayit_buton"></asp:Button>
        </div>

            
    </asp:panel>

        <asp:panel id="yeni_olay_duzenle_panel" runat="server">


        <div id="yeni_olay_duzenle_panel_form" style="padding:15px;">

            <div class="modal-header"> 
             
             <div>
		
    <h4 class="modal-title"> <h5><% Response.Write(LNG("Olay Düzenle")); %></h5></h4>
        
	</div>
         
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
            </button>
            </div>

       

            <div class="row">
                <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Olay :")); %></label>
                <div class="col-sm-12">
                    <div class="input-group input-group-primary">
                        <span class="input-group-addon">
                            <i class="icon-prepend fa fa-user"></i>
                        </span>
                        <asp:TextBox ID="dolay" required class="form-control" runat="server"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="row">
                <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Olay Tarihi :")); %></label>
                <div class="col-sm-12">
                    <div class="input-group input-group-primary">
                        <span class="input-group-addon">
                            <i class="icon-prepend fa fa-calendar"></i>
                        </span>
                        <asp:TextBox ID="dolay_tarihi" class="takvimyap form-control" runat="server"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="row">
                <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Olay Saati :")); %></label>
                <div class="col-sm-12">
                    <div class="input-group input-group-primary">
                        <span class="input-group-addon">
                            <i class="icon-prepend fa fa-clock-o"></i>
                        </span>
                        <asp:TextBox ID="dolay_saati" data-msg="Olay Saati" class="timepicker form-control" runat="server"></asp:TextBox>
                    </div>
                </div>
            </div>


            
            </div>
        <div class="row modal-footer" style="padding:20px">
                <asp:Button runat="server" class="btn btn-primary"  ID="olay_guncelle_buton"></asp:Button>&nbsp;
        <asp:Button runat="server" class="btn btn-danger"  ID="olay_sil_buton"></asp:Button>
        </div>

            
    </asp:panel>


        <asp:panel id="departman_duzenle_panel" runat="server">

         <div class="modal-header">
                <h4 class="modal-title"><% Response.Write(LNG("Proje Durum Güncelle")); %></h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
                </button>
                </div>
                <div class="modal-body">
                <div id="departman_duzenle_form">
                        <div class="row">
                            <label class="col-sm-5  col-lg-4 col-form-label"><% Response.Write(LNG("Durum Adı")); %></label>
                            <div class="col-sm-7 col-lg-8">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <asp:TextBox ID="ddepartman_adi" required class="form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <label class="col-sm-5  col-lg-4 col-form-label"><% Response.Write(LNG("Departman Tipi")); %></label>
                            <div class="col-sm-7 col-lg-8">
                               <asp:ListBox id="ddepartman_tipi" runat="server"></asp:ListBox>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" class="btn btn-primary"  ID="departman_guncelle_buton"></asp:Button>
                </div>
    </asp:panel>
        <asp:panel id="gorev_duzenle_panel" runat="server">
         <div class="modal-header">
                                                                                <h4 class="modal-title"><% Response.Write(LNG("Görev Güncelle")); %></h4>
                                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                                            </div>
                                                                            <div class="modal-body">
                                                                                <div id="gorev_duzenle_form">
                        <div class="row">
                            <label class="col-sm-5  col-lg-4 col-form-label"><% Response.Write(LNG("Görev Adı")); %></label>
                            <div class="col-sm-7 col-lg-8">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <asp:TextBox ID="dgorev_adi" required runat="server" class="form-control" ></asp:TextBox>
                                </div>
                            </div>
                        </div>


                    </div>
                                            </div>
                                            <div class="modal-footer">
                                                <asp:Button runat="server" class="btn btn-primary"  ID="gorev_guncelle_buton" Text="Görev Güncelle"></asp:Button>

                                            </div>

            
    </asp:panel>

        <asp:panel id="santiye_durum_duzenle_panel" runat="server">

        
                                                                            <div class="modal-header">
                                                                                <h4 class="modal-title"><% Response.Write(LNG("Proje Durum Güncelle")); %></h4>
                                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                                            </div>
                                                                            <div class="modal-body">
                                                                                <div id="santiye_durum_duzenle_form">
                        <div class="row">
                            <label class="col-sm-5  col-lg-4 col-form-label"><% Response.Write(LNG("Durum Adı")); %></label>
                            <div class="col-sm-7 col-lg-8">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <asp:TextBox ID="ddurum_adi" required class="form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                                                                            </div>
                                                                            <div class="modal-footer">
                                                                                <asp:Button runat="server" class="btn btn-primary waves-effect waves-light"  ID="santiye_durum_guncelle_buton"></asp:Button>

                                                                            </div>


    </asp:panel>



        <asp:panel id="is_listesi_panel" runat="server">
        <div id="lineer_kopyalanan" style="display:none;"></div>
        <div class="mobil_hide"  data-hide="phone" style="    width: 200px; float: right; margin-right: 250px; margin-bottom: -51px;  z-index: 13;  position: relative; padding-top: 10px;">
            <asp:ListBox name="tablo_customize" id="tablo_customize" multiple="multiple" runat="server"></asp:ListBox>
        </div><% gorunum gorunum = gorunum_al(); %>
        <script>
            $(function () {
                is_listesi_timeline_calistir2();
            });
        </script>
        <div class="dt-responsive table-responsive">
         <table id="example" class="nowrap display projects-table responsive table table-striped table-bordered table-hover dataTable no-footer" cellspacing="0" width="100%" role="grid" aria-describedby="example_info" style="width: 100%;">
                                    <thead>
                                        <tr id="birnumara" class="alttaki">
                                            <th sira="1" data-hide="phone" class="sortyeri"></th>
                                            <th sira="2" data-class="expand" class="sortyeri"></th>
                                            <th sira="3" data-hide="phone" class="desktop tablo85 bordersizis sortyeri sorting tablo_gorevliler <% if (!gorunum.tablo_gorevliler) { Response.Write(" gosterme "); } %>"><i class="fa fa-fw fa-user text-muted hidden-md hidden-sm hidden-xs"></i><% Response.Write(LNG("Görevliler")); %></th>
                                            <th sira="4" data-hide="phone" class=" tablo85 bordersizis sortyeri sorting tablo_etiketler <% if (!gorunum.tablo_etiketler) { Response.Write(" gosterme "); } %>"><i class="fa fa-fw fa-user text-muted hidden-md hidden-sm hidden-xs"></i><% Response.Write(LNG("Etiketler")); %></th>
                                            <th sira="5" data-hide="phone" class="tablo85 bordersizis sortyeri sorting tablo_tamamlanma <% if (!gorunum.tablo_tamamlanma) { Response.Write(" gosterme "); } %>"><i class="fa fa-fw fa-circle-o-notch text-muted hidden-md hidden-sm hidden-xs"></i><% Response.Write(LNG("Tamamlanma")); %></th>
                                            <th sira="6" data-hide="phone" class="tablo85 bordersizis sortyeri sorting tablo_baslangic <% if (!gorunum.tablo_baslangic) { Response.Write(" gosterme "); } %>"><i class="fa fa-fw fa-calendar text-muted hidden-md hidden-sm hidden-xs"></i>&nbsp;<% Response.Write(LNG("Başlama")); %></th>
                                            <th sira="7" data-hide="phone" class="tablo85 bordersizis sortyeri sorting tablo_bitis <% if (!gorunum.tablo_bitis) { Response.Write(" gosterme "); } %>"><i class="fa fa-fw fa-calendar text-muted hidden-md hidden-sm hidden-xs"></i>&nbsp;<% Response.Write(LNG("Bitiş")); %></th>
                                            <th sira="8" data-hide="phone" class="tablo85 bordersizis sortyeri sorting tablo_guncelleme <% if (!gorunum.tablo_guncelleme) { Response.Write(" gosterme "); } %>"><i class="fa fa-fw fa-calendar text-muted hidden-md hidden-sm hidden-xs"></i>&nbsp;<% Response.Write(LNG("Güncelleme")); %></th>
                                            <th sira="9" data-hide="phone" class="tablo85 bordersizis sortyeri sorting tablo_oncelik <% if (!gorunum.tablo_oncelik) { Response.Write(" gosterme "); } %>"><i class="fa fa-fw fa-user text-muted hidden-md hidden-sm hidden-xs"></i><% Response.Write(LNG("Öncelik")); %></th>
                                            <th sira="10" data-hide="phone" class="tablo85 bordersizis sortyeri sorting tablo_ekleyen <% if (!gorunum.tablo_ekleyen) { Response.Write(" gosterme "); } %>"><i class="fa fa-fw fa-user text-muted hidden-md hidden-sm hidden-xs"></i><% Response.Write(LNG("Ekleyen")); %></th>
                                            <th sira="11" data-hide="phone" class="tablo85 bordersizis sortyeri sorting tablo_durum <% if (!gorunum.tablo_durum) { Response.Write(" gosterme "); } %>"><% Response.Write(LNG("Durum")); %></th>
                                        </tr>
                                       
                                        <tr id="ikinumara" class="once_kapali ustteki">
                                            <th sira="1" data-hide="phone" class="sortyeri2 details-control sorting_disabled" style="width: 30px; text-align:center;">ID</th>
                                            <th sira="2" data-class="expand" class="sortyeri2 sorting_asc"><% Response.Write(LNG("Yapılacak İş")); %></th>
                                            <th sira="3" data-hide="phone" class="desktop tablo85 sortyeri2 sorting tablo_gorevliler  <% if (!gorunum.tablo_gorevliler) { Response.Write(" gosterme "); } %>"><i class="fa fa-fw fa-user text-muted hidden-md hidden-sm hidden-xs"></i><% Response.Write(LNG("Görevliler")); %></th>
                                            <th sira="4" data-hide="phone" class="tablo85 sortyeri2 sorting tablo_etiketler  <% if (!gorunum.tablo_etiketler) { Response.Write(" gosterme "); } %>"><i class="fa fa-fw fa-user text-muted hidden-md hidden-sm hidden-xs"></i><% Response.Write(LNG("Etiketler")); %></th>
                                            <th sira="5" data-hide="phone" class="tablo85 sortyeri2 sorting tablo_tamamlanma  <% if (!gorunum.tablo_tamamlanma) { Response.Write(" gosterme "); } %>"><i class="fa fa-fw fa-circle-o-notch text-muted hidden-md hidden-sm hidden-xs"></i><% Response.Write(LNG("Tamamlanma")); %></th>
                                            <th  sira="6" data-hide="phone" class="tablo85 sortyeri2 sorting tablo_baslangic  <% if (!gorunum.tablo_baslangic) { Response.Write(" gosterme "); } %>"><i class="fa fa-fw fa-calendar text-muted hidden-md hidden-sm hidden-xs"></i>&nbsp;<% Response.Write(LNG("Başlama")); %></th>
                                            <th sira="7"  data-hide="phone" class="tablo85 sortyeri2 sorting tablo_bitis  <% if (!gorunum.tablo_bitis) { Response.Write(" gosterme "); } %>"><i class="fa fa-fw fa-calendar text-muted hidden-md hidden-sm hidden-xs"></i>&nbsp;<% Response.Write(LNG("Bitiş")); %></th>
                                            <th  sira="8" data-hide="phone" class="tablo85 sortyeri2 sorting tablo_guncelleme  <% if (!gorunum.tablo_guncelleme) { Response.Write(" gosterme "); } %>"><i class="fa fa-fw fa-calendar text-muted hidden-md hidden-sm hidden-xs"></i>&nbsp;<% Response.Write(LNG("Güncelleme")); %></th>
                                            <th  sira="9" data-hide="phone" class="tablo85 sortyeri2 sorting tablo_oncelik  <% if (!gorunum.tablo_oncelik) { Response.Write(" gosterme "); } %>"><i class="fa fa-fw fa-user text-muted hidden-md hidden-sm hidden-xs"></i><% Response.Write(LNG("Öncelik")); %></th>
                                            <th sira="10" data-hide="phone" class="tablo85 sortyeri2 sorting tablo_ekleyen  <% if (!gorunum.tablo_ekleyen) { Response.Write(" gosterme "); } %>"><i class="fa fa-fw fa-user text-muted hidden-md hidden-sm hidden-xs"></i><% Response.Write(LNG("Ekleyen")); %></th>
                                            <th sira="11" data-hide="phone" class="tablo85 sortyeri2 sorting tablo_durum  <% if (!gorunum.tablo_durum) { Response.Write(" gosterme "); } %>"><% Response.Write(LNG("Durum")); %></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <asp:Panel ID="isler_is_yok_panel" runat="server">
                                        <tr>
                                            <td id="is_kayit_yok" varmi="yok" colspan="11" style="text-align: center; vertical-align: middle;"><% Response.Write(LNG("Kayıt Bulunamadı")); %></td>
                                        </tr>
                                        </asp:Panel>
                                        <asp:Panel ID="isler_isvar_panel" runat="server">
                                            <asp:Repeater ID="isler_repeater" runat="server">
                                                <ItemTemplate>
                                        <tr class="details-control-tr" id="<%# DataBinder.Eval(Container.DataItem, "id") %>" role="row">
                                            <td class=" details-control" data-order="<%# DataBinder.Eval(Container.DataItem, "guncelleme_tarihi_order") %>"><span class="hiddenspan"><%# DataBinder.Eval(Container.DataItem, "id") %></span></td>

                                            <td class="sorting_1"><div class="tablo_is_adi"><%# DataBinder.Eval(Container.DataItem, "adi") %></div>
                                                <span style="float:right; margin-top:-30px; text-align:right;">İş Kodu :<br /><strong><%# DataBinder.Eval(Container.DataItem, "is_kodu") %></strong></span>
                                            </td>

                                            <td class="tablo_gorevliler <%# DataBinder.Eval(Container.DataItem, "tablo_gorevliler") %>"><div>
                                                <div class="project-members"><asp:Repeater ID="gorevli_repeater" runat="server"><ItemTemplate><span class="hiddenspan"><%# DataBinder.Eval(Container.DataItem, "adi") %></span><a rel="tooltip"  data-toggle="tooltip" data-html="true" data-original-title="<img src='<%# DataBinder.Eval(Container.DataItem, "resim") %>' alt='<%# DataBinder.Eval(Container.DataItem, "adi") %>' class='online' style='width:75px;'><br><%# DataBinder.Eval(Container.DataItem, "adi") %>" data-placement="top"  href="javascript:void(0)"><img src="<%# DataBinder.Eval(Container.DataItem, "resim") %>" class="online"></a>&nbsp;</ItemTemplate></asp:Repeater></div></div>
                                            </td>

                                            <td class="tablo_etiketler <%# DataBinder.Eval(Container.DataItem, "tablo_etiketler") %>"><div><%# DataBinder.Eval(Container.DataItem, "departman_isimleri") %>&nbsp;<%# DataBinder.Eval(Container.DataItem, "hidden_etiketler") %></div></td>

                                            <td class="tablo_tamamlanma <%# DataBinder.Eval(Container.DataItem, "tablo_tamamlanma") %>" data-order="<%# DataBinder.Eval(Container.DataItem, "tamamlanma_orani") %>">
                                                <div><div ID="is_chart<%# DataBinder.Eval(Container.DataItem, "id") %>" class="progress progress-xs" data-progressbar-value="<%# DataBinder.Eval(Container.DataItem, "tamamlanma_orani") %>"><div class="progress-bar"></div></div><span class="hiddenspan"><%# DataBinder.Eval(Container.DataItem, "tamamlanma_orani") %></span></div>
                                            </td>

                                            <td class="tablo_baslangic <%# DataBinder.Eval(Container.DataItem, "tablo_baslangic") %>" data-order="<%# DataBinder.Eval(Container.DataItem, "baslangic_tarihi_order") %>"><div><%# DataBinder.Eval(Container.DataItem, "baslangic_tarihi") %><br /><%# DataBinder.Eval(Container.DataItem, "baslangic_saati") %><span class="hiddenspan"><%# DataBinder.Eval(Container.DataItem, "baslangic_tarihi") %></span>
                                                </div><div class="lineer_yeni"><lineer renk="<%# DataBinder.Eval(Container.DataItem, "renk") %>" baslangic_tarihi="<%# DataBinder.Eval(Container.DataItem, "baslangic_tarihi") %>" baslangic_saati="<%# DataBinder.Eval(Container.DataItem, "baslangic_saati") %>" bitis_tarihi="<%# DataBinder.Eval(Container.DataItem, "bitis_tarihi") %>" bitis_saati="<%# DataBinder.Eval(Container.DataItem, "bitis_saati") %>" id="<%# DataBinder.Eval(Container.DataItem, "id") %>" adi="<%# DataBinder.Eval(Container.DataItem, "adi") %>" etiketler="<%# DataBinder.Eval(Container.DataItem, "departman_isimleri") %>" ekleyen="<%# DataBinder.Eval(Container.DataItem, "ekleyen_adsoyad") %>" ></lineer></div></td>

                                            <td class="tablo_bitis <%# DataBinder.Eval(Container.DataItem, "tablo_bitis") %>" data-order="<%# DataBinder.Eval(Container.DataItem, "bitis_tarihi_order") %>"><div><%# DataBinder.Eval(Container.DataItem, "bitis_tarihi") %><br /><%# DataBinder.Eval(Container.DataItem, "bitis_saati") %><span class="hiddenspan"><%# DataBinder.Eval(Container.DataItem, "bitis_tarihi") %></span></div></td>

                                            <td class="tablo_guncelleme <%# DataBinder.Eval(Container.DataItem, "tablo_guncelleme") %>" data-order="<%# DataBinder.Eval(Container.DataItem, "guncelleme_tarihi_order") %>"><div><%# DataBinder.Eval(Container.DataItem, "guncelleyen") %><br /><%# DataBinder.Eval(Container.DataItem, "guncelleme_tarihi") %>&nbsp;<%# DataBinder.Eval(Container.DataItem, "guncelleme_saati") %><span class="hiddenspan"><%# DataBinder.Eval(Container.DataItem, "guncelleyen") %></span></div></td>

                                            <td class="label-<%# DataBinder.Eval(Container.DataItem, "oncelik_class") %> tablo_oncelik <%# DataBinder.Eval(Container.DataItem, "tablo_oncelik") %>">
                                                <div>
                                                    <span class="label label-<%# DataBinder.Eval(Container.DataItem, "oncelik_class") %> arkaplansiz"><%# DataBinder.Eval(Container.DataItem, "oncelik") %></span>
                                                    <span class="hiddenspan"><%# DataBinder.Eval(Container.DataItem, "oncelik") %></span>
                                                </div>

                                            </td>

                                            <td class="tablo_ekleyen <%# DataBinder.Eval(Container.DataItem, "tablo_ekleyen") %>" data-order="<%# DataBinder.Eval(Container.DataItem, "ekleme_tarihi_order") %>"><div><%# DataBinder.Eval(Container.DataItem, "ekleyen_adsoyad") %><br /><strong><%# DataBinder.Eval(Container.DataItem, "ekleme_tarihi") %><br /><%# DataBinder.Eval(Container.DataItem, "ekleme_saati") %></strong><span class="hiddenspan"><%# DataBinder.Eval(Container.DataItem, "ekleyen_adsoyad") %></span></div></td>

                                            <td class="label-<%# DataBinder.Eval(Container.DataItem, "is_durum_class") %> tablo_durum <%# DataBinder.Eval(Container.DataItem, "tablo_durum") %>">
                                                <div>
                                                <span class="label label-<%# DataBinder.Eval(Container.DataItem, "is_durum_class") %> arkaplansiz"><%# DataBinder.Eval(Container.DataItem, "is_durum") %></span>
                                                    <span class="hiddenspan"><%# DataBinder.Eval(Container.DataItem, "is_durum") %></span>
                                                </div>
                                            </td>
                                        </tr>
                                        </ItemTemplate>
                                                </asp:Repeater>
                                            </asp:Panel>
                                    </tbody>
                                </table>
            </div>
    </asp:panel>

        <asp:panel id="is_ara_panel" runat="server">
        <div class="modal-header"> 
             <h5><% Response.Write(LNG("İş Arama")); %></h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
            </div>


<div id="is_ara_form" class="smart-form validateform">

      <div class="row">

          <div class="col-md-6">
            <label class="col-sm-12 col-form-label"><% Response.Write(LNG("İş :")); %></label>
            <div class="col-sm-12">
                <asp:TextBox id="is_ara_adi" style="width: 93%; padding-left: 35px; padding-top: 6px;" class="form-control" runat="server"></asp:TextBox>
            </div>
          </div>
          <div class="col-md-6">
            <label class="col-sm-12 col-form-label"><% Response.Write(LNG("İş Durumu :")); %></label>
            <div class="col-sm-12">
                <select name="is_ara_durum" class="select2" id="is_ara_durum">
                    <option value="0"><% Response.Write(LNG("Tümü")); %></option>
                    <option value="BİTTİ"><% Response.Write(LNG("BİTTİ")); %></option>
                    <option value="GECİKTİ"><% Response.Write(LNG("GECİKTİ")); %></option>
                    <option value="BEKLİYOR"><% Response.Write(LNG("BEKLİYOR")); %></option>
                    <option value="DEVAM EDİYOR"><% Response.Write(LNG("DEVAM EDİYOR")); %></option>
                    <option value="İPTAL"><% Response.Write(LNG("İPTAL")); %></option>
                </select>
            </div>
          </div>
        </div>
    <div class="row">
          <div class="col-md-6">
            <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Geçerli Görevliler :")); %></label>
            <div class="col-sm-12">
                <asp:DropDownList ID="is_ara_gorevliler" runat="server"></asp:DropDownList>
            </div>
          </div>
          <div class="col-md-6">
            <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Geçerli Firmalar :")); %></label>
            <div class="col-sm-12">
                <asp:DropDownList ID="is_ara_firmalar" runat="server"></asp:DropDownList>
            </div>
          </div>
          </div>
    <div class="row">
          <div class="col-md-6">
            <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Geçerli Projeler :")); %></label>
            <div class="col-sm-12">
                <asp:DropDownList ID="is_ara_santiyeler" runat="server"></asp:DropDownList>
            </div>
          </div>
          <div class="col-md-6">
            <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Geçerli Departmanlar :")); %></label>
            <div class="col-sm-12">
                <asp:DropDownList ID="is_ara_departmanlar" runat="server"></asp:DropDownList>
            </div>
          </div>

        </div>

    
    <div class="row">
          <div class="col-md-6">
            <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Ekleme Başlangıç Tarihi :")); %></label>
            <div class="col-sm-12">
                <input type="text" id="is_ara_baslangic_tarihi" class="takvimyap form-control" />
            </div>
          </div>
          <div class="col-md-6">
            <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Ekleme Bitiş Tarihi :")); %></label>
            <div class="col-sm-12">
                <input type="text" id="is_ara_bitis_tarihi" class="takvimyap form-control" />
            </div>
          </div>

        </div>

    
    <div class="row">
          <div class="col-md-6">
            <label class="col-sm-12 col-form-label"><% Response.Write(LNG("İş Başlangıç Tarihi :")); %></label>
            <div class="col-sm-12">
                <input type="text" id="is_baslangic_tarihi" class="takvimyap form-control" />
            </div>
          </div>
          <div class="col-md-6">
            <label class="col-sm-12 col-form-label"><% Response.Write(LNG("İş Bitiş Tarihi :")); %></label>
            <div class="col-sm-12">
                <input type="text" id="is_bitis_tarihi" class="takvimyap form-control" />
            </div>
          </div>

        </div>
    
    </div>
          <div class="modal-footer">
                    <asp:Button runat="server" class="btn btn-primary"  ID="is_ara_button" ></asp:Button>

                </div>
   

            
    </asp:panel>

        <asp:panel id="yeni_is_ekle_panel" runat="server">

        <script>
            $(function () {
                setTimeout(function () { $("#yeni_is_adi").focus() }, 1500);

                autosize($("#yeni_is_adi"));
            });

            $(function () {

                $("#yeni_is_etiketler").attr("size", "1");

                $("select#yeni_is_etiketler option[optiongroup='Departmanlar']").wrapAll("<optgroup label='Departmanlar'>");
                $("select#yeni_is_etiketler option[optiongroup='Firmalar']").wrapAll("<optgroup label='Firmalar'>");
                $("select#yeni_is_etiketler option[optiongroup='Projeler']").wrapAll("<optgroup label='Projeler'>");
                $("select#yeni_is_etiketler option[optiongroup='Toplantılar']").wrapAll("<optgroup label='Toplantılar'>");

                $("select#yeni_is_etiketler option").each(function () {
                    if ($(this).text() == "") {
                        $(this).remove();
                    }
                });

            });
        </script>

         <div class="modal-header"> 
             
             <asp:Panel id="is_ekle_baslik" runat="server">
    <h4 class="modal-title"><% Response.Write(LNG("Yeni İş Emri Ekle")); %></h4>
        </asp:Panel>
         <asp:Panel id="is_ara_baslik" runat="server">
    <h4 class="modal-title"><% Response.Write(LNG("İş Arama")); %></h4>
        </asp:Panel>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
            </div>
            <div class="modal-body">
            <div id="yeni_is_ekle_form">
                        <div class="row">
                            <div class="col-sm-12">
                                <label class="col-form-label"><% Response.Write(LNG("Yapılacak İş")); %></label>
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-cubes"></i>
                                    </span>
                                    <asp:TextBox required id="yeni_is_adi" class="yeni_is_adi form-control" style="width: 95%;  padding-top: 6px;" runat="server"></asp:TextBox>
                                </div>
                            </div>

                           


                            <div style="display:none">
                                <label class="col-sm-12 col-form-label" style="padding-left:0;"><% Response.Write(LNG("Renk")); %></label>
                                <!--<input type="hidden" id="renk" class="demo" value="#FC6180">-->
                                <input type='text' id="renk" value="rgb(52, 152, 219)" />
                            </div>
                              <script type="text/javascript">
                                  $(function () {
                                      $("#renk").spectrum({
                                          color: $(this).val(),
                                          showPaletteOnly: true,
                                          showPalette: true,
                                          hideAfterPaletteSelect: true,
                                          change: function (color) {
                                              $(this).val(color);
                                          },
                                          palette: [
                                              ["rgb(231, 76, 60)", "rgb(26, 188, 156)", "rgb(46, 204, 113)", "rgb(52, 152, 219)", "rgb(241, 196, 15)", "rgb(52, 73, 94)"]
                                          ]
                                      });
                                      $(".dortlu").attr("class", "col-sm-6 dortlu");
                                      $(".uclu").attr("class", "col-sm-6 uclu");
                                      $(".takvimyap_yeni").css("max-width", "");
                                      $(".timepicker").css("max-width", "");
                                      $(".sinirlama_yeri").hide();
                                      $("#sinirlama_varmi").removeAttr("checkeds");
                                      is_ekle_yeni_takvim_calistir();
                                      $("#yeni_is_baslangic_tarihi").datepicker('setDate', new Date());
                                      $("#yeni_is_bitis_tarihi").datepicker('setDate', new Date());
                                  })
                            </script>
                        </div>

                <div class="row" style="display:none">
                 <div class="col-sm-12">
                                <label class="col-form-label"><% Response.Write(LNG("İş Tipi")); %></label>
                                 
                                <div class="">
                                    <select class="select2" name="is_tipi" id="is_tipi">
                                        <option value="Rutin">Rutin</option>
                                        <option value="Servis">Servis</option>
                                    </select>
                                </div>
                            </div></div>

                                                     <div class="row">

                                 <div class="col-md-12">
                                    <div class="col-sm-12" style="vertical-align: bottom; padding-left: 0; padding-top: 10px; ">
                                        <label for="sinirlama_varmi" style="cursor:pointer;"><input type="checkbox" onclick="sinirlama_gorunum_degis();" class="js-switch" id="sinirlama_varmi" /> <% Response.Write(LNG("Süre Sınırlama")); %></label>
                                    </div>
                                </div>

                                <div class="col-sm-4 dortlu" style="padding:0;">
                                    <label class="col-sm-12 col-form-label"><% Response.Write(LNG("İşe Başlama")); %></label>
                                    <div class="col-sm-12">
                                        <div class="input-group input-group-primary">
                                            <span class="input-group-addon">
                                                <i class="icon-prepend fa fa-calendar"></i>
                                            </span>
                                            <input type="text" id="yeni_is_baslangic_tarihi" name="yeni_is_baslangic_tarihi" onkeyup="yeni_is_ekle_sure_hesap();" required class="takvimyap_yeni" style="padding-left:10px; max-width:110px;" value="<%DateTime.Today.ToShortTimeString();%>" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3 uclu" style="padding:0;">
                                    <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Saat")); %></label>
                                    <div class="col-sm-12">
                                        <div class="input-group input-group-primary">
                                            <span class="input-group-addon">
                                                <i class="icon-prepend fa fa-calendar"></i>
                                            </span>
                                            <input type="text" id="yeni_is_baslangic_saati" onkeyup="yeni_is_ekle_sure_hesap();" required class="timepicker" style="padding-left:10px; max-width:55px;" value="<%Response.Write(DateTime.Now.ToShortTimeString()); %>" />
                                        </div>
                                    </div>
                                </div>
                                 
                                <div class="col-sm-5 sinirlama_yeri" style="padding:0; display:none; ">
                                    <label class="col-sm-12 col-form-label" style="font-size:12px;"><% Response.Write(LNG("Günlük Ort. Çalışma(saat)")); %></label>
                                    <div class="col-sm-12">
                                        <span style="float:left;"><input type="text" onkeyup="yeni_is_ekle_sure_hesap();" id="yeni_is_gunluk_ortalama_calisma" required value="0.25" style="padding-left:10px; width:65px;" class="form-control" /></span><span style="float:left;font-size: 18px;
                                                padding: 5px;"> X </span><span style="float:left;font-size: 18px;
                                                padding: 5px;" id="gunluk_gun_hesap_yeri"<% Response.Write(LNG(">1 gün")); %></span>
                                    </div>
                                </div>

                            </div>

                            <div class="row">
                                <div class="col-sm-4 dortlu" style="padding:0;">
                                    <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Planlanan Bitiş :")); %></label>
                                    <div class="col-sm-12">
                                        <div class="input-group input-group-primary">
                                            <span class="input-group-addon">
                                                <i class="icon-prepend fa fa-calendar"></i>
                                            </span>
                                            <input type="text" id="yeni_is_bitis_tarihi" onkeyup="yeni_is_ekle_sure_hesap();" name="yeni_is_bitis_tarihi" required class="takvimyap_yeni" style="padding-left:10px; max-width:110px;" value="<%DateTime.Today.ToShortDateString(); %>" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3 uclu" style="padding:0;">
                                    <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Saat :")); %></label>
                                    <div class="col-sm-12">
                                        <div class="input-group input-group-primary">
                                            <span class="input-group-addon">
                                                <i class="icon-prepend fa fa-calendar"></i>
                                            </span>
                                            <%
                                                string bitis_saati = DateTime.Now.AddMinutes(15).ToShortTimeString();
                                            %>
                                            <input type="text" id="yeni_is_bitis_saati" onkeyup="yeni_is_ekle_sure_hesap();" required class="timepicker" style="padding-left:10px; max-width:55px;" value="<%Response.Write(bitis_saati); %>" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-5 sinirlama_yeri" style="padding:0; display:none;">
                                    <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Toplam Çalışma(saat)")); %></label>
                                    <div class="col-sm-12">
                                        <div class="input-group input-group-primary">
                                            <input type="text" id="yeni_is_toplam_calisma" onkeyup="yeni_is_ekle_sure_hesap2();" required value="0.25" style="padding-left:10px; " class="form-control" />
                                        </div>
                                    </div>
                                </div>


                            </div>

                        <div class="row" style="display:none;">
                            <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Açıklama")); %></label>
                            <div class="col-sm-12">
                               <textarea rows="3" style="width:100%;" required id="yeni_is_aciklama" class="form-control"></textarea>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-6">
                                <label class=" col-form-label"><% Response.Write(LNG("Görevliler")); %></label>
                                <div class="">
                                   <asp:DropDownList ID="yeni_is_gorevliler" runat="server"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <label class="col-form-label"><% Response.Write(LNG("Etiketler")); %></label>
                                <div class="">
                                   <asp:ListBox ID="yeni_is_etiketler" runat="server"></asp:ListBox>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-12">
                                <label for="is_ajandada_goster" style="float:left; cursor:pointer; margin-top:10px" ><input type="checkbox" checked class="js-switch" onclick="is_ajandada_goster_secim();" id="is_ajandada_goster" /> <% Response.Write(LNG("Ajanda da Göster")); %></label>
                            </div>
                        </div>

                        <div id="ekleme_detay">
                            <div class="row">
                                <div class="col-sm-6">
                                    <label class=" col-form-label"><% Response.Write(LNG("Öncelik")); %></label>
                                    <div>
                                       <select id="yeni_is_oncelik" class="select2">
                                        <option value="Düşük"><% Response.Write(LNG("Düşük")); %></option>
                                        <option value="Normal" selected><% Response.Write(LNG("Normal")); %></option>
                                        <option value="Yüksek"><% Response.Write(LNG("Yüksek")); %></option>
                                    </select>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <label class="col-form-label"><% Response.Write(LNG("Kontrol ve Bildirim")); %></label>
                                    <div>
                                       <asp:DropDownList ID="yeni_is_kontrol_bildirim" multiple="multiple" class="select2" runat="server"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                     <%--       <div class="row">
                                <div class="col-sm-4" style="padding:0;">
                                    <label class="col-sm-12 col-form-label">İşe Başlama</label>
                                    <div class="col-sm-12">
                                        <div class="input-group input-group-primary">
                                            <span class="input-group-addon">
                                                <i class="icon-prepend fa fa-calendar"></i>
                                            </span>
                                            <input type="text" id="yeni_is_baslangic_tarihi" onkeyup="yeni_is_ekle_sure_hesap();" required class="takvimyap_yeni" style="padding-left:10px; max-width:80px;" value="<%Response.Write(DateTime.Today.ToShortDateString()); %>" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3" style="padding:0;">
                                    <label class="col-sm-12 col-form-label">Saat</label>
                                    <div class="col-sm-12">
                                        <div class="input-group input-group-primary">
                                            <span class="input-group-addon">
                                                <i class="icon-prepend fa fa-calendar"></i>
                                            </span>
                                            <input type="text" id="yeni_is_baslangic_saati" onkeyup="yeni_is_ekle_sure_hesap();" required class="timepicker" style="padding-left:10px; max-width:55px;" value="08:00" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-5 sinirlama_yeri" style="padding:0; display:none;">
                                    <label class="col-sm-12 col-form-label">Günlük Ort. Çalışma(saat)</label>
                                    <div class="col-sm-12">
                                        <span style="float:left;"><input type="text" onkeyup="yeni_is_ekle_sure_hesap();" id="yeni_is_gunluk_ortalama_calisma" required value="8" style="padding-left:10px; width:65px;" class="form-control" /></span><span style="float:left;font-size: 14px; padding: 5px;"> X </span><span style="float:left;font-size: 14px; padding: 5px;" id="gunluk_gun_hesap_yeri">1 gün</span>
                                    </div>
                                </div>

                            </div>

                            <div class="row">
                                <div class="col-sm-4" style="padding:0;">
                                    <label class="col-sm-12 col-form-label" style="font-size:13px;">Planlanan Bitiş</label>
                                    <div class="col-sm-12">
                                        <div class="input-group input-group-primary">
                                            <span class="input-group-addon">
                                                <i class="icon-prepend fa fa-calendar"></i>
                                            </span>
                                            <input type="text" id="yeni_is_bitis_tarihi" onkeyup="yeni_is_ekle_sure_hesap();" required class="takvimyap_yeni" style="padding-left:10px; max-width:80px;" value="<%Response.Write(DateTime.Today.ToShortDateString()); %>" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-3" style="padding:0;">
                                    <label class="col-sm-12 col-form-label">Saat :</label>
                                    <div class="col-sm-12">
                                        <div class="input-group input-group-primary">
                                            <span class="input-group-addon">
                                                <i class="icon-prepend fa fa-calendar"></i>
                                            </span>
                                            <input type="text" id="yeni_is_bitis_saati" onkeyup="yeni_is_ekle_sure_hesap();" required class="timepicker" style="padding-left:10px; max-width:55px;" value="18:00" />
                                        </div>
                                    </div>
                                </div>

                                

                                <div class="col-sm-5 sinirlama_yeri" style="  display:none;">
                                    <label class="col-sm-12 col-form-label" >Toplam Çalışma(saat)</label>
                                    <div class="col-sm-12">
                                        <div class="input-group input-group-primary">
                                            <input type="text" id="yeni_is_toplam_calisma" onkeyup="yeni_is_ekle_sure_hesap2();" required value="08:00" style="padding-left:10px; " class="form-control" />
                                        </div>
                                    </div>
                                </div>


                            </div>--%>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" class="btn btn-primary"  ID="yeni_is_ekle_button"></asp:Button>
                </div>
    </asp:panel>
        <asp:panel class="row" id="is_detay_panel" style="padding: 10px;" runat="server">
        <style>
            @media screen and (max-width:767px) {

                .mobil_iptal {
                    display: none !important;
                }

                #demo-pill-nav li a {
                    padding: 5px !important;
                }
            }
        </style>
        <div class="col-lg-4 col-md-12">
            <br />
            <br>
            <div style="display:none;">
            <div class="mobil_iptal" style="text-align:right;">
                <a class="btn btn-labeled btn-success btn-mini" href="javascript:void(0);" style=" margin-top:-27px;"><span class="btn-label"><i class="fa fa-download"></i></span><% Response.Write(LNG("İndir")); %> </a>&nbsp;&nbsp;<a class="btn btn-labeled btn-warning btn-mini" href="javascript:void(0);" style=" margin-top:-27px;"><span class="btn-label"><i class="fa fa-print"></i></span><% Response.Write(LNG("Yazdır")); %> </a>&nbsp;&nbsp;<a class="btn btn-labeled btn-primary btn-mini" href="javascript:void(0);" style=" margin-top:-27px;"><span class="btn-label"><i class="fa fa-send "></i></span><% Response.Write(LNG("Gönder")); %> </a>
            </div></div>
            <div class="well ">
                <table border="0" cellpadding="5" cellspacing="0" class="tablom_detay" style="width:100%; ">
                    <tr style="display:none;">
                        <td style="width:100px"><strong><% Response.Write(LNG("Adı")); %></strong></td>
                        <td style="width:10px;">:</td>
                        <td>
                            <asp:Label ID="is_detay_aciklama" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3"><div style="float:left; width:160px;"><strong><% Response.Write(LNG("İş Tanımı")); %></strong></div>:&nbsp;&nbsp;&nbsp;<asp:Label ID="is_detay_adi" runat="server"></asp:Label></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td  style="width:150px"><strong><% Response.Write(LNG("Görevliler")); %></strong></td>
                        <td style="width:5px;">:</td>
                        <td>
                            <asp:Label ID="is_detay_gorevliler" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td><strong><% Response.Write(LNG("Etiketler")); %></strong></td>
                        <td>:</td>
                        <td>
                            <asp:Label ID="is_detay_depatmanlar" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td><strong><% Response.Write(LNG("Öncelik")); %></strong></td>
                        <td>:</td>
                        <td>
                            <asp:Label ID="is_detay_oncelik" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td><strong><% Response.Write(LNG("Planlanan Başlangıç")); %></strong></td>
                        <td>:</td>
                        <td>
                            <asp:Label ID="is_detay_baslangic" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td><strong><% Response.Write(LNG("Planlanan Bitiş")); %></strong></td>
                        <td>:</td>
                        <td>
                            <asp:Label ID="is_detay_bitis" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td><strong><% Response.Write(LNG("Kontrol ve Bildirim")); %></strong></td>
                        <td>:</td>
                        <td>
                            <asp:Label ID="is_detay_bildirim" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
            <br />

            

            <asp:Panel ID="kayit_edit_butonlar" runat="server">
                 


            <asp:HyperLink ID="kaydi_duzenle_buton" runat="server"> <span class="btn-label"><i class="fa fa-edit "></i></span><% Response.Write(LNG("Kaydı Düzenle")); %></asp:HyperLink>
            <asp:HyperLink ID="is_iptal_buton" runat="server"> <span class="btn-label"><i class="fa fa-times"></i></span><% Response.Write(LNG("İşi İptal Et")); %></asp:HyperLink>
            <div style="display:none;">
                <asp:TextBox id="guncel_lineer" runat="server"></asp:TextBox>
                <script>
                    $(function () {
                        vis_element_guncelle();
                    });
                </script>
            </div>
            <br />
            <br /></asp:Panel>
        </div>
        <div class="col-lg-7 col-md-12">
            <div class="widget-body">
                <div class="tabs-top">
                    <ul class="nav nav-tabs  tabs is_tab ictab" role="tablist">
                                                                    <li class="nav-item">
                                                                        <a class="nav-link ictab active" data-toggle="tab" href="#tab-r1" role="tab"><% Response.Write(LNG("İş Durumu")); %></a>
                                                                    </li>
                                                                    <li class="nav-item">
                                                                        <a class="nav-link ictab" data-toggle="tab" href="#tab-r2" runat="server" id="is_yazisma_tab_buton" onclick="is_yazisma_yeni_gonder();" role="tab"><% Response.Write(LNG("Yazışmalar")); %></a>
                                                                    </li>
                                                                    <li class="nav-item">
                                                                        <a class="nav-link ictab" data-toggle="tab" href="#tab-r3" runat="server" id="dosya_listesi_tab_buton" onclick="dosya_listesi_getir();" role="tab"><% Response.Write(LNG("Dosyalar")); %></a>
                                                                    </li>
                                                                    <li class="nav-item mobil_iptal">
                                                                        <a class="nav-link ictab" data-toggle="tab" href="#tab-r4" class="mobil_iptal" data-toggle="tab" role="tab"><% Response.Write(LNG("Bildirimler")); %></a>
                                                                    </li>
                                                                </ul>
                                                                <!-- Tab panes -->
                                                                <div class="tab-content tabs card-block">
                                                                    <div class="tab-pane active" id="tab-r1" role="tabpanel">
                                                                         <legend><% Response.Write(LNG("Görevliler")); %></legend>

                            <asp:Repeater ID="gorevli_durumlari" runat="server">
                                <ItemTemplate>
                                    <asp:Panel ID="is_yetkili_durum" runat="server">
                                        
                                        <div class="row">
                            <div class="col-xs-1">
                                <a rel="tooltip" data-original-title="<%# DataBinder.Eval(Container.DataItem, "Personel_adi") %>" data-placement="top" href="javascript:void(0)">
                                    <img style="width:100%; min-width:21px;" src="<%# DataBinder.Eval(Container.DataItem, "Personel_resim") %>" class="online"></a>
                            </div>
                            <div class="col-xs-8">
                                &nbsp;&nbsp;&nbsp;<% Response.Write(LNG("İşin Tamamlanma Durumu : ")); %><br />
                                <div start="<%# DataBinder.Eval(Container.DataItem, "tamamlanma_durum") %>" class="yeni_slider"  IsID="<%# DataBinder.Eval(Container.DataItem, "IsID") %>" TamamlanmaID="<%# DataBinder.Eval(Container.DataItem, "TamamlanmaID") %>" id="is_durum<%# DataBinder.Eval(Container.DataItem, "TamamlanmaID") %>" value="<%# DataBinder.Eval(Container.DataItem, "tamamlanma_durum") %>" ></div>
                                <%--<div style="display:none;">
                                <input type="text" class="slider_durum" planlama_varmi="<%# DataBinder.Eval(Container.DataItem, "planlama_varmi") %>" IsID="<%# DataBinder.Eval(Container.DataItem, "IsID") %>" TamamlanmaID="<%# DataBinder.Eval(Container.DataItem, "TamamlanmaID") %>" id="is_durum<%# DataBinder.Eval(Container.DataItem, "TamamlanmaID") %>" value="<%# DataBinder.Eval(Container.DataItem, "tamamlanma_durum") %>"  data-slider-max="100" data-slider-min="0" data-slider-value="<%# DataBinder.Eval(Container.DataItem, "tamamlanma_durum") %>" data-slider-selection="before" data-slider-handle="round" style="margin-bottom:5px!important; " ></div>--%>
                                <br />
                                <span style="float:left;">
                                        <asp:Panel ID="planlama_yetkili_panel" runat="server">
                                            <table style="text-align:center;">
                                                <tr>
                                                    <td style="padding-right:15px;"><% Response.Write(LNG("Planlanan Çalışma(saat)")); %></td>
                                                    <td style="padding-right:15px;"><% Response.Write(LNG("Harcanan Süre")); %></td>
                                                    <td><% Response.Write(LNG("Kalan Süre")); %></td>
                                                </tr>
                                                <tr>
                                                    <td  style="padding-right:15px;"><strong style="font-size:15px;"><%# DataBinder.Eval(Container.DataItem, "planlanan_calisma") %></strong></td>
                                                    <td style="padding-right:15px;"><i class="fa fa-clock-o"></i><strong style="font-size:15px;"><%# DataBinder.Eval(Container.DataItem, "harcanan_sure") %></strong></td>
                                                    <td ><i class="fa fa-clock-o"></i><strong style="font-size:15px;"><%# DataBinder.Eval(Container.DataItem, "kalan_sure") %></strong></td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                        <asp:Panel ID="planlama_yetkili_panel_plansiz" runat="server">
                                            <table style="text-align:center;">
                                                <tr>
                                                    <td><% Response.Write(LNG("Harcanan Süre")); %></td>
                                                </tr>
                                                <tr>
                                                    <td><i class="fa fa-clock-o"></i><strong style="font-size:15px;"><%# DataBinder.Eval(Container.DataItem, "harcanan_sure") %></strong></td>
                                                </tr>
                                            </table>
                                        </asp:Panel>

                                </span>
                                <span style="float:right;"><% Response.Write(LNG("Son Güncelleme :")); %> <%# DataBinder.Eval(Container.DataItem, "tamamlanma_zamani") %></span>
                            </div>
                                            
                                <div class="col-xs-1 hidden-xs" style="padding-top:5px;">
                                    <input id="easyPieChart<%# DataBinder.Eval(Container.DataItem, "TamamlanmaID") %>" type="text" class="dial easyPieChartlar" value="<%# DataBinder.Eval(Container.DataItem, "tamamlanma_durum") %>" data-width="68" data-height="75" data-linecap="round" data-displayprevious="true" data-displayInput="true" data-readonly="true" data-fgColor="#4ECDC4">
</div>
                                            <div class="col-xs-1" style="padding-top:5px;">
                                            <input type="button" class="btn btn-danger btn-sm" onclick="is_personel_durt('<%# DataBinder.Eval(Container.DataItem, "PersonelID") %>    ','<%# DataBinder.Eval(Container.DataItem, "IsID") %>    ');" value="Dürt" />
                                            </div>
                            </div> <hr />
                                    </asp:Panel>
                                    <asp:Panel ID="is_yetkisiz_durum" runat="server">
                                        
                                        <div class="row">
                            <div class="col-xs-1">
                                <a rel="tooltip" data-original-title="<%# DataBinder.Eval(Container.DataItem, "Personel_adi") %>" data-placement="top" href="javascript:void(0)">
                                    <img style="width:100%;  min-width:21px;" src="<%# DataBinder.Eval(Container.DataItem, "Personel_resim") %>" class="online"></a>
                            </div>
                                            <div class="col-xs-1">
                                                <input id="easyPieChartlar" type="text" class="dial easyPieChartlar" value="<%# DataBinder.Eval(Container.DataItem, "tamamlanma_durum") %>" data-width="68" data-height="75" data-linecap="round" data-displayprevious="true" data-displayInput="true" data-readonly="true" data-fgColor="#40c4ff">

                                            </div>
                            <div class="col-xs-8">
                                <% Response.Write(LNG("İşin Tamamlanma Durumu : ")); %><br />
                                <div class="nprogress">
                                <div class="nprogress-bar nprogress-bar-striped nprogress-bar-success" role="progressbar" style="width: <%# DataBinder.Eval(Container.DataItem, "tamamlanma_durum") %>%" aria-valuenow="<%# DataBinder.Eval(Container.DataItem, "tamamlanma_durum") %>" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
<%--                                <div class="progress-bar bg-color-blue" aria-valuetransitiongoal="<%# DataBinder.Eval(Container.DataItem, "tamamlanma_durum") %>" aria-valuenow="<%# DataBinder.Eval(Container.DataItem, "tamamlanma_durum") %>" style="width: <%# DataBinder.Eval(Container.DataItem, "tamamlanma_durum") %>%;"><%# DataBinder.Eval(Container.DataItem, "tamamlanma_durum") %>%</div>--%>
                                <br /><span style="float:left;">
                                    <asp:Panel ID="planlama_yetkisiz_panel" runat="server">
                                            <table style="text-align:center;">
                                                <tr>
                                                    <td style="padding-right:15px;"><% Response.Write(LNG("Planlanan Çalışma(saat)")); %></td>
                                                    <td style="padding-right:15px;"><% Response.Write(LNG("Harcanan Süre")); %></td>
                                                    <td><% Response.Write(LNG("Kalan Süre")); %></td>
                                                </tr>
                                                <tr>
                                                    <td  style="padding-right:15px;"><strong style="font-size:15px;"><%# DataBinder.Eval(Container.DataItem, "planlanan_calisma") %></strong></td>
                                                    <td style="padding-right:15px;"><i class="fa fa-clock-o"></i><strong style="font-size:15px;"><%# DataBinder.Eval(Container.DataItem, "harcanan_sure") %></strong></td>
                                                    <td ><i class="fa fa-clock-o"></i><strong style="font-size:15px;"><%# DataBinder.Eval(Container.DataItem, "kalan_sure") %></strong></td>
                                                </tr>
                                            </table>
                                        </asp:Panel>

                                    <asp:Panel ID="planlama_yetkisiz_panel_plansiz" runat="server">
                                            <table style="text-align:center;">
                                                <tr>
                                                    <td><% Response.Write(LNG("Harcanan Süre")); %></td>
                                                </tr>
                                                <tr>
                                                    <td><i class="fa fa-clock-o"></i><strong style="font-size:15px;"><%# DataBinder.Eval(Container.DataItem, "harcanan_sure") %></strong></td>
                                                </tr>
                                            </table>
                                        </asp:Panel>

                                </span><span style="float:right;padding-top:0px;"><% Response.Write(LNG("Son Güncelleme : ")); %><%# DataBinder.Eval(Container.DataItem, "tamamlanma_zamani") %></span>
                            </div>
                                            <div class="col-xs-1 " style="padding-top:5px;">
                                            <input type="button" class="btn btn-danger btn-sm" onclick="is_personel_durt('<%# DataBinder.Eval(Container.DataItem, "PersonelID") %>','<%# DataBinder.Eval(Container.DataItem, "IsID") %>');" value="<% Response.Write(LNG("Dürt")); %>" />
                                            </div>
                            </div>
                                         <hr />
                                    </asp:Panel>
                                </ItemTemplate>
                            </asp:Repeater>
                            
                           
                            
                            

                                                                    </div>
                                                                    <div class="tab-pane" id="tab-r2" role="tabpanel">
                                                                        <asp:Panel ID="chatBody" runat="server"></asp:Panel>
                            <div class="input-group wall-comsment-reply" style="width:85%; padding-left:96px!important;">
                                <asp:TextBox ID="chat_yazi" runat="server" onkeyup="return false;"></asp:TextBox>
								<span class="input-group-btn">
                                    <asp:HyperLink ID="yazisma_gonder_button" style="margin-left:15px; color:white;" runat="server">
										<i class="fa fa-reply"></i> <% Response.Write(LNG("Gönder")); %>
									</asp:HyperLink>
									</span>
							</div>
                                                                    </div>
                                                                    <div class="tab-pane" id="tab-r3" role="tabpanel">
                                                                        <div class="row"><br />
                            <div class="col-md-3">
                            <h4><% Response.Write(LNG("Dosya Ekle")); %></h4><br />
                                <asp:FileUpload ID="dosya_ekleme" runat="server"></asp:FileUpload>
                                <img src="/img/loader_green.gif" id="fileLoading" style="display:none"/>
                            <br />
                                <% Response.Write(LNG("Dosya Adı:")); %><br />
                                <asp:TextBox ID="dosya_adi" runat="server"></asp:TextBox><br />
                                <br />
                                <asp:Button runat="server" ID="dosya_kaydet_buton"></asp:Button><br />
                            
                                </div>
                                <div class="col-md-8"><h4><% Response.Write(LNG("Dosya Listesi")); %></h4><br />
                                    <div class="table-responsive">
										
                                        <asp:Panel ID="dosya_listesi" runat="server"></asp:Panel>
											
											
										</div>
                                    </div>
                                </div>
                                                                    </div>
                                                                    <div class="tab-pane mobil_iptal" id="tab-r4" role="tabpanel">
                                                                        <asp:ListBox ID="is_detay_kontrol_bildirim" runat="server"></asp:ListBox><br /><br />
                            <asp:Button runat="server" ID="is_kontrol_bildirim_guncelle_button" Text="Güncelle"></asp:Button>
                                                                    </div>
                                                                </div>


             
                </div>
            </div>
        </div>
    </asp:panel>
</form>

<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.10/js/select2.min.js"></script>

<script type="text/javascript">
    $(document).ready(function () {
        $('.js-example-basic-multiple').select2();
    });
</script>
