using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Timetable_Backend.Models
{
    [Table("Teacher")]
    public class Teacher
    {
        [Key]
        [Required]
        public int ID { get; set; }

        [Required]
        public int Department_ID { get; set; }

        [StringLength(50)]
        [Required]
        public string Name { get; set; }
    }
}
