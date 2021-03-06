#!/bin/sh

shift 1

WIFI_ACCESS_POINT_SSID=${1?"WIFI_ACCESS_POINT_SSID has not been set."}
WIFI_ACCESS_POINT_CHANNEL=${2?"WIFI_ACCESS_POINT_CHANNEL has not been set."}
WIFI_ACCESS_POINT_PSK=${3?"WIFI_ACCESS_POINT_PSK has not been set."}

sed -e "s/WIFI_ACCESS_POINT_SSID/${WIFI_ACCESS_POINT_SSID}/" \
    -e "s/WIFI_ACCESS_POINT_CHANNEL/${WIFI_ACCESS_POINT_CHANNEL}/" \
    -e "s/WIFI_ACCESS_POINT_PSK/${WIFI_ACCESS_POINT_PSK}/" \
    -i ${TARGET_DIR}/etc/hostapd.conf
