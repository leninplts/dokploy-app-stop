#!/usr/bin/env sh
set -e

# Validar variables requeridas
: "${INPUT_API_KEY:?api_key es obligatorio}"
: "${INPUT_APPLICATION_ID:?application_id es obligatorio}"
: "${INPUT_DOKPLOY_URL:?dokploy_url es obligatorio}"

echo "🚀 Deteniendo aplicación $INPUT_APPLICATION_ID en Dokploy..."

# Realizar la llamada a la API y capturar la respuesta
response=$(curl -s -w "\n%{http_code}" -X POST "$INPUT_DOKPLOY_URL/api/application.stop" \
  -H "accept: application/json" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $INPUT_API_KEY" \
  -d "{\"applicationId\":\"$INPUT_APPLICATION_ID\"}")

# Separar el cuerpo de la respuesta del código HTTP
http_code=$(echo "$response" | tail -n1)
response_body=$(echo "$response" | head -n -1)

echo "📊 Código de respuesta HTTP: $http_code"
echo "📝 Respuesta: $response_body"

# Verificar si la respuesta fue exitosa
if [ "$http_code" -ge 200 ] && [ "$http_code" -lt 300 ]; then
    echo "✅ Aplicación detenida exitosamente"
    echo "response=$response_body" >> $GITHUB_OUTPUT
    exit 0
else
    echo "❌ Error al detener la aplicación"
    echo "response=$response_body" >> $GITHUB_OUTPUT
    exit 1
fi