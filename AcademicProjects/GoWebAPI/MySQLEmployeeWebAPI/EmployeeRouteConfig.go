package main

import (
	"github.com/gorilla/mux"
	"log"
	"net/http"
)

func ConfigureRoute(){
	log.Println("Server started on: http://localhost:8080")

	router := mux.NewRouter()
	//http.HandleFunc("/", CreateDB)
	router.HandleFunc("/", Index).Methods("GET")
	router.HandleFunc("/create", Create).Methods("GET")
	router.HandleFunc("/addemp", Addemp).Methods("POST")
	router.HandleFunc("/edit", Edit).Methods("GET")
	router.HandleFunc("/editemp", Editemp).Methods("PUT")
	router.HandleFunc("/show", Show).Methods("GET")
	router.HandleFunc("/delete", Delete).Methods("GET")

	http.ListenAndServe(":8080", router)
}
