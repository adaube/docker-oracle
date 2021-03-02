#!/bin/bash

# change last variable to your container
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' oracle-se2

