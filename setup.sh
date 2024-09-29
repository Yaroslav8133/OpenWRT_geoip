#!/bin/sh

# Создание файла check_and_download.sh
cat << 'EOF' > /tmp/check_and_download.sh
#!/bin/sh

# Путь к файлам
GEOIP_FILE="/usr/share/xray/geoip.dat"
LOYALSOLDIER_FILE="/usr/share/xray/LoyalsoldierSite.dat"

# Проверка файла geoip.dat
if [ ! -f "$GEOIP_FILE" ] || [ ! -s "$GEOIP_FILE" ]; then
  /usr/bin/curl -L -H "Accept: application/octet-stream" -o "$GEOIP_FILE" "https://github.com/1andrevich/antifilter-geoip/releases/latest/download/geoip.dat"
fi

# Проверка файла LoyalsoldierSite.dat
if [ ! -f "$LOYALSOLDIER_FILE" ] || [ ! -s "$LOYALSOLDIER_FILE" ]; then
  /usr/bin/curl -L -H "Accept: application/octet-stream" -o "$LOYALSOLDIER_FILE" "https://github.com/1andrevich/antifilter-domain/releases/latest/download/geosite.dat"
fi
EOF

# Даем права на выполнение
chmod +x /tmp/check_and_download.sh

# Добавление в crontab, если такой записи еще нет
CRON_JOB="* * * * * /tmp/check_and_download.sh"
if ! crontab -l | grep -qF "$CRON_JOB"; then
    (crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -
fi

# Сообщение об установке
echo "Скрипт успешно установлен и добавлен в cron" | tee /dev/tty
