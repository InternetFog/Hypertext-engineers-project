using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Http;
using Newtonsoft.Json;
using System.Linq;
using System.Threading.Tasks;
using TTB.Models;

namespace TTB.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TeacherLesonController : ControllerBase
    {
        private readonly IConfiguration _config;
        public TeacherLesonController(IConfiguration configuration)
        {
            _config = configuration;
        }
        [HttpGet("{TeacherName}")]
        public IEnumerable<TeacherLeson> Get(string TeacherName)
        {
            string query = $"select wd.Title, wd.Week, wt.Title, wt.Start_Time, wt.End_Time,  les_t.Title, Gp.Title, t.Name, d.Title, a.Title, ol.Title " +
               $"from Official_Leson as ol " + // Get Lesson Title
               $"left join Work_Day as wd on wd.Id = ol.Day_Id " + // Get Word Day (Monthday)
               $"left join Work_time as wt on wt.Id = ol.Time_Id " + // Get Work Time Title 
               $"left join leson_type as les_t on les_t.Id = ol.Type_id " + // Get Lesson type
               $"left join teacher as t on t.Id = ol.Teacher_id " + // Get Teacher name
               $"left join department as d " + 
               $"on t.department_id = d.id " + // Get Department Title
               $"left join \"Group\" as Gp on Gp.id = ol.Group_Id " + // Get Group 
               $"left join Audience as a on a.Id = ol.Audience_Id " + // Get Audience Title
               $"Where t.Name = '{TeacherName}'";
            List<TeacherLeson> result = new List<TeacherLeson>();
            SqlConnection sCon = new SqlConnection(_config.GetConnectionString("cs"));
            using (var scmd = new SqlCommand(query, sCon))
            {
                sCon.Open();

                using var reader = scmd.ExecuteReader();

                while (reader.Read())
                {
                    result.Add(new TeacherLeson()
                    {
                        Day = (string)reader[0],
                        Week = (byte)reader[1],
                        Time_Title = (string)reader[2],
                        TimeStart = DateTime.Parse(reader[3].ToString()),
                        TimeEnd = DateTime.Parse(reader[4].ToString()),
                        Type = (string)reader[5],
                        GroupTitle = (string)reader[6],
                        Teacher = (string)reader[7],
                        Department = (string)reader[8],
                        Audience = (string)reader[9],
                        Title = (string)reader[10],
                    });
                }
            }
            return result;
        }
    }
}
