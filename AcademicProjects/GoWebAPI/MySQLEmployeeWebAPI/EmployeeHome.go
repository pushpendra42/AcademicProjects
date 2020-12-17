package main

import (
    "database/sql"
    "fmt"
    _ "github.com/go-sql-driver/mysql"
    "net/http"
    "text/template"
    "time"
)


//var DbNameCreate string ="mydb2"

func main(){
    ConfigureRoute()
}

var tmpl = template.Must(template.ParseGlob("form/*"))

func Edit(w http.ResponseWriter, r *http.Request) {
    db := ConnectDB(w,DbNameCreate)
    emp_id := r.URL.Query().Get("id")
    selDB, err := db.Query("SELECT * FROM employees where emp_no="+emp_id)
    if err != nil {
        panic(err.Error())
    }

    emp := Employee{}
    //res := []Employee{}
    for selDB.Next() {
        var emp_no string
        var birth_date time.Time
        var first_name string
        var last_name string
        var gender string
        var hire_date time.Time
        var isActive bool
        err = selDB.Scan(&emp_no,&birth_date,&first_name,&last_name,&gender,&hire_date,&isActive)
        if err != nil {
            panic(err.Error())
        }

        emp.Emp_no=emp_no
        emp.Birth_date=birth_date.Format("01-02-2006")
        emp.First_name=first_name
        emp.Last_name=last_name
        emp.Gender=gender
        emp.Hire_date=hire_date.Format("01-02-2006")
        emp.IsActive= isActive

        //res = append(res, emp)
    }

    tmpl.ExecuteTemplate(w, "Edit", emp)
    defer db.Close()
}

func Create(w http.ResponseWriter, r *http.Request) {
    tmpl.ExecuteTemplate(w, "Create", nil)
}

func handler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "text/html")
	fmt.Fprintf(w, "<span style='font-size:40px;color:red;font-weigth:bold;'>Hello World!</span>")
}

func ConnectDB(w http.ResponseWriter,dbName string) (mySql *sql.DB){
    dbDriver := "mysql"
    dbUser := "root"
    dbPass := "root"
    db, err := sql.Open(dbDriver, dbUser+":"+dbPass+"@/"+dbName+"?parseTime=true")
    if err != nil {
        fmt.Fprintf(w, "ERROR from DBCreate!")
        panic(err.Error())
    }
    //fmt.Fprintf(w, "Successful from DBCreate!")
    return db
}

func Addemp(w http.ResponseWriter, r *http.Request){
    db := ConnectDB(w,DbNameCreate)
    if r.Method == "POST" {
        bDate := r.FormValue("txt_Birth_date")
        fName := r.FormValue("txt_First_name")
        lName := r.FormValue("txt_Last_name")
        gender := r.FormValue("txt_Gender")
        hDate := r.FormValue("txt_Hire_date")
        isActive := r.FormValue("chk_IsActive")
        dbIsActive:="0"

        if isActive == "on"{
            dbIsActive = "1"
    }

        q:="INSERT INTO employees(`birth_date`,`first_name`,`last_name`,`gender`,`hire_date`,`IsActive`) " +
            "VALUES("+bDate+",'"+fName+"','"+lName+"','"+gender+"',"+hDate+","+dbIsActive +")"

        insForm, err := db.Prepare(q)
        if err != nil {
            panic(err.Error())
        }
        insForm.Exec()
    }
    defer db.Close()
    http.Redirect(w, r, "/", 301)
}




func Index(w http.ResponseWriter, r *http.Request){
    Logger("Testing")
    db := ConnectDB(w,DbNameCreate)
    selDB, err := db.Query("SELECT * FROM employees")
    if err != nil {
        panic(err.Error())
    }

    emp := Employee{}
    res := []Employee{}
    for selDB.Next() {
        var emp_no string
        var birth_date time.Time
        var first_name string
        var last_name string
        var gender string
        var hire_date time.Time
        var isActive bool

        err = selDB.Scan(&emp_no,&birth_date,&first_name,&last_name,&gender,&hire_date,&isActive)
        if err != nil {
            panic(err.Error())
        }

        emp.Emp_no=emp_no
        emp.Birth_date=birth_date.Format("01-02-2006")
        emp.First_name=first_name
        emp.Last_name=last_name
        emp.Gender=gender
        emp.Hire_date=hire_date.Format("01-02-2006")
        emp.IsActive= isActive
        res = append(res, emp)
    }

    tmpl.ExecuteTemplate(w, "Index", res)
	defer db.Close()


}

func Show(w http.ResponseWriter, r *http.Request) {
    db := ConnectDB(w,DbNameCreate)
    emp_id := r.URL.Query().Get("id")
    selDB, err := db.Query("SELECT * FROM employees where emp_no="+emp_id)
    if err != nil {
        panic(err.Error())
    }

    emp := Employee{}

    for selDB.Next() {
        var emp_no string
        var birth_date time.Time
        var first_name string
        var last_name string
        var gender string
        var hire_date time.Time
        var isActive bool
        err = selDB.Scan(&emp_no,&birth_date,&first_name,&last_name,&gender,&hire_date,&isActive)
        if err != nil {
            panic(err.Error())
        }

        emp.Emp_no=emp_no
        emp.Birth_date=birth_date.Format("01-02-2006")
        emp.First_name=first_name
        emp.Last_name=last_name
        emp.Gender=gender
        emp.Hire_date=hire_date.Format("01-02-2006")
        emp.IsActive= isActive
    }

    tmpl.ExecuteTemplate(w, "Show", emp)
    defer db.Close()
}

func Delete(w http.ResponseWriter, r *http.Request) {
    db := ConnectDB(w,DbNameCreate)
    emp := r.URL.Query().Get("id")
    delForm, err := db.Prepare("DELETE FROM employees WHERE emp_no=?")
    if err != nil {
        panic(err.Error())
    }

    delForm.Exec(emp)

    defer db.Close()

    http.Redirect(w, r, "/", 301)
}

func Editemp(w http.ResponseWriter, r *http.Request) {
    db := ConnectDB(w,DbNameCreate)

    layout := "01/02/2006"
    layout1 := "2006-01-02"
    //layout := "2006-01-02T15:04:05.000Z"
    //str := "2014-11-12T11:45:26.371Z"
    if r.Method == "POST" {
        emp_no :=r.FormValue("txt_emp_no")
        //bDate := r.FormValue("txt_Birth_date")
        bDate,_ := time.Parse(layout, r.FormValue("txt_Birth_date"))
        fName := r.FormValue("txt_First_name")
        lName := r.FormValue("txt_Last_name")
        gender := r.FormValue("txt_Gender")
        hDate,_ := time.Parse(layout, r.FormValue("txt_Hire_date"))
        //hDate=hDate_temp.Unix()
        isActive := r.FormValue("chk_IsActive")
        dbIsActive := "0"

        if isActive == "on" {
            dbIsActive = "1"
        }
            q := "update employees set birth_date='"+ bDate.Format(layout1) +"',first_name='"+fName+"',last_name='"+lName+"',gender='"+gender+"',hire_date='"+hDate.Format(layout1)+"',IsActive="+dbIsActive+" where emp_no="+emp_no

            insForm, err := db.Prepare(q)
            if err != nil {
                panic(err.Error())
            }
            insForm.Exec()

    }
        defer db.Close()
        http.Redirect(w, r, "/", 301)
}

/*
type Employee struct {
    Emp_no    string
    Birth_date string
    First_name string
    Last_name string
    Gender string
    Hire_date string
    IsActive bool
}*/