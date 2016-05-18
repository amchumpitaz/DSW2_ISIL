<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListaEspecialidad.aspx.cs" 
    Inherits="PryDentalSuite.Paginas.Especialidad.ListaEspecialidad" MasterPageFile="../MasterPages/Principal.Master" %>

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
                        <%-- Popup Eliminar Especialidad--%>
                        <div runat="server" id="popupEliminarEspecialidad"><br />
                         <p>¿En realidad desea eliminar la Especialidad?</p><br /><br />
                         <asp:Button ID="btnAceptar" UseSubmitBehavior="false" Text="Aceptar"  runat="server"  OnClick="btnAceptar_Click" />
                        <asp:Button  ID="btnCancelar" Text="Cancelar" runat="server" OnClick="btnCancelar_Click"/>     
                        </div>
                    </ContentTemplate>
            </asp:UpdatePanel>
    <asp:UpdatePanel runat="server" ID="up">
        <ContentTemplate>
    <h2>Lista de Especialidades<br /></h2>
    <asp:GridView ID="dgvEspecialidad" runat="server" AutoGenerateColumns="False" CellPadding="4"
        DataKeyNames="Cod_Especialidad"
        OnSelectedIndexChanging="dgvEspecialidad_OnSelectedIndexChanging"
        OnRowDeleting="dgvEspecialidad_OnRowDeleting">
        <Columns>
            <asp:BoundField DataField="Nombre" HeaderText="Especialidad" />
            <asp:BoundField DataField="Descripcion" HeaderText="Descripción" />
            <asp:CommandField ButtonType="Image" DeleteImageUrl="~/imagenes/delete.png" HeaderText="Edicion" ShowDeleteButton="True" InsertText="" EditText="" SelectImageUrl="~/imagenes/edit.png" SelectText="Editar" ShowSelectButton="True" />
        </Columns>
        
    </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
</asp:Content>