FROM neo4j

SHELL ["/bin/bash", "-c"]
#SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# install stuff
RUN apt update && apt install -y \ 
	vim \
	iputils-ping \
	wget \
	git

RUN ssh-keygen -t rsa -q -f "$HOME/.ssh/id_rsa" -N ""
COPY $HOME/.ssh/github* $HOME/.ssh/
COPY $HOME/.ssh/config $NOME/.ssh/






