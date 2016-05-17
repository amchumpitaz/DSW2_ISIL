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
    public partial class ListaEspecialidad : System.Web.UI.Page
    {
        readonly  beEspecialidad _obeEspecialidad = new beEspecialidad();
        readonly brEspecialidad _obrEspecialidad = new brEspecialidad();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            ListarEspecialidad();
            dvfondo.Visible = false;
            popupInformativo.Visible = false;
            popupEliminarEspecialidad.Visible = false;
        }

        private void ListarEspecialidad()
        {
            dgvEspecialidad.DataSource = _obrEspecialidad.ListarEspecialidad();
            dgvEspecialidad.DataBind();
        }

        private void MensajesPopup(string info)
        {
            dvfondo.Visible = true;
            popupEliminarEspecialidad.Visible = false;
            lblInformacion.Text = info;
            popupInformativo.Visible = true;
        }

        protected void dgvEspecialidad_OnRowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            Session["codigo"] = Convert.ToInt32(dgvEspecialidad.DataKeys[e.RowIndex].Value);
            dvfondo.Visible = true;
            popupEliminarEspecialidad.Visible = true;
        }

        protected void dgvEspecialidad_OnSelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
           int cod = Convert.ToInt32(dgvEspecialidad.DataKeys[e.NewSelectedIndex].Value);

        }

        protected void btnAceptarInformacion_Click(object sender, EventArgs e)
        {
            popupInformativo.Visible = false;
            dvfondo.Visible = false;
            ListarEspecialidad();
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            popupEliminarEspecialidad.Visible = false;
            dvfondo.Visible = false;
        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            _obeEspecialidad.Cod_Especialidad = int.Parse(Session["codigo"].ToString());
            MensajesPopup(_obrEspecialidad.EliminarEspecialidad(_obeEspecialidad)
                ? "Especialidad eliminada correctamente"
                : "Error");
        }
    }
}