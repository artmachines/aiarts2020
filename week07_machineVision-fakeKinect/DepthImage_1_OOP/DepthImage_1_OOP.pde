// example from George Profenza
// adapted by aven (https://www.aven.cc)
// artMahcines & NYU Shanghai

// aiarts, spring 2020
// https://github.com/artmachines/aiarts2020

import processing.video.*;
// reference to the camera
Capture camera;
fakeKinect fKinect;
void setup() {
  size(1200, 400);
  // setup camera
  camera = new Capture(this, 600, 400, Capture.list()[0]);
  camera.start();
  fKinect = new fakeKinect();
}

void draw() {
  background(0);
  if (camera.available()) {
    camera.read();
    // crop image to Runway input format (600x400)
    PImage image = camera.get(0, 0, 600, 400);
    fKinect.update(image);
  }
  // draw image received from Runway
  if (fKinect.depthImage != null) {
    image(fKinect.depthImage, 600, 0);
  }
  // draw camera feed
  image(camera, 0, 0, 600, 400);
  // display status
  text(fKinect.status, 5, 15);
}
