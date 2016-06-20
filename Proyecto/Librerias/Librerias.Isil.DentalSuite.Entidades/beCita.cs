using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Librerias.Isil.DentalSuite.Entidades
{
    public class beCita
    {
        public string CodigoCita { get; set; }
        public DateTime FechaCita { get; set; }
        public string CodigoEspecialidad { get; set; }
        public string CodigoPaciente { get; set; }
        public string CodigoHorarioOdontologo {get;set;}
        public byte Estado { get; set; }     
    }
}
