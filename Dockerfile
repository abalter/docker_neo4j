FROM neo4j

SHELL ["/bin/bash", "-c"]
#SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# install stuff
RUN apt update && apt install -y \ 
	vim \
	iputils-ping \
	wget





