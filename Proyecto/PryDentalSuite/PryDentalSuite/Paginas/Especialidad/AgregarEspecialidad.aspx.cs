using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Librerias.Isil.DentalSuite.Entidades;
using Librerias.Isil.DentalSuite.ReglasNegocio;

namespace PryDentalSuite.Paginas.Especialidad
{
    public partial class AgregarEspecialidad : System.Web.UI.Page
    {
        readonly beEspecialidad _obeEspecialidad = new beEspecialidad();
        readonly brEspecialidad _obrEspecialidad = new brEspecialidad();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            popupAgregarEspecialidad.Visible = false;
            dvfondo.Visible = false;
            popupInformativo.Visible = false;
        }

        private void MensajesPopup(string info)
        {
            dvfondo.Visible = true;
            popupAgregarEspecialidad.Visible = false;
            LblInformacion.Text = info;
            popupInformativo.Visible = true;
        }

        private void LimpiarTextos()
        {
            var limpiarTextos = @"LimpiarTextos()";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "limpiarTextos", limpiarTextos, true);
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            popupAgregarEspecialidad.Visible = true;
            dvfondo.Visible = true;
        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            _obeEspecialidad.Nombre = txtNombre.Text;
            _obeEspecialidad.Descripcion = txtDescripcion.Text;

            if (_obrEspecialidad.InsertarEspecialidad(_obeEspecialidad))
            {
                MensajesPopup("Especialidad agregada correctamente.");
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            popupAgregarEspecialidad.Visible = false;
            dvfondo.Visible = false;
        }

        protected void btnAceptarInformacion_Click(object sender, EventArgs e)
        {
            popupInformativo.Visible = false;
            dvfondo.Visible = false;
            LimpiarTextos();
        }
    }
}