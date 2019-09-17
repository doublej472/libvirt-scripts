#!/bin/sh
# Generate a simple, random MAC address
echo "52:54:00:$(openssl rand -hex 3 | sed 's/\(..\)/\1:/g; s/:$//')"
