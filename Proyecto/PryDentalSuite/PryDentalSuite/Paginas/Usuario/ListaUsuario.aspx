<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListaUsuario.aspx.cs" 
    Inherits="PryDentalSuite.Paginas.Usuario.ListaUsuario" MasterPageFile="../MasterPages/Principal.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="cphDinamico">
    <script src="../../scripts/custom.js" type="text/javascript"></script>
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
                        <%-- Popup Eliminar Especialidad--%>
                        <div runat="server" id="popupEliminarUsuario"><br />
                         <p>¿En realidad desea eliminar el usuario?</p><br /><br />
                         <asp:Button ID="btnAceptar" UseSubmitBehavior="false" Text="Aceptar"  runat="server"  OnClick="btnAceptar_Click" />
                        <asp:Button  ID="btnCancelar" Text="Cancelar" runat="server" OnClick="btnCancelar_Click"/>     
                        </div>
                    </ContentTemplate>
            </asp:UpdatePanel>
    <asp:UpdatePanel runat="server" ID="up">
        <ContentTemplate>
            <h2>Lista de usuarios<br /></h2>
            <asp:GridView ID="dgvUsuario" runat="server" AutoGenerateColumns="False" CellPadding="4"
                DataKeyNames="Cod_Usuario"
                OnSelectedIndexChanging="OnSelectedIndexChanging"
                OnRowDeleting="OnRowDeleting">
                <Columns>
                    <asp:BoundField DataField="Nombres" HeaderText="Nombre" />
                    <asp:BoundField DataField="Apellidos" HeaderText="Apellido" />
                    <asp:CommandField ButtonType="Image" CancelText="" DeleteImageUrl="~/imagenes/delete.png" EditText="" HeaderText="Edicion" InsertText="" NewText="" SelectImageUrl="~/imagenes/edit.png" SelectText="Editar" ShowDeleteButton="True" ShowSelectButton="True" />
                </Columns>
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>