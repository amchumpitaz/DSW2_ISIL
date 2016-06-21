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
            if (IsPostBack) return;
            llenarComboEspecialidad();
            llenarComboOdontologo();
        }

        protected void btnConfirmarCita_Click(object sender, EventArgs e)
        {
            string mensaje = "";
            brCita obrCita = null;
            beCita obeCita = null;

            if (!validarDatos(ref mensaje))
            {
                Response.Write(brGenerales.mostrarMensaje(mensaje));
            }
            else
            {
                obrCita = new brCita();
                obeCita = new beCita();
                obeCita.CodigoEspecialidad = cboEspecialidad.SelectedValue;
                obeCita.CodigoHorarioOdontologo = cboHorario.SelectedValue;
                obeCita.FechaCita = DateTime.Now;
                if (!obrCita.AgregarCita(obeCita))
                {
                    brGenerales.mostrarMensaje("No se pudo agregar la cita.");
                }
                else
                {
                    brGenerales.mostrarMensaje("Se agregó la cita con éxito.");
                }
            }

        }

        private bool validarDatos(ref string mensaje)
        {
            if (!(cboEspecialidad.SelectedIndex >= 0))
            {
                mensaje = "Debe seleccionar una Especialidad.";
                return false;
            }
            if (!(cboOdontologo.SelectedIndex >= 0))
            {
                mensaje = "Debe seleccionar un Odontologo.";
                return false;
            }
            if (!(cboHorario.SelectedIndex >= 0))
            {
                mensaje = "Debe seleccionar un horario disponible.";
                return false;
            }
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
            cboEspecialidad.SelectedIndex = -1;
        }

        private void llenarComboOdontologo()
        {
            List<beOdontologo> lbeOdontologo = null;
            lbeOdontologo = brGenerales.ListarOdontologoCbo();
            cboOdontologo.DataSource = lbeOdontologo;
            cboOdontologo.DataValueField = "Codigo";
            cboOdontologo.DataTextField = "Nombres";
            cboOdontologo.DataBind();
            cboOdontologo.SelectedIndex = -1;
        }

        private void llenarComboHorario(string codOdontologo)
        {
            List<beHorarioOdontologo> lbeHorarioOdontologo = null;
            lbeHorarioOdontologo = brGenerales.ListarHorarioOdontologoCbo(codOdontologo);
            cboHorario.DataSource = lbeHorarioOdontologo;
            cboHorario.DataValueField = "CodigoHorarioOdontologo";
            cboHorario.DataTextField = "Detalle";
            cboHorario.DataBind();
            cboHorario.SelectedIndex = -1;
        }

        protected void cargaComboHorario(object sender, EventArgs e)
        {
            string codOdontologo = "";
            cboHorario.Items.Clear();
            codOdontologo = cboOdontologo.SelectedValue;
            llenarComboHorario(codOdontologo);
        }
    }
}