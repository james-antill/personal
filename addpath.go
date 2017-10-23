package main

import (
	"flag"
	"fmt"
	"os"
	"strings"
)

func addVal(vals map[string]bool, cvals, val string, prefix bool) string {
	if val == "" {
		val = "."
	}
	if vals[val] {
		return cvals
	}
	vals[val] = true

	if prefix {
		if cvals != "" {
			cvals = ":" + cvals
		}
		cvals = val + cvals
	} else {
		if cvals != "" {
			cvals += ":"
		}
		cvals += val
	}

	return cvals
}

func main() {
	help := flag.Bool("help", false, "Show help")
	prefix := flag.Bool("prefix", false, "Prefix addition")
	flag.Parse()

	if len(flag.Args()) < 2 {

		if *help || (len(flag.Args()) >= 1 && flag.Args()[0] == "help") {
			fmt.Fprintf(os.Stderr, `"Usage: addpath ENV addition
  --prefix  ...  Prefix the addition.
`)
			os.Exit(0)
		}

		fmt.Fprintf(os.Stderr, "Usage: addpath ENV addition")
		os.Exit(1)
	}

	vals := make(map[string]bool)
	nval := ""
	for _, val := range strings.Split(os.Getenv(flag.Args()[0]), ":") {
		nval = addVal(vals, nval, val, false)
	}

	nvals := strings.Split(flag.Args()[1], ":")
	for off, val := range nvals {
		if *prefix {
			val = nvals[len(nvals)-1-off]
		}
		nval = addVal(vals, nval, val, *prefix)
	}

	fmt.Printf("%s", nval)
}
