using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace appPrueba1.Models
{
    public class Cliente: Persona
    {
        public string contrasena { get; set; }

        public int estado { get; set; }

        virtual public List<Cuenta> Cuentas { get; set; }
    }
}
