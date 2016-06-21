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
            llenarComboEspecialidad();
            llenarComboOdontologo();
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

        private void llenarComboOdontologo()
        {
            List<beOdontologo> lbeOdontologo = null;
            lbeOdontologo = brGenerales.ListarOdontologoCbo();
            cboOdontologo.DataSource = lbeOdontologo;
            cboOdontologo.DataValueField = "Codigo";
            cboOdontologo.DataTextField = "Nombres";
            cboOdontologo.DataBind();
        }

        private void llenarComboHorario(string codOdontologo)
        {
            List<beHorarioOdontologo> lbeHorarioOdontologo = null;
            lbeHorarioOdontologo = brGenerales.ListarHorarioOdontologoCbo(codOdontologo);
            cboHorario.DataSource = lbeHorarioOdontologo;
            cboHorario.DataValueField = "CodigoHorarioOdontologo";
            cboHorario.DataTextField = "Detalle";
            cboHorario.DataBind();
        }

        protected void cargaComboHorario(object sender, EventArgs e)
        {
            string codOdontologo = "";
            codOdontologo = cboOdontologo.SelectedValue;
            llenarComboHorario(codOdontologo);
        }
    }
}