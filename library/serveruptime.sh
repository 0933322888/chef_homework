#!/usr/bin/env bash

SERVER_UPTIME=$(uptime -s)

echo "{\"uptime\": \"$SERVER_UPTIME\"}"