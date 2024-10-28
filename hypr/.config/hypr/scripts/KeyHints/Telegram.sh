#!/bin/bash

# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Keyhints. Idea got from Garuda Hyprland

# Detect monitor resolution and scale
x_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
y_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .height')
hypr_scale=$(hyprctl -j monitors | jq '.[] | select (.focused == true) | .scale' | sed 's/\.//')

# Calculate width and height based on percentages and monitor resolution
width=$((x_mon * hypr_scale / 100))
height=$((y_mon * hypr_scale / 100))

# Set maximum width and height
max_width=1200
max_height=1000

# Set percentage of screen size for dynamic adjustment
percentage_width=70
percentage_height=70

# Calculate dynamic width and height
dynamic_width=$((width * percentage_width / 100))
dynamic_height=$((height * percentage_height / 100))

# Limit width and height to maximum values
dynamic_width=$(($dynamic_width > $max_width ? $max_width : $dynamic_width))
dynamic_height=$(($dynamic_height > $max_height ? $max_height : $dynamic_height))

# Launch yad with calculated width and height
yad --width=$dynamic_width --height=$dynamic_height \
    --center \
    --title="KeybindingsTelegram" \
    --no-buttons \
    --list \
    --column=Key: \
    --column=Description: \
    --timeout-indicator=bottom \
"Ctrl ↑" "Выбрать сообщения для быстрого ответа" \
"Esc" "Выход из чата или поиска / переход к общему поиску" \
"Ctrl L" "Заблокировать Telegram (если установлен пароль блокировки)" \
"Ctrl J" "Открыть Контакты	" \
"Alt Shift⠈" "Отметить все чаты под курсором как прочитанные	" \
"Ctrl R" "Отметить текущий чат прочитанным" \
"Alt ↑" "Переключение на следующий/предыдущий чат" \
"Ctrl Shift ↑" "Перемещение между папками	" \
"Ctrl 0" "Переход в «Избранное» (Cохранённые сообщения)	" \
"Ctrl 9" "Переход в Архив	" \
"Ctrl 1" "Переход в общий список чатов	" \
"Ctrl 2" "Переход в папку 1" \
"Ctrl 8" "Переход в последнюю папку	" \
"Ctrl F" "Поиск по открытому чату" \
"Ctrl Q" "Полностью закрыть Telegram" \
"Ctrl O" "Прикрепить файл для отправки" \
"Ctrl W" "Свернуть Telegram в systray" \
"Ctrl M" "Свернуть Telegram на панель задач" \
"Ctrl K" "Гиперссылка" \
"Ctrl B" "Выделить жирным" \
"Ctrl I" "Выделить курсивом" \
"Ctrl U" "Подчеркнуть	" \
"Ctrl Shift X" "Зачеркнуть" \
"Ctrl Shift M" "Моноширный шрифт (код)" \
"Ctrl Shift N" "Отменить форматирование	" \
"Del" "Удалить выбранные сообщения" \

