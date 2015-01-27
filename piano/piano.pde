import ddf.minim.*;
import controlP5.*;

Minim minim;
AudioPlayer note,bip;
ControlP5 cp5;

int largeurToucheBlanche = 50;
int nombreDeTouches = 7;
int hauteurMenu = 100;
int hauteurToucheBlanche = 200;
int hauteurToucheNoire = 150;
int largeurToucheNoire = 25;      

int[] noiresNonAffichees = { 0, 3, 7 };

String[] nomsFichiersBlanches = { "2C", "2D", "2E", "2F", "2G", "2A", "2B" };
String[] nomsFichiersNoires = { "2Cs", "2Ds", "2E", "2Fs", "2Gs", "2As", "2B" };

// Métronome
float bpm = 0;
boolean demarre = false;
int timestamp;
float attente;

//************************Fonctions******************************

boolean contient(int[] tableau, int elt){
  for (int i = 0 ; i < tableau.length; i++){
    if (tableau[i] == elt){
      return true;
    }
  }
  return false;
}

//****************************Procédures**************************

void setup(){
  minim = new Minim(this);
  size(nombreDeTouches * largeurToucheBlanche, hauteurMenu + hauteurToucheBlanche);
  
  // Contrôles du métronome
  cp5 = new ControlP5(this);
  cp5.addSlider("bpm")
     .setPosition(0, hauteurMenu - 20)
     .setRange(10, 200)
     .setSize(width - 51, 20)
     .setValue(50);
  cp5.getController("bpm").getValueLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  cp5.addButton("demarre")
     .setPosition(width - 50, hauteurMenu - 20)
     .setSize(50, 20);
  cp5.addButton("arrete")
     .setPosition(width - 50, hauteurMenu - 20)
     .setSize(50, 20)
     .hide();
  bip = minim.loadFile("bip.wav");
  
}

void demarre(int theValue) {
  demarre = true;
  cp5.getController("demarre").hide();
  cp5.getController("arrete").show();
}

void arrete(int theValue) {
  demarre = false;
  cp5.getController("demarre").show();
  cp5.getController("arrete").hide();
}

void dessinerTouches() {
  for(int i = 0 ; i < nombreDeTouches ; i++){ //Dessine les touches blanches
    fill(255, 255, 255);
    rect(i * largeurToucheBlanche, hauteurMenu, largeurToucheBlanche, hauteurToucheBlanche);
    
    if (! contient(noiresNonAffichees, i)){ //Dessine les touches noires
      fill(0,0,1);
      rect((i * largeurToucheBlanche) - largeurToucheNoire / 2, hauteurMenu, largeurToucheNoire, hauteurToucheNoire);
    }
  }
}


void draw(){
  background(255,255,255);
  textSize(42);
  fill(0, 0, 255);
  text("THE SYNTHÉ", 50, 45);
  
  dessinerTouches();
  bpm = cp5.getController("bpm").getValue();
  attente = 60000 / bpm;
  if(demarre){
    if(millis() - timestamp >= attente){
      bip.rewind();
      bip.play();
      timestamp = millis();
    }
  }
  
}

void mousePressed(){
  if(mouseY <= hauteurMenu) return;
  color noir = color(0,0,1);
  color blanc = color(255,255,255);
  color couleur = get(mouseX, mouseY);
  
  if (couleur == noir){
    int touche = ((mouseX + largeurToucheNoire/2) - largeurToucheBlanche) / largeurToucheBlanche;
    note = minim.loadFile(nomsFichiersNoires[touche] + ".mp3");
    note.play();
  }
  else if (couleur == blanc){
    int touche = mouseX / largeurToucheBlanche;
    note = minim.loadFile(nomsFichiersBlanches[touche] + ".mp3");
    note.play();
  }
}


