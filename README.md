# Entorno de Desarrollo C++ con Docker

Este proyecto proporciona un entorno de desarrollo C++ containerizado usando Docker, ideal para estudiantes que trabajan en proyectos de programación en C++. El entorno garantiza la consistencia entre diferentes sistemas operativos (Windows, macOS, Linux).

## 📋 Prerrequisitos

### Instalación de Docker

**Docker Desktop** es la forma más fácil de ejecutar Docker en tu computadora. Sigue los enlaces según tu sistema operativo:

#### Windows
- **Windows 10/11 Pro, Enterprise o Education**: [Docker Desktop para Windows](https://docs.docker.com/desktop/install/windows-install/)
- **Windows 10/11 Home**: [Docker Desktop para Windows Home](https://docs.docker.com/desktop/install/windows-install/)
- **Guía detallada**: [Instalación paso a paso en Windows](https://docs.docker.com/desktop/windows/install/)

#### macOS
- **macOS 10.15 o superior**: [Docker Desktop para Mac](https://docs.docker.com/desktop/install/mac-install/)
- **Guía detallada**: [Instalación paso a paso en macOS](https://docs.docker.com/desktop/mac/install/)

#### Linux (Ubuntu/Debian)
```bash
# Actualizar el sistema
sudo apt update

# Instalar Docker
sudo apt install docker.io

# Agregar tu usuario al grupo docker
sudo usermod -aG docker $USER

# Reiniciar sesión o ejecutar:
newgrp docker
```
- **Guía oficial**: [Instalación de Docker en Linux](https://docs.docker.com/engine/install/ubuntu/)

### Verificar la instalación
Después de instalar Docker, verifica que funcione correctamente:
```bash
docker --version
docker run hello-world
```

## 🚀 Uso del Entorno

### 1. Construir la imagen Docker

Primero, construye la imagen Docker desde el directorio raíz del proyecto:

```bash
docker build -t cpp-runner-env .
```

### 2. Ejecutar un proyecto específico

Los scripts soportan variables de entorno opcionales para personalizar la configuración:

- `PROJECTS_BASE_DIR`: Directorio base para los proyectos (por defecto: "student_projects")
- `MAIN_SOURCE_FILE`: Archivo fuente principal (por defecto: "main.cpp")

#### Opción A: Usar el script interactivo (Recomendado)

**Linux/macOS:**
```bash
# Hacer el script ejecutable (solo la primera vez)
chmod +x run_interactive.sh

# Ejecutar un proyecto específico con configuración por defecto
./run_interactive.sh project_group_1

# Usar un directorio base personalizado
PROJECTS_BASE_DIR=my_projects ./run_interactive.sh project_group_1

# Usar un archivo fuente principal personalizado
MAIN_SOURCE_FILE=app.cpp ./run_interactive.sh project_group_1

# Combinar ambas opciones
PROJECTS_BASE_DIR=custom_projects MAIN_SOURCE_FILE=program.cpp ./run_interactive.sh my_project
```

**Windows (Command Prompt):**
```cmd
rem Ejecutar con configuración por defecto
run_interactive.bat project_group_1

rem Usar un directorio base personalizado
set PROJECTS_BASE_DIR=my_projects && run_interactive.bat project_group_1

rem Usar un archivo fuente principal personalizado
set MAIN_SOURCE_FILE=app.cpp && run_interactive.bat project_group_1

rem Combinar ambas opciones
set PROJECTS_BASE_DIR=custom_projects && set MAIN_SOURCE_FILE=program.cpp && run_interactive.bat my_project
```

**Windows (PowerShell):**
```powershell
# Ejecutar con configuración por defecto
.\run_interactive.ps1 project_group_1

# Usar un directorio base personalizado
$env:PROJECTS_BASE_DIR='my_projects'; .\run_interactive.ps1 project_group_1

# Usar un archivo fuente principal personalizado
$env:MAIN_SOURCE_FILE='app.cpp'; .\run_interactive.ps1 project_group_1

# Combinar ambas opciones
$env:PROJECTS_BASE_DIR='custom_projects'; $env:MAIN_SOURCE_FILE='program.cpp'; .\run_interactive.ps1 my_project
```

#### Opción B: Ejecutar manualmente con Docker

**Linux/macOS:**
```bash
# Compilar y ejecutar un archivo específico
docker run --rm -v $(pwd)/student_projects/project_group_1:/app cpp-runner-env main.cpp

# Sesión interactiva para desarrollo
docker run --rm -it -v $(pwd)/student_projects/project_group_1:/app cpp-runner-env bash
```

**Windows (Command Prompt):**
```cmd
# Compilar y ejecutar un archivo específico
docker run --rm -v "%cd%/student_projects/project_group_1":/app cpp-runner-env main.cpp

# Sesión interactiva para desarrollo
docker run --rm -it -v "%cd%/student_projects/project_group_1":/app cpp-runner-env bash
```

**Windows (PowerShell):**
```powershell
# Compilar y ejecutar un archivo específico
docker run --rm -v "${PWD}/student_projects/project_group_1:/app" cpp-runner-env main.cpp

# Sesión interactiva para desarrollo
docker run --rm -it -v "${PWD}/student_projects/project_group_1:/app" cpp-runner-env bash
```

### 3. Estructura de proyectos

Cada proyecto debe estar en su propio directorio dentro del directorio base (por defecto `student_projects/`, pero configurable):

```
<directorio_base>/
├── project_group_1/
│   ├── main.cpp           # Archivo principal (configurable)
│   └── ...               # Otros archivos fuente
├── project_group_2/
│   ├── main.cpp
│   ├── Makefile          # Opcional: para proyectos complejos
│   └── ...
└── ...
```

#### Configuración personalizada de estructura

Puedes personalizar tanto el directorio base como el nombre del archivo principal:

```bash
# Ejemplo con estructura personalizada
my_custom_projects/
├── web_app/
│   ├── server.cpp        # Archivo principal personalizado
│   └── ...
├── game_engine/
│   ├── engine.cpp
│   └── ...
```

Para usar esta estructura:
```bash
# Linux/macOS
PROJECTS_BASE_DIR=my_custom_projects MAIN_SOURCE_FILE=server.cpp ./run_interactive.sh web_app

# Windows (PowerShell)
$env:PROJECTS_BASE_DIR='my_custom_projects'; $env:MAIN_SOURCE_FILE='server.cpp'; .\run_interactive.ps1 web_app
```

## 🛠️ Funcionalidades

### Compilación automática

El sistema detecta automáticamente el tipo de proyecto y usa el sistema de compilación apropiado:

1. **Proyectos CMake**: Si existe `CMakeLists.txt`, ejecuta:
   ```bash
   cmake -B build .
   make -C build
   ```
   - Crea un directorio `build/` para compilación fuera del código fuente
   - Detecta automáticamente el nombre del ejecutable generado

2. **Proyectos con Makefile**: Si existe `Makefile` o `makefile`, ejecuta:
   ```bash
   make
   ```

3. **Proyectos simples**: Si no existe ni CMakeLists.txt ni Makefile, compila directamente:
   ```bash
   g++ -std=c++23 -o program main.cpp
   ```

### Herramientas incluidas
- **Compilador**: GCC/G++ 11.4.0 con soporte completo para C++23
- **Build tools**: make, CMake 4.1.1+ (última versión estable)
- **Sistema**: Ubuntu 22.04 LTS
- **CMake**: Instalado desde el repositorio oficial de Kitware para tener la última versión

## 📝 Ejemplos de uso

### Ejemplo 1: Proyecto simple
```cpp
// main.cpp
#include <iostream>
using namespace std;

int main() {
    cout << "¡Hola, mundo desde Docker!" << endl;
    return 0;
}
```

**Ejecutar:**
- **Linux/macOS**: `./run_interactive.sh mi_proyecto`
- **Windows**: `run_interactive.bat mi_proyecto` o `.\run_interactive.ps1 mi_proyecto`

**Con personalización:**
- **Linux/macOS**: `MAIN_SOURCE_FILE=app.cpp ./run_interactive.sh mi_proyecto`
- **Windows (CMD)**: `set MAIN_SOURCE_FILE=app.cpp && run_interactive.bat mi_proyecto`
- **Windows (PS)**: `$env:MAIN_SOURCE_FILE='app.cpp'; .\run_interactive.ps1 mi_proyecto`

### Ejemplo 2: Proyecto con múltiples archivos
```cpp
// main.cpp
#include "calculadora.h"
#include <iostream>

int main() {
    std::cout << "Suma: " << suma(5, 3) << std::endl;
    return 0;
}
```

```cpp
// calculadora.h
#ifndef CALCULADORA_H
#define CALCULADORA_H

int suma(int a, int b);

#endif
```

```cpp
// calculadora.cpp
#include "calculadora.h"

int suma(int a, int b) {
    return a + b;
}
```

```makefile
# Makefile
CXX = g++
CXXFLAGS = -std=c++23 -Wall
TARGET = program
SOURCES = main.cpp calculadora.cpp

$(TARGET): $(SOURCES)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(SOURCES)

clean:
	rm -f $(TARGET)
```

### Ejemplo 3: Proyecto con CMake
```cpp
// main.cpp
#include "calculadora.h"
#include <iostream>
#include <vector>

int main() {
    std::vector<int> numeros = {1, 2, 3, 4, 5};
    int total = 0;
    
    for (const auto& num : numeros) {
        total = suma(total, num);
    }
    
    std::cout << "Suma total: " << total << std::endl;
    return 0;
}
```

```cmake
# CMakeLists.txt
cmake_minimum_required(VERSION 3.22)
project(MiProyecto)

# Configurar estándar de C++
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Crear ejecutable
add_executable(mi_programa
    main.cpp
    calculadora.cpp
)

# Opciones de compilación
target_compile_options(mi_programa PRIVATE -Wall -Wextra)
```

**Características del build con CMake:**
- Compilación fuera del código fuente (out-of-source build)
- Archivos generados en directorio `build/`
- Detección automática del nombre del ejecutable
- Compatible con CMake 3.22+ hasta la última versión (4.1.1+)

## 🔧 Personalización

### Variables de entorno

Los scripts soportan las siguientes variables de entorno para personalizar su comportamiento:

| Variable | Descripción | Valor por defecto |
|----------|-------------|-------------------|
| `PROJECTS_BASE_DIR` | Directorio base donde se encuentran los proyectos | `student_projects` |
| `MAIN_SOURCE_FILE` | Nombre del archivo fuente principal a compilar | `main.cpp` |

### Ejemplos de uso con personalización

#### Caso 1: Organización alternativa de proyectos
```bash
# Si tus proyectos están en un directorio llamado "assignments"
PROJECTS_BASE_DIR=assignments ./run_interactive.sh homework_1
```

#### Caso 2: Archivo principal con nombre diferente
```bash
# Si tu archivo principal se llama "application.cpp"
MAIN_SOURCE_FILE=application.cpp ./run_interactive.sh my_project
```

#### Caso 3: Ambas personalizaciones
```bash
# Combinando ambas opciones
PROJECTS_BASE_DIR=coursework MAIN_SOURCE_FILE=solution.cpp ./run_interactive.sh lab_3
```

#### Caso 4: Configuración persistente
```bash
# Linux/macOS: Exportar variables para la sesión actual
export PROJECTS_BASE_DIR=my_assignments
export MAIN_SOURCE_FILE=program.cpp
./run_interactive.sh assignment_1
./run_interactive.sh assignment_2  # Usará la misma configuración
```

```cmd
rem Windows (Command Prompt): Configuración persistente para la sesión
set PROJECTS_BASE_DIR=my_assignments
set MAIN_SOURCE_FILE=program.cpp
run_interactive.bat assignment_1
run_interactive.bat assignment_2
```

```powershell
# Windows (PowerShell): Configuración persistente para la sesión
$env:PROJECTS_BASE_DIR='my_assignments'
$env:MAIN_SOURCE_FILE='program.cpp'
.\run_interactive.ps1 assignment_1
.\run_interactive.ps1 assignment_2
```

## 🔧 Solución de problemas

### Error: "docker: command not found"
- Verifica que Docker esté instalado correctamente
- En Windows/macOS: asegúrate de que Docker Desktop esté ejecutándose

### Error: "Permission denied"
- En Linux: agrega tu usuario al grupo docker: `sudo usermod -aG docker $USER`
- Reinicia tu sesión o ejecuta: `newgrp docker`

### Scripts de ejecución no funcionan
**Windows:**
- Si `run_interactive.bat` no funciona, prueba `.\run_interactive.ps1` en PowerShell
- En PowerShell, si hay problemas de política de ejecución: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`

**Linux/macOS:**
- Asegúrate de dar permisos de ejecución: `chmod +x run_interactive.sh`

### Error: "No such file or directory"
- Verifica que el archivo `main.cpp` exista en el directorio del proyecto
- Asegúrate de estar ejecutando el comando desde el directorio raíz del proyecto

### El programa no compila
- Revisa los errores de compilación mostrados en la terminal
- Verifica la sintaxis de tu código C++
- Asegúrate de usar características compatibles con C++23

### Problemas específicos con CMake

#### Error: "CMake version X.Y or higher is required"
- **Causa**: El `CMakeLists.txt` requiere una versión de CMake más nueva
- **Solución**: 
  - Opción 1: Cambiar `cmake_minimum_required(VERSION X.Y)` a `cmake_minimum_required(VERSION 3.22)`
  - Opción 2: Reconstruir la imagen Docker para obtener la última versión de CMake

#### Error: "undefined reference to function"
- **Causa**: Funciones declaradas en headers pero no implementadas, o archivos fuente no incluidos
- **Solución**: 
  - Verificar que todos los archivos `.cpp` estén listados en `CMakeLists.txt`
  - Asegurar que todas las funciones declaradas tengan implementación

#### Directorio build con archivos antiguos
- **Causa**: Builds previos interfieren con la compilación actual
- **Solución**: Los proyectos CMake ahora usan builds fuera del código fuente (out-of-source) automáticamente
- **Limpieza manual**: Si necesitas limpiar, elimina el directorio `build/`

#### Ejecutable no encontrado después de la compilación
- **Causa**: El sistema no puede encontrar el ejecutable generado por CMake
- **Solución**: El sistema detecta automáticamente el ejecutable en `build/`, pero puedes verificar:
  ```bash
  docker run --rm -it -v $(pwd)/student_projects/tu_proyecto:/app cpp-runner-env bash
  ls -la build/
  ```

## 🎓 Consejos para estudiantes

1. **Organización**: Mantén cada proyecto en su propio directorio
2. **Naming**: Usa nombres descriptivos para tus archivos y funciones
3. **Comentarios**: Documenta tu código para facilitar la comprensión
4. **Testing**: Prueba tu código con diferentes casos de uso
5. **Backup**: Mantén respaldos de tu trabajo (considera usar Git)

## 📚 Recursos adicionales

- [Documentación oficial de Docker](https://docs.docker.com/)
- [Guía de C++ moderno](https://en.cppreference.com/)
- [Tutorial de Makefile](https://makefiletutorial.com/)
- [Documentación oficial de CMake](https://cmake.org/documentation/)
- [Buenas prácticas en C++](https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines)
- [Instalación de CMake desde Kitware](https://apt.kitware.com/) - Para obtener la última versión

## 🆕 Actualizaciones recientes (Septiembre 2025)

- **CMake 4.1.1+**: Actualizado a la última versión estable desde el repositorio oficial de Kitware
- **Builds CMake mejorados**: Ahora usa compilación fuera del código fuente (out-of-source builds)
- **Detección automática**: Mejora en la detección del sistema de build y nombres de ejecutables
- **Compatibilidad**: Soporte para proyectos CMake desde versión 3.22 hasta la más reciente

---

**¿Necesitas ayuda?** Consulta con tu instructor o revisa la documentación oficial de Docker y C++.