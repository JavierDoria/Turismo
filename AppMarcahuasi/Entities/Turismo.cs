using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace AppMarcahuasi.Entities
{
    public class Turismo
    {
        [Key]
        public int Id_Turista { get; set; }
        public string Nombres { get; set; }
        public string Apellidos { get; set; }
        public char Nacionalidad { get; set; }
        public int PrecioBoleta { get; set; }
        public string Correlativo { get; set; }
        public DateTime Fecha_Registro { get; set; }
        public DateTime Fecha_Modificacion { get; set; }
        public string @Usuario_Registro { get; set; }
        public string @Usuario_Modificacion { get; set; }
    }
}