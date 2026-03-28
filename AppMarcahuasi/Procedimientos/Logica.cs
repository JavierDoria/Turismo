using AppMarcahuasi.Entities;
using AppMarcahuasi.Utils;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;


namespace AppMarcahuasi.Procedimientos
{
    public class Logica
    {
        public readonly string _cadena = ConfigurationManager.ConnectionStrings["cadenaSQL"].ToString();

        public bool RegistrarTurista(Turismo turismo)
        {
            bool Respuesta = false;
            using (SqlConnection con = new SqlConnection(_cadena))
            using (SqlCommand oCm = new SqlCommand("sp_RegistrarTurista", con))
            {
                oCm.CommandType = CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    oCm.Parameters.Clear();
                    oCm.Parameters.Add("@Nombres", SqlDbType.VarChar, 40).Value = turismo.Nombres;
                    oCm.Parameters.Add("@Apellidos", SqlDbType.VarChar, 40).Value = turismo.Apellidos;
                    oCm.Parameters.Add("@Nacionalidad", SqlDbType.Char, 1).Value = turismo.Nacionalidad;
                    oCm.Parameters.Add("@PrecioBoleta", SqlDbType.Int).Value = turismo.PrecioBoleta;
                    oCm.Parameters.AddWithValue("@Correlativo", Parametros.Correlativo);
                    oCm.Parameters.AddWithValue("@Usuario_Registro", Parametros.UserLogin);
                    Respuesta = oCm.ExecuteNonQuery() > 0;
                }
                catch (Exception)
                {
                    throw;
                }
            }
            return Respuesta;
        }

        public bool ActualizarTurista(Turismo turismo)
        {
            bool Respuesta = true;

            SqlConnection con = new SqlConnection(_cadena);
            SqlCommand oCm = new SqlCommand();

            oCm.CommandType = CommandType.StoredProcedure;
            oCm.CommandText = "sp_Actualizar";
            oCm.Connection = con;

            try
            {
                con.Open();
                oCm.Parameters.Clear();

                oCm.Parameters.Add("@Id_Turista", SqlDbType.Int);
                oCm.Parameters.Add("@Nombres", SqlDbType.VarChar, 40);
                oCm.Parameters.Add("@Apellidos", SqlDbType.VarChar, 40);
                oCm.Parameters.Add("@Nacionalidad", SqlDbType.Char, 1);
                oCm.Parameters.Add("@PrecioBoleta", SqlDbType.Int);
                oCm.Parameters.Add("@Usuario_Modifica", SqlDbType.VarChar, 40);

                oCm.Parameters["@Id_Turista"].Value = turismo.Id_Turista;
                oCm.Parameters["@Nombres"].Value = turismo.Nombres;
                oCm.Parameters["@Apellidos"].Value = turismo.Apellidos;
                oCm.Parameters["@Nacionalidad"].Value = turismo.Nacionalidad;
                oCm.Parameters["@PrecioBoleta"].Value = turismo.PrecioBoleta;
                oCm.Parameters["@Usuario_Modificacion"].Value = turismo.Usuario_Modificacion;

                Respuesta = oCm.ExecuteNonQuery() > 0;
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                oCm.Dispose();
                con.Close();
                con.Dispose();
            }

            return Respuesta;
        }

        public List<Turismo> ListarTuristas(DateTime fechaInicio, DateTime fechaFin, string nacionalidad)
        {
            List<Turismo> listado = new List<Turismo>();
            SqlConnection con = new SqlConnection(_cadena);
            SqlCommand oCm = new SqlCommand();
            SqlDataReader dr = null;

            oCm.CommandType = CommandType.StoredProcedure;
            oCm.CommandText = "sp_Listar";
            oCm.Connection = con;

            try
            {
                con.Open();
                oCm.Parameters.Clear();

                oCm.Parameters.Add("@Fecha_Inicio", SqlDbType.DateTime).Value = fechaInicio;
                oCm.Parameters.Add("@Fecha_Fin", SqlDbType.DateTime).Value = fechaFin;
                oCm.Parameters.Add("@Nacionalidad", SqlDbType.Char, 1).Value = nacionalidad;

                dr = oCm.ExecuteReader();
                while (dr.Read())
                {
                    Turismo turista = new Turismo();
                    turista.Id_Turista = Convert.ToInt32(dr["Id_Turista"]);
                    turista.Nombres = dr["Nombres"].ToString();
                    turista.Apellidos = dr["Apellidos"].ToString();
                    turista.Nacionalidad = dr["Nacionalidad"].ToString().Trim()[0];
                    turista.PrecioBoleta = Convert.ToInt32(dr["PrecioBoleta"]);
                    turista.Correlativo = dr["Correlativo"].ToString();
                    turista.Fecha_Registro = Convert.ToDateTime(dr["Fecha_Registro"]);
                    turista.Usuario_Registro = dr["Usuario_Registro"].ToString();

                    listado.Add(turista);
                }
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            return listado;
        }

        public List<Turismo> ObtenerTuristas()
        {
            List<Turismo> listado = new List<Turismo>();

            try
            {
                using (SqlConnection con = new SqlConnection(_cadena))
                using (SqlCommand cmd = new SqlCommand("sp_ObtenerUltimoRegistro", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            Turismo turista = new Turismo();
                            turista.Id_Turista = Convert.ToInt32(dr["Id_Turista"]);
                            turista.Nombres = dr["Nombres"].ToString();
                            turista.Apellidos = dr["Apellidos"].ToString();
                            turista.Nacionalidad = dr["Nacionalidad"].ToString().Trim()[0];
                            turista.PrecioBoleta = Convert.ToInt32(dr["PrecioBoleta"]);

                            listado.Add(turista);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw;
            }
            return listado;
        }

        public bool VerificarLogin(Administrador admin)
        {
            using (SqlConnection con = new SqlConnection(_cadena))
            using (SqlCommand cmd = new SqlCommand(
                "SELECT 1 FROM Administrador WHERE Dni = @Dni AND Password = @Password", con))
            {
                cmd.Parameters.Add("@Dni", SqlDbType.VarChar, 8).Value = admin.Dni;
                cmd.Parameters.Add("@Password", SqlDbType.VarChar, 25).Value = admin.Password;

                con.Open();
                return cmd.ExecuteScalar() != null;
            }
        }
    }
}