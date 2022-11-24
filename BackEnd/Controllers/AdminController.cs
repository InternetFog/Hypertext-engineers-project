using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using System.Xml;
using System.Xml.Linq;
using Timetable_Backend.Models;

namespace Timetable_Backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AdminController : ControllerBase
    {
        public struct Admin
        {
            public string Login { get; set; }
            public string Password { get; set; }

            public override bool Equals(object? obj)
            {
                return obj is Admin admin &&
                       Login == admin.Login &&
                       Password == admin.Password;
            }

            public override int GetHashCode()
            {
                return HashCode.Combine(Login, Password);
            }

            public static bool operator ==(Admin left, Admin right)
            {
                return left.Equals(right);
            }

            public static bool operator !=(Admin left, Admin right)
            {
                return !(left == right);
            }
        }

        private struct Parse_Data 
        {
            public string URI;
            public int Timetable;
        }

        private struct Teacher_Data
        {
            private static int ID = 0;
            public string Name;
            public int Kaf_Num;
            public int Teacher_ID;

            public Teacher_Data(string name, int kaf)
            {
                Teacher_ID = ID++;
                Name = name;
                Kaf_Num = kaf;
            }
        }

        private struct Leson_Data
        {
            public static int Next_ID = 0;
            public int ID;
            public string Teacher;
            public string Type;
            public string Audience;
            public int Day;
            public int Time;
            public string Title;

            public Leson_Data(string type, int day, int time, string title, string teacher = "", string audience = "")
            {
                ID = Next_ID++;
                Teacher = teacher;
                Type = type;
                Audience = audience;
                Day = day;
                Time = time;
                Title = title;
            }
        }
        private struct Group_Data
        {
            public int ID;
            public int Course;
            public string Title;

            public Group_Data(int id, int course, string title)
            {
                ID = id;
                Course = course;
                Title = title;
            }
        }

        private const string Menu_URI = "https://portal.esstu.ru/menu.htm";

        private static readonly string[] TimeTables = new string[]
        {
            "https://portal.esstu.ru/spezialitet/",
            "https://portal.esstu.ru/bakalavriat/",
            "https://portal.esstu.ru/zo1/",
            "https://portal.esstu.ru/zo2/"
        };
        private const string MKD_URI = "https://portal.esstu.ru/spezialitet/raspisan.htm";
        private const string BS_URI = "https://portal.esstu.ru/bakalavriat/raspisan.htm";
        private const string ZO1_URI = "https://portal.esstu.ru/zo1/raspisan.htm";
        private const string ZO2_URI = "https://portal.esstu.ru/zo2/raspisan.htm";

        private const string T_MKD_URI = "https://portal.esstu.ru/spezialitet/craspisanEdt.htm";
        private const string T_BS = "https://portal.esstu.ru/spezialitet/craspisanEdt.htm";

        private string Kaf_URI(int kaf_num) => $"https://portal.esstu.ru/spezialitet/Caf{kaf_num}.htm";
        private string Timetable_URI(int group, int timetable) => $"{TimeTables[timetable]}{group}.htm";


        private IConfiguration _config;

        public AdminController(IConfiguration config)
        {
            _config = config;
        }

        [HttpGet("Date")]
        public string Get_Update_Date()
        {
            string query = "select update_date from info";
            using (var connection = new SqlConnection(_config.GetConnectionString("cs")))
            {
                connection.Open();
                using (var command = new SqlCommand(query, connection))
                    return ((DateTime)command.ExecuteScalar()).ToString("d");
            }
        }

        private static async Task<string> CallUrl(string fullUrl)
        {
            HttpClient client = new HttpClient();
            var response = await client.SendAsync(new (HttpMethod.Get, fullUrl));
            var byteArray = await response.Content.ReadAsByteArrayAsync();
            var responseString = Encoding.GetEncoding(0).GetString(byteArray, 0, byteArray.Length);
            return responseString.Replace("\r", "").Replace("\t", "");
        }

        [HttpPut("Parce/Teachers")]
        public string ParceTeachers([FromBody] Admin admin)
        {
            string query = $"select admin_login, admin_password, parsing_now from info";
            using (var connection = new SqlConnection(_config.GetConnectionString("cs")))
            using (var command = new SqlCommand(query, connection))
            {
                connection.Open();
                using var reader = command.ExecuteReader();
                reader.Read();
                Admin sender = new()
                {
                    Login = (string)reader[0],
                    Password = (string)reader[1]
                };
                if (sender != admin)
                    return "Wrong login or password!";
                if ((bool)reader[2])
                {
                    return "Just parsing now!";
                }
            }

            Clear_Table("Official_Leson");


            Clear_Table("\"Group\"");
            Clear_Table("Audience");
            Clear_Table("Building");


            Clear_Table("teacher");
            Clear_Table("department");
            Clear_Table("faculty");

            new Thread(Teacher_Parsing_Process).Start(T_MKD_URI);
            //new Thread(Teacher_Parsing_Process).Start(BS_URI);

            return "Parsing...";
        }

        [HttpPut("Parce/Students")]
        public string ParceStudents([FromBody] Admin admin)
        {
            string query = $"select admin_login, admin_password, parsing_now from info";
            using (var connection = new SqlConnection(_config.GetConnectionString("cs")))
            using (var command = new SqlCommand(query, connection))
            {
                connection.Open();
                using var reader = command.ExecuteReader();
                reader.Read();
                Admin sender = new()
                {
                    Login = (string)reader[0],
                    Password = (string)reader[1]
                };
                if (sender != admin)
                    return "Wrong login or password!";
                if ((bool)reader[2])
                {
                    return "Just parsing now!";
                }
            }

            Clear_Table("Official_Leson");


            Clear_Table("\"Group\"");
            Clear_Table("Audience");
            Clear_Table("Building");


            new Thread(Student_Parsing_Process).Start(new Parse_Data
            {
                URI = MKD_URI,
                Timetable = 0
            });

            /*

            new Thread(Parsing_Process).Start(new Parse_Data
            {
                URI = T_BS,
                Is_Students = false,
                Timetable_Title = "Бакалавриат, специалитет"
            });


            new Thread(Parsing_Process).Start(new Parse_Data
            {
                URI = BS_URI,
                Is_Students = true,
                Timetable_Title = "Бакалавриат, специалитет"
            });


            // Не лезь, оно тебя сожрёт!
            new Thread(Parsing_Process).Start(new Parse_Data
            {
                URI = ZO1_URI,
                Is_Students = true,
                Timetable_Title = "Заочное 1"
            });

            new Thread(Parsing_Process).Start(new Parse_Data
            {
                URI = ZO2_URI,
                Is_Students = true,
                Timetable_Title = "Заочное 2"
            });

            */

            return "Parsing...";
        }

        private void Start_Parsing()
        {
            /*
            string query = $"update info set parsing_now = 'True'";
            using (var connection = new SqlConnection(_config.GetConnectionString("cs")))
            using (var command = new SqlCommand(query, connection))
            {
                connection.Open();
                command.ExecuteNonQuery();

            }
            */


        }

        private void Clear_Table(string table_name)
        {
            string query = $"delete from {table_name} where 0 = 0";
            using (var connection = new SqlConnection(_config.GetConnectionString("cs")))
            using (var command = new SqlCommand(query, connection))
            {
                connection.Open();
                command.ExecuteNonQuery();
            }
        }

        private void Teacher_Parsing_Process(object? value)
        {
            if (value is string URI)
            {
                Parse_Teachers(URI);
            }
        }
        private void Student_Parsing_Process(object? value)
        {
            if (value is Parse_Data data)
            {
                Parse_Students(data.URI, data.Timetable);
            }
        }

        private (string[]? row, string[] data) Get_Row(string[] data)
        {
            var row = data
                .TakeWhile(l => l.ToLower().StartsWith("</tr") == false)
                .ToArray();
            data = data.Skip(row.Length+1).ToArray();
            row = row.Where(r => r.ToLower().StartsWith("<p"))
                .Select(r => 
                    r.Substring(27)
                    .Replace(".htm\"><FONT FACE=\"Times New Roman\">", "|")
                    .Replace("</FONT></A></TD>", ""))
                .Select(r => r == "1|" ? "" : r)
                .ToArray();
            if (row.All(r => r == ""))
                row = null;
            return (row, data);
        }

        private string[][] Get_Table(string data)
        {
            var lines = 
                data
                .Split('\n')
                .SkipWhile(l => l.ToLower().StartsWith("<tr") == false)
                .Skip(13)
                .TakeWhile(l => l.ToLower().StartsWith("</table") == false)
                .ToArray();
            List<string[]> rows = new List<string[]>();
            while (lines.Length > 0)
            {
                (string[]? row, string[] data) result = Get_Row(lines);
                lines = result.data;
                if (result.row is null)
                    break;
                rows.Add(result.row);
            }
            return rows.ToArray();
        }

        private int[] Add_Groups(string uri, int timetable)
        {
            var table = Get_Table(CallUrl(uri).Result);
            List<Group_Data> groups = new List<Group_Data>();
            foreach (var row in table)
            {
                for (int course = 0; course < row.Length; course++)
                {
                    if (row[course] == "")
                        continue;
                    groups.Add(new(int.Parse(row[course].Split("|")[0]), course+1, row[course].Split("|")[1]));
                }
            }

            string query = $"insert into \"Group\" values " +
                String.Join(", ", groups.Select(g => $"({g.ID}, '{g.Title}', {g.Course}, {timetable})"));
            using (var connection = new SqlConnection(_config.GetConnectionString("cs")))
            using (var command = new SqlCommand(query, connection))
            {
                connection.Open();
                command.ExecuteNonQuery();

            }
            return groups.Select(g => g.ID).ToArray();
        }

        private Leson_Data Parse_Leson(string data, int day, int time, int week)
        {
            string leson = data.ToString();
            string[] lesons = leson.Split(" а.");

            string first_c = leson.Substring(0, 1);
            string type = "пр";
            if (first_c != first_c.ToUpper())
            {
                type = leson.Split('.')[0];
                leson = leson.Substring(type.Length + 1);
            }
            if (lesons.Length == 2)
            {
                string audience = "а." + lesons[1];
                leson = leson.Replace(audience, "").Trim();

                string teacher;
                if (leson.Last() == '.')
                    teacher = string.Join(" ", leson.Split(" ").TakeLast(2));
                else
                    teacher = leson.Split(" ").Last();
                leson = leson.Replace(teacher, "").Trim();
                
                if (leson.Split(" ").Last() == "ФКС")
                {
                    teacher = "ФКС " + teacher;
                    leson = leson.Replace("ФКС", "");
                }


                return new Leson_Data(type, day + 6 * week, time, leson, teacher, audience);
            }
            return new Leson_Data(type, day + 6 * week, time, leson);
        }

        private Leson_Data[] Parse_Lesons(string[] data, int week)
        {
            List<Leson_Data> lesons = new List<Leson_Data>();
            for (int day = 0; day < 6; day++)
                for (int time = 0; time < 6; time++)
                {
                    string leson = data[time + 6 * day].Trim();
                    if (leson != "")
                    {
                        Leson_Data parsed_leson = Parse_Leson(leson, day, time, week);
                        lesons.Add(parsed_leson);
                    }
                }

            return lesons.ToArray();
        }

        private void Add_Unparsed_Lesons(Leson_Data[] data)
        {

        }

        private int Get_Teacher_ID(string name)
        {
            string query = $"select id from teacher where name = '{name}'";
            using (var connection = new SqlConnection(_config.GetConnectionString("cs")))
            using (var command = new SqlCommand(query, connection))
            {
                connection.Open();
                var value = command.ExecuteScalar();
                if (value is DBNull || value is null)
                    return -1;
                return (int)value;
            }
        }

        private int Get_Last_ID(string table)
        {
            string query = $"select max(id) from {table}";
            using (var connection = new SqlConnection(_config.GetConnectionString("cs")))
            using (var command = new SqlCommand(query, connection))
            {
                connection.Open();
                var result = command.ExecuteScalar();
                if (result is DBNull)
                    return 0;
                return (int)result + 1;
            }
        }

        private int Add_Type(string name)
        {
            int max_id = Get_Last_ID("Leson_Type");
            string query = $"insert into Leson_Type values ({max_id}, '{name}', 0)";
            using (var connection = new SqlConnection(_config.GetConnectionString("cs")))
            using (var command = new SqlCommand(query, connection))
            {
                connection.Open();
                command.ExecuteNonQuery();
                return max_id;
            }
        }

        private int Get_Type_ID(string type)
        {
            string query = $"select id from Leson_Type where title = '{type}'";
            using (var connection = new SqlConnection(_config.GetConnectionString("cs")))
            using (var command = new SqlCommand(query, connection))
            {
                connection.Open();
                var result = command.ExecuteScalar();
                if (result is DBNull || result is null)
                    return Add_Type(type);
                return (int)result;
            }
        }

        private int Add_Audience(string audience)
        {
            int max_id = Get_Last_ID("Audience");
            string query = $"insert into Audience (ID, Title) values ({max_id}, '{audience}')";
            using (var connection = new SqlConnection(_config.GetConnectionString("cs")))
            using (var command = new SqlCommand(query, connection))
            {
                connection.Open();
                command.ExecuteNonQuery();
                return max_id;
            }
        }

        private int Get_Audience_ID(string audience)
        {
            string query = $"select id from Audience where title = '{audience}'";
            using (var connection = new SqlConnection(_config.GetConnectionString("cs")))
            using (var command = new SqlCommand(query, connection))
            {
                connection.Open();
                var result = command.ExecuteScalar();
                if (result is DBNull || result is null)
                    return Add_Audience(audience);
                return (int)result;
            }
        }

        private void Add_Lesons(string data, int group)
        {
            var first_rows = data.Split("\n")
                .Where(r => r.StartsWith("<FONT FACE=\"Arial\" SIZE=1><P ALIGN=\"CENTER\">"))
                .Select(r => r
                    .Replace("<FONT FACE=\"Arial\" SIZE=1><P ALIGN=\"CENTER\">", "")
                    .Replace("</FONT></TD>", "")
                )
                .Where(r => r != "     ")
                .Select(r => r.Contains('_') ? "" : r)
                .ToArray();

            var second_rows = data.Split("\n")
                .Where(r => r.StartsWith("<FONT FACE=\"Arial\" SIZE=1 COLOR=\"#0000ff\"><P ALIGN=\"CENTER\">"))
                .Select(r => r
                    .Replace("<FONT FACE=\"Arial\" SIZE=1 COLOR=\"#0000ff\"><P ALIGN=\"CENTER\">", "")
                    .Replace("</FONT></TD>", "")
                )
                .Where(r => r != "     ")
                .Select(r => r.Contains('_') ? "" : r)
                .ToArray();


            List<Leson_Data> lesons = Parse_Lesons(first_rows, 0).Concat(Parse_Lesons(second_rows, 1)).ToList();
            var unparsed_lesons = lesons.Where(l => Get_Teacher_ID(l.Teacher) == -1).ToArray();

            if (unparsed_lesons.Length > 0)
            {
                Add_Unparsed_Lesons(unparsed_lesons);
                lesons = lesons.Where(l => unparsed_lesons.Any(ul => ul.ID == l.ID) == false).ToList();
            }

            string query = $"insert into Official_Leson values " +
                string.Join(",\n", lesons.Select(l => $"(" +
                $"{l.ID}, {Get_Teacher_ID(l.Teacher)}, {Get_Type_ID(l.Type)}, " +
                $"{Get_Audience_ID(l.Audience)}, {l.Day}, {l.Time}, {group}, '{l.Title}')"));
            Debug.WriteLine(query);
            using (var connection = new SqlConnection(_config.GetConnectionString("cs")))
            using (var command = new SqlCommand(query, connection))
            {
                connection.Open();
                command.ExecuteNonQuery();
            }
        }

        private void Parse_Students(string uri, int timetable)
        {
            var groups = Add_Groups(uri, timetable);
            foreach (var group in groups)
            {
                Add_Lesons(CallUrl(Timetable_URI(group, timetable)).Result, group);
            }
        }

        private (string[] data, string[] departments) Get_Departments(string[] data)
        {
            var departments = data
                .TakeWhile(r => r.StartsWith("<h2") == false)
                .Select(r => r
                    .Replace("<p><a href=\"Caf", "")
                    .Replace(".htm\">", "|")
                    .Replace("</a></p>", ""))
                .ToArray();
            return (data.Skip(departments.Length).ToArray(), departments);
        }

        private string[] Get_Facultys(string data)
        {
            List<string> departments = new List<string>();
            string faculty = "0|Военная кафедра";
            var rows =
                data.Split("\n")
                .SkipWhile(r => r.ToLower().StartsWith("<div class=\"frame\"") == false)
                .TakeWhile(r => r.ToLower().StartsWith("</body") == false)
                .Where(r => r.ToLower().StartsWith("<p><a") || r.ToLower().StartsWith("<h2"))
                .ToArray();
            while (rows.Length > 0)
            {
                (string[] data, string[] departments) result = Get_Departments(rows);
                rows = result.data;
                departments.Add($"{faculty}={string.Join("+", result.departments)}");
                if (result.data.Length == 0)
                    break;
                faculty = rows[0].Replace("<h2 id=\"", "").Replace("\">", "|").Replace("</h2>", "");
                rows = rows.Skip(1).ToArray();
            }
            return departments.ToArray();
        }

        private void Add_Facultys(string[] facultys)
        {
            string query = $"insert into faculty values " +
                string.Join(",\n", facultys.Select(f => "('" +
                string.Join("', '", f.Split("=")[0].Split("|")) + "')"));
            using (var connection = new SqlConnection(_config.GetConnectionString("cs")))
            using (var command = new SqlCommand(query, connection))
            {
                connection.Open();
                command.ExecuteNonQuery();
            }
        }

        private int[] Add_Departments(string[] facultys)
        {
            List<int> kafs_nums = new List<int>();
            string query = $"insert into department (faculty_id, id, title) values ";
            foreach (var faculty in facultys)
            {
                string fac_id = faculty.Split("=")[0].Split("|")[0];
                query += "\n";
                foreach (var department in faculty.Split("=")[1].Split("+"))
                {
                    int kaf_num = int.Parse(department.Split("|")[0]);
                    kafs_nums.Add(kaf_num);
                    query += $"({fac_id}, {kaf_num}, '{department.Split("|")[1]}'),\n";
                }
            }
            query = query.Substring(0, query.Length - 2);
            using (var connection = new SqlConnection(_config.GetConnectionString("cs")))
            using (var command = new SqlCommand(query, connection))
            {
                connection.Open();
                command.ExecuteNonQuery();
            }
            return kafs_nums.ToArray();
        }

        private string[] Get_Teachers(string data)
        {
            var headers = data.Split("\n")
                .Where(h => h.Contains("Расписание занятий преподавателя:"))
                .Select(h => h
                    .Replace("<FONT FACE=\"Times New Roman\" SIZE=5 COLOR=\"#0000ff\"><P>Расписание занятий преподавателя:</FONT><FONT FACE=\"Times New Roman\" SIZE=6 COLOR=\"#ff00ff\"> ", "")
                    .Replace("</P></FONT>", "")
                )
                .ToArray();
            return headers;
        }

        private void Parse_Teachers(string uri)
        {
            var facultys = Get_Facultys(CallUrl(uri).Result);
            Add_Facultys(facultys);
            int[] kaf_nums = Add_Departments(facultys);
            List<Teacher_Data> teachers = new List<Teacher_Data>();
            foreach (int kaf_num in kaf_nums)
            {
                string[] result = Get_Teachers(CallUrl(Kaf_URI(kaf_num)).Result);
                teachers.AddRange(result.Select(t => new Teacher_Data(t, kaf_num)));
            }

            string query = "insert into teacher values " +
                string.Join(", ", teachers.Select(t => $"({t.Teacher_ID}, {t.Kaf_Num}, '{t.Name}')"));
            using (var connection = new SqlConnection(_config.GetConnectionString("cs")))
            using (var command = new SqlCommand(query, connection))
            {
                connection.Open();
                command.ExecuteNonQuery();
            }
        }
    }
}
