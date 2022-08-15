using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using appPrueba1.Models;

namespace appPrueba1.Data
{
    public class appPrueba1Context : DbContext
    {
        public appPrueba1Context (DbContextOptions<appPrueba1Context> options)
            : base(options)
        {
        }

        public DbSet<appPrueba1.Models.Persona> Persona { get; set; }
        public DbSet<appPrueba1.Models.Cliente> Cliente { get; set; }
        public DbSet<appPrueba1.Models.Cuenta> Cuenta { get; set; }
        public DbSet<appPrueba1.Models.Movimiento> Movimiento { get; set; }
    }
}
