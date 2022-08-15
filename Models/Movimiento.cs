using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace appPrueba1.Models
{
    public class Movimiento
    {
        [Key]
        public int id { get; set; }

        public int cuentaId { get; set; }

        public DateTime fecha { get; set; }

        public string tipo { get; set; }

        public decimal valor { get; set; }

        public decimal saldo { get; set; }
        
    }
}
