using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Librerias.Isil.DentalSuite.Entidades;

namespace Librerias.Isil.DentalSuite.Datos
{
    public class daPaciente
    {
        public bePaciente BuscarPaciente(SqlConnection con,string codigo)
        {
            bePaciente obePaciente = null;            
            try
            {
                SqlCommand cmd = new SqlCommand("USP_Buscar_Paciente", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Cod_Paciente", codigo);
                SqlDataReader drd = cmd.ExecuteReader(CommandBehavior.SingleRow);
                if (drd != null)
                {
                    obePaciente = new bePaciente();
                    if (drd.Read())
                    {
                        obePaciente.Codigo = drd.GetString(0);
                        obePaciente.Nombres = drd.GetString(1);
                        obePaciente.ApellidoPaterno = drd.GetString(2);
                        obePaciente.ApellidoMaterno = drd.GetString(3);
                        obePaciente.Sexo = drd.GetString(4);
                        obePaciente.TipoDocumento = drd.GetString(5);
                        obePaciente.NumeroDocumento = drd.GetString(6);
                        obePaciente.Correo = drd.GetString(7);
                        obePaciente.Direccion = drd.GetString(8);
                        obePaciente.CodigoDepartamento = drd.GetString(9);
                        obePaciente.CodigoProvincia = drd.GetString(10);
                        obePaciente.CodigoDistrito = drd.GetString(11);
                        //obePaciente.Contraseña = drd.GetStream(12);
                    }
                    drd.Close();
                }
                return obePaciente;
            }
            catch(Exception ex)
            {
                throw ex;
            }            
        }

        public List<bePaciente> ListarPacientes(SqlConnection con)
        {
            List<bePaciente> lbePaciente = null;
            bePaciente obePaciente = null;
            try
                {
                
                SqlCommand cmd = new SqlCommand("USP_Listar_Paciente", con);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataReader drd = cmd.ExecuteReader(CommandBehavior.SingleResult);
                if (drd != null)
                {
                    lbePaciente = new List<bePaciente>();                   
                    while (drd.Read())
                    {
                        obePaciente = new bePaciente();
                        obePaciente.Codigo = drd.GetString(0);
                        obePaciente.Nombres = drd.GetString(1);
                        obePaciente.ApellidoPaterno = drd.GetString(2);
                        obePaciente.ApellidoMaterno = drd.GetString(3);
                        obePaciente.Sexo = drd.GetString(4);
                        obePaciente.TipoDocumento = drd.GetString(5);
                        obePaciente.NumeroDocumento = drd.GetString(6);
                        obePaciente.Correo = drd.GetString(7);
                        obePaciente.Direccion = drd.GetString(8);
                        obePaciente.CodigoDepartamento = drd.GetString(9);
                        obePaciente.CodigoProvincia = drd.GetString(10);
                        obePaciente.CodigoDistrito = drd.GetString(11);
                        //obePaciente.Contraseña = drd.GetStream(12);
                        lbePaciente.Add(obePaciente);
                    }
                    drd.Close();
                }
                return lbePaciente;
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        public bool EliminarPaciente(SqlConnection con, string codigo)
        {
            bool exito = false;
            try
            {                
                SqlCommand cmd = new SqlCommand("USP_Eliminar_Paciente", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Cod_Paciente", codigo);
                int n = cmd.ExecuteNonQuery();
                exito = (n > 0);
                return exito;
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }
        
        public bool ActualizarPaciente(SqlConnection con, bePaciente obePaciente)
        {
            bool exito = false;
            try
            {
                SqlCommand cmd = new SqlCommand("USP_Modificar_Paciente", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Cod_Paciente", obePaciente.Codigo);
                cmd.Parameters.AddWithValue("@Nombres", obePaciente.Nombres);
                cmd.Parameters.AddWithValue("@Ape_Paterno", obePaciente.ApellidoPaterno);
                cmd.Parameters.AddWithValue("@Ape_Materno", obePaciente.ApellidoMaterno);
                cmd.Parameters.AddWithValue("@Sexo", obePaciente.Sexo);
                cmd.Parameters.AddWithValue("@Cod_Tipo_Documento", obePaciente.TipoDocumento);
                cmd.Parameters.AddWithValue("@Num_Documento", obePaciente.NumeroDocumento);
                cmd.Parameters.AddWithValue("@Correo", obePaciente.Correo);
                cmd.Parameters.AddWithValue("@Direccion", obePaciente.Direccion);
                cmd.Parameters.AddWithValue("@Cod_Departamento", obePaciente.CodigoDepartamento);
                cmd.Parameters.AddWithValue("@Cod_Provincia", obePaciente.CodigoProvincia);
                cmd.Parameters.AddWithValue("@Cod_Distrito", obePaciente.CodigoDistrito);
                int n = cmd.ExecuteNonQuery();
                exito = (n > 0);
                return exito;
            }
            catch(Exception ex)
            {
                throw ex;
            }            
        }
    }
}
