<%
    server_ip = "ucgem.com"

    Conn = "Provider=SQLOLEDB;User ID=sa; Password=J206re15; Initial Catalog=ucgem;Data Source="& server_ip &"; Network Library=DBMSSOCN;"
    set baglanti = server.CreateObject("adodb.connection")
    baglanti.open conn

    on error resume next

    t = request("t")

    if t = "1" then

        personel_id = Request("id")
        cihazID = 1
        giris_tipi = request("tip")

        SQL="insert into ucgem_personel_mesai_girisleri(personel_id, ekleme_zamani, ekleme_tarihi, ekleme_saati, cihazID, giris_tipi) values('"& personel_id &"', getdate(), getdate(), getdate(), '"& cihazID &"', '"& giris_tipi &"')"
        set ekle = baglanti.Execute(SQL)

    else

        deger = request("d")

        sicaklik1 = split(split(deger, "|")(0), "~")(0)
        sicaklik2 = split(split(deger, "|")(0), "~")(1)
        sicaklik3 = split(split(deger, "|")(0), "~")(2)
        sicaklik4 = split(split(deger, "|")(0), "~")(3)
        sicaklik5 = split(split(deger, "|")(0), "~")(4)
        sicaklik6 = split(split(deger, "|")(0), "~")(5)
        sicaklik7 = split(split(deger, "|")(0), "~")(6)
        sicaklik8 = split(split(deger, "|")(0), "~")(7)
        sicaklik9 = split(split(deger, "|")(0), "~")(8)


        akim1 = split(split(deger, "|")(1), "~")(0)
        akim2 = split(split(deger, "|")(1), "~")(1)
        akim3 = split(split(deger, "|")(1), "~")(2)
        akim4 = split(split(deger, "|")(1), "~")(3)
        akim5 = split(split(deger, "|")(1), "~")(4)


        SQL="insert into karamazak_santiye(sicaklik1, sicaklik2, sicaklik3, sicaklik4, sicaklik5, sicaklik6, sicaklik7, sicaklik8, sicaklik9, akim1, akim2, akim3, akim4, akim5, ekleme_tarihi, ekleme_saati, ekleyen_ip) values('"& sicaklik1 &"', '"& sicaklik2 &"', '"& sicaklik3 &"', '"& sicaklik4 &"', '"& sicaklik5 &"', '"& sicaklik6 &"', '"& sicaklik7 &"', '"& sicaklik8 &"', '"& sicaklik9 &"', '"& akim1 &"', '"& akim2 &"', '"& akim3 &"', '"& akim4 &"', '"& akim5 &"', getdate(),getdate(), '"& Request.ServerVariables("Remote_Addr") &"')"
        set ekle = baglanti.Execute(SQL)

    end if
    
%>ok