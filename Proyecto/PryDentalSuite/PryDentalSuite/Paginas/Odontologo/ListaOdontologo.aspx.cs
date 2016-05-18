using System;
using System.Collections.Generic;
using System.Text;
using System.Web.UI;
using Librerias.Isil.DentalSuite.Entidades;
using Librerias.Isil.DentalSuite.ReglasNegocio;

namespace PryDentalSuite.Paginas.Odontologo
{
    public partial class ListaOdontologo : Page
    {
        List<beOdontologo> lbeOdontologo;
        protected void Page_Load(object sender, EventArgs e)
        {
            string tablaPaciente = "";
            StringBuilder js = new StringBuilder();
            brOdontologo obrOdontologo = new brOdontologo();
            lbeOdontologo = obrOdontologo.Listar();
            tablaPaciente = crearTabla();
            js.Append("<script>");
            js.Append("window.onload = function() {");
            js.Append("document.getElementById('tablaOdontologo').innerHTML=\"");
            js.Append(tablaPaciente + "\"");
            js.Append(";");
            js.Append("};");
            js.Append("</script>");
            Response.Write(js.ToString());
        }

        public string crearTabla()
        {
            StringBuilder js = new StringBuilder();
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
            js.Append("<th>COP</th>");
            js.Append("<th colspan='2'>Acción</th>");
            js.Append("</tr>");
            js.Append("</thead>");
            if (lbeOdontologo != null)
            {
                if (lbeOdontologo.Count > 0)
                {
                    foreach (beOdontologo obeOdontologo in lbeOdontologo)
                    {
                        js.Append("<tr>");
                        js.Append("<td>" + obeOdontologo.Codigo + "</td>");
                        js.Append("<td>" + obeOdontologo.Nombres + "</td>");
                        js.Append("<td>" + obeOdontologo.ApellidoPaterno + "</td>");
                        js.Append("<td>" + obeOdontologo.ApellidoMaterno + "</td>");
                        js.Append("<td>" + obeOdontologo.Sexo + "</td>");
                        js.Append("<td>" + obeOdontologo.TipoDocumento + "</td>");
                        js.Append("<td>" + obeOdontologo.NumeroDocumento + "</td>");
                        js.Append("<td>" + obeOdontologo.Correo + "</td>");
                        js.Append("<td>" + obeOdontologo.Direccion + "</td>");
                        js.Append("<td>" + obeOdontologo.COP + "</td>");
                        js.Append("<td><a href='ActualizarOdontologo.aspx?codOdontologo=" + obeOdontologo.Codigo + "'>Actualizar</a></td>");
                        js.Append("<td><a href='EliminarOdontologo.aspx?codOdontologo=" + obeOdontologo.Codigo + "'>Eliminar</a></td>");
                        js.Append("</tr>");
                    }
                }
            }
            js.Append("</tbody>");
            return js.ToString();
        }
    }
}