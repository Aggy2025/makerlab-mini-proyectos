#include <Servo.h>

#define trigPin 8
#define echoPin 9
#define ledPin 7

Servo myservo;

long duration;
int distance;

int servoPos = 15;
int direccion = 1;

bool tracking = false;
bool radarActivo = true;

// Contador para confirmar que el objeto desapareció
int perdidas = 0;

// ---------- SENSOR ----------
int calculateDistance()
{
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);

  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  // Timeout reducido
  duration = pulseIn(echoPin, HIGH, 20000);

  if (duration == 0)
    return -1;

  return duration * 0.034 / 2;
}

// ---------- COMANDOS ----------
void leerComando()
{
  if (Serial.available())
  {
    String cmd = Serial.readStringUntil('\n');
    cmd.trim();

    if (cmd == "STOP")
      radarActivo = false;

    if (cmd == "START")
      radarActivo = true;
  }
}

// ---------- ESCANEO NORMAL ----------
void scanRadar()
{
  myservo.write(servoPos);

  delay(25);

  distance = calculateDistance();

  Serial.print(servoPos);
  Serial.print(",");
  Serial.print(distance);
  Serial.print(".");

  // Si detecta algo cerca entra en seguimiento
  if (distance > 0 && distance <= 10)
  {
    tracking = true;
    perdidas = 0;
    digitalWrite(ledPin, HIGH);
    return;
  }

  servoPos += direccion;

  if (servoPos >= 165 || servoPos <= 15)
    direccion *= -1;

  delay(20);
}

// ---------- SEGUIMIENTO ----------
void trackObject()
{
  digitalWrite(ledPin, HIGH);

  for (int offset = -8; offset <= 8; offset++)
  {
    leerComando();

    if (!radarActivo)
      return;

    int pos = servoPos + offset;

    pos = constrain(pos, 15, 165);

    myservo.write(pos);

    delay(40);

    distance = calculateDistance();

    Serial.print(pos);
    Serial.print(",");
    Serial.print(distance);
    Serial.print(".");

    // Si todavía existe el objeto
    if (distance > 0 && distance <= 10)
    {
      perdidas = 0;
      servoPos = pos;
    }
    else
    {
      perdidas++;
    }

    // Debe perder el objeto varias veces seguidas
    if (perdidas >= 5)
    {
      tracking = false;
      perdidas = 0;
      digitalWrite(ledPin, LOW);
      return;
    }

    delay(40);
  }
}

// ---------- SETUP ----------
void setup()
{
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  pinMode(ledPin, OUTPUT);

  myservo.attach(11);
  myservo.write(servoPos);

  Serial.begin(9600);
}

// ---------- LOOP ----------
void loop()
{
  leerComando();

  if (!radarActivo)
    return;

  if (tracking)
    trackObject();
  else
    scanRadar();
}
