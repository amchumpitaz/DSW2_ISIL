﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Librerias.Isil.DentalSuite.Entidades
{
    public class beHorarioOdontologo
    {
        public int CodigoHorarioOdontologo { get; set; }
        public string CodigoOdontologo { get; set; }
        public string CodigoHorario { get; set; }
        public DateTime FechaRegistro { get; set; }
        public string Estado { get; set; }
        public string Detalle { get; set; }        
    }
}
