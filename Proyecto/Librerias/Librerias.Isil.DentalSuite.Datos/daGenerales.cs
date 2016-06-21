using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Librerias.Isil.DentalSuite.Entidades;

namespace Librerias.Isil.DentalSuite.Datos
{
    public class daGenerales
    {
        public List<beDepartamento> ListarDepartamento(SqlConnection con)
        {
            List<beDepartamento> lbeDepartamento = null;
            beDepartamento obeDepartamento = null;
            try
            {

                SqlCommand cmd = new SqlCommand("USP_listar_departamentos", con);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataReader drd = cmd.ExecuteReader(CommandBehavior.SingleResult);
                if (drd != null)
                {
                    lbeDepartamento = new List<beDepartamento>();
                    while (drd.Read())
                    {
                        obeDepartamento = new beDepartamento();
                        obeDepartamento.codigo = drd.GetString(0);
                        obeDepartamento.Detalle = drd.GetString(1);
                        lbeDepartamento.Add(obeDepartamento);
                    }
                    drd.Close();
                }
                return lbeDepartamento;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<beProvincia> ListarProvincia(SqlConnection con,string cod_departamento)
        {
            List<beProvincia> lbeProvincia = null;
            beProvincia obeProvincia = null;
            try
            {

                SqlCommand cmd = new SqlCommand("USP_listar_provincias", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Cod_Departamento", cod_departamento);
                SqlDataReader drd = cmd.ExecuteReader(CommandBehavior.SingleResult);
                if (drd != null)
                {
                    lbeProvincia = new List<beProvincia>();
                    while (drd.Read())
                    {
                        obeProvincia = new beProvincia();
                        obeProvincia.Codigo = drd.GetString(0);
                        obeProvincia.Detalle = drd.GetString(1);
                        lbeProvincia.Add(obeProvincia);
                    }
                    drd.Close();
                }
                return lbeProvincia;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<beDistrito> ListarDistritos(SqlConnection con, string cod_departamento,string cod_provincia)
        {
            List<beDistrito> lbeDistrito = null;
            beDistrito obeDistrito = null;
            try
            {

                SqlCommand cmd = new SqlCommand("USP_listar_distritos", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Cod_Departamento", cod_departamento);
                cmd.Parameters.AddWithValue("@Cod_Provincia", cod_provincia);
                SqlDataReader drd = cmd.ExecuteReader(CommandBehavior.SingleResult);
                if (drd != null)
                {
                    lbeDistrito = new List<beDistrito>();
                    while (drd.Read())
                    {
                        obeDistrito = new beDistrito();
                        obeDistrito.Codigo = drd.GetString(0);
                        obeDistrito.Detalle = drd.GetString(1);
                        lbeDistrito.Add(obeDistrito);
                    }
                    drd.Close();
                }
                return lbeDistrito;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<beTipoDocumento> ListarTipoDocumento(SqlConnection con)
        {
            List<beTipoDocumento> lbeTipoDocumento = null;
            beTipoDocumento obeTipoDocumento = null;
            try
            {

                SqlCommand cmd = new SqlCommand("USP_Listar_Tipo_Documento", con);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataReader drd = cmd.ExecuteReader(CommandBehavior.SingleResult);
                if (drd != null)
                {
                    lbeTipoDocumento = new List<beTipoDocumento>();
                    while (drd.Read())
                    {
                        obeTipoDocumento = new beTipoDocumento();
                        obeTipoDocumento.Codigo = drd.GetValue(drd.GetOrdinal("Cod_Tipo_Documento")).ToString();
                        obeTipoDocumento.Detalle = drd.GetValue(drd.GetOrdinal("Descripcion_Corta")).ToString();
                        lbeTipoDocumento.Add(obeTipoDocumento);
                    }
                    drd.Close();
                }
                return lbeTipoDocumento;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public string ObtenerCodigoTipDocumento(SqlConnection con,string desc_corta)
        {
            object tipoDocumento = null;
            try
            {

                SqlCommand cmd = new SqlCommand("USP_obtener_codigo_TipDocumento", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Desc_Corta", desc_corta);
                tipoDocumento = cmd.ExecuteScalar();
                if (tipoDocumento != null)
                {
                    if (tipoDocumento.ToString().Trim() != "")
                    {
                        return tipoDocumento.ToString().Trim();
                    }
                    return "";
                }
                return "";
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<beEspecialidad> ListarEspecialidadCBO(SqlConnection con)
        {
            List<beEspecialidad> lbeEspecialidad = null;
            beEspecialidad obeEspecialidad = null;
            try
            {
                SqlCommand cmd = new SqlCommand("USP_Listar_Especialidad_cbo",con);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataReader drd = cmd.ExecuteReader();
                if (drd != null)
                {
                    lbeEspecialidad = new List<beEspecialidad>();
                    while (drd.Read())
                    {
                        obeEspecialidad = new beEspecialidad();
                        obeEspecialidad.Cod_Especialidad = drd.GetInt32(0);
                        obeEspecialidad.Nombre = drd.GetString(1);
                        lbeEspecialidad.Add(obeEspecialidad);
                    }
                }
                return lbeEspecialidad;
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        public List<beOdontologo> ListarOdontologoCBO(SqlConnection con)
        {
            List<beOdontologo> lbeOdontologo = null;
            beOdontologo obeOdontologo = null;
            try
            {
                SqlCommand cmd = new SqlCommand("USP_Listar_Odontologo_cbo", con);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataReader drd = cmd.ExecuteReader();
                if (drd != null)
                {
                    lbeOdontologo = new List<beOdontologo>();
                    while (drd.Read())
                    {
                        obeOdontologo = new beOdontologo();
                        obeOdontologo.Codigo = drd.GetString(0);
                        obeOdontologo.Nombres = drd.GetString(1);
                        lbeOdontologo.Add(obeOdontologo);
                    }
                }
                return lbeOdontologo;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<beHorarioOdontologo> ListarHorarioOdontologoCBO(SqlConnection con, string codOdontologo)
        {
            List<beHorarioOdontologo> lbeHorarioOdontologo = null;
            beHorarioOdontologo obeHorarioOdontologo = null;
            try
            {
                SqlCommand cmd = new SqlCommand("USP_Listar_Horario_Odontologo_Cbo", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@cod_odonto",codOdontologo);
                SqlDataReader drd = cmd.ExecuteReader();
                if (drd != null)
                {
                    lbeHorarioOdontologo = new List<beHorarioOdontologo>();
                    while (drd.Read())
                    {
                        obeHorarioOdontologo = new beHorarioOdontologo();
                        obeHorarioOdontologo.CodigoHorarioOdontologo = drd.GetInt32(0);
                        obeHorarioOdontologo.Detalle = drd.GetString(1);
                        lbeHorarioOdontologo.Add(obeHorarioOdontologo);
                    }
                }
                return lbeHorarioOdontologo;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
