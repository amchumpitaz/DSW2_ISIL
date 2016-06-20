using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Librerias.Isil.DentalSuite.Entidades;
using Librerias.Isil.DentalSuite.Datos;

namespace Librerias.Isil.DentalSuite.ReglasNegocio
{
    public class brCita
    {
        public bool AgregarCita(beCita obeCita)
        {
            bool exito = false;
            string conexion = ConfigurationManager.ConnectionStrings["Dental"].ConnectionString;
            using (SqlConnection con= new SqlConnection(conexion))
            {
                try
                {
                    con.Open();
                    daCita odaCita = new daCita();
                    exito = odaCita.AgregarCita(con, obeCita);
                    return exito;
                }
                catch(Exception ex)
                {
                    throw ex;                    
                }
            }
        }
    }
}
