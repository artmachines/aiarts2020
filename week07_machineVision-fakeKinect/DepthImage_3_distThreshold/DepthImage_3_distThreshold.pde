// by aven (https://www.aven.cc)
// artMahcines & NYU Shanghai

// aiarts, spring 2020
// https://github.com/artmachines/aiarts2020

import processing.video.*;
// reference to the camera
Capture camera, _camera;
fakeKinect fKinect;

int threshold = 100;
void setup() {
  size(1200, 400);
  // setup camera
  //camera = new Capture(this, 640, 480, Capture.list()[0]);
  camera = new Capture(this, 640, 480, Capture.list()[0]);
  //camera.start();
  camera.start();
  fKinect = new fakeKinect();
}

void draw() {
  background(0);
  if (camera.available()) {
    camera.read();
    // crop image to Runway input format (600x400)
    //PImage image = camera.get(0, 0, 600, 400);
    fKinect.update(camera, threshold);
  }
  // draw image received from Runway
  if (fKinect.depthImage != null) {
    image(fKinect.depthImage, 600, 0);
  }
  button(620, 40, 255, 20);

  // draw camera feed
  image(camera, 0, 0, 600, 400);
  // display status
  text(fKinect.status, 5, 15);
}

void button(int bx, int by, int bw, int bh) {
  fill(0, 255, 255);
  //ellipse(fKinect.closestPt.x, fKinect.closestPt.y, 15, 15);
  rect(bx, by, bw, bh);
  if (mousePressed) {
    if (mouseX > bx && mouseX < bx + bw &&
      mouseY > by && mouseY < by + bh) {
      threshold = mouseX - bx;
    }
  }
  fill(255, 0, 255);
  text("threshold:", bx, by-bh);
  rect(threshold + bx, by-0.1*bh, 5, 1.2*bh);
}
