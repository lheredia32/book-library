# 📚 Book Library

Una aplicación de gestión de biblioteca personal construida con Ruby on Rails que te permite organizar tus libros, rastrear tu estado de lectura y obtener información automáticamente desde la API de Open Library.

## ✨ Características Principales

### 📖 Gestión de Libros
- **CRUD completo**: Crear, leer, actualizar y eliminar libros
- **Información detallada**: Título, autor, ISBN, descripción, portada y estado de lectura
- **Búsqueda por ISBN**: Integración automática con la API de Open Library para completar datos al ingresar un ISBN

### 📊 Sistema de Estados de Lectura
Reemplaza el simple "prestado/no prestado" con un sistema integral de tracking:
- **Want to Read** (Por leer)
- **Currently Reading** (Leyendo actualmente)
- **Completed** (Completado)
- **On Hold** (En pausa)
- **Dropped** (Abandonado)
- **Loaned Out** (Prestado)

### 🎨 Diseño y Experiencia de Usuario
- **Tema claro/oscuro** con persistencia en localStorage y detección de preferencia del sistema
- **Tipografía premium**: Fuentes Crimson Pro (títulos) y DM Sans (cuerpo)
- **Diseño responsivo**: Optimizado para móviles y escritorio
- **Badges de estado** con colores distintivos para cada estado de lectura
- **Animaciones sutiles** y efectos de hover mejorados
- **Portadas de libros** obtenidas automáticamente desde Open Library

### 🔧 Integraciones Técnicas
- **API de Open Library**: Búsqueda automática de datos de libros por ISBN
- **Turbo y Stimulus**: Para experiencias de usuario fluidas sin recargas de página
- **Base de datos SQLite3**: Configuración lista para desarrollo local
- **Validaciones robustas**: Título y autor requeridos, validación de estados

### 🧪 Calidad de Código
- **Tests unitarios**: Cobertura para servicios y modelos
- **Estilo consistente**: Rubocop configurado
- **Migraciones de base de datos**: Versionadas y documentadas
- **Semillas de datos**: Libro de ejemplo incluido para pruebas inmediatas

## 🚀 Cómo Empezar

### Prerrequisitos
- Ruby 3.0+
- Rails 7.0+
- SQLite3 (viene preinstalado en la mayoría de sistemas)
- Conexión a internet (para obtener datos de Open Library)

### Instalación
```bash
# Clonar el repositorio (si aplica)
git clone <repository-url>
cd book-library

# Instalar dependencias
bundle install

# Preparar la base de datos
rails db:create db:migrate db:seed

# Iniciar el servidor
rails server
```

Luego visita `http://localhost:3000` en tu navegador.

## 📖 Uso Básico

### Agregar un Nuevo Libro
1. Haz clic en "Add New Book"
2. Ingresa el ISBN del libro y presiona Tab o haz clic fuera del campo
3. La aplicación completará automáticamente título, autor, descripción y portada usando Open Library API
4. Selecciona el estado de lectura actual
5. Haz clic en "Create Book"

### Cambiar el Estado de Lectura
- En la vista de detalle de un libro, verás el estado actual como un badge colorido
- Para cambiarlo, haz clic en "Edit" y selecciona un nuevo estado desde el dropdown

### Modo Claro/Oscuro
- Haz clic en el icono de sol/luna en la esquina superior derecha
- Tu preferencia se guardará y se aplicará en futuras visitas
- La aplicación también detectará automáticamente tu preferencia del sistema en la primera visita

## 🛠️ Estructura Técnica

### Dependencias Principales
- Rails 8.0.1
- Turbo-rails & Stimulus-rails (para interactividad moderna)
- CSS puro con variables para theming
- SQLite3 para desarrollo

### Arquitectura
```
app/
├── controllers/     # Lógica de control (BooksController)
├── models/          # Lógica de negocio (Book model)
├── views/           # Plantillas ERB
├── services/        # OpenLibraryService para integración API
├── javascript/
│   └── controllers/ # Controladores Stimulus (isbn_lookup)
└── assets/
    └── stylesheets/ # SCSS/CSS con variables de tema
```

### API de Open Library
La aplicación utiliza:
- `https://openlibrary.org/api/books?bibkeys=ISBN:{isbn}&format=json&jscmd=data`
- Campos obtenidos: título, autor(es), descripción, portadas (tamaños S, M, L)
- Manejo de errores para ISBNs no encontrados o problemas de conectividad

## 🎯 Diseño y Estética

Siguiendo las pautas de la skill de frontend-design:

### Dirección Estética
- **Tono**: Editorial/Lujo refinado con toques orgánicos/naturales
- **Tipografía**: Crimson Pro (display) + DM Sans (body) - combinación única y legible
- **Paleta de Colores**: Tonos tierra cálidos con acentos de azul biblioteca y verde lectura
- **Espaciado**: Diseño intencional con espacios generosos para legibilidad
- **Detalles**: Sombras suaves, bordes redondeados, micro-interacciones pensadas

### Evitando Estéticas Genéricas de IA
- ✅ Fuentes distintivas (no Inter/Roboto/Arial)
- ✅ Esquema de color original (no degradados morados genéricos)
- ✅ Layouts inesperados con composición espacial pensada
- ✅ Detalles hechos a mano (badges, animaciones, hover states)

## 🧩 Próximos Mejoramientos Sugeridos

### Funcionalidades Futuras
1. **Sistema de Calificaciones y Reseñas**
   - Añadir campos `rating` (1-5) y `review` (texto)
   - Visualización de estrellas y espacio para notas personales

2. **Etiquetas y Categorización**
   - Sistema de tags muchos-a-muchos
   - Nube de tags o filtros laterales

3. **Metadatos de Lectura Avanzados**
   - Fechas de inicio y finalización
   - Páginas actuales/totales para libros en progreso
   - Metas de lectura anuales

4. **Funcionalidad simil-Goodreads**
   - Estantes personalizados (Want to Read, Currently Reading, etc.)
   - Recomendaciones basadas en géneros/autores

5. **Exportación/Importación**
   - Backup/Restauración de biblioteca en formato CSV/JSON
   - Sincronización con servicios externos (opcional)

### Mejoras Técnicas
1. **Testing de Integración**
   - Tests de sistema para flujos completos de usuario
   - Tests de controladores para endpoints API

2. **Optimización de Rendimiento**
   - Caching de respuestas de Open Library API
   - Índices de base de datos adicionales para búsquedas frecuentes

3. **Internacionalización**
   - Soporte para múltiples idiomas
   - Formatos de fecha y número localizados

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE.md](LICENSE.md) para detalles.

## 🙏 Agradecimientos

- [Open Library](https://openlibrary.org/) por proporcionar acceso gratuito a datos bibliográficos
- El equipo de Ruby on Rails por un framework maravilloso
- La comunidad de código abierto por herramientas y bibliotecas esenciales

---

*Hecho con ❤️ para lectores apasionados. Que tu lista de "Want to Read" siempre esté llena de buenas historias.*