

<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    'Set WshShell = Server.CreateObject("WScript.Shell") 
    'WshShell.Run("C:/dll/TabTip.exe")
    'Set WshShell= nothing

    set wshell = CreateObject("WScript.Shell") 
    return = wshell.run("c:\file.bat", 4, false)
    response.write(return)
    set wshell = nothing 
    


    Response.End

%>ok