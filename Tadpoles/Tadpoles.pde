class Boid {

  PVector loc;
  PVector vel;
  PVector acc;
  float r;
  color cc;
  float maxforce;  
  float maxspeed;    


  Boid(PVector l, float ms, float mf) {
    acc = new PVector(0,0);
    vel = new PVector(random(-1,1),random(-1,1));
    loc = l.get();
    r = 2.0;
    cc = color(255);
    maxspeed = ms;
    maxforce = mf;
  }

  void run(ArrayList boids) {
    flock(boids);
    update();
    borders();
    render();
  }


  void flock(ArrayList boids) {
    PVector sep = separate(boids);  
    PVector ali = align(boids);    
    PVector coh = cohesion(boids);   
    sep.mult(1.5);
    ali.mult(1.0);
    coh.mult(1.0);
    acc.add(sep);
    acc.add(ali);
    acc.add(coh);
  }


  void update() {
    vel.add(acc);
    vel.limit(maxspeed);
    loc.add(vel);
    acc.mult(0);
  }


  void seek(PVector target) {
    acc.add(steer(target,false));
  }

  void arrive(PVector target) {
    acc.add(steer(target,true));
  }

  PVector steer(PVector target, boolean slowdown) {
    PVector steer;  
    PVector desired = target.sub(target,loc); 
    float d = desired.mag();
    if (d > 0) {
      desired.normalize();
     
      if ((slowdown) && (d < 100.0)) desired.mult(maxspeed*(d/100.0)); 
      else desired.mult(maxspeed);
      steer = target.sub(desired,vel);
      steer.limit(maxforce);  
    } 
    else {
      steer = new PVector(0,0);
    }
    return steer;
  }

  void render() {

    float theta = vel.heading2D() + PI/2;
    fill(cc);
    stroke(cc);
    pushMatrix();
    translate(loc.x,loc.y);
    rotate(theta);
    beginShape(QUAD);
    vertex(0, -r);
    vertex(r, 0);
    vertex(0, r*6);
    vertex(-r, 0);
    endShape();
    popMatrix();
  }


  void borders() {
    if (loc.x < -r) loc.x = width+r;
    if (loc.y < -r) loc.y = height+r;
    if (loc.x > width+r) loc.x = -r;
    if (loc.y > height+r) loc.y = -r;
  }


  PVector separate (ArrayList boids) {
    float desiredseparation = 40.0;
    PVector steer = new PVector(0,0,0);
    int count = 0;
    for (int i = 0 ; i < boids.size(); i++) {
      Boid other = (Boid) boids.get(i);
      float d = PVector.dist(loc,other.loc);
     
      if ((d > 0) && (d < desiredseparation)) {
        PVector diff = PVector.sub(loc,other.loc);
        diff.normalize();
        diff.div(d);      
        steer.add(diff);
        count++;            
      }
    }

    if (count > 0) {
      steer.div((float)count);
    }


    if (steer.mag() > 0) {
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(vel);
      steer.limit(maxforce);
    }
    return steer;
  }



  PVector align (ArrayList boids) {
    float neighbordist = 25.0;
    PVector steer = new PVector(0,0,0);
    int count = 0;
    for (int i = 0 ; i < boids.size(); i++) {
      Boid other = (Boid) boids.get(i);
      float d = PVector.dist(loc,other.loc);
      if ((d > 0) && (d < neighbordist)) {
        steer.add(other.vel);
        count++;
      }
    }
    if (count > 0) {
      steer.div((float)count);
    }

    if (steer.mag() > 0) {
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(vel);
      steer.limit(maxforce);
    }
    return steer;
  }

 
  PVector cohesion (ArrayList boids) {
    float neighbordist = 25.0;
    PVector sum = new PVector(0,0);  
    int count = 0;
    for (int i = 0 ; i < boids.size(); i++) {
      Boid other = (Boid) boids.get(i);
      float d = loc.dist(other.loc);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.loc); 
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      return steer(sum,false); 
    }
    return sum;
  }
}
