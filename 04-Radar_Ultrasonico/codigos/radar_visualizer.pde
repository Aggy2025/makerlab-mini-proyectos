import processing.serial.*;
import processing.sound.*;

Serial myPort;
SoundFile alarma;

String datos = "";

int angulo = 0;
int distancia = 999;

boolean detectando = false;

void setup()
{
  size(1200, 700);
  surface.setResizable(true);
  smooth();

  println(Serial.list());

  // CAMBIA COM9 POR TU PUERTO
  myPort = new Serial(this, "COM9", 9600);
  myPort.bufferUntil('.');

  alarma = new SoundFile(this, "alarm-sfx-sound.wav");
}

void draw()
{
  noStroke();
  fill(0, 35);
  rect(0, 0, width, height);

  dibujarRadar();
  dibujarLineaRadar();
  dibujarTexto();
}

// ================= SERIAL =================

void serialEvent(Serial myPort)
{
  datos = myPort.readStringUntil('.');

  if (datos == null)
    return;

  datos = trim(datos);

  int coma = datos.indexOf(',');

  if (coma < 0)
    return;

  int a = int(datos.substring(0, coma));
  int d = int(datos.substring(coma + 1));

  angulo = a;
  distancia = d;

  // No hay objeto
  if (d <= 0)
  {
    detectando = false;

    if (alarma.isPlaying())
      alarma.stop();

    return;
  }

  detectando = (d <= 10);

  // Sonido
  if (detectando)
  {
    if (!alarma.isPlaying())
      alarma.loop();
  }
  else
  {
    if (alarma.isPlaying())
      alarma.stop();
  }
}

// ================= RADAR =================

void dibujarRadar()
{
  pushMatrix();

  translate(width/2, height*0.9);

  noFill();
  stroke(0, 255, 70);
  strokeWeight(2);

  float r = width*0.9;

  arc(0, 0, r, r, PI, TWO_PI);
  arc(0, 0, r*0.75, r*0.75, PI, TWO_PI);
  arc(0, 0, r*0.5, r*0.5, PI, TWO_PI);
  arc(0, 0, r*0.25, r*0.25, PI, TWO_PI);

  for (int i = 0; i <= 180; i += 30)
  {
    line(
      0,
      0,
      -r/2*cos(radians(i)),
      -r/2*sin(radians(i))
      );
  }

  popMatrix();
}

// ================= LINEA =================

void dibujarLineaRadar()
{
  pushMatrix();

  translate(width/2, height*0.9);

  float largo = height*0.8;

  float anguloEspejo = 180 - angulo;

  if (detectando)
  {
    stroke(255, 0, 0);
    strokeWeight(5);
  } else
  {
    stroke(0, 255, 80);
    strokeWeight(3);
  }

  line(
    0,
    0,
    largo*cos(radians(anguloEspejo)),
    -largo*sin(radians(anguloEspejo))
    );

  popMatrix();
}

// ================= TEXTO =================

void dibujarTexto()
{
  fill(0);
  noStroke();
  rect(0, height-90, width, 90);

  fill(0, 255, 70);
  textSize(26);

  text("RADAR MAKERLAB", 20, height-55);
  text("Ángulo: " + angulo + "°", 320, height-55);

  if (distancia > 0)
    text("Distancia: " + distancia + " cm", 620, height-55);
  else
    text("Distancia: --", 620, height-55);

  if (detectando)
  {
    fill(255, 0, 0);
    text("⚠ OBJETO DETECTADO", 920, height-55);
  } else
  {
    fill(0, 255, 70);
    text("Escaneando...", 920, height-55);
  }
}
