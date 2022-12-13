#!/bin/sh

if [ ! -f .env ]; then
    echo "No .env file!"
    exit 1
fi

export $(grep -v '^#' .env | xargs)

# BLOCKNUMBER=4458548
BLOCKNUMBER=4515242
HEX_BLOCKNUMBER='0x'`printf '%x\n' $BLOCKNUMBER`

curl -s \
    -X POST \
    -H "Content-Type: application/json" \
    --data '{"id":1, "jsonrpc":"2.0", "method":"trace_block", "params":["'$HEX_BLOCKNUMBER'"]}' \
    $ARCHIVE_RPC | jq > debug/OE-trace_block-$BLOCKNUMBER.json

curl -s \
    -X POST \
    -H "Content-Type: application/json" \
    --data '{"id":1, "jsonrpc":"2.0", "method":"trace_replayBlockTransactions", "params":["'$HEX_BLOCKNUMBER'", ["vmTrace", "trace", "stateDiff"]]}' \
    $ARCHIVE_RPC | jq > debug/OE-trace_replayBlockTransactions-$BLOCKNUMBER.json
