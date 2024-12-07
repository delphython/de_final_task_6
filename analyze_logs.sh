#!/bin/bash

# while IFS= read -r line
# do
#   echo "$line"
# done < $1

# Проверяем, передан ли аргумент
if [ -z "$1" ]; then
    echo "Пожалуйста, укажите файл для анализа."
    exit 1
fi

# Считаем количество уникальных IP-адресов.
 awk '(NR > 1) {vals[$1]} END {print "количество уникальных IP-адресов:\t" length(vals)}' access.log