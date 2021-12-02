#!/bin/bash

# Автор : https://github.com/Lunatik-cyber 
# Author: https://github.com/Lunatik-cyber
# Репо. : https://github.com/Lunatik-cyber/password
# Repo. : https://github.com/Lunatik-cyber/password


# Проверка на наличие прав для запуска скрипта
# Checking for permissions to run the script
[[ $EUID != 0 ]] && echo "Запустите скрипт данной командой: sudo bash $0" && echo "Run the script with this command: sudo bash $0" && exit 1


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

# Очистка терминала
# Cleaning the terminal
clear

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
