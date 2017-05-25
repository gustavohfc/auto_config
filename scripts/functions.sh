#!/bin/bash

# Confere se os parametros sao validos e coloca o valor padrao nos parametros que nao foram passados
function confere_parametros
{
  # Parametro maquina
  if [ -z "$maquina" ]; then
    ac_print 'help'
    ac_print 'error' "O parametro maquina e' obrigatorio."
  fi
  if [ "$maquina" != "note" ] && [ "$maquina" != "pc" ]; then
    ac_print 'help'
    ac_print 'error' "Parametro maquina invalido ($maquina)"
  fi

  # Parametro steps
  if [ -z "$steps" ]; then
    if [ "$only_verify" = true ]; then
      readonly steps=' main '
    else
      readonly steps=' pre main pos '
    fi
  else
    for step in $steps
    do
      if [ ! -z "${VALID_STEPS##*" $step "*}" ]; then
        ac_print 'help'
        ac_print 'error' "Valor invalido no parametro steps ($step)."
      fi
    done
  fi

  readonly old_files_dir="old_files/$(date +"%Y_%m_%d_%H_%M_%S")"
}


# Funcao main para restringir o escopo das variaveis
function main
{
  ac_print 'normal' "Rodando main:" '0'


  while IFS= read -r -d '' file
  do
    local source_file_path="$file"
    local destination_file_path="$CONF_FILES_DESTINATION${source_file_path#"$CONF_FILES_SOURCE"}"
    local filename=${source_file_path##*/}

    ac_print 'processing_file' "$source_file_path" '1'

    # Faz o parser se necessario
    if [ "$(head -c ${#CONFIG_PARSER_FLAG} "$source_file_path")" == "$CONFIG_PARSER_FLAG" ]; then
      ac_print 'executing' "${Yel}Executando o parser" '2'
      #parser "$source_file_path"
      #source_file_path="$PARSER_TEMP_FILE"
      ac_print 'ok'
      parsed_file="$PARSER_TEMP_FILE"
    else
      parsed_file="$source_file_path"
    fi

    # Verifica se tem alteracao no arquivo
    verify
    if [ "$?" -eq 1 ]; then
      diff
      if [ "$only_verify" != true ]; then
        backup_old_file
        update_file
      fi
    fi

    new_lines 2
  done < <(find "$CONF_FILES_SOURCE" -type f -print0)

  new_lines 3
}


function update_file
{
  ac_print 'executing' 'Atualizando o arquivo.' '2'

  cp "$source_file_path" "$destination_file_path"
  if [ "$?" -ne 0 ]; then
    ac_print 'error' "Valor retornado pelo cp = $retorno"
  fi

  echo -e "${Gre}Atualizado ${RCol}"
}


function diff
{
  ac_print 'executing' 'Fazendo o diff do arquivo' '2'

  local file_type="$(file --mime-type -b "$source_file_path")"
  if [ "$file_type" != "text/plain" ]; then
    ac_print 'warning' "Tipo de arquivo ("$file_type") nao suporta diff."
    return
  fi

  local diff_output=$(git diff --color-words --no-index "$destination_file_path" "$source_file_path")

  if [ "$only_verify" != true ]; then
    echo -e "$diff_output\n\n\n\n\n" >> "$old_files_dir/$DIFF_FILE_NAME"
  fi

  ac_print 'ok'

  if [ "$show_diff" = true ]; then
    ac_print 'script_output' "$diff_output" '3'
  fi
}


function backup_old_file
{
  ac_print 'executing' 'Fazendo backup do arquivo antigo' '2'

  mkdir -p "$old_files_dir"
  if [ "$?" -ne 0 ]; then
    ac_print 'error' "Valor retornado pelo mkdir = $retorno"
  fi

  cp "$destination_file_path" "$old_files_dir/$filename"
  if [ "$?" -ne 0 ]; then
    ac_print 'error' "Valor retornado pelo cp = $retorno"
  fi

  ac_print 'ok'
}


function verify
{
  set -x
  ac_print 'executing' 'Comparando os arquivos' '2'

  local md5_source=$(md5sum "$parsed_file" 2>/dev/null)
  if [ -z "$md5_source" ]; then
    ac_print 'error' "Arquivo fonte nao encontrado ($parsed_file)."
  fi

  local md5_destination=$(md5sum "$destination_file_path" 2>/dev/null)
  if [ -z "$md5_destination" ]; then
    ac_print 'warning' "O arquivo de destino ainda nao existe."
    make_path_file
    return 1
  fi

  if [ "$md5_source" == "$md5_destination" ]; then
    echo -e "${Gre}Aquivo ja atualizado. ${RCol}"
    return 0
  else
    echo -e "${Yel}Arquivo desatualizado. ${RCol}"
    return 1
  fi
  set +x
}


function make_path_file
{
  ac_print 'executing' 'Criando caminho e arquivo' '3'

  mkdir_output=$(mkdir -pv "${destination_file_path%"$filename"}")
  local retorno="$?"
  if [ "$retorno" -ne 0 ]; then
    ac_print 'error' "Valor retornado pelo mkdir = $retorno" 'not exit'
    ac_print 'script_output' "$mkdir_output" '4'
    exit 1
  fi

  touch "$destination_file_path"
  local retorno="$?"
  if [ "$retorno" -ne 0 ]; then
    ac_print 'error' "Valor retornado pelo touch = $retorno"
  fi

  ac_print 'ok'
  ac_print 'script_output' "$mkdir_output" '4'
  ac_print 'script_output' "touch: foi criado o arquivo $destination_file_path" '4'
}


function parser
{
  echo a
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

  ac_print 'normal' "Rodando scripts (scripts/$1):" '0'

  while IFS= read -r -d '' script
  do
    ac_print 'executing' "Executando o script ${script#'./'}" '1'
    local script_output=$(bash "$script")
    local retorno="$?"
    if [ $retorno -eq 0 ]; then
      ac_print 'ok'
      ac_print 'script_output' "$script_output" '2'
    else
      ac_print 'error' "Valor retornado = $retorno" 'not exit'
      ac_print 'script_output' "$script_output" '2'
      exit 1
    fi
  done < <(find "./scripts/$1" -name "[!.]*" -type f -print0)

  new_lines 3
}
