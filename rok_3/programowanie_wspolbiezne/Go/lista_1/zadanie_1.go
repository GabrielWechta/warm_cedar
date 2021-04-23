package main

import (
	"fmt"
	"math/rand"
	"os"
	"strconv"
	"sync"
	"time"
)

var masterOutputer = make(chan string, 100)

/* Graph */
type Node struct {
	id       int
	link     []int
	channel  chan int
	visitors []int
}

type Graph struct {
	nodes []Node
}

func buildGraph(n int) *Graph {
	graph := Graph{nodes: make([]Node, n)}

	for i := 0; i <= n-2; i++ {
		firstEdge := []int{i + 1}
		graph.nodes[i] = Node{
			id:      i,
			link:    firstEdge,
			channel: make(chan int),
		}
	}
	graph.nodes[n-1] = Node{
		id:      n - 1,
		link:    []int{},
		channel: make(chan int),
	}
	return &graph
}

func addShortcuts(graph *Graph, n int, d int) {
	random := rand.New(rand.NewSource(time.Now().UnixNano()))

	goodShortcuts := 0
	for goodShortcuts < d {
		start := random.Int() % (n - 2)
		end := random.Int() % n

		if start >= end || intInSlice(end, graph.nodes[start].link) {
			continue
		} else {
			goodShortcuts++
			graph.nodes[start].link = append(graph.nodes[start].link, end)
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

func printGraph(graph *Graph) {
	for i, node := range graph.nodes {
		fmt.Print(strconv.Itoa(i) + "->")
		fmt.Print(node.link)
		fmt.Print("\n")
	}
	fmt.Print("\n")
}

func printVisitors(graph *Graph) {
	fmt.Print("\n")
	for _, node := range graph.nodes {
		fmt.Print("Wierzchołek " + strconv.Itoa(node.id) + " odwiedziły: ")
		fmt.Print(node.visitors)
		fmt.Print("\n")
	}
	fmt.Print("\n")
}

/* Packages */

type Package struct {
	id      int
	wasHere []int
}

type PackageKeeper struct {
	packages []Package
}

func buildPackageKeeper(k int) PackageKeeper {
	packageKeeper := PackageKeeper{packages: make([]Package, k)}

	for i := 0; i < k; i++ {
		packageKeeper.packages[i] = Package{
			id:      i,
			wasHere: []int{},
		}
	}
	return packageKeeper
}

func printPackageKeeper(keeper PackageKeeper) {
	for i, p := range keeper.packages {
		fmt.Print("Pakiet " + strconv.Itoa(i) + " był w: ")
		for _, node := range p.wasHere {
			fmt.Print(strconv.Itoa(node) + ", ")
		}
		fmt.Print("\n")
	}
	fmt.Print("\n")
}

/* Threads */

func sourceThread(node Node, graph *Graph, k int, keeper PackageKeeper) {
	random := rand.New(rand.NewSource(rand.Int63()))

	for packageID := 0; packageID < k; packageID++ {
		masterOutputer <- "pakiet " + strconv.Itoa(packageID) + " w wierzchołku " + strconv.Itoa(node.id) + "\n"
		keeper.packages[packageID].wasHere = append(keeper.packages[packageID].wasHere, 0)
		graph.nodes[node.id].visitors = append(graph.nodes[node.id].visitors, packageID)

		time.Sleep(time.Duration(random.Float64() * float64(time.Second)))
		pick := node.link[random.Intn(len(node.link))]
		graph.nodes[pick].channel <- packageID
	}
}

func receiverSenderThread(node Node, graph *Graph, keeper PackageKeeper) {
	random := rand.New(rand.NewSource(rand.Int63()))

	for {
		time.Sleep(time.Duration(random.Float64() * float64(time.Second)))
		received := <-node.channel
		keeper.packages[received].wasHere = append(keeper.packages[received].wasHere, node.id)
		graph.nodes[node.id].visitors = append(graph.nodes[node.id].visitors, received)

		masterOutputer <- "pakiet " + strconv.Itoa(received) + " w wierzchołku " + strconv.Itoa(node.id) + "\n"

		time.Sleep(time.Duration(random.Float64() * float64(time.Second)))
		pick := node.link[random.Intn(len(node.link))]
		graph.nodes[pick].channel <- received
	}
}

func outletThread(node Node, graph *Graph, k int, wg *sync.WaitGroup, keeper PackageKeeper) {
	defer wg.Done()

	for i := 0; i < k; i++ {
		received := <-node.channel
		keeper.packages[received].wasHere = append(keeper.packages[received].wasHere, node.id)
		graph.nodes[node.id].visitors = append(graph.nodes[node.id].visitors, received)

		masterOutputer <- "pakiet " + strconv.Itoa(received) + " został odebrany \n"
	}
}

func main() {
	var wg sync.WaitGroup

	n, _ := strconv.ParseInt(os.Args[1], 10, 64)
	d, _ := strconv.ParseInt(os.Args[2], 10, 64)
	k, _ := strconv.ParseInt(os.Args[3], 10, 64)

	graph := buildGraph(int(n))
	addShortcuts(graph, int(n), int(d))
	printGraph(graph)

	keeper := buildPackageKeeper(int(k))

	/* this is goroutine for output */
	go func() {
		for {
			output := <-masterOutputer
			fmt.Print(output)
		}
	}()

	for i := 0; i < int(n)-1; i++ {
		go receiverSenderThread(graph.nodes[i], graph, keeper)
	}

	go sourceThread(graph.nodes[0], graph, int(k), keeper)

	wg.Add(1)
	go outletThread(graph.nodes[n-1], graph, int(k), &wg, keeper)

	wg.Wait()
	time.Sleep(time.Second)

	printVisitors(graph)
	printPackageKeeper(keeper)
}
