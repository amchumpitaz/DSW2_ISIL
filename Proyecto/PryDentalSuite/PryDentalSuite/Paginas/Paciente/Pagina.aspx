<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pagina.aspx.cs" 
    Inherits="PryDentalSuite.Paginas.Paciente.Pagina" MasterPageFile="~/Paginas/MasterPages/Principal.Master"%>
<asp:Content runat="server" ContentPlaceHolderID="cphDinamico">
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style3 {
            width: 238px;
        }
        </style>

    <div>
    
    </div>
        <div>
            Bienvenido Paciente
    </div>
        <div>

            <table class="auto-style1">
                <table>
                    <td class="auto-style3">
                        <asp:Menu ID="Menu1" runat="server" BackColor="#B5C7DE" DynamicHorizontalOffset="2" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284E98" StaticSubMenuIndent="10px">
                            <DynamicHoverStyle BackColor="#284E98" ForeColor="White" />
                            <DynamicMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
                            <DynamicMenuStyle BackColor="#B5C7DE" />
                            <DynamicSelectedStyle BackColor="#507CD1" />
                            <Items>
                                <asp:MenuItem Text="Ver Citas" Value="Ver Citas" NavigateUrl="~/Paginas/Citas/VerCitas.aspx"></asp:MenuItem>
                                <asp:MenuItem NavigateUrl="~/Paginas/Citas/AgregarCita.aspx" Text="Crear Cita" Value="Crear Cita"></asp:MenuItem>
                                <asp:MenuItem NavigateUrl="~/Paginas/Odontologo/ListaOdontologo.aspx" Text="Odontologos" Value="Odontologos"></asp:MenuItem>
                                <asp:MenuItem NavigateUrl="~/Paginas/Odontologo/ActualizarOdontologo.aspx" Text="Modificar Perfil" Value="Modificar Perfil"></asp:MenuItem>
                            </Items>
                            <StaticHoverStyle BackColor="#284E98" ForeColor="White" />
                            <StaticMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
                            <StaticSelectedStyle BackColor="#507CD1" />

                        </asp:Menu>
                       
                        
                    </td>
                   </table> 
                </table>
           </div>  
    
      
    </asp:Content>