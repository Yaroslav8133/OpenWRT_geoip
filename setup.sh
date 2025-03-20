#!/bin/sh

# Создание файла check_and_download.sh
cat << 'EOF' > /tmp/check_and_download.sh
#!/bin/sh

# Путь к файлам
GEOIP_FILE="/usr/share/xray/geoip.dat"
GEOSITE_FILE="/usr/share/xray/geosite.dat"

# Проверка файла geoip.dat
if [ ! -f "$GEOIP_FILE" ] || [ ! -s "$GEOIP_FILE" ]; then
  /usr/bin/curl -L -H "Accept: application/octet-stream" -o "$GEOIP_FILE" "https://raw.githubusercontent.com/runetfreedom/russia-v2ray-rules-dat/release/geoip.dat"
fi

# Проверка файла geosite.dat
if [ ! -f "$GEOSITE_FILE" ] || [ ! -s "$GEOSITE_FILE" ]; then
  /usr/bin/curl -L -H "Accept: application/octet-stream" -o "$GEOSITE_FILE" "https://raw.githubusercontent.com/runetfreedom/russia-v2ray-rules-dat/release/geosite.dat"
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
