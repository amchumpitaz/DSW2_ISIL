using System.Data;
using Librerias.Isil.DentalSuite.Datos;
using Librerias.Isil.DentalSuite.Entidades;

namespace ReglasNegocio
{
    public class UsuarioBL
    {
        private readonly UsuarioADO _usuarioAdo = new UsuarioADO();

        public DataTable ListarUsuario()
        {
            return _usuarioAdo.ListarUsuario();
        }

        public bool InsertarUsuario(UsuarioBE usuarioBe)
        {
            return _usuarioAdo.InsertarUsuario(usuarioBe);
        }

        public bool EliminarUsuario(UsuarioBE usuarioBe)
        {
            return _usuarioAdo.EliminarUsuario(usuarioBe);
        }

        public bool ModificarUsuario(UsuarioBE usuarioBe)
        {
            return _usuarioAdo.ModificarUsuario(usuarioBe);
        }

    }
}
