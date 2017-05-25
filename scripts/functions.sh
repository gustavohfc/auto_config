#!/bin/bash

# Confere se os parametros sao validos e coloca o valor padrao nos parametros que nao foram passados
function confere_parametros
{
  # Parametro maquina
  if [ -z "$maquina" ]; then
    print 'help'
    print 'error' "O parametro maquina e' obrigatorio."
  fi
  if [ "$maquina" != "note" ] && [ "$maquina" != "pc" ]; then
    print 'help'
    print 'error' "Parametro maquina invalido ($maquina)"
  fi

  # Parametro steps
  if [ -z "$steps" ]; then
    readonly steps=' pre main pos '
  else
    for step in $steps
    do
      if [ ! -z "${VALID_STEPS##*" $step "*}" ]; then
        print 'help'
        print 'error' "Valor invalido no parametro steps ($step)."
      fi
    done
  fi
}


# Funcao main para restringir o escopo das variaveis
function main
{
  find "$CONF_FILES_SOURCE" -type f -print0 | while IFS= read -r -d $'\0' file
  do
    local source_file="$file"
    local destination_file="$CONF_FILES_DESTINATION${source_file#"$CONF_FILES_SOURCE"}"

    ac_print 'processing_file' "$source_file"

    # Faz o parser se necessario
    if [ "$(head -c ${#CONFIG_PARSER_FLAG} "$source_file")" == "$CONFIG_PARSER_FLAG" ]; then
      parser "$source_file"
    fi


    #if [ "$(head -c ${#CONFIG_PARSER_FLAG} "$file")" == "$CONFIG_PARSER_FLAG" ]; then
    #else
    #fi

    echo $source_file
    echo $destination_file
  done
}


function parser
{
  echo a - $source_file
  echo a - $destination_file
  source_file="$1"
  echo a - $source_file
}




function verifica_arquivo
{
  file="$1"
}


# Roda os scripts da pasta ./scripts/"$1"
function run_scripts
{
  if [ "$#" -ne 1 ]; then
    print 'error' "Numero de parametros invalido na funcao run_scripts ($#)"
  fi


  find "./scripts/$1" -name "[!.]*" -type f -print0 | while IFS= read -r -d $'\0' script
  do
    ac_print 'executing_script' "$script" '1'
    bash $script
    if [ $? -eq 0 ]; then
      ac_print 'ok'
      ac_print 'script_output' "$out" '3'
    else
      echo mmmmmm
      ac_print 'error' "Valor retornado = $?" '' 'not_exit'
      echo pppppp
      ac_print 'script_output' "$out" '3'
      echo aaaaa
      exit 1
    fi
  done
}
