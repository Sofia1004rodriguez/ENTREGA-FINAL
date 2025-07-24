import processing.sound.*;

// Lista de nombres de los destinos disponibles
String[] destinos = {"PARIS", "BALI", "TOKIO"};

// Colores de fondo para los botones de cada destino
color[] coloresBotones = {
  color(198, 228, 246),
  color(211, 103, 58),
  color(20, 20, 80)
};

// Colores del texto en los botones de cada destino
color[] coloresTexto = {
  color(87, 122, 176),
  color(252, 223, 202),
  color(242, 104, 137)
};

// Estado actual de la aplicación:
// 0 = pantalla de inicio
// 1 = pantalla de muneca por destino
// 2 = pantalla de outfit final
int pantalla = 0;

// Guarda el destino y el outfit seleccionados por el usuario
String destinoSeleccionado = "";
String outfitSeleccionado = "";

// Imágenes de fondo y outfits
PImage paris, bali, tokio;
PImage paris1, paris2, paris3;
PImage bali1, bali2, bali3;
PImage tokio1, tokio2, tokio3;

// Arreglos para los elementos que se reutilizan
BotonDestino[] botones = new BotonDestino[3];
Muneca[] munecas = new Muneca[3];
Outfit[] outfits = new Outfit[9];

// Objetos de sonido
SoundFile musicaParis, musicaBali, musicaTokio;
SoundFile musicaActual;

void setup() {
  size(1000, 600);
  textAlign(CENTER, CENTER);
  textFont(createFont("SansSerif", 36));

  // Cargar imagenes de fondo
  paris = loadImage("paris.png");
  bali = loadImage("bali.png");
  tokio = loadImage("tokio.png");

  // Cargar imagenes de outfits
  paris1 = loadImage("paris1.png");
  paris2 = loadImage("paris2.png");
  paris3 = loadImage("paris3.png");

  bali1 = loadImage("bali1.png");
  bali2 = loadImage("bali2.png");
  bali3 = loadImage("bali3.png");

  tokio1 = loadImage("tokio1.png");
  tokio2 = loadImage("tokio2.png");
  tokio3 = loadImage("tokio3.png");

  // Crear botones
  for (int i = 0; i < destinos.length; i++) {
    botones[i] = new BotonDestino(250, 200 + i * 120, 500, 80, destinos[i], coloresBotones[i], coloresTexto[i]);
  }

  // Crear muñecas
  munecas[0] = new Muneca(paris, "PARIS");
  munecas[1] = new Muneca(bali, "BALI");
  munecas[2] = new Muneca(tokio, "TOKIO");

  // Crear outfits
  outfits[0] = new Outfit(paris1, "paris1");
  outfits[1] = new Outfit(paris2, "paris2");
  outfits[2] = new Outfit(paris3, "paris3");

  outfits[3] = new Outfit(bali1, "bali1");
  outfits[4] = new Outfit(bali2, "bali2");
  outfits[5] = new Outfit(bali3, "bali3");

  outfits[6] = new Outfit(tokio1, "tokio1");
  outfits[7] = new Outfit(tokio2, "tokio2");
  outfits[8] = new Outfit(tokio3, "tokio3");

  // Cargar música por destino
  musicaParis = new SoundFile(this, "paris.mp3");
  musicaBali = new SoundFile(this, "bali.mp3");
  musicaTokio = new SoundFile(this, "tokio.mp3");
}

void draw() {
  background(232, 192, 145);

  if (pantalla == 0) {
    textSize(48);
    fill(60, 30, 10);
    text("¿A donde quieres ir hoy?", width / 2, 80);
    textSize(20);
    text("Elige un destino y viste a tu muñeca para ese viaje especial", width / 2, 130);

    for (BotonDestino b : botones) {
      b.dibujar();
    }

  } else if (pantalla == 1) {
    for (Muneca m : munecas) {
      if (m.nombre.equals(destinoSeleccionado)) {
        m.mostrar();
      }
    }

  } else if (pantalla == 2) {
    for (Outfit o : outfits) {
      if (o.nombre.equals(outfitSeleccionado)) {
        o.mostrar();
      }
    }
  }
}

void mousePressed() {
  if (pantalla == 0) {
    for (BotonDestino b : botones) {
      if (b.fuePresionado(mouseX, mouseY)) {
        destinoSeleccionado = b.nombre;
        pantalla = 1;
        reproducirMusicaPorDestino(destinoSeleccionado);
        break;
      }
    }
  } else if (pantalla == 1) {
    if (mouseX < width / 3) {
      outfitSeleccionado = destinoSeleccionado.toLowerCase() + "1";
    } else if (mouseX < 2 * width / 3) {
      outfitSeleccionado = destinoSeleccionado.toLowerCase() + "2";
    } else {
      outfitSeleccionado = destinoSeleccionado.toLowerCase() + "3";
    }
    pantalla = 2;
  } else if (pantalla == 2) {
    pantalla = 0;
    destinoSeleccionado = "";
    outfitSeleccionado = "";
    detenerMusica();
  }
}

void reproducirMusicaPorDestino(String destino) {
  detenerMusica();  // Detener cualquier música anterior

  if (destino.equals("PARIS")) {
    musicaParis.loop();
    musicaActual = musicaParis;
  } else if (destino.equals("BALI")) {
    musicaBali.loop();
    musicaActual = musicaBali;
  } else if (destino.equals("TOKIO")) {
    musicaTokio.loop();
    musicaActual = musicaTokio;
  }
}

void detenerMusica() {
  if (musicaActual != null && musicaActual.isPlaying()) {
    musicaActual.stop();
  }
  musicaActual = null;
}

// Clases
class BotonDestino {
  float x, y, w, h;
  String nombre;
  color fondo, texto;

  BotonDestino(float x, float y, float w, float h, String nombre, color fondo, color texto) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.nombre = nombre;
    this.fondo = fondo;
    this.texto = texto;
  }

  void dibujar() {
    fill(fondo);
    noStroke();
    rect(x, y, w, h, 40);
    fill(texto);
    textSize(40);
    text(nombre, x + w / 2, y + h / 2);
  }

  boolean fuePresionado(float mx, float my) {
    return mx > x && mx < x + w && my > y && my < y + h;
  }
}

class Muneca {
  PImage imagen;
  String nombre;

  Muneca(PImage img, String nombre) {
    this.imagen = img;
    this.nombre = nombre;
  }

  void mostrar() {
    image(imagen, 0, 0, width, height);
  }
}

class Outfit {
  PImage imagen;
  String nombre;

  Outfit(PImage img, String nombre) {
    this.imagen = img;
    this.nombre = nombre;
  }

  void mostrar() {
    image(imagen, 0, 0, width, height);
  }
}
