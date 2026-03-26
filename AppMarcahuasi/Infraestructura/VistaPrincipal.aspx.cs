using AppMarcahuasi.Entities;
using AppMarcahuasi.Procedimientos;
using AppMarcahuasi.Utils;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppMarcahuasi.Infraestructura
{
    public partial class VistaPrincipal : System.Web.UI.Page
    {
        public int PrecioNacional => 20;
        public int PrecioInternacional => 25;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                gvTuristas.DataSource = new List<object>(); // lista vacía
                gvTuristas.DataBind();
                ObtenerUltimoTurista();
            }
            else
            {
                // cada vez que el front mande algo, despues de la primera carga

                RegistrarTicket();
            }
        }
        private void ObtenerUltimoTurista()
        {
            Logica logica = new Logica();
            List<Turismo> lista = new List<Turismo>();
            Turismo listaDos = logica.ObtenerTuristas();
            lista.Add(listaDos);
            gvTuristas.DataSource = lista;
            gvTuristas.DataBind();
        }
        private void RegistrarTicket()
        {
            Logica logica = new Logica();
            Turismo turismo = new Turismo();

            try
            {
                turismo.Nombres = txtNombre.Text;
                turismo.Apellidos = txtApellido.Text;
                turismo.Nacionalidad = ddlNacionalidad.SelectedValue[0];
                turismo.PrecioBoleta = turismo.Nacionalidad == 'N' ? Parametros.PrecioNacional : Parametros.PrecioInternacional;

                bool respuesta = logica.RegistrarTurista(turismo);

                if (respuesta)
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ok", "imprimirExito();", true);            
                else
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "err", "errorTicket();", true);

            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", "errorTicket('" + ex.Message.Replace("'", "").Replace("\"","") + "')", true);
                
            }
        }
    }
}