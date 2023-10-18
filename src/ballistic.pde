ParticleSystem ps;
TextBuffer tb;
int fps = 144;
float moveconst = 5;  // Moltiplicatore di velocità delle particelle
float forcemult = 2;  // Moltiplicatore di forza di gravità
float gconst = 6.67428;
float gsizemult = 0.5;  // Moltiplicatori di grandezza
float psizemult = 1;
boolean bounded = true;  // Muri anelastici sul bordo
float frictionmult = 1;  // Sempre >= 1
float maxdist = 400;  // Limitatore di (raggio^2)
float traildecay = 1;  // Persistenza delle scie
boolean trails = true;  // Esistenza delle scie
int mousemass = -1;  // Forza attrattiva del mouse
float defaultmass = 8;  
float deltamass = 0.2;  // Cambiamento di massa delle particelle piazzate per scorrimento di rotella del mouse
boolean coinfluence = false;  // Attrattività tra particelle
int mode = 0;
int modes = 3;
String[] modenames = {"Particle", "Center of gravity", "Particle Bulk"};
boolean tooltip = false;
int quantity = 10;
float spread = 10;
float spreadconst = 0.854;
Text tiptext;
boolean shifted = false;
int textsize = 18;
PopUp shifttextn;
PopUp shifttexty;
boolean paused = false;

Wrapper wdefaultmass;
Wrapper wmode;

public static float square(float x) {
  return x*x;
}

void mouseClicked() {
  switch(mode) {
    case 0:
    ps.addParticle(new Particle(mouseX-width*0.5, mouseY-height*0.5, defaultmass));
    break;
    
    case 1:
    ps.addGravCenter(new GravCenter(mouseX-width*0.5, mouseY-height*0.5, defaultmass));
    break;
    
    case 2:
    for(int i = 0; i < quantity; i++) {
      ps.addParticle(new Particle((mouseX+random(-spread*spreadconst, spread*spreadconst))-width*0.5, (mouseY+random(-spread*spreadconst, spread*spreadconst))-height*0.5, defaultmass));
    }
  }
}

void mouseWheel(MouseEvent me) {
  defaultmass -= me.getCount()*deltamass;
}

void keyPressed() {
  if(key == CODED) {
    switch(keyCode) {
      default:
      break;
      
      case SHIFT:
      if(shifted) {
        deltamass /= 10;
        tb.remove(shifttexty);
        shifttextn.setTimeleft(fps*2);
        tb.post(shifttextn);
        shifted = false;
      } else {
        deltamass *= 10;
        tb.remove(shifttextn);
        shifttexty.setTimeleft(fps*2);
        tb.post(shifttexty);
        shifted = true;
      }
      break;
    }
  } else {
    switch(key) {
      default:
      break;
      
      case 'c':
      switch(mode) {
         case 0:       
         case 2:
         ps.clearParticles();
         break;
         
         case 1:
         ps.clearGravCenters();
         break;
      }
      break;
      
      case 'j':
      coinfluence = !coinfluence;
      break;
      
      case 'b':
      bounded = !bounded;
      break;
      
      case 'm':
      if(ps.m == null) {
        ps.setMouseGravCenter(new MouseGravCenter(defaultmass));
      } else {
        ps.setMouseGravCenter(null);
      }
      break;
      
      case 's':
      mode++;
      mode = mode % modes;
      break;
      
      case 'q':
      if(tooltip) {
        tooltip = false;
        tb.remove(tiptext);
      } else {
        tooltip = true;
        tb.addText(tiptext);
      }
      break;
      
      case 't':
      trails = !trails;
      if(trails) {
        ps.resetTrails();
      }
      break;
      
      case 'p':
      paused = !paused;
      break;
    }
  }
}


void setup() {  
  size(800, 800);
  textSize(textsize);
  noStroke();
  frameRate(fps);
  ps = new ParticleSystem();
  tb = new TextBuffer();
  tiptext = new Text("Click:  Places an object of mode type at the mouse cursor\nMouse wheel:  Changes the selected mass\nC:  Clear all objects of mode type\nJ:  Toggles attraction between particles\nB:  Toggles screen boundary for particles\nM:  Toggles a gravity center of selected mass at the mouse cursor\nS:  Cycles between modes\nT:  Toggles trails for particles", new PVector(0, -height*0.4), new PVector(CENTER, TOP));
  shifttexty = new PopUp("SHIFT is now active", new PVector(width*0.5, -height*0.5+textsize), fps*2, new PVector(RIGHT, TOP));
  shifttextn = new PopUp("SHIFT is now inactive", new PVector(width*0.5, -height*0.5+textsize), fps*2, new PVector(RIGHT, TOP));
  tb.addText("Press Q for tooltips", new PVector(-width*0.5, -height*0.5+textsize), new PVector(LEFT, TOP));
  
  // wrappers
  wdefaultmass = new Wrapper(defaultmass);
  wmode = new Wrapper(mode);
  tb.addDynamicText("Mass: %d", new PVector(-width*0.5,-height*0.5), wdefaultmass, new PVector(LEFT, TOP));
  tb.addDynamicText("Mode: %d", new PVector(width*0.5,-height*0.5), wmode, new PVector(RIGHT, TOP));
}

void draw() {
  translate(width*0.5, height*0.5);
  
  // drawing
  background(0);
  fill(#FFFFFF);
  ps.display();
  tb.display();
    
  // updating
  if(!paused) {
    wdefaultmass.set(floor(defaultmass*10)/10.0);
    wmode.set(modenames[mode]);
    ps.update();
    tb.update();
  }
}
