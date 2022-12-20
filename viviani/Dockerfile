####
# docker image build --build-arg NM_TAG=... -t viviani-nm-fullnode .
####

ARG NM_TAG

FROM nethermind/nethermind:${NM_TAG}

# USER root

WORKDIR /iexec/fullnode

# Viviani
COPY spec.json spec.json
COPY bootnodes.json bootnodes.json
COPY node.cfg node.cfg

ENTRYPOINT [ "/nethermind/Nethermind.Runner" ]
CMD [ "--config=/iexec/fullnode/node.cfg" ]
