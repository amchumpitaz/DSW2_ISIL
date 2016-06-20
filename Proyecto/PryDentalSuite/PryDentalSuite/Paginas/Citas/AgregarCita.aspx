<%@ Page Title="" Language="C#" MasterPageFile="~/Paginas/MasterPages/Principal.Master" AutoEventWireup="true" CodeBehind="AgregarCita.aspx.cs" Inherits="PryDentalSuite.Paginas.Citas.AgregarCita" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style14 {
            width: 100%;
        }
        .auto-style15 {
            width: 203px;
        }
        .auto-style17 {
            width: 203px;
            height: 23px;
        }
        .auto-style19 {
            height: 23px;
        }
        .auto-style20 {
            width: 296px;
            height: 23px;
        }
        .auto-style21 {
            width: 296px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphDinamico" runat="server">
    <h3>Llena los campos para reservar una cita.</h3>
    <table class="auto-style14">
        <tr>
            <td class="auto-style17"></td>
            <td class="auto-style20"></td>
            <td class="auto-style19"></td>
        </tr>
        <tr>
            <td class="auto-style15">Escoge la Especialidad:</td>
            <td class="auto-style21">
                <asp:DropDownList ID="cboEspecialidad" runat="server" Height="30px" Width="298px">
                </asp:DropDownList>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">&nbsp;</td>
            <td class="auto-style21">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">Escoge al Odontólogo:</td>
            <td class="auto-style21">
                <asp:DropDownList ID="cboOdontologo" runat="server" Height="28px" Width="298px">
                </asp:DropDownList>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">&nbsp;</td>
            <td class="auto-style21">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">Escoge un horario disponible:</td>
            <td class="auto-style21">
                <asp:DropDownList ID="cboHorario" runat="server" Height="30px" Width="301px">
                </asp:DropDownList>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">&nbsp;</td>
            <td class="auto-style21">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">
                <asp:Button ID="btnConfirmarCita" runat="server" Text="Confirmar Cita" Width="145px" />
            </td>
            <td class="auto-style21">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
