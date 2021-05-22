package main

import (
	"fmt"
	"math/rand"
	"os"
	"strconv"
	"sync"
	"time"
)

var random = rand.New(rand.NewSource(time.Now().UnixNano()))
var masterOutputer = make(chan string, 100)

type Node struct {
	id           int
	neighbours   []int
	routingTable []Routing
	standard     chan Package
	readFrom     chan readOp
	readCost     chan readCostOp
	writeTo      chan writeOp
}

type Graph struct {
	nodes []Node
}

type Routing struct {
	nexthop int
	cost    int
	changed bool
}

func mod(a, b int) int {
	return (a%b + b) % b
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func buildGraph(n int) *Graph {
	graph := Graph{nodes: make([]Node, n)}

	for i := 0; i <= n-1; i++ {
		firstEdge := []int{mod(i-1, n), (i + 1) % n}

		graph.nodes[i] = Node{
			id:         i,
			neighbours: firstEdge,
			standard:   make(chan Package),
			readFrom:   make(chan readOp),
			readCost:   make(chan readCostOp),
			writeTo:    make(chan writeOp),
		}
	}
	return &graph
}

func (graph *Graph) addRoutingTable(n int) {
	for i := 0; i <= n-1; i++ {
		freshRT := make([]Routing, n)
		for j := 0; j <= n-1; j++ {
			if i == j {
				freshRT[j].cost = -1
				freshRT[j].nexthop = -1
				continue
			}

			if intInSlice(j, graph.nodes[i].neighbours) {
				freshRT[j].cost = 1
				freshRT[j].nexthop = j
			} else {
				freshRT[j].cost = abs(i - j)
				if i < j {
					freshRT[j].nexthop = i + 1
				}
				if j < i {
					freshRT[j].nexthop = i - 1
				}
			}
			freshRT[j].changed = true
		}
		graph.nodes[i].routingTable = freshRT
	}
}

func (graph *Graph) addShortcuts(n int, d int) {
	goodShortcuts := 0
	for goodShortcuts < d {
		start := random.Int() % n
		end := random.Int() % n

		if end == start || intInSlice(end, graph.nodes[start].neighbours) || intInSlice(start, graph.nodes[end].neighbours) {
			continue
		} else {
			goodShortcuts++
			graph.nodes[start].neighbours = append(graph.nodes[start].neighbours, end)
			graph.nodes[end].neighbours = append(graph.nodes[end].neighbours, start)
		}
	}
}

func intInSlice(x int, array []int) bool {
	for _, a := range array {
		if x == a {
			return true
		}
	}
	return false
}


func (graph *Graph) printGraph() {
	for i, node := range graph.nodes {
		fmt.Print(strconv.Itoa(i) + "->")
		fmt.Print(node.neighbours)
		fmt.Print(": ")
		fmt.Print(node.routingTable)
		fmt.Print("\n")
	}
	fmt.Print("\n")
}

type Pair struct {
	id      int
	cost    int
	fromWho int
}

type Package struct {
	pairs []Pair
}

type readOp struct {
	resp chan Package
}

func (pack *Package) toString() string {
	output := ""
	for _, pair := range pack.pairs {
		output += "(" + strconv.Itoa(pair.id) + ", " + strconv.Itoa(pair.cost) + ") "
	}

	return output
}

func observerThread(n int, node Node) {
	for {
		select {
		case read := <-node.readFrom:
			var pairs []Pair
			for j := 0; j <= n-1; j++ {
				if node.routingTable[j].changed == true {
					pairs = append(pairs, Pair{id: j, cost: node.routingTable[j].cost, fromWho: node.id})
					node.routingTable[j].changed = false
				}
			}
			read.resp <- Package{pairs: pairs}

		case write := <-node.writeTo:
			node.routingTable[write.index].cost = write.newcost
			node.routingTable[write.index].nexthop = write.nexthop
			node.routingTable[write.index].changed = true

			write.resp <- true

		case readSec := <-node.readCost:
			//masterOutputer <- "starting reading"
			readSec.resp <- node.routingTable[readSec.index].cost
		}
	}
}

func senderThread(node Node, graph *Graph) {
	random := rand.New(rand.NewSource(time.Now().UnixNano()))

	for {
		time.Sleep(time.Duration(random.Float64()*float64(time.Second)) * 2)
		// in order to don't block while sending and don't miss any changed true, sender is giving responsibility
		//for checking any changes and building package to observer
		readRequest := readOp{resp: make(chan Package)}
		node.readFrom <- readRequest
		pack := <-readRequest.resp
		if len(pack.pairs) == 0 {
			continue
		}
		masterOutputer <- "node: " + strconv.Itoa(node.id) + " is sending package: " + pack.toString() + "\n"

		for _, neighbour := range node.neighbours {
			graph.nodes[neighbour].standard <- pack
		}
	}
}

func receiverThread(node Node) {
	for {
		pack := <-node.standard
		masterOutputer <- "node: " + strconv.Itoa(node.id) + " received package: " + pack.toString() + "\n"

		for _, pair := range pack.pairs {
			readCostRequest := readCostOp{index: pair.id, resp: make(chan int)}
			node.readCost <- readCostRequest
			oldCost := <-readCostRequest.resp
			newCost := pair.cost + 1
			if newCost < oldCost {
				masterOutputer <- "node: " + strconv.Itoa(node.id) + " changes: " + strconv.Itoa(pair.id) + "'s cost from " + strconv.Itoa(oldCost) + " to " + strconv.Itoa(newCost) + "\n"
				writeRequest := writeOp{index: pair.id, newcost: newCost, nexthop: pair.fromWho, resp: make(chan bool)}
				node.writeTo <- writeRequest
				<-writeRequest.resp
			}
		}
	}
}

type writeOp struct {
	index   int
	newcost int
	nexthop int
	resp    chan bool
}

type readCostOp struct {
	index int
	resp  chan int
}


func main() {
	var wg sync.WaitGroup

	n, _ := strconv.ParseInt(os.Args[1], 10, 64)
	d, _ := strconv.ParseInt(os.Args[2], 10, 64)
	// n = 10
	// d = 5
	graph := buildGraph(int(n))
	graph.addShortcuts(int(n), int(d))
	graph.addRoutingTable(int(n))
	println("Graph at the beginning:")
	graph.printGraph()

	/* this is goroutine for output */
	wg.Add(1)

	go func() {
		for {
			select {
			case output := <-masterOutputer:
				fmt.Print(output)
			case <-time.After(time.Second * 3): //finishes after 3 seconds of no input
				wg.Done()
			}
		}
	}()

	for i := 0; i <= int(n)-1; i++ {
		go observerThread(int(n), graph.nodes[i])
	}
	for i := 0; i <= int(n)-1; i++ {
		go senderThread(graph.nodes[i], graph)
		go receiverThread(graph.nodes[i])
	}

	wg.Wait()
	println("\nGraph at the end:")
	graph.printGraph()
}
