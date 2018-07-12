#!/bin/bash

cat  <<EOF > puma.service
[Unit]
Description=Puma
Requires=network-online.target
After=network.target
[Service]
WorkingDirectory=/home/appuser/reddit
ExecStart=/usr/local/bin/puma
Restart=always
[Install]
WantedBy=multi-user.target
EOF

sudo mv puma.service /etc/systemd/system/
sudo chown  root:root /etc/systemd/system/puma.service
sudo  chmod 644 /etc/systemd/system/puma.service

sudo systemctl daemon-reload
sudo systemctl enable puma
