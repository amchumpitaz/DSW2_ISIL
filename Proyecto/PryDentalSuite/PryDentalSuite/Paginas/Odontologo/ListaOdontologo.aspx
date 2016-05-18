<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListaOdontologo.aspx.cs" 
    Inherits="PryDentalSuite.Paginas.Odontologo.ListaOdontologo" 
    MasterPageFile="~/Paginas/MasterPages/Principal.Master"%>

<asp:Content runat="server" ContentPlaceHolderID="cphDinamico">
    <h2>Lista de Odontologos<br /></h2>
    <br />
    <a href="AgregarOdontologo.aspx">Ingresar nuevo Odontologo</a>    
    <table id="tablaOdontologo" border="1">            
    </table>          
</asp:Content>
