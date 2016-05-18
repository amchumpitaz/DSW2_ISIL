<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgregarUsuario.aspx.cs" 
    Inherits="PryDentalSuite.Paginas.Usuario.AgregarUsuario" MasterPageFile="../MasterPages/Principal.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="cphDinamico">
    <asp:ScriptManager ID="ScriptManager" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="upInformativo" runat="server">
                    <ContentTemplate>
                        <div runat="server" id="dvfondo">
                        </div>
                        <%-- Popup Informativo--%>
                        <div runat="server" id="popupInformativo"><br />
                         <asp:Label id="LblInformacion" runat="server" /><br /><br />
                         <asp:Button ID="btnAceptarInformacion" Text="Aceptar" runat="server" OnClick="btnAceptarInformacion_Click"/>     
                        </div>
                        <%-- Popup Agregar Especialidad--%>
                        <div runat="server" id="popupAgregarUsuario"><br />
                         <p>¿En realidad desea agregar un usuario?</p><br /><br />
                         <asp:Button ID="btnAceptar" UseSubmitBehavior="false" Text="Aceptar"  runat="server"  OnClick="btnAceptar_Click" />
                        <asp:Button  ID="btnCancelar" Text="Cancelar" runat="server" OnClick="btnCancelar_Click"/>              
                        </div>
                    </ContentTemplate>
            </asp:UpdatePanel>
    
    <h2>Ingresa los datos del nuevo usuario<br /></h2>

    <table class="auto-style14">
        <tr>
            <td>Nombre:</td>
            <td>
                <asp:TextBox ID="txtNombre" runat="server"></asp:TextBox>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>Apellido:</td>
            <td>
                <asp:TextBox ID="txtApellido" runat="server"></asp:TextBox>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnAgregar" runat="server" OnClick="btnAgregar_Click" Text="Agregar" />
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>

</asp:Content>
<asp:Content ID="Content1" runat="server" contentplaceholderid="head">
    <style type="text/css">
        .auto-style14 {
            width: 100%;
        }
    </style>
</asp:Content>
