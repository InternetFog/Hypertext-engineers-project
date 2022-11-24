using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace TTB.Models
{
    [Table("Official_Leson")]
    public class Official_Leson
    {
        [Key]
        [Required]
        public int ID { get; set; }


        [Required]
        public int Teacher_ID { get; set; }
        [Required]
        public int Type_ID { get; set; }
        [Required]
        public int Audience_ID { get; set; }
        [Required]
        public int Day_ID { get; set; }
        [Required]
        public int Time_ID { get; set; }
        [Required]
        public int Group_ID { get; set; }
        [Required]
        [StringLength(50)]
        public string Title_ID { get; set; }
    }
}
