#!/bin/bash

# Проверяем, передан ли аргумент
if [ -z "$1" ]; then
    echo "Пожалуйста, укажите файл для анализа."
    exit 1
fi

echo "Отчет о логе веб сервера"
echo "========================"

# Считаем общее количество запросов.
awk 'END {print "Общее количество запросов:\t" NR}' $1

# Считаем количество уникальных IP-адресов.
awk '(NR > 1) {vals[$1]} END {print "Количество уникальных IP-адресов:\t" length(vals)}' $1

echo $'\n'

# Подсчитать количество запросов по методам
echo "Количество запросов по методам:"
awk -F '"' 'NF>2 {print $2}' $1 | awk '{ a[$1]++ }END{ for(i in a) printf "   %s\t%s\n",a[i], i }'

echo $'\n'

# Найти самый популярный URL
awk -F '"' 'NF>2 {print $2}' access.log | awk '{ a[$2]++ }END{ for(i in a) printf "%s %s\n",a[i], i }' | awk 'BEGIN {max = 0} {if ($1>max) max=$1} END {printf "Самый популярный URL:\t%s %s\n", max, $2}'