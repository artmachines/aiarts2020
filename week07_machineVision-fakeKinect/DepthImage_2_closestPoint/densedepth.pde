// import Runway library
import com.runwayml.*;
// reference to runway instance
RunwayHTTP runway = new RunwayHTTP(this);

class fakeKinect {

  // periocally to be updated using millis()
  // how often should the above be updated and a time action take place ?

  int lastMillis;
  int waitTime = 1000;
  String status = "waiting ~"+(waitTime/1000)+"s";
  PImage depthImage;

  PVector closestPt;

  fakeKinect() {
    // update manually
    runway.setAutoUpdate(false);
    // setup timer
    lastMillis = millis();
    closestPt = new PVector(0, 0);
  }

  void update(PImage image) {
    // update timer
    int currentMillis = millis();
    // if the difference between current millis and last time we checked past the wait time
    if (currentMillis - lastMillis >= waitTime) {
      status = "sending image to Runway";
      // call the timed function
      //sendFrameToRunway();
      runway.query(image);
      // update lastMillis, preparing for another wait
      lastMillis = currentMillis;
    }
    if (runwayResult != null) {
      depthImage = runwayResult;
      status = runwayStatus;

      closestPoint(depthImage);
    }
  }

  void closestPoint(PImage img) {
    int x = 0, y = 0;
    float min = 255.0;

    int w = img.width;
    int len = img.pixels.length;
    for (int i = 0; i < len; i++) {
      float r = img.pixels[i] >> 16 & 0xFF;  
      if (min > r) {
        min = r;
        x = i % w;
        y = i / w;
      }
    }

    closestPt.x = x;
    closestPt.y = y;
  }
}

PImage runwayResult;
String runwayStatus;
// this is called when new Runway data is available
void runwayDataEvent(JSONObject runwayData) {
  // point the sketch data to the Runway incoming data 
  String base64ImageString = runwayData.getString("depth_image");
  // try to decode the image from
  try {
    runwayResult = ModelUtils.fromBase64(base64ImageString);
  }
  catch(Exception e) {
    e.printStackTrace();
  }
  runwayStatus = "received runway result";
}

// this is called each time Processing connects to Runway
// Runway sends information about the current model
public void runwayInfoEvent(JSONObject info) {
  println(info);
}
// if anything goes wrong
public void runwayErrorEvent(String message) {
  println(message);
}
