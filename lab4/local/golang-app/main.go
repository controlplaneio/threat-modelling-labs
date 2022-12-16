package main

import (
	"fmt"
	"log"
	"net/http"
)

func index(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "<h1>Hello World</h1>")
}

func main() {
	http.HandleFunc("/", index)
	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatal(err)
	}
}