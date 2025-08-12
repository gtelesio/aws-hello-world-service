# 🐕 Husky Configuration Guide

Este documento explica la configuración de **Husky** en el proyecto AWS Hello World Service.

## 📋 ¿Qué es Husky?

**Husky** es una herramienta que permite ejecutar scripts de Git hooks de manera fácil y confiable. Los hooks se ejecutan automáticamente en ciertos eventos de Git (como commit, push, etc.).

## 🏗️ Estructura de Archivos

```
.husky/
├── _/
│   └── husky.sh          # Script principal de Husky
├── pre-commit            # Hook ejecutado antes de commit
├── pre-push              # Hook ejecutado antes de push
└── .huskyrc              # Configuración de Husky
```

## 🔧 Configuración

### Archivos de Configuración

#### `.huskyrc`
```bash
# Husky configuration file
HUSKY_DEBUG=0        # Debug mode (0=disabled, 1=enabled)
HUSKY=1              # Enable/disable all hooks (0=disabled, 1=enabled)
GIT_DIR=.git         # Git directory location
```

#### `.lintstagedrc.js`
```javascript
module.exports = {
  // Run ESLint and Prettier on staged TypeScript/JavaScript files
  'app/src/**/*.{ts,tsx,js,jsx}': [
    'cd app && npm run lint:fix',
    'cd app && npm run format',
    'git add'
  ],
  
  // Run Prettier on other file types
  '**/*.{json,yaml,yml,md}': [
    'prettier --write',
    'git add'
  ]
};
```

## 🪝 Hooks Disponibles

### Pre-commit Hook
**Archivo**: `.husky/pre-commit`
**Propósito**: Se ejecuta antes de cada commit
**Acciones**:
- Linting en archivos staged
- Formateo automático con Prettier
- Verificación de calidad de código

```bash
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

echo "🔍 Running pre-commit checks..."

echo "📋 Running linting on staged files..."
cd app && npm run lint:staged
if [ $? -ne 0 ]; then
    echo "❌ Linting failed. Please fix the issues before committing."
    exit 1
fi

echo "✅ Pre-commit checks passed! Ready to commit."
```

### Pre-push Hook
**Archivo**: `.husky/pre-push`
**Propósito**: Se ejecuta antes de cada push
**Acciones**:
- Linting completo del proyecto
- Ejecución de todos los tests
- Verificación de calidad completa

```bash
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

echo "🚀 Running pre-push checks..."

echo "📋 Running linting..."
cd app && npm run lint
if [ $? -ne 0 ]; then
    echo "❌ Linting failed. Please fix the issues before pushing."
    exit 1
fi

echo "🧪 Running tests..."
cd app && npm run test
if [ $? -ne 0 ]; then
    echo "❌ Tests failed. Please fix the issues before pushing."
    exit 1
fi

echo "✅ All pre-push checks passed! Ready to push."
```

## 🚀 Uso

### Comandos Automáticos
Los hooks se ejecutan automáticamente:

1. **Al hacer commit**: `git commit -m "message"`
   - Se ejecuta `pre-commit`
   - Si falla, el commit se cancela

2. **Al hacer push**: `git push`
   - Se ejecuta `pre-push`
   - Si falla, el push se cancela

### Comandos Manuales
También puedes ejecutar los hooks manualmente:

```bash
# Ejecutar pre-commit hook
npx husky run .husky/pre-commit

# Ejecutar pre-push hook
npx husky run .husky/pre-push

# Ejecutar todos los hooks
npx husky run
```

## ⚙️ Personalización

### Agregar Nuevos Hooks
Para agregar un nuevo hook:

1. Crear el archivo en `.husky/`
2. Hacerlo ejecutable: `chmod +x .husky/nombre-del-hook`
3. Agregar la lógica del hook

Ejemplo de hook personalizado:
```bash
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

echo "🔧 Running custom hook..."
# Tu lógica aquí
echo "✅ Custom hook completed!"
```

### Modificar Hooks Existentes
Para modificar un hook existente:

1. Editar el archivo del hook
2. Los cambios se aplican inmediatamente
3. No es necesario reiniciar nada

### Deshabilitar Hooks
Para deshabilitar temporalmente todos los hooks:

```bash
# Deshabilitar
export HUSKY=0

# Habilitar nuevamente
export HUSKY=1
```

## 🐛 Troubleshooting

### Hook No Se Ejecuta
1. Verificar que el archivo sea ejecutable: `chmod +x .husky/nombre-del-hook`
2. Verificar que `.huskyrc` esté configurado correctamente
3. Verificar que `HUSKY=1` en `.huskyrc`

### Hook Falla
1. Revisar los logs de error
2. Verificar que los comandos en el hook existan
3. Verificar que las dependencias estén instaladas

### Debug
Para habilitar debug mode:

```bash
# En .huskyrc
HUSKY_DEBUG=1

# O temporalmente
export HUSKY_DEBUG=1
```

## 📚 Recursos Adicionales

- [Documentación oficial de Husky](https://typicode.github.io/husky/)
- [Git Hooks Documentation](https://git-scm.com/docs/githooks)
- [Lint-staged Documentation](https://github.com/okonet/lint-staged)

## 🤝 Contribuir

Si quieres mejorar la configuración de Husky:

1. Modifica los hooks según tus necesidades
2. Asegúrate de que los hooks sean ejecutables
3. Prueba los hooks antes de hacer commit
4. Documenta los cambios en este archivo

---

**Nota**: Los hooks están configurados para trabajar con la estructura de carpetas del proyecto donde el código de la aplicación está en `app/`.
