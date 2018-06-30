# zombrox_infra
zombrox Infra repository

# Выпоняем команды

echo -e "\nHost bastion\nHostname 35.206.171.215\nPort 22\nUser appuser\nIdentityFile ~/.ssh/appuser\nForwardAgent yes\n" >> ~/.ssh/config
echo -e "\nHost someinternalhost\nHostname 10.132.0.3\nUser appuser\nProxyCommand ssh -W %h:%p bastion\n" >> ~/.ssh/config
echo "alias someinternalhost='ssh someinternalhost'" >> ~/.bashrc

#Соединяемся с someinternalhost одной командой
someinternalhost

bastion_IP = 35.206.171.215
someinternalhost_IP = 10.132.0.3

