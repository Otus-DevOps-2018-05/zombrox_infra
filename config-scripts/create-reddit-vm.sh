#!/bin/bash

gcloud compute instances create reddit-full\
 --boot-disk-size=10GB\
 --image-family reddit-full\
 --machine-type=g1-small\
 --tags puma-server\
 --restart-on-failure\
 --zone europe-west1-d\

#################################################
# --metadata-from-file startup-script=startUp.sh\
# --image-project=ubuntu-os-cloud\
