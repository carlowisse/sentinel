package main

import (
	"log"
	"os"

	"github.com/carlowisse/sentinel/tree/main/scripts/view/sentinel-view/pkg/cli"
)

func main() {
	if err := cli.App.Run(os.Args); err != nil {
		log.Fatal(err)
	}
}
