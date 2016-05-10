using System.Data;
using Librerias.Isil.DentalSuite.Datos;
using Librerias.Isil.DentalSuite.Entidades;

namespace ReglasNegocio
{
    public class EspecialidadBL
    {
        private readonly EspecialidadADO _usuarioAdo = new EspecialidadADO();

        public DataTable ListarEspecialidad()
        {
            return _usuarioAdo.ListarEspecialidad();
        }

        public bool InsertarEspecialidad(EspecialidadBE especialidadBe)
        {
            return _usuarioAdo.InsertarEspecialidad(especialidadBe);
        }

        public bool EliminarEspecialidad(EspecialidadBE especialidadBe)
        {
            return _usuarioAdo.EliminarEspecialidad(especialidadBe);
        }

        public bool ModificarEspecialidad(EspecialidadBE especialidadBe)
        {
            return _usuarioAdo.ModificarEspecialidad(especialidadBe);
        }

    }
}
