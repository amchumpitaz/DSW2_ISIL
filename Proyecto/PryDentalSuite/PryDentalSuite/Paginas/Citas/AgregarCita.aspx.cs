using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Librerias.Isil.DentalSuite.Entidades;
using Librerias.Isil.DentalSuite.ReglasNegocio;

namespace PryDentalSuite.Paginas.Citas
{
    public partial class AgregarCita : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnConfirmarCita_Click(object sender, EventArgs e)
        {
            string mensaje = "";

            if (!validarDatos(ref mensaje))
            {

            }
        }

        private bool validarDatos(ref string mensaje)
        {

            return true;
        }

        private void llenarComboEspecialidad()
        {
            List<beEspecialidad> lbeEspecialidad= null;
            lbeEspecialidad= brGenerales.ListarEspecialidadCbo();
            cboEspecialidad.DataSource = lbeEspecialidad;
            cboEspecialidad.DataValueField = "Cod_Especialidad";
            cboEspecialidad.DataTextField = "Nombre";
            cboEspecialidad.DataBind();
        }
    }
}