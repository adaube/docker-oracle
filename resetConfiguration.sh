#!/bin/bash

# reset oracle database storage configuration
sudo rm -rf ~/.oradata
mkdir ~/.oradata
sudo chown 54321:54321 ~/.oradata
sudo chmod -R o+w ~/.oradata

