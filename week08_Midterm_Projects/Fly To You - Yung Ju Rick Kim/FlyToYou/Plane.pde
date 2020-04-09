class Plane {
  PVector origin, destination, direction, velocity, acc;
  float angle;
  int c;
  
  Plane(float x, float y, float destX, float destY) {
    origin = new PVector(x, y);
    destination = new PVector(destX, destY);
    velocity = new PVector(0, 0);
    angle = 0;
  }
  
  void updateDestination(float x, float y) {
    destination = new PVector(x, y);
  }
  
  void update() {
    direction = PVector.sub(destination, origin);
    
    // Calculating the Acceleration
    acc = PVector.sub(destination, origin);
    acc.setMag(0.05);
    
    // Finding the Smallest Angle to the desired destination
    float delta1 = direction.heading() - angle;
    float delta2 = (delta1 > 0 ? 1 : -1)*TWO_PI - delta1;
    angle += (Math.abs(delta1) < Math.abs(delta2) ? delta1 : -delta2) * 0.05;
    angle %= TWO_PI; 
    
    // Mapping the Color value depending on the distance to the destination
    c = (int)map(direction.mag(), 1000, 0, 0, 255);
    
    // Applying the accerleration and adding it to the origin
    velocity.add(acc);
    velocity.limit(1.5);
    if (origin != destination) {
      origin.add(velocity);
    }
  }
  
  void display() {
    pushMatrix();
      translate(origin.x, origin.y);
      rotate(angle);
      noStroke();
      fill(color(c, 255, 255));
      
      // Configuring the shape of each flying points
      beginShape();
        vertex(3, 0);
        vertex(0, -3);
        vertex(15, 0);
        vertex(0, 3);
      endShape();
    popMatrix();
  }
  
  float x() {
    return origin.x;
  }
  
  float y() {
    return origin.y;
  }
  
  // Function to return the distance to the destination from the point
  float directionMag() {
    direction = PVector.sub(destination, origin);
    return direction.mag();
  }
  
  float distanceTo(PVector temp) {
    return origin.dist(temp);
  }
  
  PVector vector() {
    return origin;
  }
  
  void run() {
    update();
    display();
  }
}
