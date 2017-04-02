#!/bin/bash

# Nome de todas aplicacoes q podem ser configuradas, deixar espaco no inicio e
# no final da string.
aplicacoes=" i3 vim i3blocks bashrc tmux zshrc powerline_config powerline_colors powerline_themes powerline_themes_shell powerline_themes_tmux powerline_themes_vim dircolors "

# Confere os parametros
if [ "$#" -ne 3 ]; then
  echo "USO: ./auto_config <maquina> <conf | verify | copy> <all | nome>."
  exit
elif [ "$1" != "note" ] && [ "$1" != "estagio" ] && [ "$1" != "pc" ]; then
  echo "Maquina invalida."
  exit
fi

if [[ $aplicacoes =~ " $3 " ]]; then
  aplicacoes=$3
elif [ "$3" != "all" ]; then
  echo "Aplicacao invalida"
  exit
fi


# Configura todos as aplicacoes selecionadas
for i in $aplicacoes
do
  if [ "$2" == "conf" ]; then
    echo -e "\n\n\nConfigurando $i"
    bash ./conf_parser.sh $1 $i
  elif [ "$2" == "verify" ]; then
    echo -e "\n\n\nVerificando $i"
    bash ./verify.sh $i
  elif [ "$2" == "copy" ]; then
    echo -e "\n\n\nCopiando $i"
    bash ./copy.sh $i
  else
    echo "Operacao invalida ($2) - $i"
  fi

  if [ $? -ne 0 ]; then
    echo ERRO
    exit 1
  fi
done

exit 0
