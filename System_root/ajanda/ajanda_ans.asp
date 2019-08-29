<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001
%>

<div class=" full-calenders">
    <div class="page-header card" style="display:none;">
        <div class="card-block">
            <h5 class="m-b-10"><%=LNG("Ajanda")%></h5>
            <p class="text-muted m-b-10"><%=LNG("Günlük programınızı bu bölümden takip edebilirsiniz")%></p>
        </div>
    </div>
    <div id="takvim_yeri">
        <%
            etiket = "personel"
            etiket_id = Request.Cookies("kullanici")("kullanici_id")
        %>
        <script>
            $(function (){
                yeni_ajanda_calistir('<%=etiket %>', '<%=etiket_id %>');
            });
        </script>
    </div>
</div>


