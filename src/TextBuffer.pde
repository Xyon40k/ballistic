import java.util.Iterator;

class TextBuffer {
  ArrayList<PopUp> plist;
  ArrayList<Text> tlist;
  ArrayList<DynamicText> dlist;
  
  TextBuffer() {
    plist = new ArrayList<PopUp>();
    tlist = new ArrayList<Text>();
    dlist = new ArrayList<DynamicText>();
  }
  
  PopUp post(String text, PVector pos, int timeleft) {
    PopUp p = new PopUp(text, pos, timeleft);
    plist.add(p);
    return p;
  }
  
  PopUp post(String text, PVector pos, int timeleft, PVector alignment) {
    PopUp p = new PopUp(text, pos, timeleft, alignment);
    plist.add(p);
    return p;
  }
  
  PopUp post(String text, PVector pos, int timeleft, PVector alignment, color c) {
    PopUp p = new PopUp(text, pos, timeleft, alignment, c);
    plist.add(p);
    return p;
  }
  
  PopUp post(PopUp p) {
    plist.add(p);
    return p;
  }
  
  Text addText(String text, PVector pos) {
    Text t = new Text(text, pos);
    tlist.add(t);
    return t;
  }
  
  Text addText(String text, PVector pos, PVector alignment) {
    Text t = new Text(text, pos, alignment);
    tlist.add(t);
    return t;
  }
  
  Text addText(String text, PVector pos, PVector alignment, color c) {
    Text t = new Text(text, pos, alignment, c);
    tlist.add(t);
    return t;
  }
  
  Text addText(Text t) {
    tlist.add(t);
    return t;
  }
  
  DynamicText addDynamicText(String text, PVector pos, Wrapper w) {
    DynamicText t = new DynamicText(text, pos, w);
    dlist.add(t);
    return t;
  }
  
  DynamicText addDynamicText(String text, PVector pos, Wrapper w, PVector alignment) {
    DynamicText t = new DynamicText(text, pos, w, alignment);
    dlist.add(t);
    return t;
  }
  
  DynamicText addDynamicText(String text, PVector pos, Wrapper w, PVector alignment, color c) {
    DynamicText t = new DynamicText(text, pos, w, alignment, c);
    dlist.add(t);
    return t;
  }
  
  DynamicText addDynamicText(DynamicText t) {
    dlist.add(t);
    return t;
  }
  
  boolean remove(Text t) {
    try {
      tlist.remove(t);
      return true;
    } catch(Exception e) {
      return false;
    }
  }
  
  boolean remove(PopUp p) {
    try {
      plist.remove(p);
      return true;
    } catch(Exception e) {
      return false;
    }
  }
  
  boolean remove(DynamicText d) {
    try {
      dlist.remove(d);
      return true;
    } catch(Exception e) {
      return false;
    }
  }
  
  void update() {
    PopUp p;
    for(Iterator<PopUp> i = plist.iterator(); i.hasNext();) {
      p = i.next();
      if(p.update()) {
        i.remove();
      }
    }
  }
  
  void display() {
    for(PopUp p : plist) {
      p.display();
    }
    
    for(Text t : tlist) {
      t.display();
    }
    
    for(DynamicText d : dlist) {
      d.display();
    }
  }
}
