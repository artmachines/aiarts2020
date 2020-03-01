// example from George Profenza
// adapted by aven (https://www.aven.cc)
// artMahcines & IMNYU Shanghai

// aiarts, spring 2020
// https://github.com/artmachines/aiarts2020


import oscP5.*;
import com.runwayml.*;

RunwayOSC runway;
JSONObject data; //store received data

void setup() {
  size(600, 400);
  runway = new RunwayOSC(this);
}

void draw() {
  background(0);
  runway.drawPoseNetParts(data, 10); // but what is inside this function?
}

void keyPressed() {
  print(data);
  saveJSONObject(data, "data.json");
}

void runwayDataEvent(JSONObject runwayData) { //event lisener
  data = runwayData;
}
