using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using Librerias.Isil.DentalSuite.Entidades;

namespace Librerias.Isil.DentalSuite.Datos
{
    public class daCita
    {
        public bool AgregarCita(SqlConnection con, beCita obeCita)
        {
            int n = 0;
            try
            {
                SqlCommand cmd = new SqlCommand("USP_Insertar_Cita", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@fecha",obeCita.FechaCita);
                cmd.Parameters.AddWithValue("@codEsp",obeCita.CodigoEspecialidad);
                cmd.Parameters.AddWithValue("@codPac",obeCita.CodigoPaciente);
                cmd.Parameters.AddWithValue("@codHorOdo", obeCita.CodigoHorarioOdontologo);
                n=cmd.ExecuteNonQuery();
                if (n > 0) return true;
                else return false;
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }
    }
}
