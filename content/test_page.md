+++
title = "Test page for styling"
description = ""
draft = true
+++

# Title of the Article

Voluptas eveniet eius quam ex. Rerum assumenda vero in. Molestiae totam eos exercitationem asperiores ut.

Qui sunt itaque placeat nulla. [Explicabo sunt accusamus quos.](#) Voluptates corporis autem itaque.
Quae vitae
accusamus qui aut esse eveniet non. Et molestiae ratione ut.

## A subtitle

Perferendis voluptates sequi magnam rerum[^footnote]. Saepe sed provident quia velit. Sequi quis eligendi enim earum quia.
Perspiciatis sequi quas aut harum ut. Odio deleniti ipsam qui eligendi dolorem dolor esse porro.

Eos pariatur laborum sed. Nam inventore ut explicabo. Eum voluptas eaque esse id sequi quae. Necessitatibus non
ullam nobis in. Nostrum `earum debitis` non ea nemo doloremque quia. Consectetur doloremque delectus molestiae.

Ut sunt sunt odit beatae ullam laudantium ducimus. Nisi consectetur totam qui. Sit consequatur ipsum recusandae
est sit beatae. Aliquam maxime quod at ipsam sed et quis. Et nesciunt minus nulla.

A code block:
```go
package main

import (
	"flag"
	"fmt"
	"log"
	"net/http"
	"os"
)

var port string
var dir string
var print_version bool

func init() {
	env_port, portSet := os.LookupEnv("GO_SERVER_PORT")
	if !portSet {
		env_port = "3000"
	}

	port_usage := "Set the `port` to serve on"
	flag.StringVar(&port, "port", env_port, port_usage)
	flag.StringVar(&port, "p", env_port, port_usage+" (shorthand)")

	version_usage := "Print the version of go-server"
	flag.BoolVar(&print_version, "version", false, version_usage)
	flag.BoolVar(&print_version, "v", false, version_usage)
	flag.BoolVar(&print_version, "V", false, version_usage)

	dir = os.Getenv("PWD")
}

func main() {
	flag.Parse()

	if print_version {
		fmt.Println("go-server version 0.3.0")
	} else {
		serve()
	}
}

func serve() {
	fs := http.FileServer(http.Dir(dir))
	http.Handle("/", fs)

	fmt.Printf("Serving files at http://localhost:%s ...\n", port)
	err := http.ListenAndServe(fmt.Sprintf(":%s", port), nil)
	if err != nil {
		log.Fatal(err)
	}
}
```

## Another subtitle

Perferendis voluptates sequi magnam rerum. Saepe sed provident quia velit. Sequi quis eligendi enim earum quia.
Perspiciatis sequi quas aut harum ut. Odio deleniti ipsam qui eligendi dolorem dolor esse porro.

### An h3 level title

Eos pariatur laborum sed. Nam inventore ut explicabo. Eum voluptas eaque esse id sequi quae. Necessitatibus
non
ullam nobis in. Nostrum earum debitis non ea nemo doloremque quia. Consectetur doloremque delectus molestiae.

---

Ut sunt sunt odit beatae ullam laudantium ducimus. Nisi consectetur totam qui. Sit consequatur ipsum
recusandae
est sit beatae. Aliquam maxime quod at ipsam sed et quis. Et nesciunt minus nulla.

---

## Footnotes
[^footnote]: Some extra text to reference
