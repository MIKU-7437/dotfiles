#!/usr/bin/env bash

# # Получить номер активного рабочего стола
# # Выдается от 1 до N
get_active_workspace() {
    echo $(hyprctl activeworkspace -j| jq '.id')
}

# Получить номер рабочего стола по умолчанию для терминала CUSTOMVOLUME
# выдается от 0 до N
get_customdate_workspace() {
    number=$(hyprctl clients -j | jq -r '.[] | select(.title == "CUSTOMDATE").workspace.id')
    echo $number
}



# # Проверка на существование процесса с именем окна CUSTOMDATE
if pgrep -f "kitty.*CUSTOMDATE" > /dev/null; then
    DATE_WORKSPACE=$(get_customdate_workspace)
else
    DATE_WORKSPACE=-1
fi

ACTIVE_WORKSPACE=$(get_active_workspace)
echo $DATE_WORKSPACE
echo $ACTIVE_WORKSPACE

# # если терминал не найден то мы его создаем
if [ $DATE_WORKSPACE == -1 ]; then
    kitty --title CUSTOMDATE -e calcurse &
# если они назодятся в одном окне то закрываем все
elif [[ $DATE_WORKSPACE == $ACTIVE_WORKSPACE ]]; then
    kill $(pgrep -f "kitty.*CUSTOMDATE")
# если терминал существет но окна разные. то мы удаляем все существующие и создаем этот терминал в этом окне
else
    pgrep -f "kitty.*CUSTOMDATE" > /dev/null && kill $(pgrep -f "kitty.*CUSTOMDATE")
    kitty --title CUSTOMDATE -e calcurse &
fi
