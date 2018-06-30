# zombrox_infra
zombrox Infra repository

cat <<EOF >> ~/.ssh/config

Host bastion
Hostname 35.206.171.215
Port 22
User appuser
IdentityFile ~/.ssh/appuser
ForwardAgent yes

Host someinternalhost
Hostname 10.132.0.3
User appuser
ProxyCommand ssh -W %h:%p bastion

EOF

cat <<EOF >> ~/.bashrc
alias someinternalhost='ssh someinternalhost'

EOF


#Соединяемся с someinternalhost одной командой
someinternalhost

bastion_IP = 35.206.171.215
someinternalhost_IP = 10.132.0.3

