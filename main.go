package main

import (
	"fmt"
	"io"
	"io/ioutil"
	"log"
	"net/http"
	"time"
)

func main() {
	resp, err := http.Get("https://google.com")
	if err != nil {
		log.Fatalf(`http.Get("https://google.com"): %v`, err)
	}
	defer resp.Body.Close()
	io.Copy(ioutil.Discard, resp.Body)
	fmt.Println("ca-certificates ok", resp.StatusCode)

	location, err := time.LoadLocation("America/New_York")
	if err != nil {
		log.Fatalf(`time.LoadLocation("America/New_York"): %v`, err)
	}
	fmt.Println("zoneinfo ok", location.String())

}
