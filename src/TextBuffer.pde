class TextBuffer {
  ArrayList<PopUp> list;
  
  TextBuffer() {
    list = new ArrayList<PopUp>();
  }
  
  TextBuffer(PopUp p) {
    list = new ArrayList<PopUp>();
    list.add(p);
  }
  
  void post(String text, PVector pos, int timeleft) {
    list.add(new PopUp(text, pos, timeleft));
  }
  
  void post(String text, PVector pos, int timeleft, PVector alignment) {
    list.add(new PopUp(text, pos, timeleft, alignment));
  }
  
  void post(String text, PVector pos, int timeleft, PVector alignment, color c) {
    list.add(new PopUp(text, pos, timeleft, alignment, c));
  }
  
  void update() {
    PopUp t;
    for(int i = 0; i < list.size(); i++) {
      t = list.get(i);
      if(t.update()) {
        list.remove(i);
      }
    }
  }
  
  void display() {
    for(int i = 0; i < list.size(); i++) {
      list.get(i).display();
    }
  }
  
  class PopUp {
    String text;
    color c;
    int timeleft;
    PVector pos;
    PVector alignment;
  
    PopUp(String text, PVector pos, int timeleft) {
      this.pos = pos;
      this.text = text;
      this.timeleft = timeleft;
      c = #FFFFFF;
      alignment = new PVector(CENTER, CENTER);
    }
    
    PopUp(String text, PVector pos, int timeleft, PVector alignment) {
      this.pos = pos;
      this.text = text;
      this.timeleft = timeleft;
      c = #FFFFFF;
      this.alignment = alignment;
    }
  
    PopUp(String text, PVector pos, int timeleft, PVector alignment, color c) {
      this.pos = pos;
      this.text = text;
      this.timeleft = timeleft;
      this.c = c;
      this.alignment = alignment;
    }
    
    void display() {
      fill(c);
      textAlign(int(alignment.x), int(alignment.y));
      text(text, pos.x, pos.y);
    }
    
    boolean update() {
      timeleft--;
      return timeleft == 0;
    }
  }
}
