#!/bin/bash
# initialize all submodules
git submodule update --init --recursive
# upgrading submodules to the latest published version
git submodule update --init --remote
