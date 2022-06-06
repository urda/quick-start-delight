########################################################################################################################
# Variables
########################################################################################################################

CLEAN_TARGETS := ./quick-start-delight*.zip
PROJECT_NAME := quick-start-delight
SHELL := /bin/bash
VERSION_REGEX := "([0-9]{1,}\.)+[0-9]{1,}"

########################################################################################################################
# Computed Variables
########################################################################################################################

VERSION_ID := $(shell grep '"version"' ./info.json | egrep -o $(VERSION_REGEX))

########################################################################################################################
# Composite Variables
########################################################################################################################

MOD_FULLNAME := $(PROJECT_NAME)_$(VERSION_ID)
MOD_ZIP_EXCLUDES := @$(PROJECT_NAME)/exclude.lst

########################################################################################################################
# `make help` Needs to be first so it is ran when just `make` is called
########################################################################################################################

.PHONY: help
help: # Show this help screen
	@ack '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) |\
	sort -k1,1 |\
	awk 'BEGIN {FS = ":.*?# "}; {printf "\033[1m%-30s\033[0m %s\n", $$1, $$2}'

########################################################################################################################
# User-callable commands
########################################################################################################################

.PHONY: debug
debug:
	@echo 'MOD_FULLNAME .... $(MOD_FULLNAME)'
	@echo 'SHELL ........... $(SHELL)'
	@echo 'VERSION_ID ...... $(VERSION_ID)'
	@echo 'VERSION_REGEX ... $(VERSION_REGEX)'

.PHONY: build
build: # Build the mod package
	cd .. && \
	zip -v ./$(PROJECT_NAME)/$(MOD_FULLNAME).zip -r ./$(PROJECT_NAME) -x $(MOD_ZIP_EXCLUDES) && \
	cd ./$(PROJECT_NAME)

.PHONY: clean
clean: # Clean the project directory.
	rm -rf $(CLEAN_TARGETS)
