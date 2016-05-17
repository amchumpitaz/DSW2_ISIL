using System;
using System.Collections.Generic;
using System.Web.UI;
using Librerias.Isil.DentalSuite.Entidades;
using Librerias.Isil.DentalSuite.ReglasNegocio;

namespace PryDentalSuite
{
    public partial class Paciente : Page
    {
        List<bePaciente> lbePaciente = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            string tablaPaciente = "";
            System.Text.StringBuilder js = new System.Text.StringBuilder();
            brPaciente obrPaciente = new brPaciente();
            lbePaciente = obrPaciente.Listar();
            tablaPaciente = crearTabla();
            js.Append("<script>");
            js.Append("window.onload = function() {");
            js.Append("document.getElementById('tablaPaciente').innerHTML=\"");
            js.Append(tablaPaciente + "\"");
            js.Append(";");
            js.Append("};");
            js.Append("</script>");
            Response.Write(js.ToString());
        }

        public string crearTabla()
        {
            System.Text.StringBuilder js = new System.Text.StringBuilder();
            js.Append("<tbody>");
            js.Append("<thead>");
            js.Append("<tr>");
            js.Append("<th>Codigo</th>");
            js.Append("<th>Nombres</th>");
            js.Append("<th>Apellido Paterno</th>");
            js.Append("<th>Apellido Materno</th>");
            js.Append("<th>Sexo</th>");
            js.Append("<th>Tipo Doc.</th>");
            js.Append("<th>Num. Doc.</th>");
            js.Append("<th>Correo</th>");
            js.Append("<th>Dirección</th>");
            js.Append("<th colspan='2'>Acción</th>");
            js.Append("</tr>");
            js.Append("</thead>");
            if (lbePaciente != null)
            {
                if (lbePaciente.Count > 0)
                {                    
                    foreach( bePaciente obePaciente in lbePaciente){
                        js.Append("<tr>");
                        js.Append("<td>"+obePaciente.Codigo+"</td>");
                        js.Append("<td>" + obePaciente.Nombres + "</td>");
                        js.Append("<td>" + obePaciente.ApellidoPaterno + "</td>");
                        js.Append("<td>" + obePaciente.ApellidoMaterno + "</td>");
                        js.Append("<td>" + obePaciente.Sexo + "</td>");
                        js.Append("<td>" + obePaciente.TipoDocumento + "</td>");
                        js.Append("<td>" + obePaciente.NumeroDocumento + "</td>");
                        js.Append("<td>" + obePaciente.Correo + "</td>");
                        js.Append("<td>" + obePaciente.Direccion + "</td>");
                        js.Append("<td><a href='ActualizarPaciente.aspx?codPaciente="+obePaciente.Codigo+"'>Actualizar</a></td>");
                        js.Append("<td><a href='EliminarPaciente.aspx?codPaciente=" + obePaciente.Codigo + "'>Eliminar</a></td>");
                        js.Append("</tr>");
                    }                    
                }
            }
            js.Append("</tbody>");
            return js.ToString();
        }
    }
}