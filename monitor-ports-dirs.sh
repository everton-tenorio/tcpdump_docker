#!/bin/bash
# author: Everton Tenorio

# Definição das cores
RED="\033[1;31m"
YELLOW="\033[1;33m"
CYAN="\033[1;36m"
RESET="\033[0m"

# lsof -i tcp -nP| awk 'NR==1 {print $1, $2, $3, $5, $8, $9; next} 1 == 1 {print $1, $2, $3, $5, $8, $9}'

# Cabeçalho da saída com cores aplicadas
echo -e "COMMAND\t${RED}PID${RESET}\tUSER\tTYPE\tNODE\t${YELLOW}NAME${RESET}\t${CYAN}CAMINHO${RESET}"

# Obter a lista de conexões TCP e formatar a saída com awk
lsof -i tcp -nP | awk 'NR==1 {next} 1 == 1 {print $1, $2, $3, $5, $8, $9}' | while read -r line
do
  # Extrair o PID da linha atual
  pid=$(echo $line | awk '{print $2}')

  # Obter o diretório de trabalho do PID usando pwdx
  caminho=$(pwdx $pid 2>/dev/null | awk '{print $2}')

  # Adicionar o caminho à linha e imprimir
  echo -e "$(echo $line | awk -v red="$RED" -v cyan="$CYAN" -v yellow="$YELLOW" -v reset="$RESET" '{printf "%s\t" red "%s" reset "\t%s\t%s\t%s\t" yellow "%s" reset, $1, $2, $3, $4, $5, $6}')\t${CYAN}${caminho}${RESET}"
done
