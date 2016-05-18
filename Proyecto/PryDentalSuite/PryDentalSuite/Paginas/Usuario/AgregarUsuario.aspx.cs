using System;
using System.Web.UI;
using Librerias.Isil.DentalSuite.Entidades;
using Librerias.Isil.DentalSuite.ReglasNegocio;

namespace PryDentalSuite.Paginas.Usuario
{
    public partial class AgregarUsuario : Page
    {
        readonly beUsuario obeUsuario = new beUsuario();
        readonly brUsuario obrUsuario = new brUsuario();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            dvfondo.Visible = false;
            popupInformativo.Visible = false;
            popupAgregarUsuario.Visible = false;
        }

        private void MensajesPopup(string info)
        {
            dvfondo.Visible = true;
            popupAgregarUsuario.Visible = false;
            LblInformacion.Text = info;
            popupInformativo.Visible = true;
        }

        private void LimpiarTextos()
        {
            var limpiarTextos = @"LimpiarTextosUsuario()";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "limpiarTextosUsuario", limpiarTextos, true);
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            dvfondo.Visible = true;
            popupAgregarUsuario.Visible = true;
        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            obeUsuario.Nombres = txtNombre.Text;
            obeUsuario.Apellidos = txtApellido.Text;

            if (obrUsuario.InsertarUsuario(obeUsuario))
            {
                var usuario = obrUsuario.ObtenerUsuario(obeUsuario);

                MensajesPopup("Usuario agregado correctamente. "+ "<br/>" +
                    "Su usuario es: " + usuario.Cod_Usuario + "<br/>" +
                    "Contraseña por default es: 12345");
            }
            else
            {
                MensajesPopup("Error al agregar usuario...");
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            dvfondo.Visible = false;
            popupAgregarUsuario.Visible = false;
        }

        protected void btnAceptarInformacion_Click(object sender, EventArgs e)
        {
            dvfondo.Visible = false;
            popupInformativo.Visible = false;
            LimpiarTextos();
        }
    }
}