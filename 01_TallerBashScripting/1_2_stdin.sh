#!/bin/bash

while read -r nombre
do
    echo "Nombre de virus: $nombre"
done < virus.txt
