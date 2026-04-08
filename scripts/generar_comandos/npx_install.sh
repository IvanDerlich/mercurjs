#!/bin/bash

# Uso:
# ./npx_install.sh carpeta/del/env
# Genera el comando npx para crear el proyecto mercurjs con la URL de conexión

set -e

PROJECT_NAME="my-marketplace"

if [ -z "$1" ]; then
  echo "ERROR: Debe pasar la carpeta donde está el archivo .env como primer parámetro."
  echo "PWD: $(pwd)"
  echo "Ejemplo: ./npx_install.sh ./mi-carpeta"
  exit 1
fi

source "$(dirname "$0")/../shared/validate-and-load.sh" "$1"

DB_URL="postgresql://postgres:$POSTGRES_PASSWORD@localhost:5432/$POSTGRES_DB"

echo "bunx @mercurjs/cli@$MERCURJS_VERSION create $PROJECT_NAME --template basic --skip-email --db-connection-string \"$DB_URL\""
