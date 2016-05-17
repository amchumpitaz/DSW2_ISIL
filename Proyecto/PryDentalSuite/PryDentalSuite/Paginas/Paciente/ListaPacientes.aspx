<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListaPacientes.aspx.cs" 
    Inherits="PryDentalSuite.Paciente" MasterPageFile="~/Paginas/MasterPages/Principal.Master"%>

<asp:Content runat="server" ContentPlaceHolderID="cphDinamico">
    <h2>Lista de Pacientes<br /></h2>
    <br />
    <a href="AgregarPaciente.aspx">Ingresar nuevo Paciente</a>    
    <table id="tablaPaciente" border="1">            
    </table>          
</asp:Content>
