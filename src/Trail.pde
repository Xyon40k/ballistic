class Trail {
  float maxsize;
  int capacity;
  Node head;
  Node tail;
  int count;
  color c;
  
  Trail(float sizemax, color col) {
    maxsize = sizemax;
    capacity = ceil(sizemax/traildecay)-1;
    count = 0;
    head = null;
    tail = null;
    c = col;
  }
  
  void add(PVector val) {
    Node n = new Node(val);
    if(count == 0) {
      head = n;
      tail = n;
      count++;
    } else if(count < capacity) {
      n.setNext(head);
      head.setPrev(n);
      head = n;
      count++;
    } else {
      n.setNext(head);
      head.setPrev(n);
      head = n;  
      tail = tail.getPrev();
      tail.setNext(null);
    }
  }
  
  void display() {
    color tmp = c;
    Node cursor = head;
    float sz = maxsize-traildecay;
    int j = 0;
    while(cursor != null) {
      tmp = color(red(c), green(c), blue(c), map(j, 0, capacity, 255, 0));
      fill(tmp);
      PVector pos = cursor.getValue();
      circle(pos.x, pos.y, sz);
      cursor = cursor.getNext();
      sz -= traildecay;
    }
  }
  
  class Node {
    PVector val;
    Node next;
    Node prev;
    
    Node(PVector value) {
      val = new PVector(value.x, value.y);
      next = null;
      prev = null;
    }
    
    void setNext(Node n) {
      next = n;
    }
    
    Node getNext() {
      return next;
    }
    
    void setPrev(Node n) {
      prev = n;
    }
    
    Node getPrev() {
      return prev;
    }
    
    PVector getValue() {
      return val;
    }
  }
}
