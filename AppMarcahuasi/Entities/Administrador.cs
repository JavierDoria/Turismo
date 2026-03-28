using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace AppMarcahuasi.Entities
{
    public class Administrador
    {
        [Key]
        public int Id_Administrador { get; set; }
        public string Dni {get; set;}
        public string Password { get; set;}
    }
}