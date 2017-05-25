#!/bin/bash

. scripts/shell_color.sh


function new_lines
{
  for i in $(seq 1 $1)
  do
    echo
  done
}


function make_tabs
{
  for i in $(seq 1 $tabs)
  do
    echo -ne "\t"
  done
}


function print_error
{
  #make_tabs
  echo -e "${Red}ERROR: $message ${RCol}"
  if [ "$parameters" != 'not exit' ]; then
    exit 1
  fi
}


function print_parameters
{
  new_lines 2
  tabs=1

  echo "Parametros:"
  make_tabs; echo "Maquina = $maquina"
  make_tabs; echo "Steps = $steps"
  make_tabs; echo "only_verify = $only_verify"
  make_tabs; echo "Backup files = $old_files_dir"

  new_lines 2
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


function print_script_output
{
  local IFS=$'\n'
  for line in $message
  do
    make_tabs
    echo -e "${Blu}$line ${RCol}"
  done
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
      echo -e "${Yel}WARNING: $message ${RCol}"
      ;;

    help)
      print_help
      ;;

    script_output)
      print_script_output
      ;;

    processing_file)
      make_tabs
      echo "Processando o arquivo ${message#"$CONF_FILES_SOURCE"}:"
      ;;

    executing)
      make_tabs
      echo -ne "$message ... "
      ;;

    normal)
      echo -e "$message"
      ;;

    parameters)
      print_parameters
      ;;

    *)
      echo -e "${Red}Comando invalido para o ac_print ${RCol}"

  esac
}
