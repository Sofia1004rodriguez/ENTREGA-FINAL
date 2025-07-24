String[] destinos = {"PARIS", "BALI", "TOKIO"};
color[] coloresBotones = {
  color(198, 228, 246),
  color(211, 103, 58),
  color(20, 20, 80)
};

color[] coloresTexto = {
  color(87, 122, 176),
  color(252, 223, 202),
  color(242, 104, 137)
};

int botonX = 250;
int botonY = 200;
int botonAncho = 500;
int botonAlto = 80;
int espaciado = 40;

String destinoSeleccionado = "";
int pantalla = 0; // 0 = selección de destino, 1 = pantalla de imagen

PImage imgParis, imgBali, imgTokio;

void setup() {
  size(1000, 600);
  textAlign(CENTER, CENTER);
  textFont(createFont("SansSerif", 36));

  // Cargar imágenes
  imgParis = loadImage("paris.png");
  imgBali = loadImage("bali.png");
  imgTokio = loadImage("tokio.png");
}

void draw() {
  background(232, 192, 145);

  if (pantalla == 0) {
    mostrarPantallaInicio();
  } else if (pantalla == 1) {
    mostrarPantallaDestino();
  }
}

void mostrarPantallaInicio() {
  fill(60, 30, 10);
  textSize(48);
  text("¿A dónde quieres ir hoy?", width / 2, 80);
  textSize(20);
  text("Elige un destino y viste a tu muñeca para ese viaje especial.", width / 2, 130);

  // Botones
  for (int i = 0; i < destinos.length; i++) {
    float y = botonY + i * (botonAlto + espaciado);
    fill(coloresBotones[i]);
    noStroke();
    rect(botonX, y, botonAncho, botonAlto, 40);

    fill(coloresTexto[i]);
    textSize(40);
    text(destinos[i], botonX + botonAncho / 2, y + botonAlto / 2);
  }
}

void mostrarPantallaDestino() {
  background(255);

  // Mostrar imagen según destino
  if (destinoSeleccionado.equals("PARIS")) {
    image(imgParis, 0, 0, width, height);
  } else if (destinoSeleccionado.equals("BALI")) {
    image(imgBali, 0, 0, width, height);
  } else if (destinoSeleccionado.equals("TOKIO")) {
    image(imgTokio, 0, 0, width, height);
  }

  // Texto encima
  fill(255, 255, 255, 180);
  rect(0, height - 60, width, 60);
  fill(0);
  textSize(28);
  text("Has elegido: " + destinoSeleccionado + " — haz clic para volver", width / 2, height - 30);
}

void mousePressed() {
  if (pantalla == 0) {
    for (int i = 0; i < destinos.length; i++) {
      float y = botonY + i * (botonAlto + espaciado);
      if (mouseX > botonX && mouseX < botonX + botonAncho &&
          mouseY > y && mouseY < y + botonAlto) {
        destinoSeleccionado = destinos[i];
        pantalla = 1;
        break;
      }
    }
  } else if (pantalla == 1) {
    pantalla = 0;
    destinoSeleccionado = "";
  }
}
