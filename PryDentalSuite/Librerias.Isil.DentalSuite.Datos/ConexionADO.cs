﻿using System.Configuration;

namespace Librerias.Isil.DentalSuite.Datos
{
    public class ConexionADO
    {
        public string GetCnx()
        {
            var strCnx = ConfigurationManager.ConnectionStrings["Dental"].ConnectionString;
            return ReferenceEquals(strCnx, string.Empty) ? string.Empty : strCnx;
        }
    }
}
