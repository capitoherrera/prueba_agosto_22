using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace appPrueba1.Models
{
    public class Persona
    {
        [Key]
        public int id { get; set; }
       
        public string nombre { get; set; }

        public string genero { get; set; }

        public int edad { get; set; }

        public string identificacion { get; set; }

        public string direccion { get; set; }
        public string telefono { get; set; }

    }
}
