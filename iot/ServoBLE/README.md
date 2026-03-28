# 🔵 ServoBLE - Portón Inteligente IoT

ServoBLE es un sistema IoT desarrollado con **IdeaBoard (ESP32)** que integra un sensor ultrasónico y un servomotor controlado remotamente mediante Bluetooth Low Energy (BLE).

Cuando el sistema detecta un objeto al frente, envía una notificación a una página web interactiva donde el usuario puede decidir abrir o cerrar un portón inalámbricamente.

---

## 🎯 Objetivo

Demostrar integración completa entre:

- Hardware embebido
- Sensores
- Comunicación inalámbrica
- Interfaces Web
- Interacción humano-máquina

---

## 🧠 Conceptos que enseña

- Internet of Things
- Bluetooth Low Energy
- Comunicación bidireccional
- Sistemas embebidos ESP32
- Control de actuadores
- Interfaces Web interactivas
- Sistemas de acceso inteligente

---

## 🧰 Componentes

| Componente | Función |
|---|---|
| IdeaBoard ESP32 | Controlador principal |
| Sensor HC-SR04 | Detectar presencia |
| Servomotor SG90 | Abrir portón |
| Baterías AA x4 | Alimentación |
| Jumpers | Cableado |
| Navegador Web | Control remoto |

---

## 📸 Carpeta de imágenes

Crear:








---

## 🔌 Conexiones

### Servo

| Cable | Pin |
|---|---|
| Rojo | 5V |
| Negro | GND |
| Amarillo | IO4 |

### Ultrasónico

| Pin | IdeaBoard |
|---|---|
| VCC | 5V |
| GND | GND |
| TRIG | IO26 |
| ECHO | IO25 |

---

## ⚙️ Arquitectura
Sensor Ultrasónico
↓
IdeaBoard
↓ BLE
Página Web
↓
Usuario
↓
Servomotor



---

## 🚀 Funcionamiento

1. IdeaBoard inicia BLE.
2. Sensor mide distancia.
3. Si detecta objeto:
   - envía `OBJETO_DETECTADO`.
4. La web muestra alerta visual.
5. Usuario decide abrir o cerrar.
6. Servo ejecuta acción.

---

## 📂 Archivos

servo-ble-gate/
├── code.py
├── index.html
├── img/
└── README.md



### 3. Ejecutar Web

Abrir:


index.html


o usar GitHub Pages.

---

### 4. Conectar

1. Encender sistema
2. Abrir página
3. Presionar **Conectar BLE**
4. Seleccionar:
   Porton_Sumobot


---

## 🧪 Estados

| Estado | Significado |
|---|---|
| Desconectado | Sin BLE |
| Conectado | Sistema activo |
| Objeto Detectado | Persona enfrente |
| Área Libre | Sin presencia |
| Portón Abierto | Servo activo |

---

## 🧱 Montaje Físico (Recomendado)

Ideas para impresión 3D:

- Base IdeaBoard
- Soporte ultrasónico frontal
- Mini portón 


---


## 🎓 Uso Educativo

Proyecto utilizado para enseñar:

- IoT real
- BLE
- Sensores
- Actuadores
- Integración hardware + web

Ideal para demostraciones del MakerLab.

---
