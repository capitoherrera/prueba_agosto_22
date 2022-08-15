using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace appPrueba1.Models
{
    public class ListadoMovimientos
    {
        public int clienteId { get; set; }

        public string fecha { get; set; }

        public string cliente { get; set; }

        public string numeroCuenta { get; set; }

        public string tipo { get; set; }

        public decimal saldoInicial { get; set; }

        public string estado { get; set; }

        public decimal movimiento { get; set; }

        public decimal saldoDisponible { get; set; }

    }
}
