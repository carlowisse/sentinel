#!/bin/bash
runasroot=1

print_line() {
    echo " "
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    echo " "
}

echo "Preparing Go Installation..."

print_line

echo "Installing pre-requisites..."
sudo apt install python3 git -y

print_line

echo "Determining latest version of Go..."
URL="$(wget --no-check-certificate -qO- https://go.dev/dl/ | grep -oP '\/dl\/go([0-9\.]+)\.linux-arm64\.tar\.gz' | head -n 1)"
LATESTVERSION="$(echo ${URL} | grep -oP 'go[0-9\.]+' | grep -oP '[0-9\.]+' | head -c -2 )"
DOWNLOADURL="https://go.dev${URL}"

echo "URL: ${URL}"
echo "LATESTVERSION: ${LATESTVERSION}"
echo "DOWNLOAD URL: ${DOWNLOADURL}"

print_line

echo "Retrieving latest version of Go: ${LATESTVERSION}..."
wget --quiet --continue --show-progress "${DOWNLOADURL}"
unset URL
unset DOWNLOADURL

print_line

# Remove Old Go
echo "Cleaning old versions of Go..."
sudo rm -rf /usr/local/go

print_line

echo "Installing Go..."
sudo tar -C /usr/local -xzf go"${LATESTVERSION}".linux-arm64.tar.gz

print_line

echo "Creating skeleton directory structure..."
mkdir -p ~/go/{bin,pkg,src}

print_line

echo "Setting up PATH..."
echo "export GOPATH=~/go" >> ~/.profile && source ~/.profile
echo "export PATH='$PATH':/usr/local/go/bin:$GOPATH/bin" >> ~/.profile && source ~/.profile

print_line

echo "Cleaning up download..."
rm go"${LATESTVERSION}".linux-arm64.tar.gz

print_line

echo "Go is installed here:"
which go

print_line

echo "Go version is:"
go version