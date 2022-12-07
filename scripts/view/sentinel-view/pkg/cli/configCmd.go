package cli

import (
	"fmt"
	"os/exec"

	"github.com/carlowisse/sentinel/tree/main/scripts/view/sentinel-view/pkg/auth"
	"github.com/carlowisse/sentinel/tree/main/scripts/view/sentinel-view/pkg/data"
	"github.com/fatih/color"
	"github.com/urfave/cli/v2"
)

/*
	Searches for and deletes:
		- the API key from the system keyring (if exists)
		- the config file from the user's home directory (if exists)
*/
func ConfigDeleteCommand(*cli.Context) error {
	if auth.DeleteAPIKeyFromKeyring() {
		color.Green("System keyring API entry has been deleted!")
	} else {
		color.Yellow("Sentinel View did not find a keyring entry to delete")
	}
	if data.DeleteConfigFile() {
		color.Green("Stored config file has been deleted!")
	} else {
		color.Yellow("Sentinel View did not find a config file to delete")
	}
	return nil
}

/*
	Displays any saved configuration data to the user.
	If a config file is present, that can be loaded and displayed,
	otherwise, the user can be prompted to create one.
*/
func ConfigViewCommand(*cli.Context) error {
	/*
		- Pi-Hole IP address
		- Pi-Hole port
		- Data refresh rate
	*/
	if data.ConfigFileExists() {
		// Display the location of the config file in the filesystem
		color.Green("Config location: %s\n", data.GetConfigFileLocation())

		// Open the config file so we can extract data from it
		data.SENTINELVIEWSettings.LoadFromFile()
		fmt.Printf("Pi-Hole address: %s\n", data.SENTINELVIEWSettings.PiHoleAddress)
		fmt.Printf("Pi-Hole port: %d\n", data.SENTINELVIEWSettings.PiHolePort)
		fmt.Printf("Refresh rate: %ds\n", data.SENTINELVIEWSettings.RefreshS)
	} else {
		color.Yellow("No config file is present - run the setup command to create one")
	}

	// and the same with the API key
	if auth.APIKeyIsInKeyring() {
		fmt.Printf("API key (keyring): %s\n", auth.RetrieveAPIKeyFromKeyring())
	} else if data.SENTINELVIEWSettings.APIKeyIsInFile() {
		fmt.Printf("API key (config file): %s\n", data.SENTINELVIEWSettings.APIKey)
	} else {
		color.Yellow("No API key has been provided - run the setup command to enter it")
	}

	_ = exec.Command(data.GetConfigFileLocation()).Run()

	return nil
}
