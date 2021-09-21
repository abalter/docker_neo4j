#!/bin/bash

set -Eeuo pipefail

# Set my default project to be the project named psjh-eacri-biggraph
# using the project id.  If you don't want to set it as the default
# project you can project the project id as an arugment for each
# of the following commands.

VM_NAME=balter-neo4j-2
PROJECT_ID=psjh-238522
NETWORK=projects/phs-205720/global/networks/psjh-connect
SUBNET=projects/phs-205720/regions/us-east1/subnetworks/mgmt01
ZONE=us-east1-b
NEO4J_IMAGE=neo4j-community-1-3-3-5
#USER=ariel.balter

#gcloud config set project ${PROJECT_ID}
# gcloud config set zones ${zone}

gcloud compute instances delete ${VM_NAME} \
    --project ${PROJECT_ID} \
    --zone ${ZONE} \
    --delete-disks=boot

# Create the vm in the psjh-eacri-biggraph project
gcloud compute instances create ${VM_NAME} \
    --image neo4j-community-1-4-1-0-apoc \
    --image-project launcher-public \
    --boot-disk-size=100GB \
    --boot-disk-type=pd-ssd \
    --machine-type=e2-highmem-2  \
    --network-interface=no-address \
    --zone=${ZONE} \
    --project=${PROJECT_ID}

# ssh into the vm in the psjh-eacri-biggraph project using
# the internal ip address over the IAP proxy and port
# forward Neo4j ports over the tunnel
#
# Neo4j documented ports
#    HTTP  7473
#    HTTPS 7474
#    Bolt  7687
#
# the "--" is an alternative to using the "--ssh-flag" argument
#
#gcloud beta compute ssh \
#  --zone ${ZONE} \
#  --project ${PROJECT_ID} \
#  ${VM_NAME} \
#  --tunnel-through-iap \
#  -- \
#  -L 7473:localhost:7473 \
#  -L 7474:localhost:7474 \
#  -L 7687:localhost:7687

