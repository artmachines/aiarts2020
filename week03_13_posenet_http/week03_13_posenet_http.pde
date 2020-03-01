// example from runwayML
// adapted by aven (https://www.aven.cc)
// artMahcines & NYU Shanghai

// aiarts, spring 2020
// https://github.com/artmachines/aiarts2020

import com.runwayml.*;
RunwayHTTP runway;

JSONObject data;

void setup(){
  size(600,400);
  runway = new RunwayHTTP(this);
}

void draw(){
  background(0);
  ModelUtils.drawPoseParts(data,g,10);
}

void runwayDataEvent(JSONObject runwayData){
  data = runwayData;
}
