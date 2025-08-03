# Dokploy App Stop Action

GitHub Action para detener aplicaciones en Dokploy usando su API.

## 📋 Descripción

Esta action te permite detener aplicaciones desplegadas en Dokploy directamente desde tus workflows de GitHub Actions. Es útil para automatizar el proceso de detener aplicaciones durante deployments, mantenimiento o rollbacks.

## 🚀 Uso

```yaml
- name: Detener aplicación en Dokploy
  uses: tu-usuario/dokploy-app-stop@v1
  with:
    api_key: ${{ secrets.DOKPLOY_API_KEY }}
    application_id: 'tu-app-id'
    dokploy_url: 'https://tu-dokploy.com'
```

## 📥 Inputs

| Input | Descripción | Requerido | Ejemplo |
|-------|-------------|-----------|---------|
| `api_key` | Tu API key de Dokploy | ✅ | `${{ secrets.DOKPLOY_API_KEY }}` |
| `application_id` | ID de la aplicación en Dokploy | ✅ | `app-123456` |
| `dokploy_url` | URL base de tu instancia Dokploy | ✅ | `https://dokploy.ejemplo.com` |

## 📤 Outputs

| Output | Descripción |
|--------|-------------|
| `response` | Respuesta completa de la API de Dokploy |

## 🔧 Configuración

### 1. Obtener API Key

1. Accede a tu panel de Dokploy
2. Ve a Settings > API Keys
3. Genera una nueva API key
4. Guárdala como secret en tu repositorio: `DOKPLOY_API_KEY`

### 2. Encontrar Application ID

El Application ID lo puedes encontrar en la URL cuando estés viendo tu aplicación en Dokploy:
```
https://tu-dokploy.com/dashboard/project/[project-id]/services/application/[application-id]
```

## 📝 Ejemplo completo

```yaml
name: Deploy y gestionar aplicación

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout código
        uses: actions/checkout@v4
      
      - name: Detener aplicación actual
        uses: tu-usuario/dokploy-app-stop@v1
        with:
          api_key: ${{ secrets.DOKPLOY_API_KEY }}
          application_id: 'mi-app-123'
          dokploy_url: 'https://mi-dokploy.com'
      
      # Aquí irían tus pasos de build y deploy
      
      - name: Verificar respuesta
        run: echo "Respuesta de Dokploy: ${{ steps.stop-app.outputs.response }}"
```

## ⚠️ Consideraciones

- Asegúrate de que tu API key tenga permisos para detener aplicaciones
- La action fallará si la aplicación no existe o ya está detenida
- Revisa los logs para ver el estado de la operación

## 🐛 Troubleshooting

### Error: "api_key es obligatorio"
- Verifica que hayas configurado el secret `DOKPLOY_API_KEY`
- Asegúrate de estar pasando el parámetro correctamente

### Error: "application_id es obligatorio"
- Verifica que el ID de la aplicación sea correcto
- Puedes encontrarlo en la URL de tu aplicación en Dokploy

### Error HTTP 401
- Tu API key puede estar incorrecta o haber expirado
- Genera una nueva API key en Dokploy

### Error HTTP 404
- El application_id no existe
- Verifica que la URL de Dokploy sea correcta

## 📄 Licencia

MIT License - ver [LICENSE](LICENSE) para más detalles.

## 🤝 Contribuir

Las contribuciones son bienvenidas. Por favor:

1. Fork el proyecto
2. Crea una rama para tu feature
3. Commit tus cambios
4. Push a la rama
5. Abre un Pull Request

## 📞 Soporte

Si tienes problemas o preguntas:
- Abre un issue en este repositorio
- Contacta: lenin.huaylla@gmail.com