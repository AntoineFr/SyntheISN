import ddf.minim.*;

Minim minim;
AudioPlayer note, son;

int largeurToucheBlanche = 50;
int nombreDeTouches = 7;
int hauteurMenu = 100;
int hauteurToucheBlanche = 200;
int hauteurToucheNoire = 150;
int largeurToucheNoire = 25;      

int[] noiresNonAffichees = { 0, 3, 7 };

String[] nomsFichiersBlanches = { "2C", "2D", "2E", "2F", "2G", "2A", "2B" };
AudioPlayer[] fichiersSonsBlanches = {};

String[] nomsFichiersNoires = { "2Cs", "2Ds", "2E", "2Fs", "2Gs", "2As", "2B" };
AudioPlayer[] fichiersSonsNoires = {};

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
  
  for(int i = 0 ; i < nomsFichiersBlanches.length ; i++){ //Crée deux listes de sons, une pour les noires, une pour les blanches
    son = minim.loadFile(nomsFichiersBlanches[i] + ".mp3"); 
    fichiersSonsBlanches = (AudioPlayer[]) append(fichiersSonsBlanches, son);
    
    son = minim.loadFile(nomsFichiersNoires[i] + ".mp3");
    fichiersSonsNoires = (AudioPlayer[]) append(fichiersSonsNoires, son);
  }

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

void mouseClicked(){
  if(mouseY <= hauteurMenu) return;
  color noir = color(0,0,1);
  color blanc = color(255,255,255);
  color couleur = get(mouseX, mouseY);
  
  if (couleur == noir){
    int touche = ((mouseX + largeurToucheNoire/2) - largeurToucheBlanche) / largeurToucheBlanche;
    note = fichiersSonsNoires[touche];
    note.rewind();
    note.play();
  }
  else if (couleur == blanc){
    int touche = mouseX / largeurToucheBlanche;
    note = fichiersSonsBlanches[touche];
    note.rewind();
    note.play();
  }
}


