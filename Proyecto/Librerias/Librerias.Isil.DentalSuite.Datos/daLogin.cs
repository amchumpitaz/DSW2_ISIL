using System;
using System.Data;
using System.Data.SqlClient;
using Librerias.Isil.DentalSuite.Entidades;

namespace Librerias.Isil.DentalSuite.Datos
{
    public class daLogin
    {
        private readonly daConexion _miConexion = new daConexion();

        public beLogin ValidarUsuario(string usuario, string contrasena)
        {
            using (var cnx = new SqlConnection(_miConexion.GetCnx()))
            {
                using (var cmd = new SqlCommand("USP_ValidarUsuario", cnx))
                {
                    cnx.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        cmd.Parameters.Add(new SqlParameter("@Usuario", SqlDbType.VarChar, 40)).Value = usuario;
                        cmd.Parameters.Add(new SqlParameter("@Contrasena", SqlDbType.VarChar, 40)).Value = contrasena;

                        var drd = cmd.ExecuteReader(CommandBehavior.SingleRow);
                        var obeLogin = new beLogin();
                        if (drd.HasRows)
                        {
                            drd.Read();
                            obeLogin.Nombre = drd.GetValue(drd.GetOrdinal("Nombre")).ToString();
                            obeLogin.Apellido = drd.GetValue(drd.GetOrdinal("Apellido")).ToString();
                            obeLogin.TipoUsuario = drd.GetValue(drd.GetOrdinal("TipoUsuario")).ToString();
                            drd.Close();
                        }
                        return obeLogin;
                    }
                    catch (Exception x)
                    {
                        throw new Exception(string.Format(x.Message), x);
                    }

                }
            }
        }
    }
}
