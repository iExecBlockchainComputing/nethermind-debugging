
contract_address="0x8bf38d4764929064f2d4d3a56520a76ab3df415b"
echo "Contract address: $contract_address"
block_number="0x0"
echo "Block number: $block_number"
echo ""

echo "Openethereum:"

block_hash=`curl -s -X POST -H "Content-Type: application/json" --data '{"method":"eth_getBlockByNumber", "params":["0x0", false],"id":1, "jsonrpc":"2.0"}' <archive-url> | jq .result.hash`
echo "    Block hash: $block_hash"

for i in "0x0" "0x1" "0x2" "0x3" "0x4" "0x5" "0x6" "0x7"
do
    storage_value=`curl -s -X POST -H "Content-Type: application/json" --data '{"method":"eth_getStorageAt", "params":["'$contract_address'", "'$i'", "'$block_number'"],"id":1, "jsonrpc":"2.0"}' <archive-url> | jq .result`
    echo "    slot[$i]: $storage_value"
done

echo ""
echo "Nethermind"

block_hash=`curl -s -X POST -H "Content-Type: application/json" --data '{"method":"eth_getBlockByNumber", "params":["0x0", false],"id":1, "jsonrpc":"2.0"}' http://localhost:8545 | jq .result.hash`
echo "    Block hash: $block_hash"

for i in "0x0" "0x1" "0x2" "0x3" "0x4" "0x5" "0x6" "0x7"
do
    storage_value=`curl -s -X POST -H "Content-Type: application/json" --data '{"method":"eth_getStorageAt", "params":["'$contract_address'", "'$i'", "0x0"],"id":1, "jsonrpc":"2.0"}' http://localhost:8545 | jq .result`
    echo "    slot[$i]: $storage_value"
done

echo "\n\n"
echo "------------------------------------------------"
echo "Block $block_number proofs:"
storage_slots='"0x0000000000000000000000000000000000000000000000000000000000000000","0x0000000000000000000000000000000000000000000000000000000000000001","0x0000000000000000000000000000000000000000000000000000000000000002","0x0000000000000000000000000000000000000000000000000000000000000003","0x0000000000000000000000000000000000000000000000000000000000000004","0x0000000000000000000000000000000000000000000000000000000000000005","0x0000000000000000000000000000000000000000000000000000000000000006","0xc2575a0e9e593c00f959f8c92f12db2869c3395a3b0502d05e2516446f71f85b","0x405787fa12a823e0f2b7631cc41b3ba8828b3321ca811111fa75cd3aa3bb5ace","0x02b63b542159a40fc22bccc1c22949be481578dcd962925c4f49918dea5a19e9"'
# storage_slots='"0x0000000000000000000000000000000000000000000000000000000000000000"'

echo "$storage_slots"
echo "Openethereum"
curl -s -X POST \
    --header "Content-Type: application/json" \
    --data '{"id":1, "jsonrpc":"2.0", "method":"eth_getProof", "params":["0x8bf38d4764929064f2d4d3a56520a76ab3df415b", ['$storage_slots'], "'$block_number'"]}' http://localhost:9545 | jq .result

echo ""
echo "Nethermind"
curl -s -X POST \
    --header "Content-Type: application/json" \
    --data '{"id":1, "jsonrpc":"2.0", "method":"eth_getProof", "params":["0x8bf38d4764929064f2d4d3a56520a76ab3df415b", ['$storage_slots'], "'$block_number'"]}' http://localhost:8545 | jq .result


for addr in 0x0000000000000000000000000000000000000000 0x0000000000000000000000000000000000000001 0x0000000000000000000000000000000000000002 0x0000000000000000000000000000000000000003 0x0000000000000000000000000000000000000004 0x0000000000000000000000000000000000000005 0x0000000000000000000000000000000000000006 0x0000000000000000000000000000000000000007 0x0000000000000000000000000000000000000008 0x0000000000000000000000000000000000000009 0x44B318A63D2E69d4Cd6144B33B3e823Fa02Cec40 0x8bf38d4764929064f2d4d3a56520a76ab3df415b 0xe20d0531b804fe61caa614a1af9a15d2cccb6104 0xb3474eeaba26d8b700dbb7667a6f04c826a6523b 0xffffFFFfFFffffffffffffffFfFFFfffFFFfFFfE
do
    balance_oe=`curl -s -X POST \
        --header "Content-Type: application/json" \
        --data '{"id":1, "jsonrpc":"2.0", "method":"eth_getBalance", "params":["'$addr'", "0x0"]}' http://localhost:9545 | jq .result`
    nonce_oe=`curl -s -X POST \
        --header "Content-Type: application/json" \
        --data '{"id":1, "jsonrpc":"2.0", "method":"eth_getTransactionCount", "params":["'$addr'", "0x0"]}' http://localhost:9545 | jq .result`
    balance_nm=`curl -s -X POST \
        --header "Content-Type: application/json" \
        --data '{"id":1, "jsonrpc":"2.0", "method":"eth_getBalance", "params":["'$addr'", "0x0"]}' http://localhost:8545 | jq .result`
    nonce_nm=`curl -s -X POST \
        --header "Content-Type: application/json" \
        --data '{"id":1, "jsonrpc":"2.0", "method":"eth_getTransactionCount", "params":["'$addr'", "0x0"]}' http://localhost:8545 | jq .result`
    echo "$addr - OE <-> NM - balance: $balance_oe <-> $balance_nm - nonce: $nonce_oe <-> $nonce_nm"
done