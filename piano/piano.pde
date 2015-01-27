import ddf.minim.*;

Minim minim;
AudioPlayer note;

int largeurToucheBlanche = 50;
int nombreDeTouches = 7;
int hauteurMenu = 100;
int hauteurToucheBlanche = 200;
int hauteurToucheNoire = 150;
int largeurToucheNoire = 25;      

int[] noiresNonAffichees = { 0, 3, 7 };

String[] nomsFichiersBlanches = { "2C", "2D", "2E", "2F", "2G", "2A", "2B" };
String[] nomsFichiersNoires = { "2Cs", "2Ds", "2E", "2Fs", "2Gs", "2As", "2B" };

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
  textSize(42);
  text("THE SYNTHÉ", 50, 65);
  fill(0, 0, 255);
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


