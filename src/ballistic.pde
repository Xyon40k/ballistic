ParticleSystem ps;
TextBuffer tb;
int fps = 144;
float moveconst = 5;  // Moltiplicatore di velocità delle particelle
float forcemult = 2;  // Moltiplicatore di forza di gravità
float gconst = 6.67428;
float gsizemult = 0.5;  // Moltiplicatori di grandezza
float psizemult = 1;
boolean bounded = true;  // Muri anelastici sul bordo
float frictionmult = 1.00;  // Sempre >= 1
float maxdist = 400;  // Limitatore di (raggio^2)
float traildecay = 1;  // Persistenza delle scie
boolean trails = true;  // Esistenza delle scie
float defaultmass = 8;
float deltaparam = 0.2;  // Cambiamento di massa delle particelle piazzate per scorrimento di rotella del mouse
boolean coinfluence = false;  // Attrattività tra particelle
int mode = 0;
int modes = 3;
String[] modenames = {"Particle", "Center of gravity", "Particle Bulk"};
String[] paramnames = {"Mass", "Friction", "Force", "Bulk spread", "Bulk quantity"};
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
int currparam = 0;
int params = 5;
float displayvalue;

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
  float delta = me.getCount()*deltaparam;
  switch(currparam) {
    case 0:
    defaultmass -= delta;
    break;
    
    case 1:
    frictionmult -= delta*0.01;
    break;
    
    case 2:
    forcemult -= delta*0.5;
    break;
    
    case 3:
    spread -= delta*5;
    break;
    
    case 4:
    quantity -= delta*5;
    break;
  }
}

void keyPressed() {
  if(key == CODED) {
    switch(keyCode) {
      default:
      break;
      
      case SHIFT:
      if(shifted) {
        deltaparam /= 10;
        tb.remove(shifttexty);
        shifttextn.setTimeleft(fps*2);
        tb.post(shifttextn);
        shifted = false;
      } else {
        deltaparam *= 10;
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
      
      case 'a':
      currparam++;
      currparam = currparam % params;
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
  tiptext = new Text("Click:  Places an object of mode type at the mouse cursor\nMouse wheel:  Changes the currently selected parameter\nC:  Clear all objects of mode type\nJ:  Toggles attraction between particles\nB:  Toggles screen boundary for particles\nM:  Toggles a gravity center of selected mass at the mouse cursor\nS:  Cycles between modes\nT:  Toggles trails for particles\nP:  Pauses the simulation\nA:  Cycles between parameters to change", new PVector(0, -height*0.4), new PVector(CENTER, TOP));
  shifttexty = new PopUp("SHIFT is now active", new PVector(width*0.5, -height*0.5+textsize), fps*2, new PVector(RIGHT, TOP));
  shifttextn = new PopUp("SHIFT is now inactive", new PVector(width*0.5, -height*0.5+textsize), fps*2, new PVector(RIGHT, TOP));
  
  // wrappers
  wdefaultmass = new Wrapper(defaultmass);  //TODO: change text based on chosen parameter
  wmode = new Wrapper(mode);
  tb.addDynamicText("Mode: %d", new PVector(width*0.5,-height*0.5), wmode, new PVector(RIGHT, TOP));
}

void draw() {
  translate(width*0.5, height*0.5);
  
  // drawing
  background(0);
  fill(#FFFFFF);
  ps.display();
  tb.display();
  fill(#FFFFFF);

  switch(currparam) {
    case 0:
    displayvalue = defaultmass;
    break;
    
    case 1:
    displayvalue = frictionmult;
    break;
    
    case 2:
    displayvalue = forcemult;
    break;
    
    case 3:
    displayvalue = spread;
    break;
    
    case 4:
    displayvalue = quantity;
    break;
  }
  textAlign(LEFT, TOP);
  text(paramnames[currparam]+": "+displayvalue, -width*0.5, -height*0.5);
  text("Press Q for tooltips", -width*0.5, -height*0.5+textsize);
  
  // updating
  if(!paused) {
    wdefaultmass.set(floor(defaultmass*10)/10.0);
    wmode.set(modenames[mode]);
    ps.update();
    tb.update();
  }
}
