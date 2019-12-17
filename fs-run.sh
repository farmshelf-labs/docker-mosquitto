#!/bin/bash

docker run \
    -v ${PWD}/auth-plugin.${MQTT_ENV}.conf:/etc/mosquitto.d/auth-plugin.conf \
    -v ${PWD}/mosquitto.pw:/mosquitto.pw \
    -v ${PWD}/mosquitto.conf:/etc/mosquitto/mosquitto.conf \
    -v ${PWD}/keys:/keys \
    -p 8883:8883 \
    -p 8083:8083 \
    -e DOMAIN=example.local \
    -e PORT=8080 \
    farmshelf/mqtt:latest