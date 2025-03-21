# Обновление GeoIP и Geosite для xray на OpenWRT

## Описание
Этот скрипт предназначен для автоматического обновления файлов GeoIP и Geosite, необходимых для работы VPN на роутере с установленным OpenWRT. 
В качестве источника фаилов используются:
https://raw.githubusercontent.com/runetfreedom/russia-v2ray-rules-dat/release/geoip.dat
и
https://raw.githubusercontent.com/runetfreedom/russia-v2ray-rules-dat/release/geosite.day

### Зачем это нужно
Файлы `geoip.dat` и `geosite.dat` являются критически важными для корректной работы VPN.

### Крон-задача
Скрипт создает задачу cron, которая проверяет наличие файлов каждую минуту. Если файл отсутствует или пустой, он будет загружен заново.

## Как запустить скрипт

Чтобы запустить скрипт, выполните следующие шаги:

1. Откройте терминал на вашем устройстве с установленным OpenWRT.
2. Скачайте и запустите скрипт с помощью следующей команды:

   ```sh
   bash <(curl -s https://raw.githubusercontent.com/Yaroslav8133/OpenWRT_geoip/main/setup.sh)
