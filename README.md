<div id="top"></div>

<!-- PROJECT LOGO -->
<div align="center">
  <img src="./assets/logos/svg/sentinelCore_dark.svg" alt="Logo" width="150" height="150">

  <h1 style="text-align: center; font-weight: 600; letter-spacing: 2px; border-bottom: none;">SENTINEL</h1>

  <p style="text-align: center; font-size: 18px;">
    A network wide ad, adware, malware, spyware, tracker, analytics and crypto miner denier with a recursive, caching DNS resolver, and DNS-over-TLS all-in-one!
  </p>
</div>

<br>

## What Does Sentinel Do?
* Installs and Configures Pi-Hole
* Installs and Configures Unbound DNS
* Installs and Configures Stubby for DNS-over-TLS using Quad9
* Configures Static IP
* Configures Firewall

<a href="#top"><img align="right" src="https://img.shields.io/badge/back%20to%20top-&#8593;-blue?style=for-the-badge"></a>

<br>

## About The Project
Security is a very important factor when accessing the internet and unforunately it is not something that is built into systems by default. This is done on purpose so that your privacy is stripped away and your data can be sold.

Sentinel is the answer to these problems. Encrypting your data, denying all ads, trackers, crypto miners (browser), malware, adware, spyware and much more on a network level (no need to set it up on every device) and implements a validating, recursive, caching DNS resolver that runs locally so that YOU are in control.

There are also some notes on setting up gravity-sync if you wish to have a redundant DNS server on your network. (run two Pi-Holes in sync).

**Here is why Sentinel would be good for you**
* Deny ads, not just in your browser but also on TV streaming apps and other devices that don't allow plugins
* Deny trackers
* Deny telemetry
* Deny constant analytics
* Deny common doxxing URIs
* Deny typo squatting domains
* Deny browser based crypto miners
* Deny malware
* Deny agency snooping (CIA, FBI, NSA, etc.)
* Deny adult sites
* Deny constant social network callouts
* Deny autodiscover leaks
* Deny AMP sites
* Protect yourself against malware, adware and spyware (AKA: badware)
* Speed up network using a caching DNS resolver
* Encrypt your DNS queries using DNS-over-TLS

<a href="#top"><img align="right" src="https://img.shields.io/badge/back%20to%20top-&#8593;-blue?style=for-the-badge"></a>

<br>

## Built With
**Software**
* [Pi-Hole](https://github.com/pi-hole)
* [Unbound](https://github.com/NLnetLabs/unbound)
* [gravity-sync](https://github.com/vmstan/gravity-sync)
* [Stubby](https://github.com/getdnsapi/stubby)

**Hardware**
* Raspberry Pi 4 Model B 8GB
* 15W USB-C Power Supply
* Micro HDMI to Standard HDMI Cable
* Flirc Raspberry Pi 4 Case
* CAT8 Ethernet Cable
* 32GB SanDisk Extreme Pro Micro SD Card

**Optional**
* Mouse
* Keyboard

<a href="#top"><img align="right" src="https://img.shields.io/badge/back%20to%20top-&#8593;-blue?style=for-the-badge"></a>

<br>

## Installation
> _This installation uses a single script to set up **Static IP**, **Pi-Hole**, **Unbound**, **Firewall** and **Stubby**_

1. SSH into your Raspberry Pi
```sh
ssh pi@<ip-address>
```

2. Update your Raspberry Pi
```sh
sudo apt update --fix-missing -y
sudo apt upgrade -y
sudo apt dist-upgrade -y --allow-downgrades
sudo apt autoremove --purge -y
cd
touch .hushlogin
sudo apt install git -y
git clone https://github.com/carlowisse/sentinel.git
```

3. Setup Raspberry Pi
```sh
sudo raspi-config
```
> System Options > Hostname
<br>
> Advanced Options > Expand Filesystem
<br>
> Finish > Reboot

4. Clone This Repository
```sh
cd
git clone https://github.com/carlowisse/sentinel.git
```

5. Run The Script
```sh
cd sentinel
sudo bash install.sh
```

<br>

## Contributing
Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag `enhancement`.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/amazing-feature`)
3. Commit your Changes (`git commit -m 'Added an amazing feature'`)
4. Push to the Branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

<a href="#top"><img align="right" src="https://img.shields.io/badge/back%20to%20top-&#8593;-blue?style=for-the-badge"></a>

<br>

## Issues
If there are any issues please raise an issue on the issue tab and I will look into it.

## License
Distributed under the MIT License. See [LICENSE](LICENSE.txt) for more information.

<br>

## Contact
Carlo Wisse - [Twitter](https://twitter.com/carlowisse) - [Email](mailto:contact@carlowisse.com)

<br>

## Acknowledgments
* [Choose an Open Source License](https://choosealicense.com)

<a href="#top"><img align="right" src="https://img.shields.io/badge/back%20to%20top-&#8593;-blue?style=for-the-badge"></a>
