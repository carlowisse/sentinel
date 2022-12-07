package data

import (
	"time"
)

// live updating config data used at runtime
var LiveSentinelViewData = NewSentinelViewData()

// Stores the data needed by Sentinel View during runtime
type SentinelViewData struct {
	// An instance of settings.Settings
	Settings *Settings
	// Remote address of the Pi-Hole
	FormattedAPIAddress string
	// The API key used to authenticate with the Pi-Hole
	APIKey string
	// The time that the last data poll was sent out to the Pi-Hole
	LastUpdated time.Time
	// If the keybinds screen is being shown or not
	ShowKeybindsScreen bool
	// String used to display the keybindings
	Keybinds []string
}

func NewSentinelViewData() *SentinelViewData {
	return &SentinelViewData{
		Keybinds: []string{
			"",
			"---------- Query Log ----------",
			"",
			"          [E/D]  Increase/decrease number of queries in query log by 1",
			"          [R/F]  Increase/decrease number of queries in query log by 10 ",
			"[UP/DOWN ARROW]  Scroll up/down query log by 1",
			" [PAGE UP/DOWN]  Scroll up/down query log by 10",
			"",
			"---------- Misc. ----------",
			"",
			"[P]  Enable/Disable Pi-Hole",
			"[Q]  Quit Sentinel View",
		},
	}
}
