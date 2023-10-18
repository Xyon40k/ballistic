class ParticleSystem {
  ArrayList<Particle> particles;
  ArrayList<GravCenter> gravs;
  MouseGravCenter m;
  int pcount;
  int gcount;
  
  ParticleSystem() {
    pcount = 0;
    gcount = 0;
    particles = new ArrayList<Particle>();
    gravs = new ArrayList<GravCenter>();
  }
  
  void addParticle(Particle p) {
    particles.add(p);
  }
  
  void addGravCenter(GravCenter gc) {
    gravs.add(gc);
  }
  
  void setMouseGravCenter(MouseGravCenter mgc) {
    m = mgc;
    gravs.add(m);
  }
  
  void update() {
    for(Particle p : particles) {
      p.update(gravs, particles);
    }
    
    if(m != null) {
      m.update();
    }
  }
  
  void display() {
    for(Particle p : particles) {
      p.display();
    }
    
    for(GravCenter gc : gravs) {
      gc.display();
    }

    if(m != null) {
      m.display();
    }
  }
  
  void resetTrails() {
    for(Particle p : particles) {
      p.resetTrail();
    }
  }
  
  void clearParticles() {
    particles = new ArrayList<Particle>();
  }
  
  void clearGravCenters() {
    gravs = new ArrayList<GravCenter>();
  }
}
