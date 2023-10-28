package main

import (
	"fmt"
	"net/http"
)

func main() {
	http.HandleFunc("/", welcomeHandler)
	http.ListenAndServe(":8000", nil)
}

func welcomeHandler(w http.ResponseWriter, req *http.Request) {
	fmt.Fprintf(w, "hello, world\n")
}
