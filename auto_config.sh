#!/bin/bash
. scripts/functions.sh
. scripts/shell_color.sh
. scripts/print.sh


readonly CONFIG_PARSER_FLAG='{{{ config_parser }}}'
readonly CONF_FILES_SOURCE='./home/'
#readonly CONF_FILES_DESTINATION='~/'
readonly CONF_FILES_DESTINATION='./teste/home/'
readonly PARSER_TEMP_FILE='/tmp/auto_config_temp_file_parser.tmp'
readonly VALID_STEPS=' pre main pos '
readonly VALID_MAQUINAS=' pc note '

# Trata os parametros
for parametro in "$@"
do
  case "$parametro" in

    pc|note)
      if [ ! -z "$maquina" ]; then
        ac_print 'error' "Maquina definida duas vezes."
      fi
      readonly maquina="$parametro"
      ;;

    steps=*)
      if [ ! -z "$steps" ]; then
        ac_print 'error' "Steps definido duas vezes."
      fi
      temp="${parametro#"steps="}"
      readonly steps=" ${temp//,/ } "
      if [ -z "$steps" ]; then
        ac_print 'error' "O parametro steps nao pode ser vazio."
      fi
      ;;

    *)
      ac_print 'help'
      ac_print 'error' "Parametro desconhecido($parametro)"

  esac
done

confere_parametros

echo $steps
if [ -z "${steps##*" pre "*}" ]; then
  echo pre
  run_scripts 'pre'
fi

if [ -z "${steps##*" main "*}" ]; then
  echo a
  #main
fi

if [ -z "${steps##*" pos "*}" ]; then
  run_scripts 'pos'
fi
