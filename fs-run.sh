#!/bin/bash

docker run \
    -v ${PWD}/auth-plugin.conf:/etc/mosquitto.d/auth-plugin.conf \
    -v ${PWD}/mosquitto.pw:/mosquitto.pw \
    -v ${PWD}/mosquitto.conf:/etc/mosquitto/mosquitto.conf \
    -v ${PWD}/keys:/keys \
    -p 1883:1883 \
    -p 8883:8883 \
    -p 9883:9883 \
    -e DOMAIN=example.local \
    -e PORT=8080 \
    farmshelf/mqtt:latest