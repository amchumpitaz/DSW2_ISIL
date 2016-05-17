using System.Data;
using Librerias.Isil.DentalSuite.Datos;
using Librerias.Isil.DentalSuite.Entidades;

namespace Librerias.Isil.DentalSuite.ReglasNegocio
{
    public class brEspecialidad
    {
        private readonly daEspecialidad _usuarioAdo = new daEspecialidad();

        public DataTable ListarEspecialidad()
        {
            return _usuarioAdo.ListarEspecialidad();
        }

        public bool InsertarEspecialidad(beEspecialidad especialidadBe)
        {
            return _usuarioAdo.InsertarEspecialidad(especialidadBe);
        }

        public bool EliminarEspecialidad(beEspecialidad especialidadBe)
        {
            return _usuarioAdo.EliminarEspecialidad(especialidadBe);
        }

        public bool ModificarEspecialidad(beEspecialidad especialidadBe)
        {
            return _usuarioAdo.ModificarEspecialidad(especialidadBe);
        }
    }
}
