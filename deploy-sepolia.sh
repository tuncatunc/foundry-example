#!/bin/bash
RPC_URL="https://eth-sepolia.g.alchemy.com/v2/9r4y9zWr2Oo7Yj4aFbT-4JMOhFkX1wtT"
PRIVATE_KEY=69d4137adac9577c5d7cb9e4b0b9e38b592382feaeb7e4da8e46953c74bcc909
forge script script/Counter.s.sol:CounterScript -vvvvv --fork-url $RPC_URL --private-key $PRIVATE_KEY --broadcast
