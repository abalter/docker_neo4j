#!/bin/bash

set -eu -o pipefail

showUsage()
{
echo "
DESCRIPTION:
	Connect to GCP VM tunneling ports

USAGE: 
    $(basename $0) -n VM_NAME [-p PORT -p ....] [-j PROJECT] [-z ZONE] 

OPTIONS:
	-p PORT:		Port to tunnel.
	-j PROJECT_ID:		GCP project id. Defaults to env.
	-z ZONE:		GCP zone. Defaults to env.
	-n VM_NAME:		Name of the GCP VM.
	-h:			Show this message.
" >&2
}

ports=
cmd="gcloud beta compute ssh"

while getopts ":n:j:p:z:h" flag; do
    case "${flag}" in

        j)
            PROJECT_ID=${OPTARG}
            cmd="$cmd --project $PROJECT_ID"
			;;

        z)
            ZONE=${OPTARG}
			cmd="$cmd --zone $ZONE"
            ;;

		p) 
			ports="$ports ${OPTARG}"
			;;

		n)
			VM_NAME=${OPTARG}
			cmd="$cmd $VM_NAME"
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

if [[ -z $VM_NAME ]]; then
	echo "***ERROR...no name***"
	showUsage
	exit 1
fi

if [[ "$ports" != "" ]]; then
	#echo "got ports $ports"
	
	### loop through list of ports and add tunnel for each
	tunnel_string="-- "
	for port in $ports; do
		tunnel_string="$tunnel_string -L $port:localhost:$port"
	done

	#echo "tunnel_string: $tunnel_string"
else
	echo
	#echo "no tunnel"
fi

cmd="$cmd --tunnel-through-iap $tunnel_string"

echo $cmd

$cmd

