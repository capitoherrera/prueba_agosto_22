using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace appPrueba1.Models
{
    public class Cuenta
    {
        [Key]
        public int id { get; set; }

        public string numeroCuenta { get; set; }

        public string tipoCuenta { get; set; }

        public decimal saldoInicial { get; set; }

        public int estado { get; set; }

        public int  clienteId { get; set; }

        virtual public List<Movimiento> Movimientos { get; set; }
    }
}
