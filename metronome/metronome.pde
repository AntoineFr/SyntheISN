import ddf.minim.*;
import controlP5.*;


Minim minim;
AudioPlayer bip;
ControlP5 cp5;

float bpm = 0;
boolean demarre = false;

void setup(){
  minim = new Minim(this);
  size(350, 200);
  cp5 = new ControlP5(this);
  cp5.addSlider("bpm")
     .setPosition(0, 0)
     .setRange(10, 200)
     .setSize(width, 20)
     .setValue(50);
  cp5.getController("bpm").getValueLabel().align(ControlP5.CENTER, ControlP5.CENTER);
  cp5.addButton("demarre")
     .setPosition(0, 21)
     .setSize(50, 20);
  cp5.addButton("arrete")
     .setPosition(0, 21)
     .setSize(50, 20)
     .hide();
  bip = minim.loadFile("bip.wav");
}


public void demarre(int theValue) {
  demarre = true;
  cp5.getController("demarre").hide();
  cp5.getController("arrete").show();
}

public void arrete(int theValue) {
  demarre = false;
  cp5.getController("demarre").show();
  cp5.getController("arrete").hide();
}

int time;
float wait;
void draw(){
  background(255,255,255);
  bpm = cp5.getController("bpm").getValue();
  wait = 60000 / bpm;
  if(demarre){
    if(millis() - time >= wait){
      bip.rewind();
      bip.play();
      time = millis();
    }
  }
}
