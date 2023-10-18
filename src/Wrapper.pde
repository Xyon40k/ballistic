class Wrapper<T> {
  T v;
  Wrapper(T val) {
    v = val;
  }
  
  Wrapper() {
    v = null; 
  }
  
  void set(T val) {
    v = val;
  }
}
