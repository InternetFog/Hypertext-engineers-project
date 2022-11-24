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
    public class GetGroupController : ControllerBase
    {
        private readonly IConfiguration _config;
        public GetGroupController(IConfiguration configuration)
        {
            _config = configuration;
        }
        [HttpGet("{Cource} {TimeTable_ID}")]
        public IEnumerable<Group> Get(int Cource, int TimeTable_ID)
        {
            string query = $"select * from \"Group\" where cource = {Cource} and TimeTable_ID = {TimeTable_ID}";
            List<Group> result = new List<Group>();
            SqlConnection sCon = new SqlConnection(_config.GetConnectionString("cs"));
            using (var scmd = new SqlCommand(query, sCon))
            {
                sCon.Open();

                using var reader = scmd.ExecuteReader();

                while (reader.Read())
                {
                    result.Add(new Group()
                    {
                        Title = (string)reader[1],
                        Cource = (byte)reader[2]
                    });
                }
            }
            return result;
        }
    }
}
