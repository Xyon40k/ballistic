class GravCenter {
  PVector pos;
  float mass;
  color c;
  
  GravCenter(float x, float y, float mass) {
    pos = new PVector(x,y);
    this.mass = mass;
    if(mass > 0) {
      c = #0000E0;
    } else {
      c = #E0E000;
    }
  }
  
  GravCenter(float x, float y, float mass, color c) {
    pos = new PVector(x,y);
    this.mass = mass;
    this.c = c;
  }
  
  PVector influence(Particle p) {
    PVector res = new PVector(pos.x-p.pos.x,pos.y-p.pos.y);
    res.setMag(forcemult*gconst*mass*p.mass/max(square(pos.dist(p.pos)),maxdist));
    return res;
  }
  
  void display() {
    fill(c);
    circle(pos.x, pos.y, mass*gsizemult);
  }
  
  void update() {
    ;
  }
}
