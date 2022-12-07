package cli

import (
	"os"

	"github.com/carlowisse/sentinel/tree/main/scripts/view/sentinel-view/pkg/auth"
	"github.com/carlowisse/sentinel/tree/main/scripts/view/sentinel-view/pkg/data"
	"github.com/carlowisse/sentinel/tree/main/scripts/view/sentinel-view/pkg/network"
	"github.com/fatih/color"
)

/*
	Validate that the config file and API key are in place.
	Load the required settings into memory
*/
func InitialiseSENTINELVIEW() {
	// firstly, has a config file been created?
	if !data.ConfigFileExists() {
		color.Red("Please configure Sentinel View via the 'setup' command")
		os.Exit(1)
	}

	data.SENTINELVIEWSettings.LoadFromFile()

	// retrieve the API key depending upon its storage location
	if !data.SENTINELVIEWSettings.APIKeyIsInFile() && !auth.APIKeyIsInKeyring() {
		color.Red("Please configure Sentinel View via the 'setup' command")
		os.Exit(1)
	} else {
		if data.SENTINELVIEWSettings.APIKeyIsInFile() {
			data.LiveSentinelViewData.APIKey = data.SENTINELVIEWSettings.APIKey
		} else {
			data.LiveSentinelViewData.APIKey = auth.RetrieveAPIKeyFromKeyring()
		}
	}

	data.LiveSentinelViewData.Settings = data.SENTINELVIEWSettings
	data.LiveSentinelViewData.FormattedAPIAddress = network.GenerateAPIAddress(
		data.SENTINELVIEWSettings.PiHoleAddress,
		data.SENTINELVIEWSettings.PiHolePort)
}
