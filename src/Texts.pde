  class Text {
    String text;
    color c;
    PVector pos;
    PVector alignment;
  
    Text(String text, PVector pos) {
      this.pos = pos;
      this.text = text;
      c = #FFFFFF;
      alignment = new PVector(CENTER, CENTER);
    }
    
    Text(String text, PVector pos, PVector alignment) {
      this.pos = pos;
      this.text = text;
      c = #FFFFFF;
      this.alignment = alignment;
    }
  
    Text(String text, PVector pos, PVector alignment, color c) {
      this.pos = pos;
      this.text = text;
      this.c = c;
      this.alignment = alignment;
    }
    
    void display() {
      fill(c);
      textAlign(int(alignment.x), int(alignment.y));
      text(text, pos.x, pos.y);
    }
  }
  
  class PopUp extends Text {
    int timeleft;
    
    PopUp(String text, PVector pos, int timeleft) {
      super(text, pos);
      this.timeleft = timeleft;
    }
    
    PopUp(String text, PVector pos, int timeleft, PVector alignment) {
      super(text, pos, alignment);
      this.timeleft = timeleft;
    }
  
    PopUp(String text, PVector pos, int timeleft, PVector alignment, color c) {
      super(text, pos, alignment, c);
      this.timeleft = timeleft;
    }
    
    boolean update() {
      timeleft--;
      return timeleft == 0;
    }
    
    PopUp clone() {
      return new PopUp(text, pos, timeleft, alignment, c);
    }
    
    void setTimeleft(int time) {
      timeleft = time;
    }
  }
  
  class DynamicText extends Text {
    Wrapper w;
    
    DynamicText(String text, PVector pos, Wrapper w) {
      super(text, pos);
      this.w = w;
    }
    
    DynamicText(String text, PVector pos, Wrapper w, PVector alignment) {
      super(text, pos, alignment);
      this.w = w;
    }
  
    DynamicText(String text, PVector pos, Wrapper w, PVector alignment, color c) {
      super(text, pos, alignment, c);
      this.w = w;
    }
    
    void display() {
      fill(c);
      textAlign(int(alignment.x), int(alignment.y));
      text(text.replace("%d", w.v.toString()), pos.x, pos.y);
    }
  }
