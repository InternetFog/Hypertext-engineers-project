using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using TTB.Models;

namespace TTB.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TeacherController : ControllerBase
    {
        private readonly IConfiguration _config;
        public TeacherController(IConfiguration configuration)
        {
            _config = configuration;
        }
        [HttpGet]
        public IEnumerable<Teacher> Get()
        {
            string query = $"select fac.Title, dep.Title, tea.Name " +
                $"from Teacher as tea  " +
                $"left join Department as dep on dep.id= tea.Department_ID " +
                $"left join Faculty as fac on dep.Faculty_ID = fac.Id";
            List<Teacher> result = new List<Teacher>();
            SqlConnection sCon = new SqlConnection(_config.GetConnectionString("cs"));
            using (var scmd = new SqlCommand(query, sCon))
            {
                sCon.Open();

                using var reader = scmd.ExecuteReader();

                while (reader.Read())
                {
                    result.Add(new Teacher()
                    {
                        Faculty = (string)reader[0],
                        Department_Title = (string)reader[1],
                        Name = (string)reader[2],
                    });
                }
            }
            return result;
        }
        [HttpGet("{Faculty_ID}")]
        public IEnumerable<Teacher> Get(int Faculty_ID)
        {
            string query = $"select fac.Title, dep.Title, tea.Name " +
                $"from Teacher as tea  " +
                $"left join Department as dep on dep.id= tea.Department_ID " +
                $"left join Faculty as fac on dep.Faculty_ID = fac.Id " +
                $"where fac.ID = {Faculty_ID}";
            List<Teacher> result = new List<Teacher>();
            SqlConnection sCon = new SqlConnection(_config.GetConnectionString("cs"));
            using (var scmd = new SqlCommand(query, sCon))
            {
                sCon.Open();

                using var reader = scmd.ExecuteReader();

                while (reader.Read())
                {
                    result.Add(new Teacher()
                    {
                        Faculty = (string)reader[0],
                        Department_Title = (string)reader[1],
                        Name = (string)reader[2],
                    });
                }
            }
            return result;
        }


    }
}
