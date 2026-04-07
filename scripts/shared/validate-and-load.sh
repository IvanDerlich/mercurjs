#!/bin/bash

# Uso:
#   source scripts/shared/validate-and-load.sh /ruta/al/.env
# Carga todas las variables del .env y valida que existan todas las del .env.example en la misma carpeta.

set -e  # Hace que el script falle si cualquier comando falla




# Usa el primer parámetro como carpeta donde está el .env
ENV_DIR="$1"
if [ -z "$ENV_DIR" ]; then
  echo "ERROR: Debe pasar la carpeta donde está el archivo .env como primer parámetro."
  echo "PWD: $(pwd)"
  echo "Ejemplo: source scripts/shared/validate-and-load.sh ./mi-carpeta"
  return 1 2>/dev/null || exit 1
fi

ENV_PATH="$ENV_DIR/.env"
ENV_EXAMPLE_PATH="$ENV_DIR/.env.example"

# Verifica que exista el archivo .env
if [ ! -f "$ENV_PATH" ]; then
  echo "ERROR: No se encontró el archivo .env en $ENV_PATH" >&2
  echo "PWD: $(pwd)"
  return 1 2>/dev/null || exit 1
fi

# Verifica que exista el archivo .env.example
if [ ! -f "$ENV_EXAMPLE_PATH" ]; then
  echo "ERROR: No se encontró el archivo .env.example en $ENV_EXAMPLE_PATH" >&2
  return 1 2>/dev/null || exit 1
fi

# Exporta automáticamente todas las variables que se definan a continuación
set -a
# Carga todas las variables del archivo .env al entorno
. "$ENV_PATH"
set +a

# Recorre el .env.example y verifica que todas las variables estén definidas y no vacías
MISSING_VARS=()
while IFS= read -r line; do
  # Ignora comentarios y líneas vacías
  [[ "$line" =~ ^#.*$ || -z "$line" ]] && continue
  # Obtiene el nombre de la variable (lo que está antes del '=')
  varname="${line%%=*}"
  # Ignora ABSOLUTE_ENV_PATH en la validación
  [[ "$varname" == "ABSOLUTE_ENV_PATH" ]] && continue
  # Si la variable no está definida o está vacía, la agrega a la lista de faltantes
  if [ -z "${!varname+x}" ] || [ -z "${!varname}" ]; then
    MISSING_VARS+=("$varname")
  fi
done < "$ENV_EXAMPLE_PATH"

# Si hay variables faltantes, muestra error y termina
if [ ${#MISSING_VARS[@]} -ne 0 ]; then
  echo "ERROR: Las siguientes variables requeridas no están definidas o están vacías en el entorno (.env):" >&2
  for v in "${MISSING_VARS[@]}"; do
    echo "  - $v" >&2
  done
  return 1 2>/dev/null || exit 1
fi
