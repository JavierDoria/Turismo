using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AppMarcahuasi.Utils
{
    public static class Parametros
    {
        public static string UserLogin { get; set; } = "";
        
        public static string Correlativo => "C1-" + DateTime.Now.ToString("yy");
        public static readonly string NumeroCaja = "CAJA - 01";
        public static readonly int PrecioEstudiante = 15;
        public static readonly int PrecioNacional = 20;
        public static readonly int PrecioInternacional = 25;
    }
}