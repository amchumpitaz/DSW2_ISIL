using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Librerias.Isil.DentalSuite.Entidades
{
    public class beCita
    {
        public int CodigoCita { get; set; }
        public DateTime FechaCita { get; set; }
        public int CodigoEspecialidad { get; set; }
        public string CodigoPaciente { get; set; }
        public int CodigoHorarioOdontologo {get;set;}
        public byte Estado { get; set; }     
    }
}
