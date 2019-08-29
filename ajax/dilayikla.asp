<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    girenkelimeler = trn(request("kelimeler"))

    islenenkelimeler = ""

    girkelime = split(girenkelimeler,"~")
    for x = 1 to ubound(girkelime)
        for y = x to ubound(girkelime)
            if len(girkelime(y))>len(girkelime(x)) then
                temp = girkelime(x)
                girkelime(x) = girkelime(y)
                girkelime(y) = temp
            end if
        next
    next

    for x = 1 to ubound(girkelime)
        islenenkelimeler = islenenkelimeler & "~" & girkelime(x)
    next

    girenkelimeler = islenenkelimeler

    if len(girenkelimeler)> 1 then
        kelimeler = right(girenkelimeler,len(girenkelimeler)-1)
    end if

    sql = "Exec [ucgem].[dbo].dilayikla @kelimeler ='"& kelimeler &"', @cikisdili = 'turkce';"
    set rs1 = baglanti.execute(SQL)

    cikankelimeler =  rs1(0)

 %>