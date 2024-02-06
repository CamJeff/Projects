Ripple defaultRipple;
ArrayList<Ripple> ripple = new ArrayList<Ripple>();

void setup() {
  size(600, 400);
  background(0);
  colorMode(HSB);
  defaultRipple = new Ripple(width/2, height/2, 100, floor(random(360)));
}

void draw() {

  defaultRipple.display() ;
  for (int i = 0; i < ripple.size(); i++) {
    ripple.get(i).display() ;
  }
}

void mousePressed() {
  ripple.add(new Ripple(mouseX, mouseY, floor(random(50, 100)), floor(random(360))));
}
