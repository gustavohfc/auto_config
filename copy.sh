#!/bin/bash

# Cria os diretorios necessarios
find $1/home/ -type d -print0 | while IFS= read -r -d '' diretorio
do
  diretorio=`echo $diretorio | cut -f 1 -d / --complement | cut -f 1 -d / --complement`
  if [ -n "$diretorio" ]; then
    if ! [ -d ~/"$diretorio" ]; then
      mkdir ~/"$diretorio"
    fi
  fi
done


# Copia os arquivos
find $1/home/ -type f -print0 | while IFS= read -r -d '' arquivo
do
  if [ -n "${arquivo/%*.git*/}" ]; then
    arquivo=`echo $arquivo | cut -f 1 -d / --complement | cut -f 1 -d / --complement`
    echo "$1/home/"$arquivo" -> ~/"$arquivo""
    cp $1/home/"$arquivo" ~/"$arquivo"
  fi
done

exit 0
