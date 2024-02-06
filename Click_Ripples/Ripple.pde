class Ripple {
  float x; 
  float y; 
  float size; 
  int hue; 
  Ripple(float _x, float _y, float _size, int _hue) {
    x =_x;
    y = _y;
    size = _size;
    hue = _hue;
  }
  void display() {
    if (size < width * 3) {
      noFill();
      stroke(hue, 100, 100);
      circle(x, y, size);
      move();
    } else {
      noStroke();
    }
  }
  void move() {
    fill(0, 0, 0, 4);
    noStroke();
    rect(0, 0, width, height);
    blendMode(ADD);
    colorMode(HSB, 360, 100, 100, 100);
    stroke(hue, 40, 100);
    blendMode(BLEND);
    noFill();
    circle(x, y, size);
    size += 10;
  }
}
