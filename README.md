# Flutter MVP

Aplicacion Flutter inspirada en un mock de plataforma de juegos, con foco en una experiencia visual tipo dashboard y navegacion entre secciones principales.

## Incluye

- Pantalla de `Inicio` con juegos destacados y accesos rapidos
- Pantalla de `Mis Numeros` con filtros y seleccion activa
- Pantalla de `Historial` con estados y filtros interactivos
- Pantalla de `Resultados` con selector de juego, filtros de fecha y calendario
- Assets reales para logos de juegos
- Soporte para `web`, `macOS`, `android`, `ios`, `linux` y `windows`
- Tests de widgets para vistas principales y navegacion

## Requisitos

- Flutter SDK estable

## Como ejecutar

1. Instalar dependencias:

```bash
flutter pub get
```

2. Ejecutar en Chrome:

```bash
flutter run -d chrome
```

3. Ejecutar en macOS:

```bash
flutter run -d macos
```

## Tests

Para correr la suite de tests:

```bash
flutter test
```

## Estructura principal

- `lib/widgets/home_page.dart`: home y cards principales
- `lib/widgets/app_shell.dart`: shell general con navegacion superior
- `lib/widgets/my_numbers_page.dart`: pantalla de numeros guardados
- `lib/widgets/history_page.dart`: pantalla de historial
- `lib/widgets/results_page.dart`: pantalla de resultados con filtros de fecha
- `assets/images/`: logos e imagenes de juegos

## Nota

El proyecto fue evolucionando desde un layout inicial hacia una version mas cercana a mockups de diseno, con especial atencion en navegacion, consistencia visual y soporte web.
