<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    baslangic = trn(request("start"))
    bitis = trn(request("end"))

    dongu_baslangic = cdate(date)
    dongu_bitis = cdate(date) + 185

%>
<div id="is_yuku_birinci_ekran">
    <style>
        .guncizelge {
            width: 30px;
            text-align:center; 
            margin-left:auto; 
            margin-right:auto;
        }

        .ikincisi td {
            background-color: #f8f5f5;
        }

        .ilkth {
            width: 150px;
            padding: 5px;
            background-color: #32506d;
            color: white;
            line-height: 25px;
            border: solid 1px #e8e8e8;
        }

        .ust_th_ilk {
            background-color: #32506d;
            border: solid 1px #e8e8e8;
            border-left: 3px solid #32506d;
            color: white;
            line-height: 40px;
            vertical-align: bottom;
            padding: 5px;
        }

        .ust_th {
            background-color: #32506d;
            border: solid 1px #e8e8e8;
            border-left: solid 3px white;
            color: white;
            line-height: 40px;
            vertical-align: bottom;
            padding: 5px;
        }

        .alt_th {
            text-align: center;
            background-color: #4d7193;
            border: solid 1px #e8e8e8;
            color: white;
            line-height: 25px;
        }

        .ustunegelince {
            background-color: #fff;
        }


        .ustunegelince2 td {
            background-color: #cce6ff !important;
        }

        .ust_td2 {
            border: solid 1px #e8e8e8;
            padding: 5px;
            line-height: 20px;
            font-weight: bold;
            background-color:#32506d!important;
            color:white!important;
        }

        .gosterge_td {
            text-align:center;
            background-color: #4d7193!important;
            color:white!important;
        }

        .sagcizgi {
            border-right: 3px solid #32506d!important;
        }

        .alt_td {
            text-align: center;
            border: solid 1px #e8e8e8;
            line-height: 20px;
            padding:5px;
        }

        .alt_td2 {
            border-left: 3px solid #32506d;
        }

        .sarialan {
            background-color: #f5ffa6 !important;
        }


        .tablediv {
            padding-bottom: 15px;
        }


            .tablediv::-webkit-scrollbar-track {
                -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
                border-radius: 10px;
                background-color: #F5F5F5;
            }

            .tablediv::-webkit-scrollbar {
                width: 12px;
                background-color: #F5F5F5;
            }

            .tablediv::-webkit-scrollbar-thumb {
                border-radius: 10px;
                -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
                background-color: #32506d;
            }
    </style>
<script>

    $(function (){

        $(".ustunegelince").hover(function (){
            $(this).addClass("ustunegelince2");
        },function (){
            $(this).removeClass("ustunegelince2");
        });

    });
</script>
<div style="margin: 3%; margin-bottom: 0;">
    <table>
        <tr>
            <td>İş Yükü Gösterim Tipi</td>
            <td style="width: 30px;">:</td>
            <td style="width: 200px; padding-right:15px;">
                <select name="yeni_is_yuku_gosterim_tipi" onchange="is_yuku_gosterim_proje_sectim('<%=cdate(dongu_baslangic) %>', '<%=cdate(dongu_bitis) %>');" id="yeni_is_yuku_gosterim_tipi">
                    <option value="0">Günlük İş Sayıları</option>
                    <option value="1">Günlük İş Saatleri</option>
                </select></td>

            <td>Proje</td>
            <td style="width: 30px;">:</td>
            <td style="width: 400px;">
                <select name="yeni_is_yuku_proje_id" id="yeni_is_yuku_proje_id" onchange="is_yuku_gosterim_proje_sectim('<%=cdate(dongu_baslangic) %>', '<%=cdate(dongu_bitis) %>');">
                    <option value="0">Tüm Projeler</option>
                    <%
                        SQL="select id, proje_adi from ucgem_proje_listesi where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and durum = 'true' and cop = 'false' order by proje_adi asc"
                        set proje = baglanti.execute(SQL)
                        do while not proje.eof
                    %>
                    <option value="<%=proje("id") %>"><%=proje("proje_adi") %></option>
                    <%
                        proje.movenext
                        loop
                        %>
                </select></td>
            <td style="padding-left:25px;"><input type="button" onclick="isyuku_timeline_calistir();" class="btn btn-mini btn-rnd btn-primary" value="Timeline" /></td>
        </tr>
    </table>
</div>
<script>
    $(function (){
        is_yuku_gosterim_proje_sectim('<%=cdate(dongu_baslangic) %>', '<%=cdate(dongu_bitis) %>');
    });
</script>
<div id="is_yuku_donus2" class="tablediv"  style="width: 95%; margin: 3%; margin-top: 15px; overflow: auto;"></div>
</div>
<div id="is_yuku_birinci_ekran2" style="display:none; width: 95%; margin: 3%; margin-top: 15px; overflow: auto;"></div>