package main

import (
	"fmt"
	"math/rand"
	"strconv"
	"time"
)

type Node struct {
	id   int
	link []int
}

type Graph struct {
	nodes []Node
}

func buildGraph(n int) *Graph {
	graph := Graph{nodes: make([]Node, n)}

	for i := 0; i <= n-2; i++ {
		firstEdge := []int{i + 1}
		graph.nodes[i] = Node{
			id:   i,
			link: firstEdge,
		}
	}
	return &graph
}

func addShortcuts(graph *Graph, n int, d int) {
	random := rand.New(rand.NewSource(time.Now().UnixNano()))

	i := 1
	for i <= d {
		start := random.Int() % (n - 2)
		end := random.Int() % n

		stuckCounter := 0
		for start >= end || intInSlice(end, graph.nodes[start].link) {
			end = random.Int() % n
			stuckCounter++
			if stuckCounter > 10 {
				i--
				break
			}
		}

		graph.nodes[start].link = append(graph.nodes[start].link, end)
		i++
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

func main() {
	n := 10
	d := 30
	graph := buildGraph(n)
	addShortcuts(graph, n, d)
	printGraph(graph)
}
