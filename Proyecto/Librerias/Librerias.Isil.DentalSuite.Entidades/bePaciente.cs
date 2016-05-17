using System.IO;

namespace Librerias.Isil.DentalSuite.Entidades
{
    public class bePaciente
    {
        public string Codigo {get;set;}
        public string Nombres { get; set;}
        public string ApellidoPaterno { get; set; }
        public string ApellidoMaterno { get; set; }
        public string Sexo { get; set; }
        public string TipoDocumento { get; set; }
        public string NumeroDocumento { get; set; }
        public string Correo { get; set; }
        public string Direccion { get; set; }
        public string CodigoDepartamento { get; set; }
        public string CodigoProvincia { get; set; }
        public string CodigoDistrito { get; set; }
        public Stream Contraseña { get; set; }
    }
}
