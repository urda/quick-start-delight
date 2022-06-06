########################################################################################################################
# Variables
########################################################################################################################

CLEAN_TARGETS = ./quick-start-delight*.zip
MOD_ZIP_EXCLUDES := @exclude.lst
MOD_ZIP_PREFIX := quick-start-delight
SHELL := /bin/bash
VERSION_REGEX := "([0-9]{1,}\.)+[0-9]{1,}"

########################################################################################################################
# Dynamic Variables
########################################################################################################################

VERSION_ID := $(shell grep '"version"' ./info.json | egrep -o $(VERSION_REGEX))

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
	@echo 'SHELL ........... $(SHELL)'
	@echo 'VERSION_ID ...... $(VERSION_ID)'
	@echo 'VERSION_REGEX ... $(VERSION_REGEX)'

.PHONY: build
build: # Build the mod package
	zip $(MOD_ZIP_PREFIX)_$(VERSION_ID).zip -r ./ -x $(MOD_ZIP_EXCLUDES)

.PHONY: clean
clean: # Clean the project directory.
	rm -rf $(CLEAN_TARGETS)
