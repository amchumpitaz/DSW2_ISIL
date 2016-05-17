using System;
using System.Web;
using Librerias.Isil.DentalSuite.Entidades;
using Librerias.Isil.DentalSuite.ReglasNegocio;

namespace PryDentalSuite.Paginas.Especialidad
{
    public partial class ActualizarEspecialidad : System.Web.UI.Page
    {
        readonly brEspecialidad _obrEspecialidad = new brEspecialidad();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                return;
            }

            if (Session["codigo"] == null)
            {
                Response.Redirect("ListaEspecialidad.aspx");
            }
            else
            {
                dvfondo.Visible = false;
                popupInformativo.Visible = false;
                popupActualizarEspecialidad.Visible = false;
                LlenarDatos();
            }
        }

        private void LlenarDatos()
        {
            var obeEspecialidad = _obrEspecialidad.BuscarEspecialidad(int.Parse(Session["codigo"].ToString()));
            txtNombre.Text = obeEspecialidad.Nombre;
            txtDescripcion.Text = obeEspecialidad.Descripcion;
        }

        private void MensajesPopup(string info)
        {
            dvfondo.Visible = true;
            popupActualizarEspecialidad.Visible = false;
            lblInformacion.Text = info;
            popupInformativo.Visible = true;
        }

        protected void btnAceptarInformacion_Click(object sender, EventArgs e)
        {
            dvfondo.Visible = false;
            popupInformativo.Visible = false;
            Response.Redirect("ListaEspecialidad.aspx");
        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            var obeEspecialidad = new beEspecialidad
            {
                Cod_Especialidad = int.Parse(Session["codigo"].ToString()),
                Nombre = txtNombre.Text,
                Descripcion = txtDescripcion.Text
            };

            MensajesPopup(_obrEspecialidad.ModificarEspecialidad(obeEspecialidad)
                ? "Especialidad actualizada correctamente"
                : "Error al actualizar la especialidad...");
            Session.Remove("codigo");
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            dvfondo.Visible = false;
            popupActualizarEspecialidad.Visible = false;
        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            dvfondo.Visible = true;
            popupActualizarEspecialidad.Visible = true;
        }
    }
}