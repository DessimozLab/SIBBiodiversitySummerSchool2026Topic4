#!/bin/sh

docker run -u $(id -u) -v $(pwd):/busco_wd ezlabgva/busco:v6.1.0_cv1 busco -i ./Aptenodytes_forsteri.fa -m proteins