package api

import (
	"fmt"
	"log"
	"net/http"

	"github.com/carlowisse/sentinel/tree/main/scripts/view/sentinel-view/pkg/data"
	"github.com/carlowisse/sentinel/tree/main/scripts/view/sentinel-view/pkg/network"
)

// Enable the Pi-Hole
func EnablePiHole() {
	url := data.LiveSentinelViewData.FormattedAPIAddress + "?enable" + "&auth=" + data.LiveSentinelViewData.APIKey
	req, err := http.NewRequest("GET", url, nil)
	if err != nil {
		log.Fatal(err)
	}

	_, err = network.HttpClient.Do(req)
	if err != nil {
		log.Fatal(err)
	}
}

// Disable the Pi-Hole
func DisablePiHole(timeout bool, time int64) {
	disable := "?disable"
	if timeout {
		disable += fmt.Sprintf("=%d", time)
	}
	url := data.LiveSentinelViewData.FormattedAPIAddress + disable + "&auth=" + data.LiveSentinelViewData.APIKey
	req, err := http.NewRequest("GET", url, nil)
	if err != nil {
		log.Fatal(err)
	}

	_, err = network.HttpClient.Do(req)
	if err != nil {
		log.Fatal(err)
	}
}
