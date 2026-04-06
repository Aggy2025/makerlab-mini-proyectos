# 🤖 05-Microbit_MachineLearning: Conectando la IA al Mundo Físico
MakerLab - Universidad Cenfotec. Este proyecto está diseñado para introducir a los estudiantes en la integración de la **Inteligencia Artificial (Machine Learning)** con el hardware físico. 

El objetivo general es demostrar cómo una computadora puede "aprender a ver" el mundo real y tomar decisiones que hagan reaccionar a un microcontrolador al instante. A través de este flujo, podemos lograr que un sistema clasifique gestos, reconozca objetos o controle accesos de seguridad, todo mediante la visión de una cámara web.

> 📢 **Aclaración Importante del Ecosistema Maker:**
> En el MakerLab creemos en aprovechar las mejores herramientas disponibles. Este proyecto se apoya en plataformas externas que **no** son desarrolladas por Cenfotec, pero son vitales en la comunidad educativa global para demostrar estos conceptos:
> * **Teachable Machine & MakeCode:** Herramientas gratuitas de Google y Microsoft, respectivamente.
> * **Lofirobot Teachable Microbit:** Una increíble aplicación web independiente creada por un desarrollador de la comunidad Maker que funciona como puente mágico entre la IA y la placa.

---

## 🧠 Tecnologías y Conceptos Clave

Antes de ver los ejemplos prácticos, entendamos las piezas del rompecabezas:

* 🧠 **El Cerebro Digital (Teachable Machine):** Aquí entrenamos el modelo de IA. Mediante *Aprendizaje Supervisado*, le mostramos a la computadora muchas fotos etiquetadas (ej. "Rojo", "Verde") para que encuentre patrones matemáticos y aprenda a diferenciarlos.
* 🦾 **El Cuerpo Físico (BBC Micro:bit):** Es nuestro microcontrolador. Él no sabe de IA, solo obedece órdenes. Ejecutará acciones físicas (mostrar caras, encender luces o mover motores) basándose en lo que la computadora le diga.
* 🌐 **El Sistema Nervioso (Lofirobot Bridge):** Es la página web que conecta la cámara de tu PC o teléfono con la antena de la placa.
* 📡 **El Idioma (Bluetooth UART):** El protocolo de comunicación. Lofirobot le "susurra" inalámbricamente mensajes de texto cortos al Micro:bit (ej. "Feliz", "Abrir") para que sepa cómo actuar.

---

## 🧪 Nuestros 3 Ejemplos Prácticos

A continuación, explicamos los tres laboratorios que ya tenemos preparados y listos para ejecutar. Cada uno aumenta un poco el nivel de interacción.

### Ejemplo 1: Detector de Emociones y Gestos 🎭
Este fue nuestro primer acercamiento. El sistema detecta qué estás haciendo con tus manos o tu rostro y el Micro:bit refleja esa "energía" en su pantalla.
* **¿Qué hace la IA?** Reconoce tres estados: "Feliz" (o pulgar arriba), "Triste" (o pulgar abajo) y "Nada".
* **¿Qué hace el Hardware?** Muestra el icono correspondiente (`IconNames.HAPPY`, `IconNames.SAD` o se duerme `IconNames.ASLEEP`).
* **Hardware necesario:** Solo la placa Micro:bit.

### Ejemplo 2: Contador Visual de Dedos ✌️
Este experimento demuestra cómo la IA puede cuantificar elementos en pantalla y enviar datos numéricos.
* **¿Qué hace la IA?** Evalúa la imagen y clasifica si hay "Uno", "Dos" o "Tres" dedos levantados frente a la cámara.
* **¿Qué hace el Hardware?** Dibuja dinámicamente el número exacto en su matriz de LEDs. Si la cámara está vacía ("Nulo"), limpia la pantalla.
* **Hardware necesario:** Solo la placa Micro:bit.

### Ejemplo 3: Portón de Seguridad Automatizado (Servo) 🚧
¡Llevamos la IA al mundo mecánico! Aquí combinamos reconocimiento de colores u objetos con control de actuadores para simular domótica (Smart Home).
* **¿Qué hace la IA?** Identifica "llaves visuales". En este caso, detecta el color "Verde" para permitir el paso, o el color "Rojo" para bloquearlo (también incluye reconocimiento de objetos específicos como "Minion1" y "Minion2").
* **¿Qué hace el Hardware?** Envía una señal eléctrica al **Pin P0** para que un Servomotor gire 90 grados (abriendo el portón) o regrese a 0 grados (cerrándolo).
* **Hardware necesario:** Placa Micro:bit, Servomotor SG90 y Jumpers.

---

## 🛠️ Materiales Necesarios

| Cantidad | Componente | Función |
| :--- | :--- | :--- |
| 1 | BBC Micro:bit (V1 o V2) | Microcontrolador principal con matriz LED y BLE. |
| 1 | Computadora con Webcam | Para entrenar la IA y ejecutar el modelo en la web. |
| 1 | Cable Micro-USB | Para cargar el programa base en el Micro:bit. |
| 1 | Servo Motor SG90 (Opcional) | Actuador para abrir un acceso/portón (Ejemplo 3). |
| 3 | Cables Jumper | Para realizar las conexiones del servo (Ejemplo 3). |

---

## 🔌 Conexiones de Hardware (Ejemplo 3)

⚠️ **REGLA DE ORO MAKER:** Si vas a usar el motor para el Ejemplo 3, conecta todo como se indica en la siguiente tabla antes de encender el sistema. Un micro-servo SG90 puede funcionar directamente desde los pines de la placa para un prototipo rápido.

| Cable del Servo | Conexión Física en Micro:bit |
| :--- | :--- |
| Rojo (VCC) | Pin **3V** |
| Negro / Marrón (GND) | Pin **GND** |
| Amarillo / Naranja (Señal) | Pin **P0** |

---

## 🖼️ Galería de Componentes

Para replicar este proyecto, guíate con estas imágenes de referencia:

* Montaje del Micro:bit y Servo: `imagenes/montaje_hardware.jpg`
* Entrenamiento en Teachable Machine: `imagenes/entrenamiento_ia.jpg`
* Interfaz Lofirobot Funcionando: `imagenes/interfaz_puente.jpg`

---

## 🚀 Cómo replicar estos laboratorios

Para facilitar tu aprendizaje, hemos dejado listos los modelos de IA y los códigos de programación. Sigue estos pasos:

### Paso 1: Cargar el código al Micro:bit
1.  Ve a la carpeta 📁 `codigos/` en este repositorio y descarga el archivo del ejemplo que quieras probar.
2.  Conecta tu Micro:bit a la computadora por USB. Aparecerá como si fuera una llave maya (USB drive).
3.  Arrastra el archivo descargado directamente a la unidad del Micro:bit. La placa parpadeará y se reiniciará con el código cargado. *(Alternativamente, puedes importar el código Python suministrado directamente en MakeCode).*

### Paso 2: Conectar el Puente y los Modelos
1.  Abre la carpeta 📁 `modelos/` de este proyecto. Allí encontrarás archivos de texto con los enlaces pre-entrenados para cada uno de los 3 ejemplos. Copia el enlace que deseas usar.
2.  Entra a la herramienta web: 🔗 [Lofirobot Teachable Microbit](https://cardboard.lofirobot.com/teachable-microbit/).
3.  Pega el enlace de tu modelo en la casilla de la página web.
4.  Presiona **Connect Micro:bit**, selecciona tu placa en la lista de Bluetooth (recuerda tener activa la configuración de "No Pairing Required" en MakeCode) y ¡listo! Pon a prueba la inteligencia del sistema frente a la cámara.

---

## 📂 ¿Qué contiene esta carpeta?

Para mantener el orden de nuestro FabLab, los recursos están divididos así:

* 📄 `README.md`: Este documento con la documentación completa.
* 📁 `codigos/`: Los archivos de programación de MakeCode (Emociones, Conteo y Servo) listos para la placa.
* 📁 `modelos/`: Enlaces URL de Teachable Machine con los entrenamientos pre-configurados.
* 📁 `imagenes/`: Fotografías del montaje y diagramas de conexión.

---

## 🔬 Futuras Pruebas y Mejoras (¡Tu turno!)

El MakerLab es un espacio para experimentar. Ahora que entiendes cómo funciona el flujo **Cámara -> IA -> Web -> Bluetooth -> Micro:bit**, te invitamos a intentar lo siguiente usando **únicamente** la pantalla de tu Micro:bit:

1.  **Monitor de Postura Inteligente 🧘:** ¡Usa la IA para cuidar tu salud! Entrena un modelo que detecte "Espalda Recta" y "Espalda Encorvada". Programa el Micro:bit para que, si te encorvas, parpadee una gran "X" en su pantalla LED, recordándote que debes sentarte bien.
2.  **Juego de "Piedra, Papel o Tijeras" contra la IA ✌️:** Combina IA con lógica de videojuegos. Entrena a la computadora para reconocer las tres señas. Luego, programa en MakeCode que el Micro:bit elija su propia jugada al azar, la compare con la tuya y muestre una "W" (Ganaste) o "L" (Perdiste).
3.  **Mascota Virtual (Estilo Tamagotchi) 🐾:** Entrena la cámara para reconocer dibujos en papel (ej. una manzana, una gota de agua, una cama). Cuando le muestres la manzana a la cámara, programa el Micro:bit para que muestre una animación de "masticar" en sus LEDs.

*Si tienes alguna idea increíble o mejoras los códigos, ¡no dudes en crear un Pull Request en este repositorio!*
