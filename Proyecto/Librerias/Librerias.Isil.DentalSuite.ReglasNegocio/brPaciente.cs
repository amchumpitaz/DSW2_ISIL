using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using Librerias.Isil.DentalSuite.Datos;
using Librerias.Isil.DentalSuite.Entidades;

namespace Librerias.Isil.DentalSuite.ReglasNegocio
{
    public class brPaciente
    {
        public List<bePaciente> Listar()
        {
            List<bePaciente> lbePaciente = null;
            string conexion = ConfigurationManager.ConnectionStrings["Dental"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conexion))
            {
                try
                {
                    con.Open();
                    daPaciente odaPaciente = new daPaciente();
                    lbePaciente = odaPaciente.ListarPacientes(con);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return lbePaciente;
        }
    }
}
