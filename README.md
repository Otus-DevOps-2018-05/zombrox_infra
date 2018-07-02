# zombrox_infra
zombrox Infra repository

testapp_IP=35.189.210.104
testapp_port=9292

############################################################################################
# startUp script content... :)
 
#!/bin/bash
git clone --branch cloud-testapp https://github.com/Otus-DevOps-2018-05/zombrox_infra.git
cd zombrox_infra
./install_ruby.sh 
./install_mongodb.sh
./deploy.sh 

############################################################################################

# gCloud command that create instance with local file startUp script
gcloud compute instances create reddit-app\
 --boot-disk-size=10GB \
 --image-family ubuntu-1604-lts \
 --image-project=ubuntu-os-cloud \
 --machine-type=g1-small \
 --tags puma-server \
 --restart-on-failure \
 --zone europe-west1-d \
 --metadata-from-file startup-script=startUp.sh

# gCloud command that create instance with URL file startUp script
gcloud compute instances create reddit-app\
 --boot-disk-size=10GB \
 --image-family ubuntu-1604-lts \
 --image-project=ubuntu-os-cloud \
 --machine-type=g1-small \
 --tags puma-server \
 --restart-on-failure \
 --zone europe-west1-d \
 --metadata startup-script-url=gs://zombrox_infra/startUp.sh

# gCloud command that create fireWall rule
gcloud compute firewall-rules create puma-server\
 --direction=in \
 --action=allow \
 --target-tags=puma-server \
 --source-ranges=0.0.0.0/0 \
 --rules=tcp:9292  

