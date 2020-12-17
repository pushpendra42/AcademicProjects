package main

import (
	_ "github.com/go-sql-driver/mysql"
	"fmt"
	"net/http"
)

func CreateDB(w http.ResponseWriter, r *http.Request){

	db := ConnectDB(w,"sys")
	_, err := db.Query("CREATE DATABASE "+DbNameCreate)
	db.Close()
	if err != nil {
		fmt.Fprintf(w, "ERROR creating Database!")
		panic(err.Error())
	}    else {
		db := ConnectDB(w,DbNameCreate)
		_, err1 := db.Query("CREATE TABLE employees(emp_no INT NOT NULL AUTO_INCREMENT, PRIMARY KEY(emp_no),birth_date DATE NOT NULL, first_name VARCHAR(14)  NOT NULL, last_name VARCHAR(16) NOT NULL,gender ENUM ('M','F') NOT NULL,hire_date DATE NOT NULL,IsActive bool default false)")

		if err1 != nil {
			fmt.Fprintf(w, "ERROR creating table!")
			panic(err.Error())
		}
		//fmt.Fprintf(w, "Success creating table")
	}
	defer db.Close()
}

func GetAllRows(){

}

func UpdateRow(){

}

func DeleteRow(){

}

func CreateRow(){

}