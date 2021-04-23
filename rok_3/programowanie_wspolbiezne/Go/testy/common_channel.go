package main

import (
	"fmt"
	"math/rand"
	"time"
)

func main() {

	messages := make(chan string) // wspólny kanał

	s1 := rand.NewSource(time.Now().UnixNano()) // ziarno generatora liczb pseudolosowych
	r1 := rand.New(s1)                          // generator liczb pseudolosowych

	/* kod wątku nadawcy */
	ping := func(id string) {
		r := rand.New(rand.NewSource(r1.Int63()))
		for {
			time.Sleep(time.Duration(r.Float64() * float64(time.Second)))
			messages <- "ping " + id
		}
	}

	/* uruchomienie dwóch współbieżnych nadawców */
	go ping("1")
	go ping("2")

	/* kod wątku odbiorcy */
	pong := func(id string) {
		r := rand.New(rand.NewSource(r1.Int63()))
		for {
			time.Sleep(time.Duration(r.Float64() * float64(time.Second)))
			msg := <-messages
			fmt.Println("pong " + id + " got: " + msg)
		}
	}

	/* uruchomienie dwóch współbieżnych odbiorców */
	go pong("a")
	go pong("b")

	wait := make(chan byte)
	<-wait

}
