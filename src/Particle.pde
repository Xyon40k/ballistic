class Particle {
  PVector pos;
  PVector vel;
  float mass;
  color c;
  Trail trail;
  
  Particle(float x, float y, float mass) {
    pos = new PVector(x,y);
    this.mass = mass;
    if(mass > 0) {
      c = #E00000;
    } else {
      c = #00E000;
    }
    vel = new PVector();
    if(trails) {
      trail = new Trail(mass, c);
    }
  }
  
  Particle(float x, float y, float mass, color c) {
    pos = new PVector(x,y);
    this.mass = mass;
    this.c = c;
    vel = new PVector();
    if(trails) {
      trail = new Trail(mass, c);
    }
  }
  
  Particle(float x, float y, float mass, PVector initialvelocity, color c) {
    pos = new PVector(x,y);
    this.mass = mass;
    this.c = c;
    vel = initialvelocity;
    if(trails) {
      trail = new Trail(mass, c);
    }
  }
  
  Particle(float x, float y, float mass, PVector initialvelocity) {
    pos = new PVector(x,y);
    this.mass = mass;
    if(mass > 0) {
      c = #E00000;
    } else {
      c = #00E000;
    }
    vel = initialvelocity;
    if(trails) {
      trail = new Trail(mass, c);
    }
  }
  
  void resetTrail() {
    trail = new Trail(mass, c);
  }
  
  void update(ArrayList<GravCenter> gravs, ArrayList<Particle> particles) {
    if(trails) {
      trail.add(pos);
    }
    
    pos.add(vel);
    if(coinfluence) {
      vel.add(resultingAcc(gravs, particles));
    } else {
      vel.add(resultingAcc(gravs));
    }
    vel.div(frictionmult);
    
    if(bounded) {
      if(pos.x < -width*0.5) {
        pos.x = -width*0.5;
        vel.x *= -1;
      }
      if(pos.x > width*0.5) {
        pos.x = width*0.5;
        vel.x *= -1;
      }
      if(pos.y < -height*0.5) {
        pos.y = -height*0.5;
        vel.y *= -1;
      }
      if(pos.y > height*0.5) {
        pos.y = height*0.5;
        vel.y *= -1;
      }
    }
    
  }
  
  PVector resultingForce(ArrayList<GravCenter> gravs) {
    PVector res = new PVector();
    for(GravCenter gc : gravs) {
      res.add(gc.influence(this));
    }
    
    return res;
  }
  
  PVector resultingForce(ArrayList<GravCenter> gravs, ArrayList<Particle> particles) {
    PVector res = resultingForce(gravs);
    for(Particle p : particles) {
      res.add(p.influence(this));
    }
    
    return res;
  }
  
  PVector resultingAcc(ArrayList<GravCenter> gravs) {
    PVector res = resultingForce(gravs);
    res.div(mass);
    return res;
  }
  
  PVector resultingAcc(ArrayList<GravCenter> gravs, ArrayList<Particle> particles) {
    PVector res = resultingForce(gravs, particles);
    res.div(mass);
    return res;
  }
  
  PVector influence(Particle p) {
    if(p == this) {
      return new PVector(0,0);
    }
    PVector res = new PVector(pos.x-p.pos.x,pos.y-p.pos.y);
    res.setMag(forcemult*gconst*mass*p.mass/max(square(pos.dist(p.pos)),maxdist));
    return res;
  }
  
  void display() {
    fill(c);
    circle(pos.x, pos.y, abs(mass)*psizemult);
    if(trails) {
      trail.display();
    }
  }
}
