#!/bin/bash

set -eu -o pipefail

VM_NAME=balter-neo4j
PROJECT_ID=psjh-238522
NETWORK=projects/phs-205720/global/networks/psjh-connect
SUBNET=projects/phs-205720/regions/us-east1/subnetworks/mgmt01
ZONE=us-east1-b
IMAGE=neo4j-server


VM_NAME=$1
VM_NAME=${VM_NAME:-balter-neo4j}

showUsage()
{
echo "
Turn IP address on for TIMEOUT minutes or turn off.

USAGE: 
    $(basename $0) [ -e TIMEOUT | -d ]

OPTIONS:
    -e TIMEOUT: Enable IP address for a number of minutes, the
                smaller of 30 or TIMEOUT.
    -d:         Disable IP address.
    -h:         Show this message.
" >&2
}


while getopts ":e:dh" flag; do
    case "${flag}" in

        e)
            timeout=${OPTARG}
            if [[ timeout -gt 30 ]]; then
                echo "Timeout cannot exceed 30min"
                timeout=30
            fi
            showContext
            echo "$VMNAME: enabling external IP address"
            echo "Network will turn off in $timeout minutes..."
            enableNetwork 
            exit 0
            ;;

        d)
            echo "$VMNAME: disabling external IP address"
            showContext
            disableNetwork 
            exit 0
            ;;

         h)
            showUsage
            exit 0
            ;;

        /?)
            showUsage
            exit 1
            ;;
    esac
done
showUsage
exit 1

#gcloud config set project ${PROJECT_ID}
# gcloud config set zones ${zone}

# Delete instance if exists
exsists=`gcloud compute instances list | grep "$VM_NAME"`

if [[ $exists != "" ]]; then
	echo "exists: $exists......DELETING"
	gcloud compute instances delete ${VM_NAME} \
    	--project ${PROJECT_ID} \
    	--zone ${ZONE} \
    	--delete-disks=boot
fi

# Create the vm using the docker image
cmd="
gcloud compute instances create_with_container ${VM_NAME} \
    --container-image ${IMAGE} \
    --boot-disk-size=200GB \
    --boot-disk-type=pd-ssd \
    --machine-type=e2-highmem-2  \
    --zone=${ZONE} \
    --project=${PROJECT_ID}
"

echo "$cmd"
$cmd
