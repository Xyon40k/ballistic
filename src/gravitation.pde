ParticleSystem ps;
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
    tooltip = !tooltip;
    break;
    
    case 't':
    trails = !trails;
    if(trails) {
      ps.resetTrails();
    }
    break;
  }
}


void setup() {  
  size(800, 800);
  textSize(18);
  noStroke();
  frameRate(fps);
  ps = new ParticleSystem();
}

void draw() {
  background(0);
  fill(#FFFFFF);
  textAlign(LEFT, TOP);
  text("Mass: "+floor(defaultmass*10)/10.0, 0, 0);
  textAlign(RIGHT, TOP);
  text("Mode: "+modenames[mode], width, 0);
  translate(width*0.5, height*0.5);
  ps.display();
  ps.update();
}
