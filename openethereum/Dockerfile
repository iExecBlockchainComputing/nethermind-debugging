###
# docker image build -t bellecour-oe-fullnode .
###

FROM openethereum/openethereum:v3.3.3

USER root

WORKDIR /iexec/fullnode

# Download spec.json file
RUN wget "https://raw.githubusercontent.com/iExecBlockchainComputing/poa-chain-spec/645897f70be92ff1574263c5bffc2a24441d16b6/spec.json"

# Download bootnodes.txt file
RUN wget "https://raw.githubusercontent.com/iExecBlockchainComputing/poa-chain-spec/645897f70be92ff1574263c5bffc2a24441d16b6/bootnodes.txt"

# Copy node.toml file
COPY node.toml node.toml

ENTRYPOINT [ "/home/openethereum/openethereum" ]
CMD [ "--config=node.toml", "--jsonrpc-interface=all" ]