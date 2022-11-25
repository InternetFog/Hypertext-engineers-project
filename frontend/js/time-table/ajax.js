class Group {
    Title
    Cource
}

class GetLeson {
    ID
    GroupTitle
    Day
    Week
    Time_Title
    TimeStart
    TimeEnd
    Type
    Title
    Teacher
    Department
    Audience
}

class Teacher {
    ID
    Faculty
    Department_Title
    Name
}

class TeacherLeson {
    ID
    GroupTitle
    Day
    Week
    Time_Title
    TimeStart
    TimeEnd
    Type
    Title
    Teacher
    Department
    Audience
}

addr = "https://localhost:7088/api"

/** Запрос даты последнего обновления */
function UpdateDate() {
    let xhttp = new XMLHttpRequest()

    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            return JSON.parse(xhttp.responseText);
        } else {
            console.log("ERR: ReadyState - " + this.readyState + " Status - " + this.status)
        }
    }

    xhttp.open("GET", addr + "/Info", true)
    xhttp.send()
}

/**
 * @description Запрос списка групп по курсу и типу
 * @param course Тип-Integer
 * <p>1-6-Курс
 * @param type Тип - Integer
 * <p>0 - Магистратура
 * <p>1 - Бакалавриат
 * <p>2 - Заочное 1
 * <p>3 - Заочное 2
 * @return При успешном запросе возвращает массив групп
 */
 function GetGroups(course, type) {
	if (course === "" || course === undefined) throw "Пустой параметр"
	if (type === "" || type === undefined) throw "Пустой параметр"
	let xhttp = new XMLHttpRequest()

	xhttp.open("GET", addr + "/GetGroups/" + type + "%" + course, true)
	xhttp.send()

	xhttp.onreadystatechange = function () {
		 if (this.readyState === 4 && this.status === 200) {
			  let json = JSON.parse(xhttp.responseText);
			  let str = "<ul>"
			  for(let i = 0; i < json.length; i++)
					str += <li>json[i].title</li>
			  return (str + "</ul>")
		 } else {
			  console.log("ERR: ReadyState - " + this.readyState + " Status - " + this.status)
		 }
	}
}

/**
 * @description Запрос списка преподавателей по ID факультета
 * @param faculty_ID Тип - Integer
 *<p>0 - Военная кафедра
 *<p>1 - Факультет экологии, сервиса, технологии и дизайна
 *<p>2 - Институт пищевой инженерии и биотехнологии
 *<p>3 - Строительный факультет
 *<p>4 - Машиностроительный факультет
 *<p>5 - Электротехнический факультет
 *<p>6 - Факультет экономики и управления
 *<p>7 - Юридический факультет
 *<p>8 - Факультет компьютерных наук и технологий
 *<p>10 - Технологический колледж
 * @return При успешном запросе возвращает отсортированный по имени массив преподавателей
 */
function GetTeacher(faculty_ID) {
    if (faculty_ID === "" || faculty_ID === undefined) throw "Пустой параметр"

    let xhttp = new XMLHttpRequest()

    xhttp.open("GET", addr + "/Teacher/" + faculty_ID, true)
    xhttp.send()

    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            let arr = []
            arr = xhttp.responseText
            arr = arr["name"].sort()
            return arr;
        } else {
            console.log("ERR: ReadyState - " + this.readyState + " Status - " + this.status)
        }
    }
}

function GetTeacher() {

    let xhttp = new XMLHttpRequest()

    xhttp.open("GET", addr + "/Teacher", true)
    xhttp.send()

    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            let json = JSON.parse(xhttp.responseText);

        } else {
            console.log("ERR: ReadyState - " + this.readyState + " Status - " + this.status)
        }
    }
}

/**
 * @description Запрос списка групп по курсу и типу
 * @param groupTitle Тип-String
 * <p>1-6-Курс
 * @return При успешном запросе возвращает массив групп
 */
function GetGroupLesson(groupTitle) {
    if (groupTitle === "" || groupTitle === undefined) throw "Пустой параметр"
    let xhttp = new XMLHttpRequest()

    xhttp.open("GET", addr + "/Leson/" + groupTitle, true)
    xhttp.send()

    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            return xhttp.responseText;
        } else {
            console.log("ERR: ReadyState - " + this.readyState + " Status - " + this.status)
        }
    }
}

/**
 * @param teacherName Тип-String; Фамилия и инициалы преподавателя
 */
function GetTeachersLesson(teacherName) {
    if (teacherName === "" || teacherName === undefined) throw "Пустой параметр"
    let xhttp = new XMLHttpRequest()

    xhttp.open("GET", addr + "/TeacherLeson/" + teacherName, true)
    xhttp.send()

    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            let arr = []
            arr = xhttp.responseText
            arr = arr["name"].sort()
            return arr;
        } else {
            console.log("ERR: ReadyState - " + this.readyState + " Status - " + this.status)
        }
    }
}
