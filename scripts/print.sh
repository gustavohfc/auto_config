#!/bin/bash

. scripts/shell_color.sh


function new_lines
{
  for i in $(seq 0 $1)
  do
    echo
  done
}


function make_tabs
{
  for i in $(seq 0 $tabs)
  do
    echo -ne "\t"
  done
}


function print_error
{
  make_tabs
  echo -e "${Red}ERROR: $message ${RCol}"
  if [ "$parameters" != 'not exit' ]; then
    exit 1
  fi
}


function print_warning
{
  echo -e "${Yel}WARNING: $message ${RCol}"
}


function print_help
{
  echo 'Uso: ./auto_config.sh maquina [steps]'
  echo
  echo "parametros:"
  echo "  maquina:"
  echo "    Parametro obigatorio, deve ter o valor 'pc' ou 'note'"
  echo
  echo "  steps:"
  echo "    Lista de passos que o programa ira executar, os possiveis passos sao pre, main e pos, nao teve ter espacos no parametro"
  echo "    O valor padrao e' steps=pre,main,pos"
  echo
}


function ac_print
{
  message_type="$1"
  message="$2"
  tabs="$3"
  parameters="$4"


  case "$message_type" in

    ok)
      echo -e "${Gre}OK ${RCol}"
      ;;

    error)
      print_error
      ;;

    warning)
      print_warning
      ;;

    help)
      print_help
      ;;

    script_output)
      ;;

    processing_file)
      echo "Processando o arquivo ${message#"$CONF_FILES_SOURCE"}:"
      ;;

    executing_script)
      echo -n "Executando o script ${message#'./'} ... "
      ;;

  esac
}
