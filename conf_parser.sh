#!/bin/bash

maquina="$1"
source_file="$2/source_conf"
conf_link="$2/conf_link"
conf_file_path=`readlink $2/conf_link | cut -f 1 -d / --complement`


# Limpa o arquivo
echo "" > $conf_link

while IFS='' read -r linha || [[ -n "$linha" ]]
do
  inicio_linha=${linha:0:4}
  if [ "$inicio_linha" == "##< " ]; then
    maquina_linha=`echo ${linha:4} | cut -f 1 -d ' '`
    if [ "$maquina_linha" == "$maquina" ]; then
      echo "$linha" | cut -f 1 -d '>' --complement | sed 's/^ *//' >> "$conf_link"
    fi
  else
    echo "$linha" >> "$conf_link"
  fi
done < $source_file


# Substitui a configuracao
if [ "`md5sum ~/"$conf_file_path" | cut -f 1 -d ' '`" != "`md5sum $2/home/"$conf_file_path" | cut -f 1 -d ' '`    " ]; then
  cp ~/"$conf_file_path" "$2"/conf_old
  cp "$2"/home/"$conf_file_path" ~/"$conf_file_path"
  echo "Arquivo de configuracao substituido"
else
  echo "Nao foi necessario substituir o arquivo de configuracao"
fi

exit 0
