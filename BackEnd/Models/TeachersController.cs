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
    public class TeachersController : ControllerBase
    {
        private IConfiguration _config;

        public TeachersController(IConfiguration config)
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

        // GET api/<TeachersController>/5
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

        // POST api/<TeachersController>
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

        // Update api/<TeachersController>/5
        [HttpPut("{id}")]
        public int Update(int id, [FromBody]object[] value)
        {
            string query = $"update teacher " +
                $"set department_id = {value[0]}, name = '{value[1]}'" +
                $"where id = {id}";
            using (var connection = new SqlConnection(_config.GetConnectionString("cs")))
            using (var command = new SqlCommand(query, connection))
            {
                connection.Open();
                return command.ExecuteNonQuery();
            }
        }

        // DELETE api/<TeachersController>/5
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
