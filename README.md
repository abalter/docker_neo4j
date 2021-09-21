# Docker neo4j

This launches a neo4j container on VM in GCP which you can connect to locally.

Right now, it "works"

## Prerequisites
* A VM on GCP
* Docker installed
* This repository cloned

<<<<<<< HEAD
## Usage Instructions
### On the VM
* SSH to the VM
* `cd docker-neo4j`
* To build the container, run `./build`. 
* To run the container, run `./run`. 
* Can exit

### Locally
=======
* Connect to existing VM
* To build the container, run `./build`. 
* To run the container, run `./run`. 
* To access the server (on local machine):
<<<<<<< HEAD
>>>>>>> 04e6c83b9347bc72b2eda6096ef0884b9972ff5c
  1. Run `./connect_to_neo4j_server.sh`
=======
  1. Run `./connect_to_neo4j_server.sh` providing your parameters
>>>>>>> 9dd44dd9b8e300bcdf04e275eb34d06e86cc3888
  2. Browse `localhost:7474`

