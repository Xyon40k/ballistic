class MouseGravCenter extends GravCenter {
  MouseGravCenter(float mass) {
    super(mouseX,mouseY,mass);
    c = #00E000;
  }
  
  void update() {
    pos.x = mouseX-width*0.5;
    pos.y = mouseY-height*0.5;
  }
}
