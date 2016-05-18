using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Librerias.Isil.DentalSuite.Entidades;

namespace Librerias.Isil.DentalSuite.Datos
{
    public class daOdontologo
    {
        public beOdontologo BuscarOdontologo(SqlConnection con, string codigo)
        {
            beOdontologo obeOdontologo = null;
            try
            {
                SqlCommand cmd = new SqlCommand("USP_Buscar_Odontologo", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Cod_Odontologo", codigo);
                SqlDataReader drd = cmd.ExecuteReader(CommandBehavior.SingleRow);
                if (drd != null)
                {
                    obeOdontologo = new beOdontologo();
                    if (drd.Read())
                    {
                        obeOdontologo.Codigo = drd.GetString(0);
                        obeOdontologo.Nombres = drd.GetString(1);
                        obeOdontologo.ApellidoPaterno = drd.GetString(2);
                        obeOdontologo.ApellidoMaterno = drd.GetString(3);
                        obeOdontologo.Sexo = drd.GetString(4);
                        obeOdontologo.TipoDocumento = drd.GetString(5);
                        obeOdontologo.NumeroDocumento = drd.GetString(6);
                        obeOdontologo.Correo = drd.GetString(7);
                        obeOdontologo.Direccion = drd.GetString(8);
                        obeOdontologo.CodigoDepartamento = drd.GetString(9);
                        obeOdontologo.CodigoProvincia = drd.GetString(10);
                        obeOdontologo.CodigoDistrito = drd.GetString(11);
                        obeOdontologo.COP = drd.GetString(12);
                        //obeOdontologo.estado = drd.GetByte(13);
                        //obeOdontologo.Contraseña = drd.GetStream(14);
                    }
                    drd.Close();
                }
                return obeOdontologo;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<beOdontologo> ListarOdontologos(SqlConnection con)
        {
            List<beOdontologo> lbeOdontologo = null;
            beOdontologo obeOdontologo = null;
            try
            {

                SqlCommand cmd = new SqlCommand("USP_Listar_Odontologo", con);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataReader drd = cmd.ExecuteReader(CommandBehavior.SingleResult);
                if (drd != null)
                {
                    lbeOdontologo = new List<beOdontologo>();
                    while (drd.Read())
                    {
                        obeOdontologo = new beOdontologo();
                        obeOdontologo.Codigo = drd.GetString(0);
                        obeOdontologo.Nombres = drd.GetString(1);
                        obeOdontologo.ApellidoPaterno = drd.GetString(2);
                        obeOdontologo.ApellidoMaterno = drd.GetString(3);
                        obeOdontologo.Sexo = drd.GetString(4);
                        obeOdontologo.TipoDocumento = drd.GetString(5);
                        obeOdontologo.NumeroDocumento = drd.GetString(6);
                        obeOdontologo.Correo = drd.GetString(7);
                        obeOdontologo.Direccion = drd.GetString(8);
                        obeOdontologo.CodigoDepartamento = drd.GetString(9);
                        obeOdontologo.CodigoProvincia = drd.GetString(10);
                        obeOdontologo.CodigoDistrito = drd.GetString(11);
                        obeOdontologo.COP = drd.GetString(12);
                        //obeOdontologo.estado = drd.GetByte(13);
                        //obeOdontologo.Contraseña = drd.GetStream(14);
                        lbeOdontologo.Add(obeOdontologo);
                    }
                    drd.Close();
                }
                return lbeOdontologo;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool EliminarOdontologo(SqlConnection con, string codigo)
        {
            bool exito = false;
            try
            {
                SqlCommand cmd = new SqlCommand("USP_Eliminar_Odontologo", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Cod_Odontologo", codigo);
                int n = cmd.ExecuteNonQuery();
                exito = (n > 0);
                return exito;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool ActualizarOdontologo(SqlConnection con, beOdontologo obeOdontologo)
        {
            bool exito = false;
            try
            {
                SqlCommand cmd = new SqlCommand("USP_Modificar_Odontologo", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Cod_Odontologo", obeOdontologo.Codigo);
                cmd.Parameters.AddWithValue("@Nombres", obeOdontologo.Nombres);
                cmd.Parameters.AddWithValue("@Ape_Paterno", obeOdontologo.ApellidoPaterno);
                cmd.Parameters.AddWithValue("@Ape_Materno", obeOdontologo.ApellidoMaterno);
                cmd.Parameters.AddWithValue("@Sexo", obeOdontologo.Sexo);
                cmd.Parameters.AddWithValue("@Cod_Tipo_Documento", obeOdontologo.TipoDocumento);
                cmd.Parameters.AddWithValue("@Num_Documento", obeOdontologo.NumeroDocumento);
                cmd.Parameters.AddWithValue("@Correo", obeOdontologo.Correo);
                cmd.Parameters.AddWithValue("@Direccion", obeOdontologo.Direccion);
                cmd.Parameters.AddWithValue("@Cod_Departamento", obeOdontologo.CodigoDepartamento);
                cmd.Parameters.AddWithValue("@Cod_Provincia", obeOdontologo.CodigoProvincia);
                cmd.Parameters.AddWithValue("@Cod_Distrito", obeOdontologo.CodigoDistrito);
                cmd.Parameters.AddWithValue("@COP", obeOdontologo.COP);
                int n = cmd.ExecuteNonQuery();
                exito = (n > 0);
                return exito;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
