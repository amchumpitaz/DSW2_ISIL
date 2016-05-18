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
    }
}
