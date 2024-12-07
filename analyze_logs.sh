#!/bin/bash

# Проверяем, передан ли аргумент
if [ -z "$1" ]; then
    echo "Пожалуйста, укажите файл для анализа."
    exit 1
fi

report_file="report.txt"

{
  echo "Отчет о логе веб сервера"
  echo "========================"

  # Считаем общее количество запросов.
  result_1="$(awk 'END {print "Общее количество запросов: " NR}' $1)"
  echo "$result_1"

  # Считаем количество уникальных IP-адресов.
  result_2="$(awk '(NR > 1) {vals[$1]} END {print "Количество уникальных IP-адресов: " length(vals)}' $1)"
  echo "$result_2"

  echo $'\n'

  # Подсчитать количество запросов по методам
  echo "Количество запросов по методам:"
  result_3="$(awk -F '"' 'NF>2 {print $2}' $1 | awk '{ a[$1]++ }END{ for(i in a) printf "   %s\t%s\n",a[i], i }')"
  echo "$result_3"

  echo $'\n'

  # Найти самый популярный URL
  result_4="$(awk -F '"' 'NF>2 {print $2}' $1 | awk '{ a[$2]++ }END{ for(i in a) printf "%s %s\n",a[i], i }' | awk 'BEGIN {max = 0} {if ($1>max) max=$1} END {printf "Самый популярный URL:\t%s %s\n", max, $2}')"
  echo "$result_4"
} 2>&1 | tee -- "$report_file"