using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace TTB.Models
{
    [Table("GetLeson")]
    public class GetLeson
    {

        [Key]
        [Required]
        public int ID { get; set; }
        [Required]
        public string Day { get; set; }
        [Required]
        public byte  Week { get; set; }
        [Required]
        public string Time_Title { get; set; }
        [Required]
        public DateTime TimeStart { get; set; }
        [Required]
        public DateTime TimeEnd{ get; set; }
        [Required]
        public string Type { get; set; }
        [Required]
        [StringLength(50)]
        public string Title { get; set; }
        [Required]
        public string Teacher{ get; set; }
        [Required]
        public string Department { get; set; }
        [Required]
        public string Audience { get; set; }
    }
}
