VM_NAME=balter-neo4j
PROJECT_ID=psjh-238522
NETWORK=projects/phs-205720/global/networks/psjh-connect
SUBNET=projects/phs-205720/regions/us-east1/subnetworks/mgmt01
ZONE=us-east1-b
IMAGE=neo4j-server
#USER=ariel.balter

VM_NAME=$1
VM_NAME=${VM_NAME:-balter-neo4j}

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
