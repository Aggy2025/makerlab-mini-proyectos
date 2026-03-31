# 🛰️ Radar Ultrasónico Interactivo (Visualización 2D)

> **MakerLab - Universidad Cenfotec**
> Este proyecto es una introducción perfecta al mundo de la **percepción robótica** y la **sincronización hardware-software**, recreando cómo las máquinas "ven" su entorno.

Este sistema simula un radar militar real. Un sensor de ultrasonido montado sobre un servomotor realiza un barrido continuo de 180°. Mientras el hardware mide distancias, una interfaz gráfica en **Processing** dibuja el radar en tiempo real. Si un objeto entra en el rango de detección, el sistema reacciona de forma multimodal: el radar digital cambia a color rojo, se enciende un LED físico y suena una alarma sonora desde los altavoces de la computadora.

---

## 🧠 Tecnologías y Conceptos Clave

Para que este radar funcione, conectamos el mundo físico con el digital usando estos cuatro pilares:

* **🦇 Sensor Ultrasónico (Los Ojos):** Funciona como el sonar de un murciélago. Envía pulsos de sonido inaudibles y mide cuánto tardan en rebotar para calcular la distancia de los objetos.
* **🦾 Servo Motor (El Cuello):** Es un motor de precisión que nos permite rotar el sensor grado por grado para cubrir un área de visión completa de 180°.
* **🌉 Comunicación Serial (El Puente):** El cable USB transporta ráfagas de datos constantemente. Arduino le dice a la PC: *"Estoy en el grado 45 y veo algo a 10cm"*, y la PC lo dibuja al instante.
* **🎨 Processing (La Pantalla del Radar):** Es un lenguaje de programación visual. Toma los datos crudos de Arduino y los transforma en una interfaz estética, similar a la de un submarino o una torre de control.

---

## 🛠️ Materiales Necesarios

| Cantidad | Componente | Notas |
| :---: | :--- | :--- |
| 1 | Arduino UNO | El cerebro que coordina los sensores. |
| 1 | Sensor HC-SR04 | El sensor de ultrasonido. |
| 1 | Servo SG90 | Motor de rotación de 180°. |
| 1 | LED | Indicador visual de alerta física. |
| 1 | Resistencia 220Ω | Para proteger el LED. |
| 1 | Caja de Baterías 4xAA | **Fuente externa necesaria** para el motor. |
| Varios | Cables Jumper | Macho-Macho para las interconexiones. |

---

## 🔌 Conexiones de Hardware

Sigue estos pasos con cuidado. Recuerda que los motores (servos) consumen mucha energía y pueden reiniciar tu Arduino si no usas la fuente externa.

**⚠️ Regla de Oro Maker:** Conecta el cable negro (GND) de las baterías al pin **GND** de Arduino. Todos los componentes deben compartir la misma "tierra" para que las señales eléctricas se entiendan.

### Esquema de Pines:

| Componente | Pin Arduino | Nota |
| :--- | :---: | :--- |
| **LED (Ánodo)** | **Pin 7** | Usar resistencia de 220Ω al GND. |
| **Ultrasonido TRIG** | **Pin 8** | Disparador del pulso de sonido. |
| **Ultrasonido ECHO** | **Pin 9** | Receptor del eco del sonido. |
| **Servo (Señal)** | **Pin 11** | Cable naranja o amarillo del motor. |

---

### Galería de Componentes

**Montaje del Sensor y Servo**
![Sensor y Servo](imagenes/sensor_servo.jpg)

**Gestión de Energía (Baterías)**
![Conexión Baterías](imagenes/conexion_baterias.jpg)

**Circuito Final Terminado**
![Circuito Final](imagenes/circuito_final.jpg)

---

## 💻 Configuración del Software

### 1. Preparación del Arduino
1. Conecta el Arduino a la PC y abre el **Arduino IDE**.
2. Carga el código localizado en `codigos/radar_arduino.ino`.
3. Selecciona tu placa, el puerto correspondiente y haz clic en **Subir**.

### 2. Configuración de Processing
Para visualizar el radar en tu pantalla, necesitamos preparar el entorno de Processing:
1. Descarga e instala [Processing](https://processing.org/).
2. **Instalar Librerías:** Ve a `Sketch` > `Import Library` > `Add Library...` y busca:
   * **Serial** (para la comunicación con Arduino).
   * **Sound** (para activar la alarma auditiva).
3. **Carpeta de Sonido:** Localiza el archivo `alarm-sfx-sound.wav`. Debes crear una carpeta llamada `data` dentro de la carpeta donde guardaste tu código de Processing y pegar el archivo ahí.

### 3. Ejecución
1. Con Arduino conectado, abre el archivo `codigos/radar_visualizer.pde` en Processing.
2. Haz clic en el botón **Play** (el triángulo arriba a la izquierda).
3. ¡Verás cómo el radar cobra vida en tu pantalla!

---

## 🔬 Más sobre las Tecnologías (Aprendizaje Maker)

En el MakerLab, no solo armamos piezas; entendemos los problemas reales del prototipado:

**1. El reto de la alimentación eléctrica:**
Muchos principiantes creen que con los 5V del USB es suficiente. Sin embargo, el servo motor requiere picos de **corriente (amperios)** que el Arduino no puede dar solo. Al usar baterías externas, aprendemos a separar la potencia (motor) de la lógica (microcontrolador).

**2. Sincronización de Tiempos:**
El código debe estar perfectamente balanceado. Si el servo gira demasiado rápido, el sensor de ultrasonido no tiene tiempo de recibir el "eco" y las mediciones darán error. Este proyecto enseña a manejar los tiempos de respuesta del hardware.

**3. Debugging Físico vs Digital:**
Si el radar no se mueve en la pantalla, aprendemos a usar el **Monitor Serie**. Si los números aparecen ahí, sabemos que el problema no es el cable ni el Arduino, sino el código de Processing. Dividir el problema en partes es la base de la ingeniería.

---
**¿Dudas o mejoras?** ¡Visítanos en el MakerLab y comparte tu versión del proyecto! 🚀
