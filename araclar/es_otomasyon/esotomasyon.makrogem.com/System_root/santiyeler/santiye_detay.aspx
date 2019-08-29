<%@ Page Language="C#" AutoEventWireup="true" CodeFile="santiye_detay.aspx.cs" Inherits="System_root_santiyeler_santiye_detay" %>

<form autocomplete="off" id="form1" runat="server">
    <style>
        .label {
            font-size: 90% !important;
            font-weight: normal !important;
        }
    </style>
    <div class="card page-header p-0" style="display:none;">
        <div class="card-block front-icon-breadcrumb row align-items-end">
            <div class="breadcrumb-header col">
                <div class="big-icon">
                    <i class="fa fa-map-o"></i>
                </div>
                <div class="d-inline-block">
                    <h5>
                        <asp:label runat="server" id="santiye_adi_label"></asp:label>
                    </h5>
                    <span>
                        <asp:label runat="server" id="firma_adi_label"></asp:label>
                    </span>
                </div>
            </div>
            <div class="col">
                <div class="page-header-breadcrumb">
                    <ul class="breadcrumb-title">
                        <li class="breadcrumb-item"><a href="javascript:void(0);" onclick="santiye_sil('<%Response.Write(Request.Form["id"].ToString()); %>');" class="btn btn-labeled btn-danger btn-mini btn-round" style="color: white;"><span class="btn-label" style="color: white;"><i class="fa fa-trash-o"></i></span>&nbsp;<% Response.Write(LNG("Projeyi Sil")); %></a>
                        </li>
                        <li class="breadcrumb-item"><a href="javascript:void(0);" onclick="sayfagetir('/santiyeler/','jsid=4559&acilacak=<%Response.Write(Request.Form["departman_id"].ToString()); %>');" class="btn btn-labeled btn-success btn-mini  btn-round" style="color: white;"><span class="btn-label" style="color: white;"><i class="fa fa-history"></i></span>&nbsp;<% Response.Write(LNG("Geri Dön")); %></a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    

    <div class="row">
        <div class="col-sm-12">
            <div class="well" style="background-color: white!important;">
                <div class="row" style="padding-top: 20px;">
                    <form id="wizard-1" novalidate="novalidate">
                        <div id="bootstrap-wizard-1" class="col-sm-12">
                            <div class="form-bootstrapWizard">
                                <ul class="bootstrapWizard form-wizard">

                                    <li data-target="#step0">
                                        <a href="#tab0" class="active wizard_tab" onclick="wizard_renklendirme();" data-toggle="tab"><span class="step">
                                            <asp:label runat="server" id="santiye_genel_span" text="0"></asp:label>
                                        </span><span class="title">&nbsp;<% Response.Write(LNG("Genel")); %>&nbsp;</span> </a>
                                    </li>

                                    <asp:repeater id="santiye_durum_repater" runat="server">
                                    <ItemTemplate>
                                        <li  data-target="#step<%# DataBinder.Eval(Container.DataItem, "rowid") %>">
                                            <a class="wizard_tab"  href="#tab<%# DataBinder.Eval(Container.DataItem, "rowid") %>" onclick="santiye_detay_tab_getir('<%Response.Write(Request.Form["id"].ToString()); %>','<%# DataBinder.Eval(Container.DataItem, "rowid") %>', '<%# DataBinder.Eval(Container.DataItem, "id") %>');wizard_renklendirme();" data-toggle="tab"><span class="step"><%# DataBinder.Eval(Container.DataItem, "gosterge_sayisi") %>/<%# DataBinder.Eval(Container.DataItem, "is_sayisi") %></span> <span class="title"><%# DataBinder.Eval(Container.DataItem, "departman_adi") %></span> </a>
                                        </li>
                                    </ItemTemplate>
                                </asp:repeater>


                                </ul>
                                <div class="clearfix"></div>
                            </div>
                            <div class="tab-content">
                                <div class="tab-pane active" id="tab0">
                                    <div style="padding-top: 30px;">
                                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-8" style="padding-top: 15px;">

                                            <div class="z-depth-top-0" style="margin-top: 15px; padding: 10px;">
                                                <h4 style="margin-bottom:20px;"><% Response.Write(LNG("Proje Olay Çizelgesi")); %></h4>
                                                <asp:panel id="olay_yok_panel" runat="server">
                <ItemTemplate>
                    <center><br /><br /><i style="font-size:50px; color:#f53232;" class="fa fa-flag"></i><br /><br /><% Response.Write(LNG("Proje Olay Kaydı Bulunamadı")); %></center>
                </ItemTemplate>
            </asp:panel>
                                                <div class="tree">
                                                    <asp:repeater id="ay_repeater" runat="server">
                        <ItemTemplate>
                <ul>
                    <li><span class="label label-inverse-primary" style="   
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
                                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-4">



                                            <div id="santiye_guncelle_form" runat="server" class="smart-form validateform" style="padding-top: 15px;">

                                                <div class="row">
                                                    <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Firma")); %> </label>
                                                    <div class="col-sm-12">
                                                        <div class="input-group input-group-primary">
                                                            <asp:dropdownlist id="firma_id" class="form-control select2" runat="server"></asp:dropdownlist>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Proje Durum")); %> </label>
                                                    <div class="col-sm-12">
                                                        <asp:dropdownlist id="santiye_durum_id" class="form-control select2" runat="server"></asp:dropdownlist>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Proje Adı")); %> </label>
                                                    <div class="col-sm-12">
                                                        <div class="input-group input-group-primary">
                                                            <span class="input-group-addon">
                                                                <i class="icon-prepend fa fa-user"></i>
                                                            </span>
                                                            <asp:textbox id="proje_adi" required class="form-control" runat="server"></asp:textbox>
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
                                                    <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Enlem")); %> </label>
                                                    <div class="col-sm-12">
                                                        <div class="input-group input-group-primary">
                                                            <span class="input-group-addon">
                                                                <i class="icon-prepend fa fa-user"></i>
                                                            </span>
                                                            <asp:textbox id="enlem" class="form-control" runat="server"></asp:textbox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row" style="display:none;">
                                                    <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Boylam")); %> </label>
                                                    <div class="col-sm-12">
                                                        <div class="input-group input-group-primary">
                                                            <span class="input-group-addon">
                                                                <i class="icon-prepend fa fa-user"></i>
                                                            </span>
                                                            <asp:textbox id="boylam" class="form-control" runat="server"></asp:textbox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row" style="display:none;">
                                                    <label class="col-sm-12 col-form-label"><% Response.Write(LNG("Supervisor")); %> </label>
                                                    <div class="col-sm-12">
                                                        <asp:dropdownlist id="firma_supervisor_id" class="form-control select2" runat="server"></asp:dropdownlist>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row modal-footer" style="margin-top: 20px;">
                                                <input type="button" class="btn btn-mini btn-primary" onclick="proje_guncelle('<%Response.Write(Request.Form["id"].ToString());%>');" value="<% Response.Write(LNG("Proje Güncelle")); %>" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <asp:repeater id="santiye_tab_repeater" runat="server">
                                <ItemTemplate>
                                    <div class="tab-pane tablar" id="tab<%# DataBinder.Eval(Container.DataItem, "rowid") %>">
                                
                                    </div>
                                </ItemTemplate>
                            </asp:repeater>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script>
        $(function () {
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
    </script>
</form>
