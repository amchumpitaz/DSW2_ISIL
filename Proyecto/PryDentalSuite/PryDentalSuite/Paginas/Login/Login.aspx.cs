using Librerias.Isil.DentalSuite.Entidades;
using Librerias.Isil.DentalSuite.ReglasNegocio;
using System;
using System.Web;

namespace PryDentalSuite.Paginas.Login
{
    public partial class Login : System.Web.UI.Page
    {
        private beLogin _beLogin;
        private readonly brLogin _brLogin = new brLogin();
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
        }

        private void ValidarLogin(string usuario, string contrasena)
        {
            try
            {
                _beLogin = _brLogin.ValidarUsuario(usuario, contrasena);
                if (_beLogin == null)
                {

                }
                else
                {
                    Session["Usuario"] = usuario;
                    Session["Nombre"] = _beLogin.Nombre;
                    Session["Apellido"] = _beLogin.Apellido;
                    Session["TipoUsuario"] = _beLogin.TipoUsuario;
                    var tipoUsuario = _beLogin.TipoUsuario;
                    switch (tipoUsuario)
                    {
                        case "Usuario":
                            // Redireccionar a la pagina que corresponda
                            Response.Redirect(@"~\Paginas\Usuario\ListaUsuario.aspx",false);
                            break;
                        case "Odontologo":
                            // Redireccionar a la pagina que corresponda
                            Response.Redirect("Pagina.aspx", false);
                            break;
                        case "Paciente":
                            Response.Redirect("Pagina.aspx", false);
                            // Redireccionar a la pagina que corresponda
                            break;
                    }
                }
            }
            catch (Exception x)
            {
                throw new Exception(string.Format(x.Message), x);
            }
        }

        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            if (txtUsuario.Text.Trim() != string.Empty && txtContraseña.Text.Trim() != string.Empty)
            {
                ValidarLogin(txtUsuario.Text, txtContraseña.Text);
            }
            else
            {
                
            }
        }
    }


}