<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ActualizarPaciente.aspx.cs" 
    Inherits="PryDentalSuite.Paginas.Paciente.ActualizarPaciente" 
    MasterPageFile="~/Paginas/MasterPages/Principal.Master"%>

<asp:Content runat="server" ContentPlaceHolderID="cphDinamico">
    <a href="ListaPacientes.aspx">Regresar a Lista de Pacientes</a>
    <h2>Actualiza los datos del Paciente<br /></h2>
    <table class="auto-style14">
        <tr>
            <td class="auto-style15">Codigo:</td>
            <td class="auto-style16">
                <asp:TextBox ID="txtCodigo" runat="server" ReadOnly="True" Width="99px"></asp:TextBox>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">Nombres:</td>
            <td class="auto-style16">
                <asp:TextBox ID="txtNombres" runat="server" Width="222px"></asp:TextBox>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">Apellido Paterno:</td>
            <td class="auto-style16">
                <asp:TextBox ID="txtApePaterno" runat="server" Width="221px"></asp:TextBox>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">Apellido Materno:</td>
            <td class="auto-style16">
                <asp:TextBox ID="txtApeMaterno" runat="server" Width="221px"></asp:TextBox>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">Sexo:</td>
            <td class="auto-style16">
                <asp:RadioButton ID="rbMasculino" runat="server" GroupName="Sexo" Text="Masculino" />
                <asp:RadioButton ID="rbFemenino" runat="server" GroupName="Sexo" Text="Femenino" />
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">Tipo Documento:</td>
            <td class="auto-style16">
                <asp:DropDownList ID="cboTipoDocumento" runat="server" Height="19px" Width="120px">
                </asp:DropDownList>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">Número Documento:</td>
            <td class="auto-style16">
                <asp:TextBox ID="txtNumDocumento" runat="server" Width="109px"></asp:TextBox>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">Correo:</td>
            <td class="auto-style16">
                <asp:TextBox ID="txtCorreo" runat="server" Width="235px"></asp:TextBox>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">Dirección:</td>
            <td class="auto-style16">
                <asp:TextBox ID="txtDireccion" runat="server" Width="233px"></asp:TextBox>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">Departamento:</td>
            <td class="auto-style16">
                <asp:DropDownList ID="cboDepartamento" runat="server" Height="22px" Width="135px" OnSelectedIndexChanged="cargaComboProvincia">
                </asp:DropDownList>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">Provincia:</td>
            <td class="auto-style16">
                <asp:DropDownList ID="cboProvincia" runat="server" Height="19px" Width="136px" OnSelectedIndexChanged="cargarComboDistrito">
                </asp:DropDownList>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">Distrito:</td>
            <td class="auto-style16">
                <asp:DropDownList ID="cboDistrito" runat="server" Height="16px" Width="136px">
                </asp:DropDownList>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">&nbsp;</td>
            <td class="auto-style16">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">
                <asp:Button ID="btnActualizar" runat="server" Text="Actualizar" Width="142px" OnClick="btnActualizar_Click" />
            </td>
            <td class="auto-style16">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
    <br />
                  
</asp:Content>
<asp:Content ID="Content1" runat="server" contentplaceholderid="head">
    <style type="text/css">
        .auto-style14 {
            width: 100%;
        }
        .auto-style15 {
            width: 142px;
        }
        .auto-style16 {
            width: 251px;
        }
    </style>
</asp:Content>

