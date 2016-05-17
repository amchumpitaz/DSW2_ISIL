using System;
using System.Data;
using System.Data.SqlClient;
using Librerias.Isil.DentalSuite.Entidades;

namespace Librerias.Isil.DentalSuite.Datos
{
    public class daUsuario
    {
        private readonly daConexion _miConexion = new daConexion();
        public bool Exito;
        public DataTable ListarUsuario()
        {
            var dts = new DataSet();
            using (var cnx = new SqlConnection(_miConexion.GetCnx()))
            {
                using (var cmd = new SqlCommand("USP_Listar_Usuario", cnx))
                {
                    cnx.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        using (var miada = new SqlDataAdapter(cmd))
                        {
                            miada.Fill(dts, "Usuario");
                        }
                    }
                    catch (Exception x)
                    {
                        throw new Exception(string.Format(x.Message), x);
                    }
                }
            }
            return dts.Tables["Usuario"];
        }

        public bool InsertarUsuario(beUsuario usuarioBe)
        {
            using (var cnx = new SqlConnection(_miConexion.GetCnx()))
            {
                using (var cmd = new SqlCommand("USP_Insertar_Usuario", cnx))
                {
                    cnx.Open();
                    cmd.CommandType = CommandType.StoredProcedure;

                    try
                    {
                        cmd.Parameters.Add(new SqlParameter("@Nombres", SqlDbType.VarChar)).Value = usuarioBe.Nombres;
                        cmd.Parameters.Add(new SqlParameter("@Apellidos", SqlDbType.VarChar)).Value = usuarioBe.Apellidos;
                        cmd.Parameters.Add(new SqlParameter("@Contrasena", SqlDbType.VarChar)).Value = usuarioBe.Contrasena;
                        var n = cmd.ExecuteNonQuery();
                        Exito = (n > 0);
                        return Exito;
                    }
                    catch (Exception x)
                    {
                        throw new Exception(string.Format(x.Message), x);
                    }
                }
            }
        }

        public bool EliminarUsuario(beUsuario usuarioBe)
        {
            using (var cnx = new SqlConnection(_miConexion.GetCnx()))
            {
                using (var cmd = new SqlCommand("USP_Eliminar_Usuario", cnx))
                {
                    cnx.Open();
                    cmd.CommandType = CommandType.StoredProcedure;

                    try
                    {
                        cmd.Parameters.Add(new SqlParameter("@Cod_Usuario", SqlDbType.Char)).Value = usuarioBe.Cod_Usuario;
                        var n = cmd.ExecuteNonQuery();
                        Exito = (n > 0);
                        return Exito;
                    }
                    catch (Exception x)
                    {
                        throw new Exception(string.Format(x.Message), x);
                    }
                }
            }
        }

        public bool ModificarUsuario(beUsuario usuarioBe)
        {
            using (var cnx = new SqlConnection(_miConexion.GetCnx()))
            {
                using (var cmd = new SqlCommand("USP_Modificar_Usuario", cnx))
                {
                    try
                    {
                        cmd.Parameters.Add(new SqlParameter("@Cod_Usuario", SqlDbType.Char)).Value = usuarioBe.Cod_Usuario;
                        cmd.Parameters.Add(new SqlParameter("@Nombres", SqlDbType.VarChar)).Value = usuarioBe.Nombres;
                        cmd.Parameters.Add(new SqlParameter("@Apellidos", SqlDbType.VarChar)).Value = usuarioBe.Apellidos;
                        cmd.Parameters.Add(new SqlParameter("@Contrasena", SqlDbType.VarChar)).Value = usuarioBe.Contrasena;
                        var n = cmd.ExecuteNonQuery();
                        Exito = (n > 0);
                        return Exito;
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
