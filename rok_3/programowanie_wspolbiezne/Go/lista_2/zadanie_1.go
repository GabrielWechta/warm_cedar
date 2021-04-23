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
	id          int
	link        []int
	channel     chan int
	trapChannel chan bool
	visitors    []int
}

type Graph struct {
	nodes []Node
}

func buildGraph(n int) *Graph {
	graph := Graph{nodes: make([]Node, n)}

	for i := 0; i <= n-2; i++ {
		firstEdge := []int{i + 1}
		graph.nodes[i] = Node{
			id:          i,
			link:        firstEdge,
			channel:     make(chan int),
			trapChannel: make(chan bool),
		}
	}
	graph.nodes[n-1] = Node{
		id:      n - 1,
		link:    []int{},
		channel: make(chan int),
	}
	return &graph
}

func (graph *Graph) addShortcuts(n int, d int) {
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

func (graph *Graph) addReverseShortcuts(n int, b int) {
	random := rand.New(rand.NewSource(time.Now().UnixNano()))

	goodReverseShortcuts := 0
	for goodReverseShortcuts < b {
		start := random.Int()%(n-2) + 1
		end := random.Int()%(n-2) + 1

		if start <= end || intInSlice(end, graph.nodes[start].link) {
			continue
		} else {
			goodReverseShortcuts++
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

func (graph *Graph) printGraph() {
	for i, node := range graph.nodes {
		fmt.Print(strconv.Itoa(i) + "->")
		fmt.Print(node.link)
		fmt.Print("\n")
	}
	fmt.Print("\n")
}

func (graph *Graph) printVisitors() {
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
	ttl     int
}

type PackageKeeper struct {
	packages     []Package
	deathChannel chan int
}

func buildPackageKeeper(k int, h int) PackageKeeper {
	packageKeeper := PackageKeeper{
		packages:     make([]Package, k),
		deathChannel: make(chan int),
	}

	for i := 0; i < k; i++ {
		packageKeeper.packages[i] = Package{
			id:      i,
			wasHere: []int{},
			ttl:     h,
		}
	}
	return packageKeeper
}

func (keeper PackageKeeper) printPackageKeeper() {
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
		keeper.packages[packageID].wasHere = append(keeper.packages[packageID].wasHere, node.id)
		graph.nodes[node.id].visitors = append(graph.nodes[node.id].visitors, packageID)

		time.Sleep(time.Duration(random.Float64() * float64(time.Second)))
		pick := node.link[random.Intn(len(node.link))]
		graph.nodes[pick].channel <- packageID
	}
}

func receiverSenderThread(node Node, graph *Graph, keeper PackageKeeper) {
	random := rand.New(rand.NewSource(rand.Int63()))
	isTrap := false

	for {
		time.Sleep(time.Duration(random.Float64() * float64(time.Second)))
		select {
		case received := <-node.channel:
			keeper.packages[received].wasHere = append(keeper.packages[received].wasHere, node.id)
			graph.nodes[node.id].visitors = append(graph.nodes[node.id].visitors, received)

			masterOutputer <- "pakiet " + strconv.Itoa(received) + " w wierzchołku " + strconv.Itoa(node.id) + "\n"
			if isTrap == true {
				masterOutputer <- "pakiet " + strconv.Itoa(received) + " został złapany w " + strconv.Itoa(node.id) + "\n"
				isTrap = false
				keeper.deathChannel <- received
			} else {
				keeper.packages[received].ttl -= 1

				if keeper.packages[received].ttl <= 0 {
					masterOutputer <- "pakiet " + strconv.Itoa(received) + " nieszczęśliwie zmarł w " + strconv.Itoa(node.id) + "\n"
					keeper.deathChannel <- received
				} else {
					time.Sleep(time.Duration(random.Float64() * float64(time.Second)))
					pick := node.link[random.Intn(len(node.link))]
					graph.nodes[pick].channel <- received
				}
			}
		case _ = <-node.trapChannel:
			isTrap = true
		}
	}
}

func outletThread(node Node, graph *Graph, k int, wg *sync.WaitGroup, keeper PackageKeeper, finishPoacher chan bool) {
	defer wg.Done()
	letGoCount := 0
	deathsCount := 0

	for letGoCount+deathsCount < k {
		select {
		case _ = <-keeper.deathChannel:
			deathsCount += 1
		case received := <-node.channel:
			letGoCount += 1
			keeper.packages[received].wasHere = append(keeper.packages[received].wasHere, node.id)
			graph.nodes[node.id].visitors = append(graph.nodes[node.id].visitors, received)

			masterOutputer <- "pakiet " + strconv.Itoa(received) + " został odebrany \n"
		}
	}
	finishPoacher <- true
}

/* Poacher */

func poacher(n int, graph *Graph, finishPoacher chan bool) {
	finish := false
	for {
		random := rand.New(rand.NewSource(rand.Int63()))
		time.Sleep(time.Duration(random.Float64() * float64(time.Second)))
		trapTarget := random.Int()%(n-2) + 1
		graph.nodes[trapTarget].trapChannel <- true
		println("zasadzilem w " + strconv.Itoa(trapTarget))
		finish = <-finishPoacher
		if finish == true {
			return
		}
	}
}

func main() {
	var wg sync.WaitGroup

	n, _ := strconv.ParseInt(os.Args[1], 10, 64)
	d, _ := strconv.ParseInt(os.Args[2], 10, 64)
	b, _ := strconv.ParseInt(os.Args[3], 10, 64)
	k, _ := strconv.ParseInt(os.Args[4], 10, 64)
	h, _ := strconv.ParseInt(os.Args[5], 10, 64)
	finishPoacher := make(chan bool)

	graph := buildGraph(int(n))
	graph.addShortcuts(int(n), int(d))
	graph.addReverseShortcuts(int(n), int(b))
	graph.printGraph()

	keeper := buildPackageKeeper(int(k), int(h))

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
	go outletThread(graph.nodes[n-1], graph, int(k), &wg, keeper, finishPoacher)

	go poacher(int(n), graph, finishPoacher)

	wg.Wait()
	time.Sleep(time.Second)

	graph.printVisitors()
	keeper.printPackageKeeper()
}
