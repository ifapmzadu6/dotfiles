#!/bin/bash

cd `dirname $0`

# update
git pull

# run
./setup_gitconfig.sh
./setup_vim.sh

