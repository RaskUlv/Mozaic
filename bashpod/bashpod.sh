#!/bin/bash

PODDIR="local podcast directory"
DEVICEDIR="device podcast directory"
SDIR=$(cd `dirname $0` && pwd)

notify-send 'Bashpod' 'Скачивание подкастов' ; podget -s --config bpconf --serverlist bpserverlist --dir_config "$SDIR" &&
notify-send 'Bashpod' 'Синхронизация с устройством' ; rsync -ruq --del "$PODDIR" "$DEVICEDIR" && notify-send 'Bashpod' 'Готово' || notify-send 'Bashpod' 'При работе возникли ошибки'
