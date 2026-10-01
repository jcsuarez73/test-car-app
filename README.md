# test-car-app

Aplicación de **Auditoría e Inspección Vehicular** con interfaz Cyberpunk / Dark UI, soporte bilingüe (ES/EN) y base de datos local en el navegador mediante IndexedDB.

---

## 🎯 Criterios de Búsqueda Predefinidos (Referencia de Compra)

Basado en el análisis de mercado del Toyota C-HR (1.8 125h Active/Advance) y alternativas equivalentes en Península:

| Parámetro | Criterio de Selección |
| :--- | :--- |
| **Presupuesto Máximo** | 16.000 € |
| **Kilometraje Máximo** | 125.000 km |
| **Años Objetivo** | 2017 – 2019 (2 años antes / 1 año entorno a 2018) |
| **Ubicación Exclusiva** | Península Ibérica (Excluidos: Las Palmas, Tenerife, Mallorca) |
| **Motorización Objetivo** | Híbrido Gasolina HEV / Etiqueta ECO |

### 🚘 Modelos de Referencia en Búsqueda

* **Toyota C-HR 1.8 125h Advance (2017)**: ~15.290 € - 15.990 € | 90k - 115k km.
* **Toyota C-HR 1.8 125h Active / Advance (2018)**: ~15.800 € - 16.000 € | 105k - 122k km.
* **Toyota C-HR 1.8 125h Advance (2019)**: ~15.990 € - 16.000 € | 103k - 118k km.

---

## 💻 Características de la Aplicación

- **Modularización**: Separación completa de estructura (`index.html`), estilos (`css/styles.css`) y lógica (`js/app.js`).
- **Checklist Interactivo**: Cálculo automático de índice de confianza (100 a 0) según la gravedad del fallo (Crítico / Grave).
- **Audio Context**: Efectos sonoros interactivos (Glitch de inicio, Fallo Crítico y Sirena Hazard si la puntuación llega a 0).
- **Persistencia Local**: Base de datos IndexedDB para guardar e inspeccionar múltiples vehículos.
- **Exportación**: Formato apto para exportar e imprimir informes en PDF.

---

## 🚀 Inicio Rápido

Abre el archivo `index.html` en un navegador web o utiliza la extensión **Live Server** de Visual Studio Code.
# test-car-app
# test-car-app
