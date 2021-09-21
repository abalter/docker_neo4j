# Docker neo4j

This launches a neo4j container on VM in GCP which you can connect to locally.

Right now, it "works"

## Prerequisites
* A VM on GCP
* Docker installed
* This repository cloned

## Usage Instructions
### On the VM
* SSH to the VM
* `cd docker-neo4j`
* To build the container, run `./build`. 
* To run the container, run `./run`. 
* Can exit

### Locally
  1. Run `./connect_to_neo4j_server.sh`
  2. Browse `localhost:7474`

