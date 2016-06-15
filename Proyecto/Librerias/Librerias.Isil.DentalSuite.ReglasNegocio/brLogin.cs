using Librerias.Isil.DentalSuite.Datos;
using Librerias.Isil.DentalSuite.Entidades;

namespace Librerias.Isil.DentalSuite.ReglasNegocio
{
    public class brLogin
    {
        private readonly daLogin _login = new daLogin();

        public beLogin ValidarUsuario(string usuario, string contrasena)
        {
            return _login.ValidarUsuario(usuario, contrasena);
        }
    }
}
