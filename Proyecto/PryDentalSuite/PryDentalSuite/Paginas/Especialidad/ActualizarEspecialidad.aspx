<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ActualizarEspecialidad.aspx.cs" 
    Inherits="PryDentalSuite.Paginas.Especialidad.ActualizarEspecialidad" MasterPageFile="../MasterPages/Principal.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="cphDinamico">
    <asp:ScriptManager ID="ScriptManager" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="upInformativo" runat="server">
                    <ContentTemplate>
                        <div runat="server" id="dvfondo">
                        </div>
                        <%-- Popup Informativo--%>
                        <div runat="server" id="popupInformativo"><br />
                         <asp:Label id="lblInformacion" runat="server" /><br /><br />
                         <asp:Button ID="btnAceptarInformacion" Text="Aceptar" runat="server" OnClick="btnAceptarInformacion_Click"/>     
                        </div>
                        <%-- Popup Actualizar Especialidad--%>
                        <div runat="server" id="popupActualizarEspecialidad"><br />
                         <p>¿En realidad desea actualizar la Especialidad?</p><br /><br />
                         <asp:Button ID="btnAceptar" UseSubmitBehavior="false" Text="Aceptar"  runat="server"  OnClick="btnAceptar_Click" />
                        <asp:Button  ID="btnCancelar" Text="Cancelar" runat="server" OnClick="btnCancelar_Click"/>     
                        </div>
                    </ContentTemplate>
            </asp:UpdatePanel>
    <h2>Actualizar datos de Especialidad<br /></h2>
    <table class="auto-style14">
        <tr>
            <td>Nombre:</td>
            <td>
                <asp:TextBox ID="txtNombre" runat="server"></asp:TextBox>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>Descripción:</td>
            <td>
                <asp:TextBox ID="txtDescripcion" runat="server"></asp:TextBox>
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
                <asp:Button ID="btnActualizar" runat="server" Text="Actualizar" OnClick="btnActualizar_Click" />
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

