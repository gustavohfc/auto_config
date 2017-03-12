#!/bin/bash

find $1/home/ -type f -print0 | while IFS= read -r -d '' arquivo
do
  if [ -n "${arquivo/%*.git*/}" ]; then
    arquivo=`echo $arquivo | cut -f 1 -d / --complement | cut -f 1 -d / --complement`
    if [ -f ~/"$arquivo" ]; then
      if [ "`md5sum ~/"$arquivo" | cut -f 1 -d ' '`" == "`md5sum $1/home/"$arquivo" | cut -f 1 -d ' '`" ]; then
        echo "$arquivo - OK"
      else
        echo "$arquivo - Desatualizado *************************************************************"
      fi
    else
      echo "$arquivo - Arquivo nao encontrado ******************************************************"
    fi
  fi
done


exit 0
