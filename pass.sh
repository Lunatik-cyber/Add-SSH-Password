sudo cp /etc/ssh/sshd_config{,.bak}
sed -i "/PasswordAuthentication no/d" /etc/ssh/sshd_config
echo "
LoginGraceTime 120
PermitRootLogin yes
StrictModes yes
PasswordAuthentication yes" >> /etc/ssh/sshd_config
echo "Введите пароль, он будет невидимый при вводе не пугайтесь."
passwd root
sudo systemctl reload ssh
