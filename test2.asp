<%
    Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
    Response.CodePage = 65001

   gonder = _
   "<?xml version=""1.0"" encoding=""utf-8""?>" &_
"<soap12:Envelope xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" xmlns:xsd=""http://www.w3.org/2001/XMLSchema"" xmlns:soap12=""http://www.w3.org/2003/05/soap-envelope"">" &_
  "<soap12:Body>" &_
    "<istanbul34Data xmlns=""http://tempuri.org/"">" &_
      "<pcStartDate>01/05/2019</pcStartDate>" &_
      "<pcEndDate>02/05/2019</pcEndDate>" &_
    "</istanbul34Data>" &_
  "</soap12:Body>" &_
"</soap12:Envelope>"

   
   uzunluk = len(gonder)
   
    Set oXmlHTTP = CreateObject("Microsoft.XMLHTTP")
    oXmlHTTP.Open "POST", "http://176.235.178.202:8647/istanbul34/istanbul34.asmx", False 

    oXmlHTTP.setRequestHeader "Content-Type", "application/soap+xml; charset=utf-8" 
    oXmlHTTP.setRequestHeader "Content-Length", uzunluk 

    oXmlHTTP.send gonder    


    If oXmlHTTP.readyState = 4  Then
		If oXmlHTTP.Status = 200  Then
			SorguSonucu = oXmlHTTP.responseText
		End If
	End If

   
    
  
    Set objXML = server.CreateObject("Microsoft.XMLDOM")
    objXML.loadXML(SorguSonucu)
  
    set ObjItems = objXML.getElementsByTagName("istanbul34DataResponse")(0).getElementsByTagName("istanbul34DataResult")
    BulunanSonucSayisi = ObjItems.Length - 1

    Set objXML2 = server.CreateObject("Microsoft.XMLDOM")
    objXML2.loadXML(ObjItems(0).text)

    set ObjItems2 = objXML2.getElementsByTagName("tt_gecis_kaydi")
    BulunanSonucSayisi = ObjItems2.Length - 1
   
   

   
   %>

<div class="panel panel-primary filterable margin-top-20">

    <div class="panel-heading">
        <h3 class="panel-title">BAŞLIK</h3>
    </div>
    <table class="table" colspan="3">
        <tr>
            <td>Geçiş Durumu</td>
            <td>Tarih</td>
            <td>Acenta No</td>
            <td>Gemi Adı</td>
            <td>Pers</td>
            <td>Bölge</td>
            <td>Geliş Limanı</td>
            <td>Gidiş Limanı</td>
        </tr>

        <tbody>
            <%    For x = 0 to BulunanSonucSayisi    %>
            <tr>
                <td><%=ObjItems2(x).getElementsByTagName("gecis_durumu")(0).text %></td>
                <td><%=ObjItems2(x).getElementsByTagName("tarih")(0).text %></td>
                <td><%=ObjItems2(x).getElementsByTagName("acenta_no")(0).text %></td>
                <td><%=ObjItems2(x).getElementsByTagName("gemi_adi")(0).text %></td>
                <td><%=ObjItems2(x).getElementsByTagName("pers")(0).text %></td>
                <td><%=ObjItems2(x).getElementsByTagName("bolge")(0).text %></td>
                <td><%=ObjItems2(x).getElementsByTagName("gelis_limani")(0).text %></td>
                <td><%=ObjItems2(x).getElementsByTagName("gidis_limani")(0).text %></td>

            </tr>
            <%    Next    %>
        </tbody>
    </table>
</div>













