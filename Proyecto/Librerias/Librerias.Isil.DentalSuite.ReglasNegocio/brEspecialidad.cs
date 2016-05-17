using System.Data;
using Librerias.Isil.DentalSuite.Datos;
using Librerias.Isil.DentalSuite.Entidades;

namespace Librerias.Isil.DentalSuite.ReglasNegocio
{
    public class brEspecialidad
    {
        private readonly daEspecialidad _especialidadoAdo = new daEspecialidad();

        public DataTable ListarEspecialidad()
        {
            return _especialidadoAdo.ListarEspecialidad();
        }

        public bool InsertarEspecialidad(beEspecialidad especialidadBe)
        {
            return _especialidadoAdo.InsertarEspecialidad(especialidadBe);
        }

        public bool EliminarEspecialidad(beEspecialidad especialidadBe)
        {
            return _especialidadoAdo.EliminarEspecialidad(especialidadBe);
        }

        public bool ModificarEspecialidad(beEspecialidad especialidadBe)
        {
            return _especialidadoAdo.ModificarEspecialidad(especialidadBe);
        }

        public beEspecialidad BuscarEspecialidad(int codEspecialidad)
        {
            return _especialidadoAdo.BuscarEspecialidad(codEspecialidad);
        }
    }
}
