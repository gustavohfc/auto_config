#!/bin/bash
set -e

. scripts/functions.sh
. scripts/shell_color.sh
. scripts/print.sh


readonly CONFIG_PARSER_FLAG='{{{ config_parser }}}'
readonly CONF_FILES_SOURCE='./home/'
#readonly CONF_FILES_DESTINATION='~/'
readonly CONF_FILES_DESTINATION='./teste/home/'
readonly PARSER_TEMP_FILE='/tmp/auto_config_temp_file_parser.tmp'
readonly DIFF_FILE_NAME='DIFF'
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
      local temp="${parametro#"steps="}"
      readonly steps=" ${temp//,/ } "
      if [ -z "$steps" ]; then
        ac_print 'error' "O parametro steps nao pode ser vazio."
      fi
      ;;

    only_verify)
      readonly only_verify=true
      ;;

    show_diff)
      readonly show_diff=true
      ;;

    *)
      ac_print 'help'
      ac_print 'error' "Parametro desconhecido($parametro)"

  esac
done

confere_parametros
ac_print 'parameters'

if [ -z "${steps##*" pre "*}" ]; then
  run_scripts 'pre'
fi

if [ -z "${steps##*" main "*}" ]; then
  main
fi

if [ -z "${steps##*" pos "*}" ]; then
  run_scripts 'pos'
fi
