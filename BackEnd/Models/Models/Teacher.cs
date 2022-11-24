using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace TTB.Models
{
    [Table("Teacher")]
    public class Teacher
    {
        [Key]
        [Required]
        public int ID { get; set; }
        [StringLength(250)]
        [Required]
        public string Faculty { get; set; }
        [Required]
        public string Department_Title { get; set; }

        [StringLength(250)]
        [Required]
        public string Name { get; set; }


    }
}
