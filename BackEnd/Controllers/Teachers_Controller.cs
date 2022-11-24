using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Data;
using System.Diagnostics;
using Timetable_Backend.Models;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Timetable_Backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class Teachers_Controller : ControllerBase
    {
        private IConfiguration _config;

        public Teachers_Controller(IConfiguration config)
        {
            _config = config;
        }

        [HttpGet]
        public IEnumerable<Teacher> Get()
        {
            List<Teacher> result = new List<Teacher>();
            string query = "select * from teacher";
            using (var connection = new SqlConnection(_config.GetConnectionString("cs")))
            using (var command = new SqlCommand(query, connection))
            {
                connection.Open();
                using var reader = command.ExecuteReader();
                while (reader.Read())
                {
                    result.Add(new Teacher()
                    {
                        ID = (int)reader[0],
                        Department_ID = (int)reader[1],
                        Name = (string)reader[2]
                    });
                }
            }
            return result;
        }

        // GET api/<Teachers_Controller>/5
        [HttpGet("{id}")]
        public Teacher Get(int id)
        {
            string query = $"select * from teacher where id = {id}";
            using (var connection = new SqlConnection(_config.GetConnectionString("cs")))
            using (var command = new SqlCommand(query, connection))
            {
                connection.Open();
                using var reader = command.ExecuteReader();
                reader.Read();
                return new Teacher()
                {
                    ID = (int)reader[0],
                    Department_ID = (int)reader[1],
                    Name = (string)reader[2]
                };
            }
        }

        // POST api/<Teachers_Controller>
        [HttpPost]
        public int Post([FromBody] Teacher value)
        {
            string query = $"insert into teacher (id, department_id, name) " +
                $"values ({value.ID}, {value.Department_ID}, '{value.Name}')";
            using (var connection = new SqlConnection(_config.GetConnectionString("cs")))
            using (var command = new SqlCommand(query, connection))
            {
                connection.Open();
                return command.ExecuteNonQuery();
            }
        }

        // PUT api/<Teachers_Controller>/5
        [HttpPut("{id}")]
        public int Put(int id, [FromBody] Teacher value)
        {
            string query = $"update teacher " +
                $"set department_id = {value.Department_ID}, name = '{value.Name}'" +
                $"where id = {value.ID}";
            using (var connection = new SqlConnection(_config.GetConnectionString("cs")))
            using (var command = new SqlCommand(query, connection))
            {
                connection.Open();
                return command.ExecuteNonQuery();
            }
        }

        // DELETE api/<Teachers_Controller>/5
        [HttpDelete("{id}")]
        public int Delete(int id)
        {
            string query = $"delete from teacher where id = {id}";
            using (var connection = new SqlConnection(_config.GetConnectionString("cs")))
            using (var command = new SqlCommand(query, connection))
            {
                connection.Open();
                return command.ExecuteNonQuery();
            }
        }
    }
}
