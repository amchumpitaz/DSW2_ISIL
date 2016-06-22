<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VerCitas.aspx.cs" 
    Inherits="PryDentalSuite.Paginas.Citas.VerCitas" MasterPageFile="~/Paginas/MasterPages/Principal.Master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphDinamico" runat="server">
    <h3>Estado de Cita</h3>
    <asp:ListBox ID="lstCitas" runat="server" Width="464px"></asp:ListBox>
    </asp:Content>
