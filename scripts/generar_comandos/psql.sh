#!/bin/bash

# Uso:
#   ./psql.sh carpeta/del/env
# Genera el comando psql para conectarse a la base de datos PostgreSQL

if [ -z "$1" ]; then
	echo "ERROR: Debe pasar la carpeta donde está el archivo .env como primer parámetro."
	echo "PWD: $(pwd)"
	echo "Ejemplo: ./psql.sh ./mi-carpeta"
	exit 1
fi

source "$(dirname "$0")/../shared/validate-and-load.sh" "$1"

echo "psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@localhost:5432/$POSTGRES_DB"

