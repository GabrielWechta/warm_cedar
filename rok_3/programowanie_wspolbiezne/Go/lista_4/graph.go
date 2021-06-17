package main

import (
	"fmt"
	"strconv"
	"strings"
)

type Node struct {
	id              int
	neighbours      []int
	routingTable    []Routing
	routingChannel  chan RoutingPackage
	standardChannel chan StandardPackage
	standardQueue   chan StandardPackage
	readFrom        chan readOp
	readCost        chan readCostOp
	writeTo         chan writeOp
	hosts           []Host
}

type Graph struct {
	nodes          []Node
	hostsAddresses []Address // random order
}

type Routing struct {
	nexthop int
	cost    int
	changed bool
}

type Host struct {
	innerId        int
	routerId       int
	initChannel    chan Address
	deliverChannel chan StandardPackage
}

type RoutingInfo struct {
	id      int
	cost    int
	fromWho int
}

type RoutingPackage struct {
	pairs []RoutingInfo
}

type Address struct {
	nodeId int
	hostId int
}

type StandardPackage struct {
	senderAddress   Address
	receiverAddress Address
	visited         []int
}

type readOp struct {
	resp chan RoutingPackage
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

func mod(a, b int) int {
	return (a%b + b) % b
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func intInSlice(x int, array []int) bool {
	for _, a := range array {
		if x == a {
			return true
		}
	}
	return false
}

func (pack *RoutingPackage) toString() string {
	output := ""
	for _, pair := range pack.pairs {
		output += "(" + strconv.Itoa(pair.id) + ", " + strconv.Itoa(pair.cost) + ") "
	}

	return output
}

func (pack *StandardPackage) toString() string {
	output := ""
	output += "Package: (" + strconv.Itoa(pack.senderAddress.nodeId) + ":" + strconv.Itoa(pack.senderAddress.hostId) + ") -> (" + strconv.Itoa(pack.receiverAddress.nodeId) + ":" + strconv.Itoa(pack.receiverAddress.hostId) + ") "
	output += "path: "
	if len(pack.visited) > 0 {
		b := make([]string, len(pack.visited))
		for i, nodeId := range pack.visited {
			b[i] = strconv.Itoa(nodeId)
		}

		output += strings.Join(b, ", ")
	}

	output += "\n"
	return output
}

func buildGraph(n int, h int) *Graph {
	graph := Graph{nodes: make([]Node, n)}

	for i := 0; i <= n-1; i++ {
		firstEdge := []int{mod(i-1, n), (i + 1) % n}

		graph.nodes[i] = Node{
			id:              i,
			neighbours:      firstEdge,
			routingChannel:  make(chan RoutingPackage),
			standardChannel: make(chan StandardPackage),
			standardQueue:   make(chan StandardPackage, 100),
			readFrom:        make(chan readOp),
			readCost:        make(chan readCostOp),
			writeTo:         make(chan writeOp),
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

func (graph *Graph) addHosts(n int, h int) {
	addedHosts := 0
	for addedHosts < h {
		nodeId := random.Int() % n
		hostId := len(graph.nodes[nodeId].hosts)
		host := Host{routerId: nodeId, innerId: hostId, initChannel: make(chan Address), deliverChannel: make(chan StandardPackage)}
		graph.hostsAddresses = append(graph.hostsAddresses, Address{nodeId: nodeId, hostId: hostId})
		graph.nodes[nodeId].hosts = append(graph.nodes[nodeId].hosts, host)

		addedHosts += 1
	}
}

func (graph *Graph) printGraph() {
	for i, node := range graph.nodes {
		fmt.Print(strconv.Itoa(i))
		fmt.Print("(" + strconv.Itoa(len(node.hosts)) + ")")
		fmt.Print("->")
		fmt.Print(node.neighbours)
		fmt.Print(": ")
		fmt.Print(node.routingTable)
		fmt.Print("\n")
	}
	fmt.Print("\n")
}
