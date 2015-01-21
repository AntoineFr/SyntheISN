import ddf.minim.*;

Minim minim;
AudioPlayer note;

int largeurTouche = 50;
int nombreDeTouches = 7;
int hauteurMenu = 100;
int hauteurTouche = 200;
String[] fichiers = { "2C", "2D", "2E", "2F", "2G", "2A", "2B" };

void setup(){
  minim = new Minim(this);
  size(nombreDeTouches * largeurTouche, hauteurMenu + hauteurTouche);
  for(int i = 0 ; i < nombreDeTouches ; i++){
    rect(i * largeurTouche, hauteurMenu, largeurTouche, hauteurTouche);
  }
  
}

void draw(){
  textSize(42);
  text("THE SYNTHÉ", 50, 65);
  fill(0, 0, 255);
}

void mouseClicked(){
  if(mouseY <= hauteurMenu) return;
  int touche = mouseX / largeurTouche;
  
  note = minim.loadFile(fichiers[touche] + ".mp3");
  note.play();
  
}


