using System;
using System.Data;
using System.Data.SqlClient;
using Librerias.Isil.DentalSuite.Entidades;

namespace Librerias.Isil.DentalSuite.Datos
{
    public class daEspecialidad
    {
        private readonly daConexion _miConexion = new daConexion();
        public bool Exito;
        public DataTable ListarEspecialidad()
        {
            var dts = new DataSet();
            using (var cnx = new SqlConnection(_miConexion.GetCnx()))
            {
                using (var cmd = new SqlCommand("USP_Listar_Especialidad", cnx))
                {
                    cnx.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        using (var miada = new SqlDataAdapter(cmd))
                        {
                            miada.Fill(dts, "Especialidad");
                        }
                    }
                    catch (Exception x)
                    {
                        throw new Exception(string.Format(x.Message), x);
                    }
                }
            }
            return dts.Tables["Especialidad"];
        }

        public bool InsertarEspecialidad(beEspecialidad especialidadBe)
        {
            using (var cnx = new SqlConnection(_miConexion.GetCnx()))
            {
                using (var cmd = new SqlCommand("USP_Insertar_Especialidad", cnx))
                {
                    cnx.Open();
                    cmd.CommandType = CommandType.StoredProcedure;

                    try
                    {
                        cmd.Parameters.Add(new SqlParameter("@Nombre", SqlDbType.VarChar)).Value = especialidadBe.Nombre;
                        cmd.Parameters.Add(new SqlParameter("@Descripcion", SqlDbType.VarChar)).Value = especialidadBe.Descripcion;

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

        public bool EliminarEspecialidad(beEspecialidad especialidadBe)
        {
            using (var cnx = new SqlConnection(_miConexion.GetCnx()))
            {
                using (var cmd = new SqlCommand("USP_Eliminar_Especialidad", cnx))
                {
                    cnx.Open();
                    cmd.CommandType = CommandType.StoredProcedure;

                    try
                    {
                        cmd.Parameters.Add(new SqlParameter("@Cod_Especialidad", SqlDbType.Int)).Value = especialidadBe.Cod_Especialidad;
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

        public bool ModificarEspecialidad(beEspecialidad especialidadBe)
        {
            using (var cnx = new SqlConnection(_miConexion.GetCnx()))
            {
                using (var cmd = new SqlCommand("USP_Modificar_Especialidad", cnx))
                {
                    cnx.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        cmd.Parameters.Add(new SqlParameter("@Cod_Especialidad", SqlDbType.Int)).Value = especialidadBe.Cod_Especialidad;
                        cmd.Parameters.Add(new SqlParameter("@Nombre", SqlDbType.VarChar)).Value = especialidadBe.Nombre;
                        cmd.Parameters.Add(new SqlParameter("@Descripcion", SqlDbType.VarChar)).Value = especialidadBe.Descripcion;

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

        public beEspecialidad BuscarEspecialidad(int codEspecialidad)
        {
            using (var cnx = new SqlConnection(_miConexion.GetCnx()))
            {
                using (var cmd = new SqlCommand("USP_Buscar_Especialidad", cnx))
                {
                    cnx.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        cmd.Parameters.Add(new SqlParameter("@Cod_Especialidad", SqlDbType.Int)).Value = codEspecialidad;

                        var drd = cmd.ExecuteReader(CommandBehavior.SingleRow);
                        beEspecialidad obeEspecialidad = null;
                        obeEspecialidad = new beEspecialidad();
                        if (drd.HasRows)
                        {
                            drd.Read();
                            obeEspecialidad.Cod_Especialidad = int.Parse(drd.GetValue(drd.GetOrdinal("Cod_Especialidad")).ToString());
                            obeEspecialidad.Nombre = drd.GetValue(drd.GetOrdinal("Nombre")).ToString();
                            obeEspecialidad.Descripcion = drd.GetValue(drd.GetOrdinal("Descripcion")).ToString();
                            drd.Close();
                        }
                        return obeEspecialidad;
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
