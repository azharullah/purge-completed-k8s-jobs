# source: https://github.com/azer/go-makefile-example/blob/master/Makefile

VERSION := $(shell git describe --tags --abbrev=0)
BUILD := $(shell git rev-parse --short HEAD)
BINARYNAME?=$(shell basename "$(PWD)")-$(VERSION)

# Go related variables.
GOCMD := go
GOBASE := $(shell pwd)
GOPATH := $(GOBASE)/vendor:$(GOBASE)
GOBIN := $(GOBASE)/bin
GOBUILD := $(GOCMD) build
GOBUILDCMD := GOPATH=$(GOPATH) GOBIN=$(GOBIN) $(GOBUILD) $(LDFLAGS) -o $(GOBIN)/$(BINARYNAME)

# Use linker flags to provide version/build settings
LDFLAGS=-ldflags "-X=main.Version=$(VERSION) -X=main.Build=$(BUILD)"

## clean: Clean build files. Runs `go clean` internally.
clean:
	echo "  >  Cleaning up..."
	GOPATH=$(GOPATH) GOBIN=$(GOBIN) go clean
	rm -f $(GOBIN)/$(BINARYNAME)

build:
	echo "  >  Building binary..."
	$(GOBUILDCMD)

build-linux:
	echo $(BINARYNAME)
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 BINARYNAME=$(BINARYNAME) $(GOBUILDCMD)