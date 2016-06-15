<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PryDentalSuite.Paginas.Login.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<link href="../../Estilos/Login.css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
<asp:ScriptManager ID="ScriptManager" runat="server"></asp:ScriptManager>
        <div id="contenido">
            <h1>Login</h1>
            <hr/>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <span>USUARIO</span>
                    <asp:TextBox runat="server" ID="txtUsuario" placeholder="Usuario - Correo"/><br/><br/>
                    <span>CONTRASEÑA</span>
                    <asp:TextBox runat="server" ID="txtContraseña" type="password" placeholder="Contraseña"/><br/><br/>
                    <asp:Button ID="btnIngresar"  runat="server" Text="INGRESAR" OnClick="btnIngresar_Click" />
                </ContentTemplate>
            </asp:UpdatePanel>        
        </div>
    </form>
</body>
</html>
