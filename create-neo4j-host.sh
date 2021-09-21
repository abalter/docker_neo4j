VM_NAME=balter-neo4j
PROJECT_ID=psjh-238522
NETWORK=projects/phs-205720/global/networks/psjh-connect
SUBNET=projects/phs-205720/regions/us-east1/subnetworks/mgmt01
ZONE=us-east1-b
IMAGE=neo4j-server
#USER=ariel.balter

VM_NAME=$1

#gcloud config set project ${PROJECT_ID}
# gcloud config set zones ${zone}

gcloud compute instances delete ${VM_NAME} \
    --project ${PROJECT_ID} \
    --zone ${ZONE} \
    --delete-disks=boot

# Create the vm in the psjh-eacri-biggraph project
gcloud compute instances create ${VM_NAME} \
    --image ${IMAGE} \
    --image-project launcher-public \
    --boot-disk-size=100GB \
    --boot-disk-type=pd-ssd \
    --machine-type=e2-highmem-2  \
#    --network-interface=no-address \
    --zone=${ZONE} \
    --project=${PROJECT_ID}

