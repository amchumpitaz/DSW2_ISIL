using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Librerias.Isil.DentalSuite.Entidades;
using Librerias.Isil.DentalSuite.ReglasNegocio;

namespace PryDentalSuite.Paginas.Usuario
{
    public partial class ListaUsuario : Page
    {
        readonly beUsuario _obeUsuario = new beUsuario();
        readonly brUsuario _oBrUsuario = new brUsuario();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            dvfondo.Visible = false;
            popupInformativo.Visible = false;
            popupEliminarUsuario.Visible = false;
            
            ListarUsuario();
        }

        private void ListarUsuario()
        {
            dgvUsuario.DataSource = _oBrUsuario.ListarUsuario();
            dgvUsuario.DataBind();
        }

        private void MensajesPopup(string info)
        {
            dvfondo.Visible = true;
            popupEliminarUsuario.Visible = false;
            lblInformacion.Text = info;
            popupInformativo.Visible = true;
        }

        protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            Session["CodigoUsuario"] = Convert.ToInt32(dgvUsuario.DataKeys[e.RowIndex]?.Value);
            dvfondo.Visible = true;
            popupEliminarUsuario.Visible = true;
        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            _obeUsuario.Cod_Usuario = Session["CodigoUsuario"].ToString();
            MensajesPopup(_oBrUsuario.EliminarUsuario(_obeUsuario)
                ? "Usuario eliminado correctamente" 
                : "Error al eliminar el usuario..."
                );
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            popupEliminarUsuario.Visible = false;
            dvfondo.Visible = false;
        }

        protected void btnAceptarInformacion_Click(object sender, EventArgs e)
        {
            dvfondo.Visible = false;
            popupInformativo.Visible = false;
            ListarUsuario();
        }

        protected void OnSelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
            Session["CodigoUsuario"] = Convert.ToInt32(dgvUsuario.DataKeys[e.NewSelectedIndex]?.Value);
            Response.Redirect("ActualizarUsuario.aspx");
            ListarUsuario();
        }
    }
}