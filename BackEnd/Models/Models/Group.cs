using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace TTB.Models
{
    [Table("Group")]
    public class Group
    {
        
        [Required]
        [StringLength(50)]
        public string Title { get; set; }
        [Required]
        public byte Cource { get; set; }
      

    }
}
