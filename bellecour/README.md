# nethermind-debugging

### Issue description:

We're having an other issue, we're trying to sync Nethermind with our production sidechain (Bellecour) but we're encountering the error `Processed block is not valid`.
According to the logs, it seems like a gas calculation difference.
```
2022-11-08 02:49:14.8539|  hash 0xe33ed5b6b10fd3865391d96677fe3961991dfe7b1e74b6fd27761bfa48f820c1 != stated hash 0x5ce3a0e578a1fe2c9bec189de3d544a1c494deb062fce409c1cf167312d50e7c 
2022-11-08 02:49:14.8539|  gas used 491486 != stated gas used 495686 (-4200 difference) 
2022-11-08 02:49:14.8539|  receipts root 0x097024a815877f9318b47941108cc2ac7001410c8428280607748a035473f040 != stated receipts root 0x3648ac6cc05a0f719f027165393c102fe9dc47cd2c183233ad44d83b05acd5aa 
2022-11-08 02:49:14.8539|Processed block is not valid 4458548 (0x5ce3a0e578a1fe2c9bec189de3d544a1c494deb062fce409c1cf167312d50e7c) 
```

Here are the specs of the chain:
* Genesis: https://github.com/iExecBlockchainComputing/poa-chain-spec/blob/bellecour/spec.json
* RPC: https://bellecour.iex.ec
* Explorer: https://blockscout-bellecour.iex.ec/


The concerned block is 4458548: https://blockscout-bellecour.iex.ec/blocks/4458548/transactions. More info can be found in:
* `debug/NM-fullnode.log` for the client logs.
* `debug/NM-container-env-dump.env` for the list of env variables in the container.
* `debug/OE-invalid-block-trace.json` for the `trace_replayBlockTransactions` RPC call response.