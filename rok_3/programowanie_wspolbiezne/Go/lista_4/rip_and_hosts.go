package main

import (
	"fmt"
	"math/rand"
	"strconv"
	"sync"
	"time"
	"os"
)

var random = rand.New(rand.NewSource(time.Now().UnixNano()))
var masterOutputer = make(chan string, 100)
var standardOutputer = make(chan string, 100)

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
		time.Sleep(time.Duration(random.Float64()*float64(time.Second)) * 10)
		// in order to don't block while sending and don't miss any changed true, sender is giving responsibility
		// for checking any changes and building package to observer
		readRequest := readOp{resp: make(chan RoutingPackage)}
		node.readFrom <- readRequest
		pack := <-readRequest.resp
		if len(pack.pairs) == 0 {
			continue
		}

		for _, neighbour := range node.neighbours {
			graph.nodes[neighbour].routingChannel <- pack
		}
	}
}

func receiverThread(node Node) {
	for {
		pack := <-node.routingChannel

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
			node.hosts[standardPackage.receiverAddress.hostId].deliverChannel <- standardPackage
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

func hostThread(host Host, node Node) {
	for {
		select {
		case initAddress := <-host.initChannel:
			standardOutputer <- "Host: " + strconv.Itoa(host.routerId) + ":" + strconv.Itoa(host.innerId) + " has drawn lots to see " + strconv.Itoa(initAddress.nodeId) + ":" + strconv.Itoa(initAddress.hostId) + " as his loving receiver\n"
			node.standardChannel <- StandardPackage{
				senderAddress:   Address{nodeId: host.routerId, hostId: host.innerId},
				receiverAddress: initAddress,
			}
		case deliveredPackage := <-host.deliverChannel:
			// received
			standardOutputer <- deliveredPackage.toString()

			//thinking
			time.Sleep(time.Duration(random.Float64() * float64(time.Second)))

			//responding
			node.standardChannel <- StandardPackage{
				senderAddress:   Address{nodeId: host.routerId, hostId: host.innerId},
				receiverAddress: Address{nodeId: deliveredPackage.senderAddress.nodeId, hostId: deliveredPackage.senderAddress.hostId},
			}
		}
	}
}

func main() {
	var wg sync.WaitGroup

	f, _ := strconv.ParseInt(os.Args[1], 10, 64)
	s, _ := strconv.ParseInt(os.Args[2], 10, 64)
	t, _ := strconv.ParseInt(os.Args[3], 10, 64)
	n := int(f)
	d := int(s)
	h := int(t)
	//n := 24
	//d := 10
	//h := 6
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
			case <-time.After(time.Second * 6): //finishes after 3 seconds of no input
				wg.Done()
			}
		}
	}()

	go func() {
		for {
			select {
			case output := <-standardOutputer:
				fmt.Print(output)
			}
		}
	}()

	for i := 0; i <= int(n)-1; i++ {
		go observerThread(n, graph.nodes[i])
	}
	for i := 0; i <= int(n)-1; i++ {
		go senderThread(graph.nodes[i], graph)
		go receiverThread(graph.nodes[i])
		go forwarderReceiverThread(graph.nodes[i])
		go forwarderSenderThread(graph.nodes[i], graph)
	}

	for i := 0; i <= int(n)-1; i++ {
		for _, host := range graph.nodes[i].hosts {
			go hostThread(host, graph.nodes[i])

		}
	}

	go initializeStandardPackages(graph, h)

	wg.Wait()
	println("\nGraph at the end:")
	graph.printGraph()
}
