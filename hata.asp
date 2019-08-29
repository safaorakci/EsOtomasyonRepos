<%
    On Error Resume Next
    response.Buffer = true
    Response.Clear
    Dim objError
    Set objError = Server.GetLastError()

    if request.Cookies("kullanici")("kullanici_id")="27" or request.Cookies("kullanici")("ben_salih")="True" or 1 = 1 then

%>
<table>
<% If Len(CStr(objError.ASPCode)) > 0 Then %>
  <tr>
    <th nowrap align="left" valign="top">IIS Hata Numarası</th>
    <td align="left" valign="top"><%=objError.ASPCode %></td>
  </tr>
<% End If %>
<% If Len(CStr(objError.Number)) > 0 Then %>
  <tr>
    <th nowrap align="left" valign="top">COM Hata Numarası</th>
    <td align="left" valign="top"><%=objError.Number%>
    <%=" (0x" & Hex(objError.Number) & ")"%></td>
  </tr>
<% End If %>
<% If Len(CStr(objError.Source)) > 0 Then %>
  <tr>
    <th nowrap align="left" valign="top">Hata Kaynağı</th>
    <td align="left" valign="top"><%=objError.Source %></td>
  </tr>
<% End If %>
<% If Len(CStr(objError.File)) > 0 Then %>
  <tr>
    <th nowrap align="left" valign="top">Dosya İsmi</th>
    <td align="left" valign="top"><%=objError.File%></td>
  </tr>
<% End If %>
<% If Len(CStr(objError.Line)) > 0 Then %>
  <tr>
    <th nowrap align="left" valign="top">Hata Satırı</th>
    <td align="left" valign="top"><%=objError.Line%></td>
  </tr>
<% End If %>
<% If Len(CStr(objError.Description)) > 0 Then %>
  <tr>
    <th nowrap align="left" valign="top">Kısa Açıklama</th>
    <td align="left" valign="top"><%=objError.Description%></td>
  </tr>
<% End If %>
<% If Len(CStr(objError.ASPDescription)) > 0 Then %>
  <tr>
    <th nowrap align="left" valign="top">Açıklama</th>
    <td align="left" valign="top"><%=objError.ASPDescription%></td>
  </tr>
<% End If %>
</table>
<% end if %>
<% response.flush %>
