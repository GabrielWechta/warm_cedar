package main

import (
	"fmt"
	"math/rand"
	"strconv"
	"sync"
	"time"
)

var random = rand.New(rand.NewSource(time.Now().UnixNano()))
var masterOutputer = make(chan string, 100)

func observerThread(n int, node Node) {
	for {
		select {
		case read := <-node.readFrom:
			var pairs []RoutingInfo
			for j := 0; j <= n-1; j++ {
				if node.routingTable[j].changed == true {
					pairs = append(pairs, RoutingInfo{id: j, cost: node.routingTable[j].cost, fromWho: node.id})
					node.routingTable[j].changed = false
				}
			}
			read.resp <- RoutingPackage{pairs: pairs}

		case write := <-node.writeTo:
			node.routingTable[write.index].cost = write.newcost
			node.routingTable[write.index].nexthop = write.nexthop
			node.routingTable[write.index].changed = true

			write.resp <- true

		case readSec := <-node.readCost:
			readSec.resp <- node.routingTable[readSec.index].cost
		}
	}
}

func senderThread(node Node, graph *Graph) {
	random := rand.New(rand.NewSource(time.Now().UnixNano()))

	for {
		time.Sleep(time.Duration(random.Float64()*float64(time.Second)) * 2)
		// in order to don't block while sending and don't miss any changed true, sender is giving responsibility
		// for checking any changes and building package to observer
		readRequest := readOp{resp: make(chan RoutingPackage)}
		node.readFrom <- readRequest
		pack := <-readRequest.resp
		if len(pack.pairs) == 0 {
			continue
		}
		//masterOutputer <- "node: " + strconv.Itoa(node.innerId) + " is sending package: " + pack.toString() + "\n"

		for _, neighbour := range node.neighbours {
			graph.nodes[neighbour].routingChannel <- pack
		}
	}
}

func receiverThread(node Node) {
	for {
		pack := <-node.routingChannel
		//masterOutputer <- "node: " + strconv.Itoa(node.innerId) + " received package: " + pack.toString() + "\n"

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

func forwarderReceiverThread(node Node) {
	for {
		standardPackage := <-node.standardChannel
		standardPackage.visited = append(standardPackage.visited, node.id)
		node.standardQueue <- standardPackage
	}
}

func forwarderSenderThread(node Node, graph *Graph) {
	for {
		standardPackage := <-node.standardQueue

		if standardPackage.receiverAddress.nodeId == node.id {
			node.hosts[standardPackage.senderAddress.hostId].deliverChannel <- standardPackage
		} else {
			nextHop := node.routingTable[standardPackage.receiverAddress.nodeId].nexthop
			graph.nodes[nextHop].standardChannel <- standardPackage
		}
	}
}

func initializeStandardPackages(graph *Graph, h int) {
	for i, host := range graph.hostsAddresses {
		randomAddress := random.Int() % h

		for {
			if randomAddress != i {
				break
			}
			randomAddress = random.Int() % h
		}

		targetNodeId := graph.hostsAddresses[randomAddress].nodeId
		targetHostId := graph.hostsAddresses[randomAddress].hostId
		graph.nodes[host.nodeId].hosts[host.hostId].initChannel <- Address{nodeId: targetNodeId, hostId: targetHostId}
	}
}

func hostThread(host Host) {
	for {
		select {
		case initAddress := <-host.initChannel:
			masterOutputer <- "Host: " + strconv.Itoa(host.routerId) + ":" + strconv.Itoa(host.innerId) + " has drawn lots to see " + strconv.Itoa(initAddress.nodeId) + ":" + strconv.Itoa(initAddress.hostId) + "\n"

		}
	}
}

func main() {
	var wg sync.WaitGroup

	//n, _ := int(strconv.ParseInt(os.Args[1], 10, 64))
	//d, _ := int(strconv.ParseInt(os.Args[2], 10, 64))cd 
	//h, _ := int(strconv.ParseInt(os.Args[3], 10, 64))
	n := 5
	d := 2
	h := 7
	graph := buildGraph(n, h)
	graph.addShortcuts(n, d)
	graph.addRoutingTable(n)
	graph.addHosts(n, h)
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
		go observerThread(n, graph.nodes[i])
	}
	for i := 0; i <= int(n)-1; i++ {
		go senderThread(graph.nodes[i], graph)
		go receiverThread(graph.nodes[i])
	}

	for i := 0; i <= int(n)-1; i++ {
		for _, host := range graph.nodes[i].hosts {
			go hostThread(host)

		}
	}

	go initializeStandardPackages(graph, h)

	wg.Wait()
	println("\nGraph at the end:")
	graph.printGraph()
}
