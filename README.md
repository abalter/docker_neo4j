# Docker neo4j

This launches a neo4j container on VM in GCP which you can connect to locally.

Right now, it "works"

## Prerequisites
* A VM on GCP
* Docker installed
* This repository cloned

## Usage Instructions
### On the VM
1. SSH to the VM
1. Clone this repo
1. `cd docker-neo4j`
1. To build the container, run `./build`. 
1. To run the container, run `./run`. 
1. Can exit

### Locally
1. Run `./connect_to_neo4j_server.sh` providing your parameters
1. Browse `localhost:7474`

