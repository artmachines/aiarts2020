// example from runwayML
// adapted by aven (https://www.aven.cc)
// artMahcines & NYU Shanghai

// aiarts, spring 2020
// https://github.com/artmachines/aiarts2020

import com.runwayml.*;
RunwayHTTP runway;

JSONObject data;

void setup() {
  size(600, 400);
  runway = new RunwayHTTP(this);
}

void draw() {
  background(0);
  //ModelUtils.drawPoseParts(data,g,10);
  draw_poses();
}



void draw_poses() {
  if (data != null) {
    JSONArray poses = data.getJSONArray("poses");

    // lets assume we have multi-poses detection on
    for (int i = 0; i < poses.size(); i ++) {
      //pass in index
      JSONArray the_pose = poses.getJSONArray(i);
      //println(the_pose);
      //println(the_pose.size());
      for (int j = 0; j < the_pose.size(); j ++) { //access to keypoints
        JSONArray point = the_pose.getJSONArray(j);
        //print(point);
        //println(point.size());
        float x = point.getFloat(0)*width;
        float y = point.getFloat(1)*height;
        //println("x: " + x +", y: " + y);

        fill(255);
        ellipse(x, y, 10, 10);

        //what about index --> body parts?
        //here: https://github.com/tensorflow/tfjs-models/tree/master/posenet
        //keypoints
        //for instance: nose --> 0
        if (j == 0) {
          fill(255, 0, 0);
          ellipse(x, y, 30, 30);
        }
        //if mirrored, you can adjust it in runwayML!!!
      }
    }
  }
}


void runwayDataEvent(JSONObject runwayData) {
  data = runwayData;
}
