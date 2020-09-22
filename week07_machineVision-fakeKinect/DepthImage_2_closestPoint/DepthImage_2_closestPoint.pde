// by aven (https://www.aven.cc)
// artMahcines & NYU Shanghai

// aiarts, spring 2020
// https://github.com/artmachines/aiarts2020

import processing.video.*;
// reference to the camera
Capture camera, _camera;
fakeKinect fKinect;
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
    fKinect.update(camera);
  }
  // draw image received from Runway
  if (fKinect.depthImage != null) {
    pushMatrix();
    translate(600, 0);
    image(fKinect.depthImage, 0, 0);
    fill(0, 255, 255);
    ellipse(fKinect.closestPt.x, fKinect.closestPt.y, 15, 15);
    popMatrix();
  }

  // draw camera feed
  image(camera, 0, 0, 600, 400);
  // display status
  text(fKinect.status, 5, 15);
}
