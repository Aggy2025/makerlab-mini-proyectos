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

# 1️⃣ Detector Básico de Manos (01-hand_detector.py)
**¿Qué hace?** Es el "Hola Mundo" de MediaPipe. Abre tu cámara y dibuja el esqueleto digital (los 21 puntos clave o landmarks) sobre cualquier mano que aparezca en pantalla

```python
import cv2
import mediapipe as mp

# Cargar los módulos de dibujo y detección de manos de MediaPipe
mp_hands = mp.solutions.hands
mp_drawing = mp.solutions.drawing_utils
mp_styles = mp.solutions.drawing_styles

def run_hand_tracking():
    # Iniciar la captura de video (0 suele ser la cámara web principal)
    cam = cv2.VideoCapture(0)

    # Configurar el modelo de Inteligencia Artificial
    with mp_hands.Hands(
        model_complexity=0,         # 0 es más rápido, 1 es más preciso
        max_num_hands=2,            # Número máximo de manos a detectar
        min_detection_confidence=0.5, # Umbral de confianza para detectar (50%)
        min_tracking_confidence=0.5   # Umbral de confianza para seguir el movimiento (50%)
    ) as hands:

        # Bucle principal: se ejecuta mientras la cámara esté abierta
        while cam.isOpened():
            success, frame = cam.read() # Leer un cuadro (foto) de la cámara

            if not success:
                print("Ignoring empty camera frame.")
                continue

            # MediaPipe requiere colores en formato RGB, pero OpenCV usa BGR por defecto.
            # Aquí hacemos la conversión para que la IA entienda la imagen.
            frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            
            # Procesar la imagen y buscar manos
            results = hands.process(frame_rgb)

            # Si se encontraron manos en la imagen...
            if results.multi_hand_landmarks:
                # Recorrer cada mano detectada
                for hand_landmarks in results.multi_hand_landmarks:
                    # Dibujar los puntos (landmarks) y las líneas que los conectan
                    mp_drawing.draw_landmarks(
                        frame, # Imagen donde vamos a dibujar
                        hand_landmarks, # Coordenadas de los puntos de la mano
                        mp_hands.HAND_CONNECTIONS, # Conexiones (huesos)
                        mp_styles.get_default_hand_landmarks_style(), # Estilo de los puntos
                        mp_styles.get_default_hand_connections_style(), # Estilo de las líneas
                    )

            # Mostrar el resultado en una ventana (cv2.flip crea un efecto espejo)
            cv2.imshow("Detector de manos", cv2.flip(frame, 1))

            # Esperar 1 milisegundo por si el usuario presiona la tecla 'q' para salir
            if cv2.waitKey(1) & 0xFF == ord("q"):
                break

    # Liberar la cámara y cerrar todas las ventanas al terminar
    cam.release()
    cv2.destroyAllWindows()

# Ejecutar la función
run_hand_tracking()
```

# 2️⃣ Control de Mouse con la Mano (02-hand_mouse.py)

**¿Qué hace?** Transforma tu dedo índice en el cursor de tu computadora. El script interpola la posición de tu dedo en la cámara con la resolución de tu monitor. Si bajas el dedo medio, el programa simula un "clic izquierdo". ¡Prueba cerrar ventanas o abrir carpetas sin tocar tu mouse físico!

```python
import cv2
import mediapipe as mp
import pyautogui
import numpy as np

# Inicializar módulos de MediaPipe
mp_hands = mp.solutions.hands
mp_drawing = mp.solutions.drawing_utils

# Obtener la resolución exacta de tu monitor (ej. 1920x1080)
screen_w, screen_h = pyautogui.size()

def hand_mouse_control():
    cam = cv2.VideoCapture(0)
    # Ajustar la resolución de la cámara para que el proceso sea rápido
    cam.set(3, 640)  # ancho
    cam.set(4, 480)  # alto

    with mp_hands.Hands(
        max_num_hands=1, # Solo queremos controlar el mouse con 1 mano a la vez
        min_detection_confidence=0.7,
        min_tracking_confidence=0.7
    ) as hands:

        while cam.isOpened():
            success, frame = cam.read()
            if not success:
                continue

            # Crear efecto espejo inmediatamente para coordinar mejor los movimientos
            frame = cv2.flip(frame, 1)
            frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            results = hands.process(frame_rgb)

            if results.multi_hand_landmarks:
                # Tomar los datos de la primera mano detectada
                hand_landmarks = results.multi_hand_landmarks[0]

                # Obtener las coordenadas del PUNTO 8 (Punta del dedo índice)
                index_finger_tip = hand_landmarks.landmark[8]
                # Multiplicar por el tamaño del frame porque MediaPipe devuelve valores entre 0 y 1
                x = int(index_finger_tip.x * frame.shape[1])
                y = int(index_finger_tip.y * frame.shape[0])

                # MATEMÁTICAS: Regla de tres (Interpolación)
                # Convertir las coordenadas de la cámara (pequeñas) a las de la pantalla (grandes)
                mouse_x = np.interp(x, [0, frame.shape[1]], [0, screen_w])
                mouse_y = np.interp(y, [0, frame.shape[0]], [0, screen_h])

                # Mover el mouse real de la computadora
                pyautogui.moveTo(mouse_x, mouse_y)

                # DETECCIÓN DE CLIC:
                # Obtener las coordenadas del dedo medio
                middle_finger_tip = hand_landmarks.landmark[12]
                
                # Si la punta del índice está ARRIBA de su nudillo (dedo estirado)
                # Y la punta del medio está ABAJO de su nudillo (dedo doblado hacia abajo)
                if index_finger_tip.y < hand_landmarks.landmark[6].y and \
                   middle_finger_tip.y > hand_landmarks.landmark[10].y:
                    pyautogui.click()  # Simular clic izquierdo

                # Dibujar esqueleto para visualizar
                mp_drawing.draw_landmarks(frame, hand_landmarks, mp_hands.HAND_CONNECTIONS)

            cv2.imshow("Hand Mouse Control", frame)
            if cv2.waitKey(1) & 0xFF == ord('q'):
                break

    cam.release()
    cv2.destroyAllWindows()

hand_mouse_control()
```
# 3️⃣ Contador de Dedos Matemático (03-hand_tracking.py)

**¿Qué hace?** En lugar de usar herramientas de terceros, este código incluye una función matemática nativa llamada fingers_up. Calcula si las puntas de tus dedos (tips) están por encima de tus nudillos para saber si están estirados o doblados, y muestra en tiempo real cuántos dedos estás levantando.
```python
import cv2
import mediapipe as mp

mp_hands = mp.solutions.hands
mp_drawing = mp.solutions.drawing_utils
mp_styles = mp.solutions.drawing_styles

# Función personalizada para saber qué dedos están levantados
def fingers_up(hand_landmarks, hand_label):
    fingers = []

    # Identificadores de las puntas de los dedos: índice(8), medio(12), anular(16), meñique(20)
    tips_ids = [8, 12, 16, 20]
    
    # Evaluar los 4 dedos largos
    for tip_id in tips_ids:
        # En la pantalla, la coordenada Y aumenta hacia abajo. 
        # Si la Y de la punta es MENOR que la Y de dos nudillos más abajo, el dedo está levantado.
        if hand_landmarks.landmark[tip_id].y < hand_landmarks.landmark[tip_id - 2].y:
            fingers.append(1) # Levantado
        else:
            fingers.append(0) # Doblado

    # Evaluar el pulgar (su mecánica es diferente, se mueve en el eje X, no en el Y)
    if hand_label == "Right": # Si es la mano derecha
        # Compara la posición horizontal de la punta (4) con el nudillo (3)
        if hand_landmarks.landmark[4].x > hand_landmarks.landmark[3].x:
            fingers.append(1)
        else:
            fingers.append(0)
    else: # Si es la mano izquierda
        if hand_landmarks.landmark[4].x < hand_landmarks.landmark[3].x:
            fingers.append(1)
        else:
            fingers.append(0)

    # Retorna una lista de 5 números (ej. [1, 0, 0, 0, 0] significa solo pulgar levantado)
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

            frame = cv2.flip(frame, 1) # Efecto espejo vital para la lógica del pulgar
            frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            results = hands.process(frame_rgb)

            total_fingers = 0

            if results.multi_hand_landmarks:
                # zip une las coordenadas de la mano con la etiqueta (Izquierda/Derecha)
                for hand_landmarks, handedness in zip(results.multi_hand_landmarks, results.multi_handedness):
                    hand_label = handedness.classification[0].label # "Left" o "Right"
                    
                    # Dibujar puntos
                    mp_drawing.draw_landmarks(
                        frame, hand_landmarks, mp_hands.HAND_CONNECTIONS,
                        mp_styles.get_default_hand_landmarks_style(),
                        mp_styles.get_default_hand_connections_style()
                    )

                    # Llamar a nuestra función matemática
                    fingers = fingers_up(hand_landmarks, hand_label)
                    # Sumar los 1s de la lista para saber el total de dedos levantados
                    total_fingers += sum(fingers)

                    # Obtener la coordenada de la muñeca (punto 0) para escribir el número encima de cada mano
                    wrist = hand_landmarks.landmark[0]
                    h, w, _ = frame.shape
                    cx, cy = int(wrist.x * w), int(wrist.y * h)

                    # Escribir el número de dedos de cada mano cerca de su muñeca
                    cv2.putText(frame, f"{sum(fingers)}", (cx, cy - 20),
                                cv2.FONT_HERSHEY_SIMPLEX, 2, (0, 255, 0), 3)

            # Escribir el total sumado de ambas manos en la esquina superior izquierda
            cv2.putText(frame, f"Total dedos: {total_fingers}", (50, 50),
                        cv2.FONT_HERSHEY_SIMPLEX, 1.5, (255, 0, 0), 3)

            cv2.imshow("Contador Matematico", frame)

            if cv2.waitKey(1) & 0xFF == ord("q"):
                break

    cam.release()
    cv2.destroyAllWindows()

run_hand_tracking()
```
# 4️⃣ Pizarra Virtual / Finger Paint (04-finger_paint.py)

**¿Qué hace?** Convierte el aire en un lienzo. Usa tu dedo índice para dibujar en la pantalla en tiempo real. Utiliza geometría para medir la distancia entre tu pulgar y tu índice: si los juntas (haciendo una pinza o chasquido), la pantalla se borra instantáneamente.

```python
import cv2
import mediapipe as mp
import numpy as np

mp_hands = mp.solutions.hands
mp_drawing = mp.solutions.drawing_utils

# Definir una lista de colores (Formato BGR de OpenCV: Azul, Verde, Rojo)
colors = [(0, 0, 255), (255, 0, 0), (0, 255, 0)]  # Rojo, Azul, Verde
color_index = 0
brush_color = colors[color_index]
brush_thickness = 5

# Variable global que actuará como nuestro lienzo transparente
canvas = None

def finger_paint():
    global canvas, brush_color, color_index

    cam = cv2.VideoCapture(0)
    cam.set(3, 1280)  # Establecer resolución HD para tener más espacio de dibujo
    cam.set(4, 720)

    # Variables para recordar dónde estaba el dedo un instante atrás y poder trazar una línea
    prev_x, prev_y = None, None

    with mp_hands.Hands(
        model_complexity=1, # Subimos la complejidad para más precisión al dibujar
        max_num_hands=2,
        min_detection_confidence=0.7,
        min_tracking_confidence=0.7
    ) as hands:

        while cam.isOpened():
            success, frame = cam.read()
            if not success:
                continue

            frame = cv2.flip(frame, 1)  # Espejo

            # Si es la primera vez que corre, crear un lienzo negro del mismo tamaño que la cámara
            if canvas is None:
                canvas = np.zeros_like(frame)

            frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            results = hands.process(frame_rgb)

            if results.multi_hand_landmarks:
                for hand_landmarks in results.multi_hand_landmarks:
                    # 1. Extraer las coordenadas del índice (pincel)
                    x = int(hand_landmarks.landmark[8].x * frame.shape[1])
                    y = int(hand_landmarks.landmark[8].y * frame.shape[0])

                    # 2. Extraer los puntos del pulgar y el índice para calcular distancia
                    thumb_tip = hand_landmarks.landmark[4]
                    index_tip = hand_landmarks.landmark[8]

                    # GEOMETRÍA: Calcular la distancia (Hipotenusa) entre pulgar e índice
                    dist = np.hypot((thumb_tip.x - index_tip.x) * frame.shape[1],
                                    (thumb_tip.y - index_tip.y) * frame.shape[0])

                    # 3. GESTO DE BORRAR: Si la distancia es menor a 40 píxeles (dedos tocándose)
                    if dist < 40:
                        canvas = np.zeros_like(frame) # Resetear el lienzo a negro
                        prev_x, prev_y = None, None   # Soltar el trazo

                    # 4. GESTO CAMBIO DE COLOR: Si abres toda la mano (dedo medio estirado)
                    # Cambia de color iterando por la lista de forma cíclica
                    if hand_landmarks.landmark[12].y < hand_landmarks.landmark[9].y:
                        color_index = (color_index + 1) % len(colors)
                        brush_color = colors[color_index]

                    # 5. DIBUJAR: Si ya teníamos un punto anterior, trazar una línea hasta el nuevo punto
                    if prev_x is not None and prev_y is not None:
                        cv2.line(canvas, (prev_x, prev_y), (x, y), brush_color, brush_thickness)

                    # Guardar la posición actual como la "anterior" para el siguiente ciclo
                    prev_x, prev_y = x, y

                    # Dibujar el esqueleto (opcional, ayuda a ver la detección)
                    mp_drawing.draw_landmarks(frame, hand_landmarks, mp_hands.HAND_CONNECTIONS)

            else:
                # Si no hay manos en pantalla, soltar el trazo para que no se dibujen líneas rectas feas al regresar
                prev_x, prev_y = None, None

            # FUSIÓN: Combinar el cuadro de la cámara real (frame) con el lienzo de dibujo (canvas)
            # addWeighted mezcla las imágenes (70% cámara, 30% dibujos) para que parezca un holograma
            frame = cv2.addWeighted(frame, 0.7, canvas, 0.3, 0)

            cv2.imshow("Finger Paint MakerLab", frame)
            
            # Presionar 'q' para salir
            if cv2.waitKey(1) & 0xFF == ord('q'):
                break

    cam.release()
    cv2.destroyAllWindows()

finger_paint()
```
