Flock flock;

void setup() {
  size(1200, 400);
  frameRate(120);
  flock = new Flock();
  for (int i = 0; i < 350; i++) {
    flock.addBoid(new Boid(new PVector(width/2,height/2), 3.0, 0.05));
  }
  smooth();
}

void draw() {
  fill(0,20);
  noStroke();
  rect(0,0,1200,400);
  flock.run();
}


void mousePressed() {
  Boid b = new Boid(new PVector(mouseX,mouseY),2.0f,0.05f);
  b.r = 4;
  b.cc = color(255, 255, 0);
  flock.addBoid(b);
}
