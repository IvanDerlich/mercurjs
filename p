#!/bin/bash
# Acceso directo para generar el comando psql con los datos del .env
# Modifica ENV_DIR para apuntar a la carpeta donde está tu .env

ENV_DIR="."

# Llama al generador de comando psql
"$(dirname "$0")/scripts/generar_comandos/psql.sh" "$ENV_DIR"
