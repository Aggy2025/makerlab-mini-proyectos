# 🖐️ Ejemplos Extra: Visión Artificial y Hand Tracking (Software Puro)

> **MakerLab - Universidad Cenfotec**
> Esta sección contiene proyectos exploratorios que demuestran el poder de la visión por computadora. A diferencia del proyecto principal, estos ejemplos no utilizan hardware (Arduino), sino que interactúan directamente con el software de tu computadora.

En esta carpeta encontrarás 4 scripts de Python que llevan el reconocimiento de manos al siguiente nivel: desde dibujar en la pantalla hasta controlar el cursor de tu computadora al estilo "Minority Report".

---

## 🛠️ Requisitos e Instalación de Librerías

Para correr estos ejemplos, asegúrate de tener instalada la versión **Python 3.11** (marcando la opción "Add to PATH" al instalar). Además de las librerías base (OpenCV y MediaPipe), ocuparemos un par extra para controlar el sistema operativo y realizar cálculos.

Abre tu terminal (CMD o PowerShell) y ejecuta este comando para instalar todo lo necesario:

```bash
pip install opencv-python mediapipe pyautogui numpy
```


# 🧠 Entendiendo las Librerías Extra
Entender qué hace cada herramienta es vital en la filosofía del MakerLab para no quedarse solo en el "copiar y pegar". En estos códigos extra, introdujimos dos librerías nuevas muy poderosas y, de forma deliberada, dejamos de usar una (cvzone).

🖱️ **1. PyAutoGUI (pyautogui)**
¿Qué es? Es una librería de automatización para la Interfaz Gráfica de Usuario (GUI).

Su rol: Es el "Fantasma en la Máquina". Le da a tu código Python el permiso y la capacidad de tomar el control físico de tu mouse y tu teclado.

En el script 2-hand_mouse.py, usamos MediaPipe para saber dónde está tu dedo, pero usamos PyAutoGUI para que el sistema operativo de tu computadora obedezca a ese dedo.

pyautogui.size(): Le pregunta a tu computadora cuál es la resolución exacta de tu monitor.

pyautogui.moveTo(x, y): Mueve la flecha de tu mouse físicamente a ese punto de la pantalla.

pyautogui.click(): Simula el clic izquierdo de un mouse físico.

🧮 **2. NumPy (numpy)**
¿Qué es? Significa Numerical Python. Es la librería matemática más importante de todo el ecosistema de Python, diseñada para hacer cálculos complejos y manejar matrices a altísima velocidad.

Su rol: Es la "Calculadora Científica". Una imagen no es más que una matriz matemática gigante llena de números (píxeles), y NumPy es el experto en manejarlos.

Interpolación (np.interp): Hace una "regla de tres" matemática instantánea para mapear y expandir los movimientos pequeños captados por la cámara a la resolución total de tu pantalla.

Geometría (np.hypot): Calcula la hipotenusa (distancia en línea recta) entre las coordenadas de tus dedos para detectar gestos como "pellizcos".

Lienzos (np.zeros_like): Crea una matriz de ceros (una imagen totalmente negra/transparente) exactamente del mismo tamaño que la imagen de tu cámara para poder pintar sobre ella.

🎓 **El Detalle Educativo**: ¿Por qué ya no usamos cvzone aquí?
En el proyecto principal de Arduino usamos cvzone.HandTrackingModule porque nos hacía la vida muy fácil. Sin embargo, en los scripts 3 y 4 de esta carpeta no la usamos. ¿Por qué? Porque queremos ver cómo funcionan las matemáticas por debajo.

El script 3-hand_tracking.py incluye una función manual. En lugar de depender de una librería mágica, aquí hacemos el trabajo duro: le decimos a Python que compare la coordenada Y de la punta de tu dedo (tip) con la coordenada Y de tu nudillo medio (pip). Si la punta está más alta que el nudillo, ¡significa que el dedo está estirado!

## 🚀 ¿Cómo descargar y ejecutar los scripts?
Mantenemos el mismo estándar que en nuestros proyectos principales. Sigue estos pasos:

- Ve al inicio del repositorio y descarga todo el proyecto (Code > Download ZIP) y descomprímelo.

- Abre una terminal (CMD o PowerShell).

- Navega hasta la carpeta codigos que se encuentra dentro de esta sección de ejemplos extra.

- Ejecuta el script que desees utilizando el comando específico para forzar la versión 3.11 de Python. Por ejemplo:

```Bash
py -3.11 1-hand_detector.py
```
(Recuerda que para cerrar la ventana de la cámara de forma segura y detener el programa, debes presionar la tecla q en tu teclado o ctl+c).

# 📂Catálogo de Códigos
A continuación, se explica qué hace cada archivo y se incluye su código fuente.

1️⃣ **Detector Básico de Manos (01-hand_detector.py)**
**¿Qué hace?** Es el "Hola Mundo" de MediaPipe. Abre tu cámara y dibuja el esqueleto digital (los 21 puntos clave o landmarks) sobre cualquier mano que aparezca en pantalla

```python
import cv2
import mediapipe as mp

mp_hands = mp.solutions.hands
mp_drawing = mp.solutions.drawing_utils
mp_styles = mp.solutions.drawing_styles

def run_hand_tracking():
    cam = cv2.VideoCapture(0)

    with mp_hands.Hands(
        model_complexity=0,
        max_num_hands=2,
        min_detection_confidence=0.5,
        min_tracking_confidence=0.5
    ) as hands:

        while cam.isOpened():
            success, frame = cam.read()

            if not success:
                print("Ignoring empty camera frame.")
                continue

            frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            results = hands.process(frame_rgb)

            if results.multi_hand_landmarks:
                for hand_landmarks in results.multi_hand_landmarks:
                    mp_drawing.draw_landmarks(
                        frame,
                        hand_landmarks,
                        mp_hands.HAND_CONNECTIONS,
                        mp_styles.get_default_hand_landmarks_style(),
                        mp_styles.get_default_hand_connections_style(),
                    )

            cv2.imshow("Detector de manos", cv2.flip(frame, 1))

            if cv2.waitKey(1) & 0xFF == ord("q"):
                break

    cam.release()
    cv2.destroyAllWindows()

run_hand_tracking()
```

**2️⃣ Control de Mouse con la Mano (02-hand_mouse.py)**
**¿Qué hace?** Transforma tu dedo índice en el cursor de tu computadora. El script interpola la posición de tu dedo en la cámara con la resolución de tu monitor. Si bajas el dedo medio, el programa simula un "clic izquierdo". ¡Prueba cerrar ventanas o abrir carpetas sin tocar tu mouse físico!

```python
import cv2
import mediapipe as mp
import pyautogui
import numpy as np

mp_hands = mp.solutions.hands
mp_drawing = mp.solutions.drawing_utils

screen_w, screen_h = pyautogui.size()  # resolución de pantalla

def hand_mouse_control():
    cam = cv2.VideoCapture(0)
    cam.set(3, 640)  # ancho cámara
    cam.set(4, 480)  # alto cámara

    with mp_hands.Hands(
        max_num_hands=1,
        min_detection_confidence=0.7,
        min_tracking_confidence=0.7
    ) as hands:

        while cam.isOpened():
            success, frame = cam.read()
            if not success:
                continue

            frame = cv2.flip(frame, 1)
            frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            results = hands.process(frame_rgb)

            if results.multi_hand_landmarks:
                hand_landmarks = results.multi_hand_landmarks[0]

                # Coordenadas del dedo índice
                index_finger_tip = hand_landmarks.landmark[8]
                x = int(index_finger_tip.x * frame.shape[1])
                y = int(index_finger_tip.y * frame.shape[0])

                # Mapear a resolución de pantalla
                mouse_x = np.interp(x, [0, frame.shape[1]], [0, screen_w])
                mouse_y = np.interp(y, [0, frame.shape[0]], [0, screen_h])

                pyautogui.moveTo(mouse_x, mouse_y)

                # Detectar si dedo medio bajado para clic
                middle_finger_tip = hand_landmarks.landmark[12]
                if index_finger_tip.y < hand_landmarks.landmark[6].y and \
                   middle_finger_tip.y < hand_landmarks.landmark[10].y:
                    pyautogui.click()  # clic izquierdo

                mp_drawing.draw_landmarks(frame, hand_landmarks, mp_hands.HAND_CONNECTIONS)

            cv2.imshow("Hand Mouse Control", frame)
            if cv2.waitKey(1) & 0xFF == ord('q'):
                break

    cam.release()
    cv2.destroyAllWindows()

hand_mouse_control()
```
3️⃣ **Contador de Dedos Matemático (03-hand_tracking.py)**
**¿Qué hace?** En lugar de usar herramientas de terceros, este código incluye una función matemática nativa llamada fingers_up. Calcula si las puntas de tus dedos (tips) están por encima de tus nudillos para saber si están estirados o doblados, y muestra en tiempo real cuántos dedos estás levantando.
```python
import cv2
import mediapipe as mp

# Inicializar MediaPipe Hands y utilidades de dibujo
mp_hands = mp.solutions.hands
mp_drawing = mp.solutions.drawing_utils
mp_styles = mp.solutions.drawing_styles

# Función para detectar dedos levantados
def fingers_up(hand_landmarks, hand_label):
    fingers = []

    # Dedos excepto pulgar
    tips_ids = [8, 12, 16, 20]
    for tip_id in tips_ids:
        # Comparar la y del tip con la y del pip
        if hand_landmarks.landmark[tip_id].y < hand_landmarks.landmark[tip_id - 2].y:
            fingers.append(1)
        else:
            fingers.append(0)

    # Pulgar
    if hand_label == "Right":
        if hand_landmarks.landmark[4].x > hand_landmarks.landmark[3].x:
            fingers.append(1)
        else:
            fingers.append(0)
    else:
        if hand_landmarks.landmark[4].x < hand_landmarks.landmark[3].x:
            fingers.append(1)
        else:
            fingers.append(0)

    return fingers

def run_hand_tracking():
    cam = cv2.VideoCapture(0)

    with mp_hands.Hands(
        model_complexity=0,
        max_num_hands=2,
        min_detection_confidence=0.5,
        min_tracking_confidence=0.5
    ) as hands:

        while cam.isOpened():
            success, frame = cam.read()
            if not success:
                print("Ignorando frame vacío")
                continue

            # Espejo
            frame = cv2.flip(frame, 1)
            frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            results = hands.process(frame_rgb)

            total_fingers = 0

            if results.multi_hand_landmarks:
                for hand_landmarks, handedness in zip(results.multi_hand_landmarks, results.multi_handedness):
                    hand_label = handedness.classification[0].label
                    mp_drawing.draw_landmarks(
                        frame,
                        hand_landmarks,
                        mp_hands.HAND_CONNECTIONS,
                        mp_styles.get_default_hand_landmarks_style(),
                        mp_styles.get_default_hand_connections_style()
                    )

                    fingers = fingers_up(hand_landmarks, hand_label)
                    total_fingers += sum(fingers)

                    # Coordenadas de la muñeca para colocar el número
                    wrist = hand_landmarks.landmark[0]
                    h, w, _ = frame.shape
                    cx, cy = int(wrist.x * w), int(wrist.y * h)

                    cv2.putText(frame, f"{sum(fingers)}", (cx, cy - 20),
                                cv2.FONT_HERSHEY_SIMPLEX, 2, (0, 255, 0), 3)

            cv2.putText(frame, f"Total dedos: {total_fingers}", (50, 50),
                        cv2.FONT_HERSHEY_SIMPLEX, 1.5, (255, 0, 0), 3)

            cv2.imshow("Detector de manos", frame)

            if cv2.waitKey(1) & 0xFF == ord("q"):
                break

    cam.release()
    cv2.destroyAllWindows()

run_hand_tracking()
```
4️⃣ **Pizarra Virtual / Finger Paint (04-finger_paint.py)**
**¿Qué hace?** Convierte el aire en un lienzo. Usa tu dedo índice para dibujar en la pantalla en tiempo real. Utiliza geometría para medir la distancia entre tu pulgar y tu índice: si los juntas (haciendo una pinza o chasquido), la pantalla se borra instantáneamente.

```python
import cv2
import mediapipe as mp
import numpy as np

mp_hands = mp.solutions.hands
mp_drawing = mp.solutions.drawing_utils

# Colores iniciales y canvas
colors = [(0, 0, 255), (255, 0, 0), (0, 255, 0)]  # rojo, azul, verde
color_index = 0
brush_color = colors[color_index]
brush_thickness = 5

canvas = None

def finger_paint():
    global canvas, brush_color, color_index

    cam = cv2.VideoCapture(0)
    cam.set(3, 1280)  # ancho
    cam.set(4, 720)   # alto

    prev_x, prev_y = None, None

    with mp_hands.Hands(
        model_complexity=1,
        max_num_hands=2,
        min_detection_confidence=0.7,
        min_tracking_confidence=0.7
    ) as hands:

        while cam.isOpened():
            success, frame = cam.read()
            if not success:
                continue

            frame = cv2.flip(frame, 1)  # espejo
            if canvas is None:
                canvas = np.zeros_like(frame)

            frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            results = hands.process(frame_rgb)

            if results.multi_hand_landmarks:
                for hand_landmarks in results.multi_hand_landmarks:
                    # Coord dedo índice (landmark 8)
                    x = int(hand_landmarks.landmark[8].x * frame.shape[1])
                    y = int(hand_landmarks.landmark[8].y * frame.shape[0])

                    # Coord pulgar (landmark 4) para detectar gesto de puño cerrado
                    thumb_tip = hand_landmarks.landmark[4]
                    index_tip = hand_landmarks.landmark[8]

                    # Calcular distancia pulgar-indice para gesto de borrado
                    dist = np.hypot((thumb_tip.x - index_tip.x) * frame.shape[1],
                                    (thumb_tip.y - index_tip.y) * frame.shape[0])

                    # Borrar pantalla si distancia < cierto umbral (pulgar tocando índice)
                    if dist < 40:
                        canvas = np.zeros_like(frame)
                        prev_x, prev_y = None, None

                    # Cambiar color si mano abierta (solo ejemplo)
                    if hand_landmarks.landmark[12].y < hand_landmarks.landmark[9].y:
                        color_index = (color_index + 1) % len(colors)
                        brush_color = colors[color_index]

                    # Dibujar línea si hay posición previa
                    if prev_x is not None and prev_y is not None:
                        cv2.line(canvas, (prev_x, prev_y), (x, y), brush_color, brush_thickness)

                    prev_x, prev_y = x, y

                    mp_drawing.draw_landmarks(frame, hand_landmarks, mp_hands.HAND_CONNECTIONS)

            else:
                prev_x, prev_y = None, None

            # Superponer canvas sobre frame
            frame = cv2.addWeighted(frame, 0.7, canvas, 0.3, 0)

            cv2.imshow("Finger Paint", frame)
            if cv2.waitKey(1) & 0xFF == ord('q'):
                break

    cam.release()
    cv2.destroyAllWindows()

finger_paint()
```
