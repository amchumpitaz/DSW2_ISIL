using System.Data;
using Librerias.Isil.DentalSuite.Datos;
using Librerias.Isil.DentalSuite.Entidades;

namespace Librerias.Isil.DentalSuite.ReglasNegocio
{
    public class brUsuario
    {
        private readonly daUsuario _usuarioAdo = new daUsuario();

        public DataTable ListarUsuario()
        {
            return _usuarioAdo.ListarUsuario();
        }

        public bool InsertarUsuario(beUsuario usuarioBe)
        {
            return _usuarioAdo.InsertarUsuario(usuarioBe);
        }

        public bool EliminarUsuario(beUsuario usuarioBe)
        {
            return _usuarioAdo.EliminarUsuario(usuarioBe);
        }

        public bool ModificarUsuario(beUsuario usuarioBe)
        {
            return _usuarioAdo.ModificarUsuario(usuarioBe);
        }
    }
}
