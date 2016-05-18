using System;
using System.Web.UI;
using Librerias.Isil.DentalSuite.Entidades;
using Librerias.Isil.DentalSuite.ReglasNegocio;

namespace PryDentalSuite.Paginas.Usuario
{
    public partial class ActualizarUsuario : Page
    {
        readonly brUsuario obrUsuario = new brUsuario();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            if (Session["CodigoUsuario"] == null)
            {
                Response.Redirect("ListaUsuario.aspx");
            }
            else
            {
                dvfondo.Visible = false;
                popupInformativo.Visible = false;
                popupActualizarUsuario.Visible = false;
                LlenarDatos();
            }
        }

        private void LlenarDatos()
        {
            var obeUsuario = obrUsuario.Buscarusuario(Session["CodigoUsuario"].ToString());
            txtCodigo.Text = obeUsuario.Cod_Usuario;
            txtNombre.Text = obeUsuario.Nombres;
            txtApellido.Text = obeUsuario.Apellidos;

        }

        private void MensajesPopup(string info)
        {
            dvfondo.Visible = true;
            popupActualizarUsuario.Visible = false;
            lblInformacion.Text = info;
            popupInformativo.Visible = true;
        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            dvfondo.Visible = true;
            popupActualizarUsuario.Visible = true;
        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            var obeUsuario = new beUsuario
            {
                Cod_Usuario = Session["Cod_Usuario"].ToString(),
                Nombres = txtNombre.Text,
                Apellidos = txtApellido.Text,
                Contrasena = txtContrasena.Text
            };

            MensajesPopup(obrUsuario.ModificarUsuario(obeUsuario)
                ? "Usuario actualizado correctamente"
                : "Error al actualizar usuario..."
                );
            Session.Remove("Cod_Usuario");
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            dvfondo.Visible = false;
            popupActualizarUsuario.Visible = false;
        }

        protected void btnAceptarInformacion_Click(object sender, EventArgs e)
        {
            dvfondo.Visible = false;
            popupInformativo.Visible = false;
            Response.Redirect("ListaUsuario.aspx");
        }
    }
}